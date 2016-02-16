import Widget from require "lapis.html"

class UploadWidget extends Widget
    content: =>
        form {
            action: "/upload"
            method: "POST"
            enctype: "multipart/form-data" -- no idea why/if we need this
        }, ->
            input type: "file", name: "file"
            input type: "submit"
