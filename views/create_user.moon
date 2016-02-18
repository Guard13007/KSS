import Widget from require "lapis.html"

class CreateUser extends Widget
    content: =>
        form {
            action: "/create_user"
            method: "POST"
            enctype: "multipart/form-data" --TODO find out if this is needed and why
            class: "pure-form"
        }, ->
            p "Username:"
            input type: "text", name: "name"
            p "Password:"
            input type: "password", name: "password"
            p "Is admin? " --TODO REMOVE THIS AND NEXT LINE!!
            input type: "checkbox", name: "admin"
            input type: "hidden", name: "csrf_token", value: @token
            input type: "submit"
