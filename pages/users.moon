lapis = require "lapis"
csrf = require "lapis.csrf"

Users = require "models.Users"

import respond_to, assert_error from require "lapis.application"
import unescape from require "lapis.util"
import const_compare from require "helpers.security"

class UsersApp extends lapis.Application
    "/user": => redirect_to: @url_for("users"), status: 301

    [users: "/users"]: =>
        @users = {
            admins: Users\select "WHERE admin = TRUE ORDER BY name ASC"
            active: Users\select "WHERE weekday != 0 ORDER BY weekday, name ASC"
            inactive: Users\select "WHERE weekday = 0 ORDER BY name ASC"
        }
        @title = "All Users"
        render: true

    [user: "/user/:name"]: =>
        @user = Users\find name: unescape(@params.name)

        if not @user
            @title = "404: Not Found"
            return status: 404, "User not found."

        @title = @user.name
        @subtitle = @user.id
        render: true

    [create_user: "/create_user"]: respond_to {
        GET: =>
            if @session.id
                if user = Users\find id: @session.id
                    return "You are logged in as #{user.name}. Please log out before attempting to create a new account."
                else
                    return "Error: Session ID is invalid. Please report this error." --TODO have an error report in the error itself? Or make the error report itself dammit
            else
                @title = "Create Account"
                @subtitle = "Welcome to Kerbal Warfare"
                render: true
        POST: =>
            unless csrf.validate_token @
                return "Invalid token. Please try again."

            user = assert_error Users\create {
                name: @params.name
                password: @params.password
            }

            --TODO modify stack trace output to include note to email me the error ?!

            @session.id = user.id -- log them in
            redirect_to: @url_for user --TODO redirect somewhere else
    }

    [modify_user: "/modify_user"]: respond_to {
        GET: =>
            return status: 404, "Not found."
        POST: =>
            unless csrf.validate_token @
                return "Invalid token. Please try again."

            current_user = Users\find id: @session.id
            user = Users\find id: @params.user_id

            if @params.form == "user_edit"
                if user.id == current_user.id
                    if @params.delete
                        if user\delete!
                            @session.id = nil
                            return "User deleted."
                        else
                            return "Error deleting user."

                    if const_compare user.password, @params.oldpassword
                        assert_error user\update password: @params.password
                    else
                        return "Invalid password."

            if @params.form == "admin_edit"
                if current_user.admin
                    if @params.delete
                        if user\delete!
                            return "User deleted."
                        else
                            return "Error deleting user."

                    columns = {} -- columns to update
                    if @params.name != ""
                        columns.name = @params.name
                    if @params.weekday != ""
                        columns.weekday = @params.weekday
                    if @params.admin
                        if @params.admin == "on"
                            columns.admin = true
                        else
                            columns.admin = false

                    assert_error user\update columns

            redirect_to: @url_for user
    }

    [login: "/login"]: respond_to {
        GET: =>
            if @session.id
                if user = Users\find id: @session.id
                    return "You are logged in as #{@session.username}. Please log out before attempting to log in as another user."
                else
                    return "Error: Session ID is invalid. Please report this error." --TODO have errors like this report themselves?
            else
                @title = "Log In"
                render: true
        POST: =>
            unless csrf.validate_token @
                return "Invalid token. Please try again."

            if user = Users\find name: @params.name
                if const_compare user.password, @params.password
                    @session.id = user.id
                    return redirect_to: @url_for index

            return "Invalid login information."
    }

    [logout: "/logout"]: =>
        @session.id = nil --this should be all that is needed to log out
        redirect_to: @url_for "index"
