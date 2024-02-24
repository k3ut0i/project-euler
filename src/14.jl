function collatz_next(n)
    if n % 2 == 0
        return div(n, 2)
    else
        return 3*n+1
    end
end

function collatz_seq(n)
    x = n
    v = Vector{Int}([x])
    while (x != 1)
        x = collatz_next(x)
        push!(v, x)
    end
    return v
end

function all_collatz_below(n)
    v = fill([], 4*n)
    v[1] = [1]
    for i in 2:n
        x = i
        c = Vector{Int}([x])
        while get(v, x, []) == []
            x = collatz_next(x)
            push!(c, x)
        end
        v[i] = c
    end
    return v[1:n]
end

function path_lengths(ps)
    v = fill(0, length(ps))
    for i in 1:length(ps)
        if last(ps[i]) == 1
            v[i] = length(ps[i])
        else
            v[i] = length(ps[i]) + v[last(ps[i])] - 1
        end
    end
    return v
end

function longest_collatz(n)
    pl = path_lengths(all_collatz_below(n))
    reduce((i, j) -> (pl[i] > pl[j]) ? i : j , 1:n)
end
