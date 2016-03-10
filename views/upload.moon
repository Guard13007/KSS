import Widget from require "lapis.html"

Users = require "models.Users"

class UploadWidget extends Widget
    content: =>
        if not @session.id
            p "You must be logged in to upload."
        else
            p "Please upload a compressed save file. Write a brief report about what has changed in the save file."
            p ->
                text "(Max filesize is 50 MB. If you feel this is too small, please "
                a href: "https://discord.gg/0e25Cmk0wjIXjc5I", target: "_blank", "contact an administrator"
                text " and we will see what we can do about it.)"

            user = Users\find id: @session.id
            day = os.date("!*t").wday

            if user.admin or (user.weekday == day)
                form {
                    action: "/upload"
                    method: "POST"
                    enctype: "multipart/form-data"
                    class: "pure-form"
                }, ->
                    p "Report:"
                    textarea rows: 10, cols: 80, name: "report"
                    p "Save file:"
                    input type: "file", name: "file"
                    input type: "hidden", name: "csrf_token", value: @csrf_token
                    input type: "submit"
            else
                p "You are not allowed to upload right now."
