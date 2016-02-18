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
                @html -> p "Woo! New user! :D" --TODO rewrite this to redirect!
    }

    [login: "/login"]: respond_to {
        GET: =>
            @token = csrf.generate_token @ --TODO figure out if the @ saves it in @ ??
            render: true
        POST: =>
            csrf.assert_token @
            --TODO verify details and login if able!
            -- "logging in" is saving user.name as @session.username
    }

    [logout: "/logout"]: =>
        @session.username = nil --this should be all that is needed to log out
        redirect_to: @url_for("index")
