lapis = require "lapis"
csrf = require "lapis.csrf"

Saves = require "models.Saves"
Users = require "models.Users"

import respond_to, assert_error from require "lapis.application"
import gmt_date from require "helpers.time"

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

            if not @session.id
                return "You must be logged in to upload."

            user = Users\find id: @session.id
            day = gmt_date!.wday

            if not (user.weekday == day) and (not user.admin)
                return "You are not allowed to upload today. Please check the schedule."

            render: true
        POST: =>
            unless csrf.validate_token @
                return "Invalid token. Please try again." --TODO pretty print errors

            @title = "Error" --redirects on success, so this will only apply to an error

            if not @session.id
                return "You must be logged in to upload a file."

            -- is the user allowed to upload now?
            day = gmt_date!.wday
            user = Users\find id: @session.id
            if not (user.weekday == day) and (not user.admin) --if not their day and not admin
                return "You are not allowed to upload today. Please check the schedule."

            file = @params.file
            if #file.content > 0
                date = os.date "!%Y.%m.%d.%H.%M.%S"
                ext = file.filename\match "^.+(%..+)$"
                save_file = "static/uploads/#{date .. ext}"
                filename = file.filename\sub(1, -ext\len! - 1)

                if file_exists save_file
                    return "Error: Please upload again in a moment, and report this error to Guard13007 immediately." --TODO remove the need for this error (by automatically choosing a new file name)

                File = assert_error io.open save_file, "w"
                File\write file.content
                File\close!

                new_save, errorMsg = Saves\create {
                    file: save_file
                    filename: filename
                    filetype: ext
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
