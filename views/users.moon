import Widget from require "lapis.html"
import get_day_name from require "helpers.time"
import max from math

class UsersWidget extends Widget
    content: =>
        element "table", class: "pure-table", ->
            thead ->
                tr ->
                    th "Administrators"
                    th colspan: 2, "Active Users"
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
                            td -> a href: @url_for(@users.admins[i]), @users.admins[i].name
                        else
                            td ""

                        if @users.active[i]
                            td -> a href: @url_for(@users.active[i]), @users.active[i].name
                            td -> text get_day_name @users.active[i].weekday
                        else
                            td ""
                            td ""

                        if @users.inactive[i]
                            td -> a href: @url_for(@users.inactive[i]), @users.inactive[i].name
                        else
                            td ""
