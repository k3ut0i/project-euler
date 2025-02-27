using .Combinatorics: choose, permutations
using .NumberTheory: is_prime, smallest_prime_factors

digits2num(ds) = foldl((acc, x) -> 10*acc+x, ds)

function prime_pairs(ub)
    spf_vec = smallest_prime_factors(ub)
    primes = filter(x -> is_prime(x, spf_vec), 2:ub)
    result = []
    for (is_sp, pair) in map(p -> split_prime(p, spf_vec), primes)
        if is_sp
            push!(result, pair)
        end
    end
    return result
end

"digits in `x` can be split, so that the parts are primes and reverse concat is also a prime"
function split_prime(x, spf_vec)
    ds = reverse(digits(x))
    nd = ndigits(x)
    ip(x) = is_prime(x, spf_vec)
    for i in 1:nd-1
        x1 = digits2num(ds[1:i]);
        x2 = digits2num(ds[(i+1):nd])
        y = digits2num(view(ds, vcat((i+1):nd, 1:i)))
        if ip(x1) && ip(x2) && ip(y)
            return (true, (x1, x2)) # this need not be a unique split. XXX: TOOD: 
        end
    end
    return (false, nothing)
end

"dump graphviz graph for pairs of numbers"
function draw_graph(ps, n, filename)
    d = Dict{Int, Vector{Int}}()
    io = open(filename, "w")
    println(io, "graph {")
    println(io, "node [shape=point]")
    for (x, y) in ps
        if x < y # ignore duplicates for undirect graph
            println(io, "  ", x, " -- ", y, ";")
        end
        d[x] = push!(get(d, x, []), y)
    end
    for (x, y) in pairs(d)
        if length(y) >= n
            println(io, "  ", x, "[style=filled fillcolor=red]")
        end
    end
    println(io, "}")
    close(io)
    return d
end

"given `d` a adjacency list of a graph, find if there is a complete subgraph of n elements"
function complete_graph(d, n)
    es = collect(filter(x -> length(d[x]) >= n, keys(d)))
    result = []
    for c in choose(es, n)
        f(e) = issubset(setdiff(es, [e]), d[e])
        if all(f, es)
            println(es)
            push!(result, es)
        end
    end
    return result
end
