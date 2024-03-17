using .NumberTheory: smallest_prime_factors, prime_factors

"sum divisors of n (not including n)"
function sum_divisors(n, spf_vec)
    if n == 1
        return 0
    end
    pf = prime_factors(n, spf_vec)
    r = 1
    for (p, a) in pairs(pf)
        r *= div(p^(a+1)-1, p-1)
    end
    return r-n
end

function all_transitions(ub)
    spf_vec = smallest_prime_factors(ub)
    a = map(n -> sum_divisors(n, spf_vec), 1:ub)
    return a
end

function chain(x, ts, ub)
    r = Int[]
    while !(x in r) && 0 < x <= ub
        push!(r, x)
        x = ts[x]
    end
    if x > ub || x <= 0 # ignore chains that go out of bounds
        return ([], 0)
    else
        return (r, x)
    end
end

function all_chains(ub)
    ts = all_transitions(ub)
    cs = Vector{Tuple{Vector{Int}, Int}}(undef, length(ts))
    for i in 1:ub
        cs[i] = chain(i, ts, ub)
    end
    return cs
end

is_amicable_chain(n, cs) = cs[n][2] == n

# no filter all amicable chains and find the one with max length and then find min in that chain
