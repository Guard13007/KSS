lapis = require "lapis"

Saves = require "models.Saves" --TODO learn how to use the fancy autoload thing properly

import respond_to from require "lapis.application" --not needed?

class SavesApp extends lapis.Application
    "/save": => redirect_to: @url_for("saves"), status: 301

    [saves: "/saves"]: =>
        if saves = Saves\select!
            --TODO rewrite using a Widget and add the proper things!
            @html ->
                if #saves > 0
                    ul ->
                        for id in pairs saves
                            li ->
                                a href: @url_for("save", id: id), id --NOTE I don't like this format / style
                else
                    p "No saves."

    [save: "/save/:id"]: => --TODO rewrite this as well! more details please!
        @html ->
            if save = Saves\find @params.id
                h1 "It's working, shut up"
                p @params.id
                a href: @build_url(save.file), "Test"
            else
                @write status: 404, "Not found"
