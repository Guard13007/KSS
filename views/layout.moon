import Widget from require "lapis.html"
import gmt_date, get_day_name from require "helpers.time"
import shallow_copy from require "helpers.table"

Users = require "models.Users"

class Layout extends Widget
    content: =>
        html_5 ->
            head ->
                meta charset: "utf-8"
                meta name: "viewport", content: "width=device-width, initial-scale=1.0"
                title @title or "K.S.S."
                link rel: "stylesheet", href: @build_url "static/css/pure-min.css"
                link rel: "stylesheet", href: @build_url "static/css/side-menu.css"
                link rel: "stylesheet", href: @build_url "static/css/custom.css"
            body ->
                div id: "layout", ->
                    a href: "#menu", id: "menuLink", class: "menu-link", ->
                        span! -- Hamburger icon!
                    div id: "menu", ->
                        div class: "pure-menu", ->
                            a class: "pure-menu-heading", href: @url_for("index"), "Home"
                            ul class: "pure-menu-list", ->
                                li class: "pure-menu-item", -> a href: @url_for("saves"), class: "pure-menu-link", "Saves"
                                li class: "pure-menu-item", -> a href: @url_for("users"), class: "pure-menu-link", "Users"
                            hr!
                            time = gmt_date!
                            day = time.wday
                            user = Users\find weekday: day
                            if user
                                p "Current user:", br, user.name
                            else
                                p "Current user:", br, "N/A"
                            today = shallow_copy(time)
                            today.hour = 0
                            today.min = 0
                            today.sec = 0
                            today = os.time(today)
                            time_to_tomorrow = today + 24*60*60 - os.time(time) -- start of today + a day - time of today = raw time till tomorrow
                            -- process time remaining in seconds to an hours and minutes value
                            mins = math.floor time_to_tomorrow/60
                            hours = math.floor mins/60
                            mins = mins%60
                            if hours < 10
                                hours = "0#{hours}"
                            if mins < 10
                                mins = "0#{mins}"
                            p ->
                                text "Time remaining:"
                                br!
                                text "#{hours}:#{mins}"
                            tomorrow = day + 1
                            if tomorrow == 8
                                tomorrow = 1
                            user = Users\find weekday: tomorrow
                            if user
                                p "Next user:", br, user.name
                            else
                                p "Next user:", br, "N/A"
                            hr!
                            ul class: "pure-menu-list", ->
                                if @session.id
                                    li class: "pure-menu-item", -> a href: @url_for("logout"), class: "pure-menu-link", "Log Out"
                                    user = Users\find id: @session.id
                                    if (user.weekday == day) or user.admin
                                        li class: "pure-menu-item", -> a href: @url_for("upload"), class: "pure-menu-link", "Upload"
                                else
                                    li class: "pure-menu-item", -> a href: @url_for("login"), class: "pure-menu-link", "Log In"
                                    li class: "pure-menu-item", -> a href: @url_for("create_user"), class: "pure-menu-link", "Create Account"
                            hr!
                            p "Day:", br, get_day_name(time.wday), br, "Date:", br, os.date("!%Y/%m/%d"), br, "Time:", br, os.date("!%H:%M")
                    div id: "main", ->
                        div class: "header", ->
                            h1 @title or "Kerbal Warfare"
                            h2 @subtitle if @subtitle
                        div class: "content", ->
                            @content_for "inner"
                    div id: "footer", ->
                        hr!
                        a href: "https://github.com/Guard13007/KSS", target: "_blank", "Source"
                        text " | "
                        a href: "https://github.com/Guard13007/KSS/issues", target: "_blank", "Issues"
                script src: @build_url "static/js/ui.js"
