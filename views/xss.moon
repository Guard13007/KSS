import Widget from require "lapis.html"

class CreateXSS extends Widget
    content: =>
        form {
            action: "/vulnerable/xss"
            method: "POST"
            enctype: "multipart/form-data"
            class: "pure-form"
        }, ->
            p "Value: "
            input type: "text", name: "value"
            br!
            input type: "submit"
