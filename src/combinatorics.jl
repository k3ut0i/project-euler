module Combinatorics
export all_combinations, select_from_each

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
end #endmodule
