digitsquare(d) = sum(map(i -> i*i, digits(d)))

function all_transitions(ub)
    # I am assuming ub > 2*9^2 so I don't need to do a transitive closure
    return map(digitsquare, 1:ub)
end

function chain(x, ts, f)
    r = Int[]
    while !f(x)
        push!(r, x)
        x = ts[x]
    end
    push!(r, x)
    return (r, x)
end

function chain_dests(ts)
    ds = zeros(Int, length(ts))
    f(x) = x == 1 || x == 89
    for i in 1:length(ts)
        if ds[i] == 0
            (cs, e) = chain(i, ts, f)
            for j in cs
                ds[j] = e
            end
        end
    end
    return ds
end
