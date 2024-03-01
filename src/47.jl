using .NumberTheory: prime_factors, smallest_prime_factors

function search(k, ub)
    spf_vec = smallest_prime_factors(ub+k)
    for n in 2:ub
        fss = map(i -> length(keys(prime_factors(i, spf_vec))), n:(n+k-1))
        if all(i -> i == k, fss)
            return n
        end
    end
end
