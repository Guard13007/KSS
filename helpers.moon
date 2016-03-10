import yield_error from require "lapis.application"

get_day = (day) ->
    switch day
        when 0
            return "None"
        when 1
            return "Sunday"
        when 2
            return "Monday"
        when 3
            return "Tuesday"
        when 4
            return "Wednesday"
        when 5
            return "Thursday"
        when 6
            return "Friday"
        when 7
            return "Saturday"
        else
            if @user
                yield_error("User \"#{@user.name}\" (ID: \"#{@user.id}\") has invalid weekday.")
            else
                yield_error("Invalid day. (Please use @user when calling get_day!)")

gmt_time = () ->
    return os.time(os.date("!*t"))

return {
    :get_day
    :gmt_time
}
