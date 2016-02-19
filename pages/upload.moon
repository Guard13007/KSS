lapis = require "lapis"
csrf = require "lapis.csrf"

Saves = require "models.Saves"
Users = require "models.Users"

import respond_to from require "lapis.application"

file_exists = (filename) ->
    handle = io.open(filename, "r")
    if handle == nil
        return false
    else
        handle\close!
        return true

class UploadApp extends lapis.Application
    [upload: "/upload"]: respond_to {
        GET: =>
            @token = csrf.generate_token @
            @title = "Upload a Save"
            render: true
        POST: =>
            csrf.assert_token @

            @title = "Error" --redirects on success, so this will only apply to an error

            if not @session.username
                return "You must be logged in to upload a file."

            -- is the user allowed to upload now?
            day = os.date("!*t").wday
            user = Users\find name: @session.username
            if not (user.weekday == day) and (not user.admin) --if not their day and not admin
                return "You are not allowed to upload today. Please check the schedule."

            file = @params.file
            if #file.content > 0
                date = os.date("!%Y.%m.%d.%H.%M.%S")
                filename = "static/uploads/#{date .. file.filename\match("^.+(%..+)$")}"

                if file_exists filename
                    return "Error: Please upload again in a moment, and report this error to Guard13007 immediately." --TODO remove the need for this error

                File, errorMsg = io.open(filename, "w")
                if File
                    File\write file.content
                    File\close!
                else
                    return errorMsg

                new_save, errorMsg = Saves\create {
                    file: filename
                    report: @params.report
                    user_id: user.id
                }

                if new_save
                    return redirect_to: @url_for "save", id: new_save.id
                else
                    os.remove filename --delete the file, (failed saving to database)
                    return errorMsg
            else
                return "Please upload a file with content."
    }
