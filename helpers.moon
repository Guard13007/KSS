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
            error("User \"#{@user.name}\" (ID: \"#{@user.id}\") has invalid weekday.") -- this will break when @user isn't defined...

gmt_time = () ->
    return os.time(os.date("!*t"))

trim = (s) ->
    return s\match '^()%s*$' and '' or s\match '^%s*(.*%S)'

return { :get_day, :gmt_time, :trim }
