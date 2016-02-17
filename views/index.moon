--NOTE this file is essentially a testing placeholder. get rid of it or improve it

import Widget from require "lapis.html"

class Index extends Widget
    content: =>
        h1 class: "header", "Test!"
        div class: "body", ->
            text "If you are seeing this, it has worked!"
            h3 "Hurray!"
