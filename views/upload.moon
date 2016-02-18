import Widget from require "lapis.html"

class UploadWidget extends Widget
    content: =>
        form {
            action: "/upload"
            method: "POST"
            enctype: "multipart/form-data"
            class: "pure-form"
        }, ->
            p "Report:"
            textarea rows: 8, cols: 60, name: "report"
            p "Save file:" --NOTE this will be different in the future
            input type: "file", name: "file"
            input type: "hidden", name: "csrf_token", value: @token
            input type: "submit"
