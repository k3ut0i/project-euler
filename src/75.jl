using .NumberTheory

function prime_triple_of_len(l, spf_vec)
    if mod(l, 2) != 0
        return nothing
    else
        l1 = div(l, 2)
        ds = divisors(l1, spf_vec)
        count = 0
        triple = false
        for d in ds
            m = d; n = div(l1, d) - m
            if (0 < n < m) && gcd(n, m) == 1 && mod(n+m, 2) == 1
                count += 1
                triple = (m*m-n*n, 2*m*n, m*m+n*n)
            end
        end
        return (count == 1 ? triple : nothing)
    end
end

function all_triples(ub)
    spf_vec = smallest_prime_factors(ub)
    a = fill(0, ub)
    for i in 1:ub
        if !isnothing(prime_triple_of_len(i, spf_vec))
            a[i] += 1
            for q in 2:div(ub, i)
                a[q*i] += 1
            end
        end
    end
    return count(i -> i == 1, a)
end
