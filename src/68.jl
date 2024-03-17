using .Utils

"find triples (x, y, z) such that x+y+z=n, x < y < z <= ub"
function findtriples(n, ub)
    r = Vector{Tuple{Int, Int, Int}}()
    for z in 3:ub
        for y in 2:z-1
            if z+y<n && y>n-y-z
                push!(r, (n-y-z, y, z))
            end
        end
    end
    return r
end

edgelabel(t1, t2) = collect(Set(t1) ∩ Set(t2))[1]
isadjacent(t1, t2) = isempty(Set(t1) ∩ Set(t2))


function isvalidcycle(cs, ub)
    allnums = Set(mapfoldl(collect, vcat, cs))
    multiplicities = Set(values(count_freq(mapfoldl(collect, vcat, cs))))
    return allnums == Set(1:ub) && multiplicities == Set([1, 2])
end

"given a graph of triples (a, b, c) find n-cycles such that two adjacent triples have distinctly labelled edges. adjacency list is of the form n -> [(n1, l1)...] where l1.. are edge labels from n -> n1."
function findcycle(g, n, ub)
    onenodes = filter(t -> t[1] == 1, keys(g))
    cs = Set{Vector{Tuple}}()
    for x in onenodes
        unique = Set{Int}()
        for (y, e) in g[x]
            u = deepcopy(unique)
            push!(u, e)
            ps = findpaths(g, y, x, u, n)
            for p in ps
                (_, i) = findmin(p)
                push!(cs, view(p, vcat(i:n, 1:i-1)))
            end
        end
    end

   return filter(c -> isvalidcycle(c, ub), cs)
end

"Find all paths in the graph g, from n1 to n2 with edges _unique_ and len length."
function findpaths(g, n1, n2, unique, len)
    if len < 1
        return []
    elseif n1 == n2 && len == 1
        return [[n1]]
    else
        r = Vector{Vector{Tuple}}()
        for (x, e) in g[n1]
            if !(e in unique)
                u = deepcopy(unique)
                push!(u, e)
                for p in findpaths(g, x, n2, u, len-1)
                    push!(r, vcat(n1, p))
                end
            end
        end
        return r
    end
end

"convert the number triples into a adjacency list representation of a graph"
function adjlist(ts)
    l = length(ts)
    d = Dict{Tuple, Vector{Tuple}}()
    for i in 2:l
        for j in 1:i-1
            x = Set(ts[i]) ∩ Set(ts[j])
            if !isempty(x)
                e = collect(x)[1]
                d[ts[i]] = push!(get(d, ts[i], []), (ts[j], e))
                d[ts[j]] = push!(get(d, ts[j], []), (ts[i], e))
            end
        end
    end
    return d
end

function soln2str(cs, n)
    ec = Dict()
    es = []
    d = Dict()
    for i in 1:n
        x1 = cs[i]; x2 = cs[mod(i, n)+1]
        e = edgelabel(x1, x2)
        push!(es, e)
        d[e] = Set(x2)
    end
    for e in es
        ec[e] = collect(setdiff(d[e], Set(es)))[1]
    end
    p = []
    remain(i, e) = collect(setdiff(d[i], Set([i, e])))[1]
    for i in es
        e = ec[i]
        push!(p, (e, i, remain(i, e)))
    end
    (_, i) = findmin(p)
    return mapfoldl(string, *, mapfoldl(collect, vcat, view(p, vcat(i:n, 1:i-1))))
end

f(n, ub, k) = map(c -> soln2str(c, k),
                  collect(findcycle(adjlist(findtriples(n,ub)), k, ub)))
