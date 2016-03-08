lapis = require "lapis"
-- no csrf checking because idc and this is for XSS vulnerability testing anyhow

Users = require "models.Users"
XSS = require "models.XSS"

import respond_to from require "lapis.application"

class XSSApp extends lapis.Application
    [xss: "/vulnerable/xss"]: respond_to {
        GET: =>
            @title = "Attempt Exploit"
            @subtitle = "This page is for testing XSS exploits. Hopefully nothing works."
            render: true
        POST: =>
            xss, errorMsg = XSS\create {
                value: @params.value
            }

            if errorMsg
                return errorMsg
            else
                redirect_to: @url_for "xss"
    }

    --[xss2: "/vulnerable/x/:id"]: =>
    "/vulnerable/:x/:id": => --no idea if that will work properly...
        @value = XSS\find id: @params.id
        @title = "XSS Vulnerability?"
        @subtitle = @value.value
        --render: true
        render: @params.x

    [vulnerable: "/vulnerable/:user"]: =>
        if user = Users\find name: @params.user
            return p onmouseover: "var useless = \"#{user.name}\";", "This piece of text is potentially vulnerable to XSS. DO NOT MOVE YOUR MOUSE OVER THIS TEXT." --NOTE example of XSS vulnerability for testing purposes!
