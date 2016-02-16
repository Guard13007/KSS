import Model from require "lapis.db.model"

class Users extends Model
    @timestamp: true
    url_params: (req, ...) =>
        "user", {name: @name}, ...

    @constraints: {
        name: (value) =>
            require("moon").p value
            value = value\lower!
            if (value == "admin") or (value == "administrator") or (value == "new")
                'Users cannot be named "admin", "administrator", or "new".'
    }

    @relations: {
        {"saves", has_many: "Saves"}
    }
