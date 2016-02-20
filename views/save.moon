import Widget from require "lapis.html"

class SaveWidget extends Widget
    content: =>
        pre @save.report
        hr!
        p "Created by: ", (@save\get_user!).name --NOTE should be valid, but not sure
        p -> a href: @build_url(@save.file), "Download" --TODO make file ext available here
