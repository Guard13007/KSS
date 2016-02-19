import Widget from require "lapis.html"

class CreateUser extends Widget
    content: =>
        form {
            action: "/create_user"
            method: "POST"
            enctype: "multipart/form-data"
            class: "pure-form"
        }, ->
            p "Username:"
            input type: "text", name: "name"
            p "Password:"
            input type: "password", name: "password"
            input type: "hidden", name: "csrf_token", value: @token
            br!
            input type: "submit"
