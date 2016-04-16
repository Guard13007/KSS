import Model from require "lapis.db.model"
import escape, trim from require "lapis.util"

class Users extends Model
    @timestamp: true
    url_params: (req, ...) =>
        "user", {name: escape(@name)}, ...

    @constraints: {
        name: (value) =>
            if not value
                return "You must have a username."

            value = trim value

            if value\find "%W"
                return "Usernames can only contain alphanumeric characters."

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

        weekday: (value=0) =>
            -- fix accidentally using a string that would otherwise be valid
            value = tonumber value
            if value == nil
                return "Please enter a valid number."

            -- must be in range (0 = no day, 1-7 = Sunday to Saturday)
            if (value > 7) or (value < 0)
                return "Weekday must be 0 to 7. 0 disables a user from uploading, 1-7 represents Sunday through Saturday."
    }

    @relations: {
        {"saves", has_many: "Saves"}
        -- user\get_saves! --a list of save objects
        -- saves = user\get_saves_paginated per_page: 50 --get a paginator, 50 saves at a time
        -- saves\get_page 3 --get a list of saves based on page
    }
