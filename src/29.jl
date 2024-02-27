using .NumberTheory

"is a^d <= ub. This is to avoid bounded integer overflow."
function exp_is_less(a, d, ub) # Hmm, I could have just used d*log(a) <= log(ub)
    x = 1
    for i in 1:d
        x = x*a
        if(x > ub)
            return false
        end
    end
    return true
end

"count distinct powers a^b, for a,b in 2:ub range"
function count_powers(ub)
    pf_ub = ub*Int(ceil(log(2, ub)))
    spf_vec = smallest_prime_factors(pf_ub)
    pairs = []
    for a in 2:ub, b in 2:ub
        (an, e) = which_power(a, prime_factors(a, spf_vec))
        a = an; b = b*e # smallest possible pair, but _b*e_ might be > _ub_
        bds = sort(divisors(b, spf_vec))
        for d in bds
            if exp_is_less(a, d, ub) && div(b, d) <= ub
                push!(pairs, (a^d, div(b, d)))
                break
            end
        end
    end
    return length(unique(pairs))
end
