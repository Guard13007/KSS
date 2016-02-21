import Widget from require "lapis.html"

class Index extends Widget
    content: =>
        h3 ->
            text "Welcome to K.S.S. Still a work-in-progress, so not much to show "
            em "here"
            text " yet."
        p, style: "color: red;", ->
            b "Note"
            text ": SSL has not been set up yet. This is for testing only right now. DO NOT use a password you use elsewhere."
        p ->
            text "Welcome, please make an account and "
            a href: "https://discord.gg/0e25Cmk0wjIXjc5I", "contact an administrator"
            text " to ask to be given an upload day. When you have been assigned a day, please test the upload/download system with KSP save-games and craft files."
