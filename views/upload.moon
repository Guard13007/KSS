import Widget from require "lapis.html"

Users = require "models.Users"

class UploadWidget extends Widget
    content: =>
        if not @session.username
            p "You must be logged in to upload."
        else
            p "Please upload KSP save files and craft files. Remember to compress a save file before uploading. Write a brief description about the file for the \"report\" that will be stored with each upload. Remember that this is a test server and that things can and will change a lot."
            p ->
                text "(Max filesize is 50 MB. If you feel this is too small, please "
                a href: "https://discord.gg/0e25Cmk0wjIXjc5I", target: "_blank", "contact an administrator"
                text " and we will see what we can do about it.)"

            user = Users\find name: @session.username
            day = os.date("!*t").wday

            if user.admin or (user.weekday == day)
                form {
                    action: "/upload"
                    method: "POST"
                    enctype: "multipart/form-data"
                    class: "pure-form"
                }, ->
                    p "Report:"
                    textarea rows: 8, cols: 60, name: "report"
                    p "Save file:"
                    input type: "file", name: "file"
                    input type: "hidden", name: "csrf_token", value: @token
                    input type: "submit"
            else
                p "You are not allowed to upload right now."
