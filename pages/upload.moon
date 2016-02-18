lapis = require "lapis"
csrf = require "lapis.csrf"

Saves = require "models.Saves"
Users = require "models.Users"

import respond_to from require "lapis.application"

class UploadApp extends lapis.Application
    [upload: "/upload"]: respond_to {
        GET: =>
            @token = csrf.generate_token @
            render: true
        POST: =>
            csrf.assert_token @

            file = @params.file
            if #file.content > 0
                --require("moon").p file
                date = os.date("!%Y-%m-%d.%H-%M.%S", os.time())
                filename = "static/uploads/#{date .. file.filename\match("^.+(%..+)$")}"
                File = io.open(filename, "w")
                File\write(file.content)
                File\close!

                @html ->
                    p "Uploaded #{file.filename}, #{#file.content} bytes written. Saved to /#{filename}"

                new_save = Saves\create {
                    file: filename
                    report: @params.report
                    -- user: ?
                    -- user_id: ?
                    user_id: (Users\find name: "test").id
                }
                --TODO learn how to catch an error here and display better error page

                if new_save
                    @html -> p "Save created in database. Oo"

            else
                "Please refresh the page and actually upload a file." --this is bad form...
    }
