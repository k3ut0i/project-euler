function alphabet_score(c)
    return c - 'A' + 1
end

function name_score(s)
    sum(map(alphabet_score, collect(s)))
end

function read_names(file)
    contents = read(file, String)
    names = map(n -> strip(n, ['"']), split(contents, ","))
    return names
end

function score(names)
    f = (n, i) -> name_score(n)*i
    return sum(map(f, sort(names), 1:length(names)))
end
