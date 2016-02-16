config = require "lapis.config"
import sql_password, session_secret from require "secret"

config {"development", "production"}, ->
    session_name "kss_session"
    secret session_secret
    postgres ->
        host "127.0.0.1"
        user "postgres"
        password sql_password

config "development", ->
    port 8001
    num_workers 1
    code_cache "off"
    measure_performance true
    postgres ->
        database "kss_dev"

config "production", ->
    port 8000
    num_workers 3
    code_cache "on"
    measure_performance false
    postgres ->
        database "kss_live"
