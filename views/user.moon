import Widget from require "lapis.html"

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
            return "An error has occured. A very serious error. Contact Guard13007 at once!"

class UserWidget extends Widget
    content: =>
        p "This user's weekday is:", get_day @user.weekday
        p "Sorry, not much else available on users yet. We're working on it."
        hr!
        p "Is admin? ", @user.admin
        hr!
        p "Created at: ", @user.created_at
        p "Last updated at: ", @user.updated_at
