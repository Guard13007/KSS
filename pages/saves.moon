lapis = require "lapis"
csrf = require "lapis.csrf"

Saves = require "models.Saves"
Users = require "models.Users"

import respond_to, assert_error from require "lapis.application"

class SavesApp extends lapis.Application
    "/save": => redirect_to: @url_for("saves"), status: 301

    [saves: "/saves"]: =>
        @saves = Saves\select "ORDER BY created_at DESC"
        @title = "All Saves"
        render: true

    [save: "/save/:id"]: =>
        @save = Saves\find id: @params.id

        if not @save
            @title = "404: Not Found"
            return status: 404, h3 "Save not found."

        @title = "Save File"
        @subtitle = @save.id
        render: true

    [modify_save: "/modify_save"]: respond_to {
        GET: =>
            return status: 404, "Not found."
        POST: =>
            unless @session.id
                return "You must be logged in to access this page."
            unless csrf.validate_token @
                return "Invalid token. Please try again." --TODO pretty print errors

            @title = "Error"

            -- TODO the first 3 if's should go into a is_admin function
            -- specifically user = is_admin! (returns nil or the user if they are admin)
            --  so use is "if user = is_admin!", and then do whatever if they are an admin

            save = assert_error Saves\find id: @params.save_id
            current_user = assert_error Users\find id: @session.id
            user = assert_error save\get_user!

            if @params.form == "user_edit"
                save.report = @params.report
                save = assert_error save\update!
                redirect_to: @url_for save
            if @params.form == "admin_edit"
                if current_user.admin
                    if @params.delete == "on"
                        file = save.file
                        if save\delete! --NOTE WE NEED A "ON-DELETE TO ALSO REMOVE THE FILE ITSELF!"
                            @title = nil
                            os.remove file
                            return "Save deleted." --TODO redirect with message instead of its own "page"
                        else
                            return "Error while trying to delete save."
                else
                    return "You must be an administrator to perform this action."
    }
