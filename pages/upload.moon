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
            render: true
        POST: =>
            csrf.assert_token @

            if not @session.username
                return "You must be logged in to upload a file."

            -- is this user allowed to upload NOW??
            weekday = os.date("!*t").wday
            user = Users\find name: @session.username
            if not (user.weekday == weekday) and (not user.admin) --if not their day and not admin
                return "You are not allowed to upload today. Please check the schedule."

            file = @params.file
            if #file.content > 0
                date = os.date("!%Y-%m-%d.%H-%M.%S", os.time())
                filename = "static/uploads/#{date .. file.filename\match("^.+(%..+)$")}"

                if file_exists filename
                    return "Error: Please upload again in a moment, and report this error to Guard13007 immediately."
                else
                    File = io.open(filename, "w")
                    File\write file.content
                    File\close!

                    new_save, errorMsg = Saves\create {
                        file: filename
                        report: @params.report
                        user_id: (Users\find name: @session.username).id
                    }

                    if new_save
                        redirect_to: @url_for "save", id: new_save.id
                    else
                        os.remove(filename) --delete the file, (failed saving to database)
                        return errorMsg
            else
                return "Please go back and upload a file."
    }
