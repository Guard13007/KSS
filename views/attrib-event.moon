import Widget from require "lapis.html"

class extends Widget
    content: =>
        p "In an event handling attribute: "
        p onmouseover: "var i = \"#{@value.value}\";", "Hover over me."
