word_value(w) = foldl((acc, c) -> acc+Int(c)-Int('A')+1, collect(w); init = 0)

function is_triangular(n)
    possible = round((sqrt(1+8n)-1)/2)
    return n == div(possible*(possible+1), 2)
end

function read_words(file)
    contents = read(file, String)
    names = map(n -> strip(n, ['"']), split(contents, ","))
    return names
end
