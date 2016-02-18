lapis = require "lapis"
csrf = require "lapis.csrf"

Users = require "models.Users" --TODO learn how to use the fancy autoload thing properly

import respond_to from require "lapis.application"

class UsersApp extends lapis.Application
    "/user": => redirect_to: @url_for("users"), status: 301

    [users: "/users"]: =>
        "Not done yet!" --TODO finish (see /saves)

    [user: "/user/:name"]: => --TODO rewrite this as well! more details please!
        @html ->
            if user = Users\find name: @params.name
                h1 "It's working, shut up"
                p @params.name
                --a href: @build_url(save.file), "Test"
            else
                @write status: 404, "Not found"

    [create_user: "/create_user"]: respond_to {
        GET: =>
            if @session.username
                "You are logged in as #{@session.username}. Please log out before attempting to create a new account."
            else
                @token = csrf.generate_token @
                render: true
        POST: =>
            csrf.assert_token @ --TODO make this pretty print invalid token instead of erroring out entirely

            --TODO replace setting admin with..false
            if @params.admin
                @params.admin = true
            else
                @params.admin = false

            user = Users\create {
                name: @params.name
                password: @params.password
                admin: @params.admin
            }

            --TODO capture errors and display appropriate response! (or use validate (same syntax as assert_valid without the errors!) to validate input first!)

            --TODO modify stack trace output to include note to email me the error ?!

            if user
                @session.username = user.name -- log them in
                redirect_to: @url_for "user", name: user.name --TODO redirect to saves or index or something instead?
    }

    [login: "/login"]: respond_to {
        GET: =>
            if @session.username
                "You are logged in as #{@session.username}. Please log out before attempting to log in as another user."
            else
                @token = csrf.generate_token @ --TODO figure out if the @ saves it in @ ??
                render: true
        POST: =>
            csrf.assert_token @

            if user = Users\find name: @params.name
                if user.password == @params.password
                    @session.username = user.name
                    redirect_to: @url_for "user", name: user.name --TODO redirect somewhere else??
    }

    [logout: "/logout"]: =>
        @session.username = nil --this should be all that is needed to log out
        redirect_to: @url_for("index")
