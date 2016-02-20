import Model from require "lapis.db.model"

class Users extends Model
    @timestamp: true
    url_params: (req, ...) =>
        "user", {name: @name}, ...

    @constraints: {
        name: (value) =>
            if not value
                return "You must have a username."

            if Users\find name: value
                return "That username is already taken."

            lower = value\lower!
            if (lower == "admin") or (lower == "administrator") or (lower == "new")
                return 'Users cannot be named "admin", "administrator", or "new".'

        password: (value) =>
            if #value == 0
                return "You must have a password."

            if #value < 4
                return "Your password must be at least 4 characters."

        weekday: (value) =>
            value = 0 unless value -- enforce defaulting to zero

            if (value > 7) or (value < 0)
                return "Weekday must be 0 to 7. 0 disables a user from uploading, 1-7 represents Sunday through Saturday."
    }

    @relations: {
        {"saves", has_many: "Saves"}
        -- user\get_saves! --a list of save objects
        -- saves = user\get_saves_paginated per_page: 50 --get a paginator, 50 saves at a time
        -- saves\get_page 3 --get a list of saves based on page
    }
