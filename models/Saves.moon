import Model from require "lapis.db.model"

class Saves extends Model
    @timestamp: true
    url_params: (req, ...) =>
        "save", {id: @id}, ...

    @relations: {
        {"user", belongs_to: "Users"}
    }
