module Combinatorics
export all_combinations, select_from_each, permutations, choose

function introduce(e, c, r)
    nr = deepcopy(r)
    for i in 1:c
        x = deepcopy(r)
        for d in x
            d[e] = i
        end
        append!(nr, x)
    end
    return nr
end

function split_dict!(d)
    f = first(d)
    delete!(d, f[1])
    return (f, d)
end

function all_combinations(d)
    if isempty(d)
        return [Dict()]
    else
        dc = deepcopy(d)
        ((element, count), rest) = split_dict!(dc)
        vrest = all_combinations(rest)
        return introduce(element, count, vrest)
    end
end

"ass is a Vector{Vector{Any}}, return a [[x1, x2...] x1 in ass[1] ...]"
function select_from_each(ass)
    f = (xs, ys) -> [append!([x], y) for x in xs for y in ys]
    return foldr(f, ass, init=[[]])
end

"vector of all possible insertions of `A` into `AS`"
function all_inserts(a, as)
    result = []
    for i in 1:length(as)+1
        cs = deepcopy(as)
        insert!(cs, i, a)
        push!(result, cs)
    end
    return result
end

"all permutations of numbers 1..n"
function permutations(n)
    if n == 1
        return [[1]]
    else
        return collect(Iterators.flatmap(p -> all_inserts(n, p), permutations(n-1)))
    end
end


function insert_pos(i, cs)
    for x in 1:length(cs)
        if i < cs[x]
            return x
        end
    end
    return length(cs)+1
end


function my_insert(cs, x)
    i = 1
    for j in 1:length(cs)
        if cs[j] >= x
            break
        else
            i += 1
        end
    end
    for j in i:length(cs)
        cs[i] += 1
    end
    insert!(cs, i, x)
end

"all choices of k elements from as"
function choose(as, k)
    n = length(as)
    if n == k
        return [as]
    elseif k == 1
        return map(a -> [a], as)
    else
        for i in 1:length(as)
            as1 = view(as, vcat(1:(i-1), (i+1):length(as)))
            return vcat(choose(as1, k), map(v -> vcat([as[i]], v), choose(as1, k-1)))
        end
    end
end

end #endmodule
