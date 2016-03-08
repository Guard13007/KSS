import Widget from require "lapis.html"

class extends Widget
    content: =>
        p "In a script tag: "
        script, ->
            "var i = \"#{@value.value}\";"
