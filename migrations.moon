import create_table
    drop_table
    types
    add_column from require "lapis.db.schema"

db = require "lapis.db"

Saves = require "models.Saves"

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
        -- this was a derp that ended up just running a SELECT
        assert true
    [4]: =>
        assert db.query db.raw "INSERT INTO \"users\" (\"password\", \"updated_at\", \"created_at\", \"name\") VALUES ('changeme', '2016-02-19 05:12:32', '2016-02-19 05:12:32', 'admin') RETURNING \"id\""
    [5]: =>
        assert db.query db.raw "UPDATE \"users\" SET admin=TRUE WHERE name='admin'"
    [6]: =>
        create_table "xss", {
            {"id", types.serial primary_key: true}
            {"value", types.text unique: true}
        }
    [7]: =>
        drop_table "xss"
    [8]: =>
        add_column "saves", "filename", types.text default: "null"
        add_column "saves", "filetype", types.text default: "null"
    [9]: =>
        if saves = Saves\select "ORDER BY created_at DESC"
            for save in *saves
                save.filename = "download"
                save.filetype = save.file\match "^.+(%..+)$"
                save\update "filename", "filetype"
    [10]: =>
        create_table "mods", {
            {"id", types.serial primary_key: true}
            {"name", types.text unique: true}
            {"status", types.integer default: 0} -- using an enum, default to no_status
            {"description", types.text}
            {"info_link", types.text}
            {"download_link", types.text unique: true}
            {"config_download", types.text unique: true}
            {"version", types.text}
            {"notes", types.text}
        }
}
