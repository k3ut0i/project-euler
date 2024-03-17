using .NumberTheory: smallest_prime_factors, is_prime

function f(a, b, c, bound)
    a_ = a*a; b_ = b*b*b; c_ = c*c*c*c
    if a_ < bound && b_ < bound && c_ < bound
        s = a_ + b_ + c_
        return (s <= bound, s)
    else
        return (false, 0)
    end
end

function count_ppt(ub)
    p_ub = isqrt(ub-2^3-2^4) # find out the largest prime needed
    spf_vec = smallest_prime_factors(p_ub)
    primes = filter(i -> is_prime(i, spf_vec), 2:p_ub)
    lp = length(primes)

    d = Set{Int}()
    for i in 1:lp, j in 1:lp, k in 1:lp
        (status, n) = f(primes[i], primes[j], primes[k], ub)
        if status
            push!(d, n)
        end
    end
    return length(d) #count(i -> d[i], keys(d))
end
