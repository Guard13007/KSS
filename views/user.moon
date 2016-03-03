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
        if @session.id
            current_user = Users\find id: @session.id
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
                    input type: "hidden", name: "form", value: "user_edit"
                    input type: "hidden", name: "user_id", value: @user.id
                    br!
                    input type: "hidden", name: "csrf_token", value: @token
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
                    p "Weekday:"
                    --input type: "number", name: "weekday", value: @user.weekday
                    select name: "weekday", ->
                        option value: 0, "Unassigned"
                        option value: 1, "Sunday"
                        option value: 2, "Monday"
                        option value: 3, "Tuesday"
                        option value: 4, "Wednesday"
                        option value: 5, "Thursday"
                        option value: 6, "Friday"
                        option value: 7, "Saturday"
                        option value: @user.weekday, selected: true, get_day @user.weekday --NOTE THIS IS TERRIBLE
                    p "Admin? "
                    if @user.admin
                        input type: "checkbox", name: "admin", checked: true
                    else
                        input type: "checkbox", name: "admin"
                    p "Delete user? "
                    input type: "checkbox", name: "delete"
                    input type: "hidden", name: "form", value: "admin_edit"
                    input type: "hidden", name: "user_id", value: @user.id
                    br!
                    input type: "hidden", name: "csrf_token", value: @token
                    input type: "submit"
