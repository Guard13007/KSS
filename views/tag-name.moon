import Widget from require "lapis.html"

class extends Widget
    content: =>
        p "In a tag name: "
        raw "<#{@value.value}>This is broken.</#{@value.value}>" --DEFINITELY BROKEN (but only cause stupid)
