import Model, enum from require "lapis.db.model"

class Mods extends Model
    @timestamp: true
    url_params: (req, ...) =>
        "mod", {id: @id}, ...

    @constraints: {
        status: (value) =>
            unless @statuses[value]
                return "Invalid status."
    }

    @statuses: enum {
        no_status: 0
        under_consideration: 1
        bugged: 2
        enhancement: 3
        required: 4
        rejected: 5
        incompatible: 6
    }
