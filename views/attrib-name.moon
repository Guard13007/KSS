import Widget from require "lapis.html"

class extends Widget
    content: =>
        p "In an attribute name: "
        p [@value.value]: "data", "This is hacked?"
