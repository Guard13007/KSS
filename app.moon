lapis = require "lapis"

models = require "models"

import respond_to from require "lapis.application"

class extends lapis.Application
    layout: "layout"  -- require views.layout

    --[index: "/"]: =>
    --    redirect_to: @url_for "saves"
    [index: "/"]: =>
        render: true --should render views.index ?

    [save: "/save/:id"]: =>
        @html ->
            if save = models.Saves\find @params.id
                h1 "It's working, shut up"
                p @params.id
                a href: @build_url(save.file), "Test"
            else
                @write status: 404, "Not found"

    "/save": => redirect_to: @url_for("saves"), status: 301
    [saves: "/saves"]: =>
        if saves = models.Saves\select!
            @html ->
                if #saves > 0
                    ul ->
                        for id in pairs saves
                            li ->
                                a href: @url_for("save", id: id), id --NOTE not sure if will work, and I don't like it
                else
                    p "No saves."

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

    --NOTE SUPER TEMPORARY PLACEHOLDER:
    [users: "/users"]: =>
        "Not done yet!"

    [create_user: "/create_user"]: respond_to {
        GET: =>
            render: "CreateUser"
        POST: =>
            require("moon").p @params
            if @params.admin
                @params.admin = true
            else
                @params.admin = false

            require("moon").p @params.username
            new_user = models.Users\create {
                name: @params.username
                password: @params.password
                admin: @params.admin
            }
            --TODO capture error and display appropriate response!

            if new_user
                @html -> p "Woo! New user! :D"
    }
