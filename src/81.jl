function read_matrix(file)
    vss = map(l -> map(x -> parse(Int, x), split(l, ",")), eachline(file))
    nrows = length(vss)
    ncols = length(vss[1])
    return reshape(vcat(vss...), nrows, ncols) # tranpose, so first col is first line
end

function neighbours_1(m, i, j)
    return filter((x, y)::Tuple -> (x in axes(m, 1) && y in axes(m, 2)),
                  [(i-1, j), (i, j-1)])
end

function distances(m)
    d = fill(-1, axes(m))
    d[1, 1] = m[1, 1]
    for j in 2:size(m, 2)
        d[1, j] = d[1, j-1] + m[1, j]
    end
    for i in 2:size(m, 1)
        d[i, 1] = d[i-1, 1] + m[i, 1]
    end
    for i in 2:size(m, 1), j in 2:size(m, 2)
        d[i, j] = m[i, j]
        d[i, j] += minimum(map((x, y)::Tuple -> d[x, y], neighbours_1(m, i, j)))
    end
    return d
end
