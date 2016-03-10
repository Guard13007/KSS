import Model from require "lapis.db.model"
import escape from require "lapis.util"
import trim from require "helpers"

class Users extends Model
    @timestamp: true
    url_params: (req, ...) =>
        "user", {name: escape(@name)}, ... --is escaping here correct?

    @constraints: {
        name: (value) =>
            --TODO honestly, I should just allow letters, numbers, and _ and - ONLY...

            if value\find "/"
                return "Usernames cannot have a / in them."

            -- block these?  ?=#

            if not value
                return "You must have a username."

            if Users\find name: value
                return "That username is already taken."

            if value != trim value
                return "Usernames must not start or end with spaces. \"#{value}\""

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

            value = tonumber value --fixes accidentally using a string that would otherwise be valid
            if value == nil
                return "Please enter a valid number."

            if (value > 7) or (value < 0)
                return "Weekday must be 0 to 7. 0 disables a user from uploading, 1-7 represents Sunday through Saturday."
    }

    @relations: {
        {"saves", has_many: "Saves"}
        -- user\get_saves! --a list of save objects
        -- saves = user\get_saves_paginated per_page: 50 --get a paginator, 50 saves at a time
        -- saves\get_page 3 --get a list of saves based on page
    }
