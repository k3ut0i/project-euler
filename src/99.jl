function read_nums(filename)
    r = []
    for line in eachline(filename)
        (b, e) = map(s -> parse(Int, s), split(line, ","))
        push!(r, (b, e))
    end
    return r
end

f((b, e)) = e*log(b)
