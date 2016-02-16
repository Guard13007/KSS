import Widget from require "lapis.html"

class CreateUser extends Widget
    content: =>
        form {
            action: "/create_user"
            method: "POST"
            enctype: "multipart/form-data" -- no idea why/if we need this
        }, ->
            p "Username: "
            input type: "text", name: "username"
            p "Password: "
            input type: "password", name: "password"
            p "Is admin? "
            input type: "checkbox", name: "admin"
            input type: "submit"
