import Widget from require "lapis.html"
import get_day from require "helpers"

Users = require "models.Users"

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
            current_user = Users\find name: @session.username
            if @user.name == current_user.name
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

            if current_user.admin and
                hr!
                h2 "Admin Panel"
                form {
                    action: "/modify_user"
                    method: "POST"
                    enctype: "multipart/form-data"
                    class: "pure-form"
                }, ->
                    p "Rename:"
                    input type: "text", name: "name", defaultValue: @user.name --NOTE defaultValue doesn't seem to actually do anything
                    p "Weekday (0-7):" --TODO consider changing to a dropdown menu selection
                    input type: "number", name: "weekday", value: @user.weekday
                    p "Admin? "
                    if @user.admin
                        input type: "checkbox", name: "admin", checked: true
                    else
                        input type: "checkbox", name: "admin"
                    p "Delete user? "
                    input type: "checkbox", name: "delete"
                    input type: "hidden", name: "user_id", value: @user.id
                    input type: "hidden", name: "csrf_token", value: @token
                    br!
                    input type: "submit"
