import Widget from require "lapis.html"

class extends Widget
    content: =>
        p "In an HTML comment: "
        raw "<!--#{@value.value}-->" --DEFINITELY VULNERABLE (but only because I'm using it stupidly)
