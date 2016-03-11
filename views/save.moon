import Widget from require "lapis.html"

Users = require "models.Users"

class SaveWidget extends Widget
    content: =>
        script src: @build_url "static/js/form.js"

        user = @save\get_user!

        pre @save.report
        hr!
        p "Created by: ", user.name
        p -> a href: @build_url(@save.file), download: true, "Download" --TODO make file ext available here

        if @session.id
            if current_user = Users\find id: @session.id
                if current_user.name == user.name
                    -- user report edit
                    hr!
                    form {
                        action: "/modify_save"
                        method: "POST"
                        enctype: "multipart/form-data"
                        class: "pure-form"
                    }, ->
                        h3 "Edit report?"
                        textarea rows: 10, cols: 80, name: "report", @save.report
                        input type: "hidden", name: "form", value: "user_edit"
                        input type: "hidden", name: "save_id", value: @save.id
                        input type: "hidden", name: "csrf_token", value: @csrf_token
                        input type: "submit"
                if user.admin
                    hr!
                    form {
                        action: "/modify_save"
                        method: "POST"
                        enctype: "multipart/form-data"
                        class: "pure-form"
                        onsubmit: "return confirm_delete('Are you sure you want to delete this save?');"
                    }, ->
                        p "Delete save? "
                        input type: "checkbox", name: "delete"
                        br!
                        input type: "hidden", name: "form", value: "admin_edit"
                        input type: "hidden", name: "save_id", value: @save.id
                        input type: "hidden", name: "csrf_token", value: @csrf_token
                        input type: "submit"
