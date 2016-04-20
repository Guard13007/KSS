import Widget from require "lapis.html"

Users = require "models.Users"

class UploadWidget extends Widget
    content: =>
        p "Please upload a compressed save file. Write a brief report about what has changed in the save file. Please include the following in your report:"
        ol ->
            li "Craft launched, their part counts, their mission(s)."
            li "Parts used out of your allotment, parts left, etc."
            li "Bases taken, craft lost, etc."
            li "Anything else you feel is appropriate."
        p "(Basically, as much of a proper mission report as you can.)"
        p ->
            text "(Max filesize is 50 MB. If you feel this is too small, please "
            a href: "https://discord.gg/0e25Cmk0wjIXjc5I", target: "_blank", "contact an administrator"
            text " and we will see what we can do about it.)"

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
