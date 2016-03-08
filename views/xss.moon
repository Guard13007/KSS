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

        p ->
            a href: "https://dev.kerbalwarfare.xyz/vulnerable/attrib-event/1", "attrib-event"
            br!
            a href: "https://dev.kerbalwarfare.xyz/vulnerable/attrib-name/1", "attrib-name"
            br!
            a href: "https://dev.kerbalwarfare.xyz/vulnerable/attrib-value/1", "attrib-value"
            br!
            a href: "https://dev.kerbalwarfare.xyz/vulnerable/comment/1", "comment"
            br!
            a href: "https://dev.kerbalwarfare.xyz/vulnerable/css/1", "css"
            br!
            a href: "https://dev.kerbalwarfare.xyz/vulnerable/script/1", "script"
            br!
            a href: "https://dev.kerbalwarfare.xyz/vulnerable/tag-inside/1", "tag-inside"
            br!
            a href: "https://dev.kerbalwarfare.xyz/vulnerable/tag-name/1", "tag-name"
            br!
            a href: "https://dev.kerbalwarfare.xyz/vulnerable/url1/1", "url1"
            br!
            a href: "https://dev.kerbalwarfare.xyz/vulnerable/url2/1", "url2"
            br!
            a href: "https://dev.kerbalwarfare.xyz/vulnerable/url3/1", "url3"
            br!
            a href: "https://dev.kerbalwarfare.xyz/vulnerable/url4/1", "url4"
