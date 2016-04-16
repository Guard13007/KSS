get_day_name = (day) ->
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
            if @user --NOTE this line itself might error, I need to intentionally test this with bad data
                error("User \"#{@user.name}\" (ID: \"#{@user.id}\") has invalid weekday.")
            else
                error("Invalid day (#{day}).")

gmt_date = () ->
    return os.date("!*t")

gmt_time = () ->
    return os.time(os.date("!*t"))

return {
    :get_day_name
    :gmt_date
    :gmt_time
}
