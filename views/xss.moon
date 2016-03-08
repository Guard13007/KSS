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

        p, ->
            a href: "https://dev.kerbalwarfare.xyz/attrib-event/1", "attrib-event"
            a href: "https://dev.kerbalwarfare.xyz/attrib-name/1", "attrib-name"
            a href: "https://dev.kerbalwarfare.xyz/attrib-value/1", "attrib-value"
            a href: "https://dev.kerbalwarfare.xyz/comment/1", "comment"
            a href: "https://dev.kerbalwarfare.xyz/css/1", "css"
            a href: "https://dev.kerbalwarfare.xyz/script/1", "script"
            a href: "https://dev.kerbalwarfare.xyz/tag-inside/1", "tag-inside"
            a href: "https://dev.kerbalwarfare.xyz/tag-name/1", "tag-name"
            a href: "https://dev.kerbalwarfare.xyz/url1/1", "url1"
            a href: "https://dev.kerbalwarfare.xyz/url2/1", "url2"
            a href: "https://dev.kerbalwarfare.xyz/url3/1", "url3"
            a href: "https://dev.kerbalwarfare.xyz/url4/1", "url4"
