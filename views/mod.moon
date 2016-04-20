--{"id", types.serial primary_key: true}
--{"name", types.text unique: true}
--{"status", types.integer default: 0}
--{"description", types.text}
--{"info_link", types.text}
--{"download_link", types.text unique: true}
--{"config_download", types.text unique: true}
--{"version", types.text}
--{"notes", types.text}

import Widget from require "lapis.html"

class Mod extends Widget
    content: =>
        -- do stuff!
