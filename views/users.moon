import Widget from require "lapis.html"
import get_day from require "helpers"

class UsersWidget extends Widget
    content: =>
        element "table", class: "pure-table", ->
            thead ->
                tr ->
                    th "Name"
                    th "Weekday"
            tbody ->
                if #@users > 0
                    for i in ipairs @users
                        tr ->
                            td -> a href: @url_for("user", name: @users[i].name), @users[i].name
                            td -> text get_day @users[i].weekday
                else
                    tr ->
                        td "None"
                        td "N/A"
