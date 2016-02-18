import Model from require "lapis.db.model"

class Saves extends Model
    @timestamp: true
    url_params: (req, ...) =>
        "save", {id: @id}, ...

    @constraints: {
        -- no file constraint because if it fails, that's a serious issue
        --TODO determine if I can use a constraint to CHANGE a value instead of
        --     just detecting errors. Duplicate file values could have a value
        --     appended to the non-ext part to no longer be a duplicate.

        report: (value) =>
            if #value < 1
                "Uploaded saves must have a mission report."
    }

    @relations: {
        {"user", belongs_to: "Users"}
    }
