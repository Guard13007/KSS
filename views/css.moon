import Widget from require "lapis.html"

class extends Widget
    content: =>
        p "Inside CSS: "
        style, ->
            @value.value
