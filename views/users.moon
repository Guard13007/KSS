import Widget from require "lapis.html"
import get_day from require "helpers"

class UserWidget extends Widget
    content: =>
        element "table", class: "pure-table", ->
            thead ->
                tr ->
                    th "Name"
                    th "Weekday"
            tbody ->
                if #@users > 0
                    require("moon").p @users --temporary, take a look at it
                    for id in ipairs @users --I want to sort by name...
                        tr ->
                            td -> a href: @url_for("user", name: @users[id].name), @users[id].name
                            td -> get_day @users[id].weekday
                else
                    tr ->
                        td "None"
                        td "N/A"
