shallow_copy = (original) ->
    copy = {}

    for k,v in pairs original
        copy[k] = v

    return copy

return {
    :shallow_copy
}
