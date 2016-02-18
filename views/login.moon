import Widget from require "lapis.html"

class LoginWidget extends Widget
    content: =>
        form {
            action: "/login"
            method: "POST"
            enctype: "multipart/form-data"
            class: "pure-form"
        }, ->
            p "Username:"
            input type: "text", name: "name"
            p "Password:"
            input type: "password", name: "password"
            input type: "hidden", name: "csrf_token", value: @token
            input type: "submit", value: "Log in"
