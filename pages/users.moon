lapis = require "lapis"
csrf = require "lapis.csrf"

Users = require "models.Users"

import respond_to from require "lapis.application"
import unescape from require "lapis.util"

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
            @title = "User Not Found"
            return status: 404, "Not found."

        @token = csrf.generate_token @
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
                @token = csrf.generate_token @
                @title = "Create Account"
                @subtitle = "Welcome to K.S.S."
                render: true
        POST: =>
            csrf.assert_token @ --TODO make this pretty print invalid token instead of erroring out entirely

            user, errorMsg = Users\create {
                name: @params.name
                password: @params.password
            }

            --TODO check if user, print errorMsg
            --TODO capture errors and display appropriate response! (or use validate (same syntax as assert_valid without the errors!) to validate input first!)
            --TODO modify stack trace output to include note to email me the error ?!

            if user
                @session.id = user.id -- log them in
                redirect_to: @url_for "user", name: user.name --TODO redirect somewhere else
            else
                return errorMsg
    }

    [modify_user: "/modify_user"]: respond_to {
        GET: =>
            return status: 404, "Not found."
        POST: =>
            csrf.assert_token @

            current_user = Users\find id: @session.id
            user = Users\find id: @params.user_id

            if @params.form == "user_edit"
                if user.id == current_user.id
                    print("ENTER")
                    if user.password == @params.oldpassword
                        user, errorMsg = user\update password: @params.password
                        if errorMsg
                            return errorMsg
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

                    _, errorMsg = user\update columns
                    if errorMsg
                        return errorMsg

            redirect_to: @url_for("user", name: user.name)
    }

    [login: "/login"]: respond_to {
        GET: =>
            if @session.id
                if user = Users\find id: @session.id
                    return "You are logged in as #{@session.username}. Please log out before attempting to log in as another user."
                else
                    return "Error: Session ID is invalid. Please report this error." --TODO have errors like this report themselves?
            else
                @token = csrf.generate_token @
                @title = "Log In"
                render: true
        POST: =>
            csrf.assert_token @

            if user = Users\find name: @params.name
                if user.password == @params.password
                    @session.id = user.id
                    return redirect_to: @url_for "user", name: user.name --TODO redirect somewhere else

            return "Invalid login information."
    }

    [logout: "/logout"]: =>
        @session.id = nil --this should be all that is needed to log out
        redirect_to: @url_for("index")

    [vulnerable: "/vulnerable/:user"]: =>
        if user = Users\find name: @params.user
            return p onmouseover: "var useless = \"#{user.name}\";", "This piece of text is potentially vulnerable to XSS. DO NOT MOVE YOUR MOUSE OVER THIS TEXT." --NOTE example of XSS vulnerability for testing purposes!
