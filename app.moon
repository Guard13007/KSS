lapis = require "lapis"

models = require "models"

import respond_to from require "lapis.application"

class App extends lapis.Application
    @include "pages.users"
    @include "pages.saves"

    layout: "layout"  -- require views.layout

    [index: "/"]: =>
        render: true -- views.index

    [upload: "/upload"]: respond_to {
        --TODO before: =>
        GET: =>
            render: "UploadWidget"
        POST: =>
            file = @params.file
            if #file.content > 0
                require("moon").p file
                date = os.date("!%Y-%m-%d.%H-%M.%S", os.time())
                filename = "static/uploads/#{date .. file.filename\match("^.+(%..+)$")}"
                File = io.open(filename, "w")
                File\write(file.content)
                File\close!

                @html ->
                    p "Uploaded #{file.filename}, #{#file.content} bytes written. Saved to /#{filename}"

                new_save = models.Saves\create {
                    file: filename
                    report: "Testing."
                    -- user: ?
                    -- user_id: ?
                    user_id: (models.Users\find name: "test").id
                }
                --TODO learn how to catch an error here and display better error page

                if new_save
                    @html -> p "Save created in database. Oo"

            else
                "Please refresh the page and actually upload a file." --this is bad form...
    }
