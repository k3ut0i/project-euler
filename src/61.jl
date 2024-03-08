figurate(s, n) = div((s-2)*n*n - (s-4)*n, 2)

"Index of the smallest s-figurate number above x"
figurate_index(s, x) = ceil(Int, (sqrt(8*(s-2)*x+(s-4)^2) + (s-4))/(2*(s-2)))

"s-figurates in from:to range"
function figurates_in(s, from, to)
    start_i = figurate_index(s, from)
    end_i = figurate_index(s, to) - 1
    return map(i -> figurate(s, i), start_i:end_i)
end

"Next s-figurate number, given previous `fn`"
function possible_next(s, fn)
    next_start = 100*mod(fn, 100)
    next_end = next_start + 99
    mod(fn, 100) < 10 && return Dict() # if 10th place digit is zero, next isnt 4digit
    return Dict(map(i -> (i, figurates_in(i, next_start, next_end)),
                    vcat(3:(s-1), (s+1):8)))
end

function all_transitions()
    r = Dict{Tuple{Int, Int}, Vector{Tuple{Int, Int}}}()
    for i in 3:8
        for n in figurates_in(i, 1000, 10_000)
            for (k, vs) in pairs(possible_next(i, n))
                for v in vs
                    r[(i, n)] = push!(get(r, (i, n), []), (k, v))
                end
            end
        end
    end
    return r
end

function dump_graph(file)
    io = open(file, "w")
    println(io, "digraph {")
    println(io, " node [shape=point];")
    d = all_transitions()
    for (k, vs) in pairs(d)
        for v in vs
            println(io, "\"", k, "\" -> \"", v, "\";")
        end
    end
    println(io, "}")
    close(io)
end

"given a graph `d` as an adjacency list, find all cycles"
function find_cycles(d)
    r = []
    for (k, vs) in pairs(d)
        for v in vs
            # (status, path) = find_path(d, v, k)
            # if status
            #     push!(r, (k, path))
            # end
            ps = find_paths(d, v, k)
            for p in ps
                push!(r, (k, p))
            end
        end
    end
    return r
end

function find_path(d, n1, n2; visited = Dict(), unique = Dict())
    if n1 == n2
        return (true, [n1])
    else
        visited[n1] = true;
        unique[first(n1)] = true;
        for v in get(d, n1, [])
            if !get(visited, v, false) && !get(unique, first(v), false)
                (status, path) = find_path(d, v, n2; visited=visited, unique=unique)
                if status
                    return (true, vcat([n1], path))
                end
            end
        end
        return (false, [])
    end
end


function find_paths(d, n1, n2; visited = Dict(), unique = Dict())
    if n1 == n2
        return [[n1]]
    else
        visited[n1] = true
        unique[first(n1)] = true
        paths = []
        for v in get(d, n1, [])
            if !get(visited, v, false) && !get(unique, first(v), false)
                ps = find_paths(d, v, n2; visited=copy(visited), unique=copy(unique))
                for p in ps
                    push!(paths, vcat([n1], p))
                end
            end
        end
        return paths
    end
end
