lapis = require "lapis"
csrf = require "lapis.csrf"

Users = require "models.Users"

import respond_to from require "lapis.application"

class UsersApp extends lapis.Application
    "/user": => redirect_to: @url_for("users"), status: 301

    [users: "/users"]: =>
        return "Not done yet!" --TODO #25

    [user: "/user/:name"]: =>
        @user = Users\find name: @params.name

        if not @user
            return status: 404, "Not found."

        @title = @user.name
        @subtitle = @user.id
        render: true

    [create_user: "/create_user"]: respond_to {
        GET: =>
            if @session.username
                return "You are logged in as #{@session.username}. Please log out before attempting to create a new account."
            else
                @token = csrf.generate_token @
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
                @session.username = user.name -- log them in
                redirect_to: @url_for "user", name: user.name --TODO redirect somewhere else
            else
                return errorMsg
    }

    [login: "/login"]: respond_to {
        GET: =>
            if @session.username
                return "You are logged in as #{@session.username}. Please log out before attempting to log in as another user."
            else
                @token = csrf.generate_token @ --TODO figure out if the @ saves it in @ ?? (just print the damn @)
                render: true
        POST: =>
            csrf.assert_token @

            if user = Users\find name: @params.name
                if user.password == @params.password
                    @session.username = user.name
                    redirect_to: @url_for "user", name: user.name --TODO redirect somewhere else

            return "Invalid login information."
    }

    [logout: "/logout"]: =>
        @session.username = nil --this should be all that is needed to log out
        redirect_to: @url_for("index")
