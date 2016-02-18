import Model from require "lapis.db.model"

class Users extends Model
    @timestamp: true
    url_params: (req, ...) =>
        "user", {name: @name}, ...

    @constraints: {
        name: (value) =>
            if not value
                "You must have a username."

            value = value\lower! --NOTE does this just check or does it CHANGE the value? TEST THIS

            if Users\find name: value
                "That username is already taken."

            if (value == "admin") or (value == "administrator") or (value == "new")
                'Users cannot be named "admin", "administrator", or "new".'
        password: (value) =>
            if not value
                "You must have a password."
            if #value < 4
                "Your password must be at least 4 characters."
    }

    @relations: {
        {"saves", has_many: "Saves"}
    }
