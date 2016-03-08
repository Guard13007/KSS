import Widget from require "lapis.html"

XSS = require "models.XSS"
count = XSS\count!

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

        element "table", class: "pure-table", ->
            for i = 1, count
                tr ->
                    td -> a href: "https://dev.kerbalwarfare.xyz/vulnerable/attrib-event/#{i}", "attrib-event #{i}"
                    td -> a href: "https://dev.kerbalwarfare.xyz/vulnerable/attrib-name/#{i}", "attrib-name #{i}"
                    td -> a href: "https://dev.kerbalwarfare.xyz/vulnerable/attrib-value/#{i}", "attrib-value #{i}"
                    td -> a href: "https://dev.kerbalwarfare.xyz/vulnerable/comment/#{i}", "comment #{i}"
                    td -> a href: "https://dev.kerbalwarfare.xyz/vulnerable/css/#{i}", "css #{i}"
                    td -> a href: "https://dev.kerbalwarfare.xyz/vulnerable/script/#{i}", "script #{i}"
                    td -> a href: "https://dev.kerbalwarfare.xyz/vulnerable/tag-inside/#{i}", "tag-inside #{i}"
                    td -> a href: "https://dev.kerbalwarfare.xyz/vulnerable/tag-name/#{i}", "tag-name #{i}"
                    td -> a href: "https://dev.kerbalwarfare.xyz/vulnerable/url1/#{i}", "url1 #{i}"
                    td -> a href: "https://dev.kerbalwarfare.xyz/vulnerable/url2/#{i}", "url2 #{i}"
                    td -> a href: "https://dev.kerbalwarfare.xyz/vulnerable/url3/#{i}", "url3 #{i}"
                    td -> a href: "https://dev.kerbalwarfare.xyz/vulnerable/url4/#{i}", "url4 #{i}"
