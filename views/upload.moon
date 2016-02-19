import Widget from require "lapis.html"

Users = require "models.Users"

class UploadWidget extends Widget
    content: =>
        if not @session.username
            p "You must be logged in to upload."
        else
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
