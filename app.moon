lapis = require "lapis"

class App extends lapis.Application
    @include "pages.users"
    @include "pages.saves"
    @include "pages.upload"
    @include "pages.xss"

    layout: "layout"  -- require views.layout

    [index: "/"]: =>
        render: true -- views.index
