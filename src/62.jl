using .Combinatorics: permutations
using .Utils: count_freq

d2n(as) = foldl((acc, x) -> 10*acc+x, as) # this will be in reverse
all_digit_perms(n) = unique(map(p -> d2n(view(digits(n), p)),
                                permutations(ndigits(n))))
is_cube(x) = round(Int, exp(log(x)/3))^3 == x
is_a_perm(as, bs) = count_freq(as) == count_freq(bs)

function search_brute(n, dsize)
    r = []
    perms = Dict(map(i -> (i, permutations(i)), 3*(dsize-1):3*dsize))
    all3perms(n) = unique(map(p -> d2n(view(digits(n), p)), perms[ndigits(n)]))
    for i in 10^(dsize-1):10^dsize-1
        ps = filter(is_cube, all3perms(i^3))
        if length(ps) >= n && allequal(map(ndigits, ps))
            push!(r, ps)
        end
    end
    return r
end

function search_s1(n, dsize)
    r = Dict{Int, Vector{Int}}()
    for i in 10^(dsize-1):10^dsize-1
        for j in (i+1):ceil(Int, i*10^(1/3))
            if is_a_perm(digits(i^3), digits(j^3))
                r[i] = push!(get(r, i, []), j)
            end
        end
    end
    return filter(kv -> length(kv[2]) == (n-1), collect(pairs(r)))
end
