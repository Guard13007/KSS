import Widget from require "lapis.html"

class extends Widget
    content: =>
        p "In a paragraph element: "
        p @value.value
