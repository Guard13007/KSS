import Model from require "lapis.db.model"

class XSS extends Model
    url_params: (req, ...) =>
        "xss2", {id: @id}, ...
