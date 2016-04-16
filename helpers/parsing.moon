--NOTE THIS FILE SHOULD *NOT* BE REQUIRED RIGHT NOW

lunamark = require "lunamark"

markdown = (input) ->
    writer = lunamark.writer.html5.new!

    writer.inline_html = (s) ->
        return writer.string s
    writer.display_html = (s) ->
        return writer.string s

    parse = lunamark.reader.markdown.new writer, {
        definition_lists: true
        require_blank_before_blockquote: true
        require_blank_before_header: true
        hash_enumerators: true
    }

    -- return parse input
    output = parse input
    print output
    return ouput

return {
    :markdown
}
