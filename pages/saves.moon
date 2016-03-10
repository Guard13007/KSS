lapis = require "lapis"
csrf = require "lapis.csrf"

Saves = require "models.Saves"
Users = require "models.Users"

import respond_to from require "lapis.application"

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
            unless csrf.validate_token @
                return "Invalid token. Please try again." --TODO pretty print errors

            -- TODO the first 3 if's should go into a is_admin function
            -- specifically user = is_admin! (returns nil or the user if they are admin)
            --  so use is "if user = is_admin!", and then do whatever if they are an admin
            @title = "Error"

            if @session.id
                if user = Users\find id: @session.id
                    if user.admin
                        if @params.delete == "on"
                            if save = Saves\find id: @params.save_id
                                if save\delete!
                                    @title = nil
                                    return "Save deleted."
                                else
                                    return "Error deleting save."
                            else
                                return "Save not found."
                    else
                        return "You must be an administrator to perform this action."

            return "You must be logged in to perform this action."
    }
