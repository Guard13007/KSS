import Model from require "lapis.db.model"

class XSS extends Model
    @table_name: => "xss"
    url_params: (req, ...) =>
        "xss2", {id: @id}, ...
