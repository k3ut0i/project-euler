module Combinatorics
export all_combinations

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

end #endmodule
