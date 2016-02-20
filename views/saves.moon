import Widget from require "lapis.html"

Users = require "models.Users"

class SavesWidget extends Widget
    content: =>
        element "table", class: "pure-table", ->
            thead ->
                tr ->
                    th "Uploaded at (UTC)"
                    th "User"
                    th "Download"
                    th "Info/Mission Report"
            tbody ->
                if #@saves > 0
                    require("moon").p @saves --TODO figure out why this is here
                    for id in ipairs @saves
                        tr ->
                            td @saves[id].created_at
                            user = Users\find id: @saves[id].user_id --NOTE probably massively inefficient, lots of queries!!
                            td -> a href: @url_for("user", name: user.name), user.name
                            td -> a href: @build_url(@saves[id].file), target: "_blank", download: true, "Download"
                            td -> a href: @url_for("save", id: id), "Info/Mission Report"
                else
                    tr ->
                        td "None"
                        td "N/A"
                        td "No uploads"
                        td "No data"
        hr!
        p ->
            text "If download links are opening in a new tab instead of downloading, please right-click the link and choose 'save-as' (or "
            a href: "http://caniuse.com/#feat=download", "use a better browser"
            text ")."
