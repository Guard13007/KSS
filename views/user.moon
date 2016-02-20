import Widget from require "lapis.html"

Users = require "models.Users"

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
            error("User \"#{@user.name}\" (ID: \"#{@user.id}\") has invalid weekday.")

class UserWidget extends Widget
    content: =>
        p "This user's weekday is: ", get_day @user.weekday
        p "Sorry, not much else available on users yet. We're working on it."
        hr!
        if @user.admin
            p "This user is an admin."
            hr!
        p "Created at: ", @user.created_at
        p "Last updated at: ", @user.updated_at
        if @session.username
            user = Users\find name: @session.username
            if @user.name == @session.username
                hr!
                h2 "Change Password?"
                form {
                    action: "/modify_user"
                    method: "POST"
                    enctype: "multipart/form-data"
                    class: "pure-form"
                }, ->
                    p "Old password:"
                    input type: "password", name: "oldpassword"
                    p "New password:"
                    input type: "password", name: "password"
                    input type: "hidden", name: "user_id", value: @user.id
                    input type: "hidden", name: "csrf_token", value: @token
                    br!
                    input type: "submit"

            if user.admin and
                hr!
                h2 "Admin Panel"
                form {
                    action: "/modify_user"
                    method: "POST"
                    enctype: "multipart/form-data"
                    class: "pure-form"
                }, ->
                    p "Rename:"
                    input type: "text", name: "name"
                    p "Weekday (0-7):" --TODO consider changing to a dropdown menu selection
                    input type: "number", name: "weekday"
                    p "Admin? "
                    input type: "checkbox", name: "admin"
                    p "Delete user? "
                    input type: "checkbox", name: "delete"
                    input type: "hidden", name: "user_id", value: @user.id
                    input type: "hidden", name: "csrf_token", value: @token
                    br!
                    input type: "submit"
