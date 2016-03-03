import Widget from require "lapis.html"

Users = require "models.Users"

class SaveWidget extends Widget
    content: =>
        script src: @build_url "static/js/form.js"

        pre @save.report --TODO find a way to limit width?
        hr!
        p "Created by: ", (@save\get_user!).name
        p -> a href: @build_url(@save.file), download: true, "Download" --TODO make file ext available here

        if @session.id
            if user = Users\find id: @session.id
                if user.admin
                    hr!
                    form {
                        action: "/modify_save"
                        method: "POST"
                        enctype: "multipart/form-data"
                        class: "pure-form"
                    }, ->
                        p "Delete save? "
                        input type: "checkbox", name: "delete"
                        input type: "hidden", name: "save_id", value: @save.id
                        br!
                        input type: "hidden", name: "csrf_token", value: @token
                        input type: "submit", onclick: "confirm_delete('Are you sure you want to delete this save?')"
