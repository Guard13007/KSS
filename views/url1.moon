import Widget from require "lapis.html"

class extends Widget
    content: =>
        p "In a URL: "
        p, ->
            a href: "https://fake.site/?q=#{@value.value}", "Click me if you dare."
