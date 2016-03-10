lapis = require "lapis"
csrf = require "lapis.csrf"

Saves = require "models.Saves"
Users = require "models.Users"

import respond_to, assert_error from require "lapis.application"

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
            @title = "Upload a Save"
            render: true
        POST: =>
            unless csrf.validate_token @
                return "Invalid token. Please try again." --TODO pretty print errors

            @title = "Error" --redirects on success, so this will only apply to an error

            if not @session.id
                return "You must be logged in to upload a file."

            -- is the user allowed to upload now?
            day = os.date("!*t").wday
            user = Users\find id: @session.id
            if not (user.weekday == day) and (not user.admin) --if not their day and not admin
                return "You are not allowed to upload today. Please check the schedule."

            file = @params.file
            if #file.content > 0
                date = os.date("!%Y.%m.%d.%H.%M.%S")
                filename = "static/uploads/#{date .. file.filename\match("^.+(%..+)$")}" --TODO make this a file_ext function ? also store file extension

                if file_exists filename
                    return "Error: Please upload again in a moment, and report this error to Guard13007 immediately." --TODO remove the need for this error (by automatically choosing a new file name)

                File = assert_error io.open filename, "w"
                File\write file.content
                File\close!

                new_save, errorMsg = Saves\create {
                    file: filename
                    report: @params.report
                    user_id: user.id
                }

                if new_save
                    return redirect_to: @url_for new_save
                else
                    os.remove filename --delete the file, (failed saving to database)
                    return errorMsg
            else
                return "Please upload a file with content."
    }
