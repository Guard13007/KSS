lapis = require "lapis"

class App extends lapis.Application
    @include "pages.users"
    @include "pages.saves"
    @include "pages.upload"

    layout: "layout"  -- require views.layout

    [index: "/"]: =>
        render: true -- views.index
