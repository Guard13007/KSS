import Widget from require "lapis.html"
import get_day_name from require "helpers.time"

Users = require "models.Users"

class UserWidget extends Widget
    content: =>
        p "This user's weekday is: ", get_day_name @user.weekday
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
                    br!
                    input type: "hidden", name: "form", value: "user_edit"
                    input type: "hidden", name: "user_id", value: @user.id
                    input type: "hidden", name: "csrf_token", value: @csrf_token
                    input type: "submit"

            if current_user.admin
                hr!
                script src: @build_url "static/js/form.js"
                h2 "Admin Panel"
                form {
                    action: "/modify_user"
                    method: "POST"
                    enctype: "multipart/form-data"
                    class: "pure-form"
                    onsubmit: "return confirm_delete('Are you sure you want to delete this user?');"
                }, ->
                    p "Rename:"
                    input type: "text", name: "name", defaultValue: @user.name --NOTE defaultValue doesn't seem to actually do anything
                    p "Weekday:"
                    --input type: "number", name: "weekday", value: @user.weekday
                    element "select", name: "weekday", ->
                        for day = 0, 7
                            if @user.weekday == day
                                option value: day, selected: true, get_day_name day
                            else
                                option value: day, get_day_name day
                    p "Admin? "
                    if @user.admin
                        input type: "checkbox", name: "admin", checked: true
                    else
                        input type: "checkbox", name: "admin"
                    p "Delete user? "
                    input type: "checkbox", name: "delete"
                    br!
                    input type: "hidden", name: "form", value: "admin_edit"
                    input type: "hidden", name: "user_id", value: @user.id
                    input type: "hidden", name: "csrf_token", value: @csrf_token
                    input type: "submit"
