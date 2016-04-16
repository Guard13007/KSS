import Widget from require "lapis.html"

class Index extends Widget
    content: =>
        h3 ->
            text "Nothing much on the homepage. Sign in or make an account or something."
        p ->
            text "Welcome, please make an account and "
            a href: "https://discord.gg/0e25Cmk0wjIXjc5I", target: "_blank", "contact an administrator"
            text " to ask to be given an upload day. When you have been assigned a day, please test the upload/download system with KSP save-games and craft files."
