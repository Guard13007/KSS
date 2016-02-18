db = require "lapis.db"

import create_table
    types
    add_column from require "lapis.db.schema"

{
    [1]: =>
        create_table "users", {
            {"id", types.serial primary_key: true}
            {"name", types.text unique: true}
            {"password", types.text}
            {"admin", types.boolean default: false}

            {"created_at", types.time}
            {"updated_at", types.time}
        }

        create_table "saves", {
            {"id", types.serial primary_key: true}
            {"file", types.text unique: true}
            {"report", types.text}

            {"user_id", types.foreign_key}

            {"created_at", types.time}
            {"updated_at", types.time}
        }
    [2]: =>
        add_column "users", "weekday", types.integer default: 0
    [3]: =>
        db.insert "users", {
            name: "admin"
            password: "changeme"
            admin: true
        }
}
