lapis = require "lapis"

Saves = require "models.Saves"

class SavesApp extends lapis.Application
    "/save": => redirect_to: @url_for("saves"), status: 301

    [saves: "/saves"]: =>
        @saves = Saves\select!
        @title = "All Saves"
        render: true

    [save: "/save/:id"]: =>
        @save = Saves\find id: @params.id

        if not @save
            @title "Save Not Found"
            return status: 404, "Not found."

        @title = "Save File"
        @subtitle = @save.id
        render: true
