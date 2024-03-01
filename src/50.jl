using .NumberTheory

max2nd(as) = foldl(((k1, v1), (k2, v2)) -> v1 > v2 ? (k1, v1) : (k2, v2), as)

function search(ub)
    spf_vec = smallest_prime_factors(ub)
    ps = filter(x -> is_prime(x, spf_vec), 2:ub)
    psa = accumulate(+, ps)
    l = length(ps)
    possible = []
    for i in 1:l, j in 1:(i-2)
        d = psa[i] - psa[j]
        if d <= ub && is_prime(d)
            push!(possible, (psa[i]-psa[j], i-j))
        end
    end
    return max2nd(possible)
end
