import Widget from require "lapis.html"

class XSS2 extends Widget
    content: =>
        p "In a paragraph element: "
        p @value.value
        p "In a script tag: "
        script, ->
            "var i = #{@value.value};"
        p "In an attribute name: "
        p [@value.value]: "data", "This is hacked?"
        p "In an attribute's value: "
        p data: @value.value, "This is not hacked?"
        p "In an event handling attribute: "
        p onmouseover: "var i = #{@value.value};", "Hover over me."
        p "Inside CSS: "
        style, ->
            @value.value
        p "In a URL: "
        p, ->
            a href: "https://fake.site/?q=#{@value.value}", "Click me if you dare."
        p, ->
            a href: @value.value, "Click *me* if you dare."
        p "In an HTML comment: "
        raw "<!--#{@value.value}-->" --DEFINITELY VULNERABLE (but only because I'm using it stupidly)
        p "In a tag name: "
        raw "<#{@value.value}>This is broken.</#{@value.value}>" --DEFINITELY BROKEN (but only cause stupid)
