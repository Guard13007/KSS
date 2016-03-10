lapis = require "lapis"
csrf = require "lapis.csrf"

class App extends lapis.Application
    @before_filter =>
        @csrf_token = csrf.generate_token @

    @include "pages.users"
    @include "pages.saves"
    @include "pages.upload"

    layout: "layout"  -- require views.layout

    [index: "/"]: =>
        render: true -- views.index
