module Utils
export count_freq

function count_freq(as)
    d = Dict()
    for a in as
        d[a] = get(d, a, 0) + 1
    end
    return d
end

end
