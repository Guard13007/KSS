import Widget from require "lapis.html"

class Layout extends Widget
    content: =>
        html_5 ->
            head ->
                meta charset: "utf-8"
                meta name: "viewport", content: "width=device-width, initial-scale=1.0"
                title @title or "kss2"
                link rel: "stylesheet", href: @build_url "static/css/pure-min.css"
                link rel: "stylesheet", href: @build_url "static/css/side-menu.css"
            body ->
                div id: "layout", ->
                    a href: "#menu", id: "menuLink", class: "menu-link", ->
                        span -- Hamburger icon!
                    div id: "menu", ->
                        div class: "pure-menu", ->
                            a class: "pure-menu-heading", href: @url_for("index"), "K.S.S." --NOTE top level special looking link (should it be used??)
                            ul class: "pure-menu-list", ->
                                --li class: "pure-menu-item", -> a href: "#", class: "pure-menu-link", "Home"
                                li class: "pure-menu-item", -> a href: @url_for("saves"), class: "pure-menu-link", "Saves"
                                li class: "pure-menu-item", -> a href: @url_for("users"), class: "pure-menu-link", "Users"
                            hr style: "color: white;" --TODO put these styles in CSS
                            p "Current user:", br, "NAME" --TODO pull from database
                            p "Time remaining:", br, "TIME" --TODO pull from database
                            p "Next user:", br, "NAME" --TODO pull from database
                            hr style: "color: white;" --TODO put these styles in CSS
                            ul class: "pure-menu-list", ->
                                --li class: "pure-menu-item", -> a href: @url_for("create_user"), class: "pure-menu-link", "Create Account"
                                --li class: "pure-menu-item", -> a href: @url_for("login"), class: "pure-menu-link", "Log In"
                                --li class: "pure-menu-item", -> a href: @url_for("logout"), class: "pure-menu-link", "Log Out"
                                li class: "pure-menu-item", -> a href: "#", class: "pure-menu-link", "Create Account"
                                li class: "pure-menu-item", -> a href: "#", class: "pure-menu-link", "Log In"
                                li class: "pure-menu-item", -> a href: "#", class: "pure-menu-link", "Log Out"
                            hr style: "color: white;" --TODO put these styles in CSS
                            p "Date:", br, os.date("!%Y-%m-%d", os.time()) , br, "Time:", br , os.date("!%H-%M.%S", os.time())
                    div id: "main", ->
                        div class: "header", ->
                            h1 @title or "Kerbal Save Sharing"
                            h2 @subtitle if @subtitle --TODO test (this should only render a subtitle if there is one)
                        div class: "content", ->
                            @content_for "inner"
                            --h2 class: "content-subhead", "Some sub-header"
                            --p "Some long string of test, like a paragraph or something. Honestly, this is where @content_for should go, but I'm putting temporary bullshit here."
                script src: @build_url "static/js/ui.js"
