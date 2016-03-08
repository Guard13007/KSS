import Widget from require "lapis.html"

class extends Widget
    content: =>
        p "In an attribute's value: "
        p data: @value.value, "This is not hacked?"
