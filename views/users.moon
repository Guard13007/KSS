import Widget from require "lapis.html"
import get_day from require "helpers"
import max from math

class UsersWidget extends Widget
    content: =>
        element "table", class: "pure-table", ->
            thead ->
                tr ->
                    th "Administrators"
                    th "Active Users", colspan: 2
                    th "Inactive Users"
                tr ->
                    th "Name"
                    th "Name"
                    th "Weekday"
                    th "Name"
            tbody ->
                count = max #@users.admins, #@users.active, #@users.inactive
                for i = 1, count
                    tr ->
                        if @users.admins[i]
                            td -> a href: @url_for("user", name: @users.admins[i].name), @users.admins[i].name
                        else
                            td ""

                        if @users.active[i]
                            td -> a href: @url_for("user", name: @users.active[i].name), @users.active[i].name
                            td -> text get_day @users.active[i].weekday
                        else
                            td ""
                            td ""

                        if @users.inactive[i]
                            td -> a href: @url_for("user", name: @users.inactive[i].name), @users.inactive[i].name
                        else
                            td ""
