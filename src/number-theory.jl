module NumberTheory
using ..Combinatorics

export is_prime, smallest_prime_factors, prime_factors, divisors
export non_trivial_divisors, which_power, totient

function is_prime(n)
    if n <= 1
        return false
    elseif n == 2
        return true
    end
    for i in 2:ceil(sqrt(n))
        if n%i == 0
            return false
        end
    end
    return true
end

"TODO: this will be better than unary version after linear-sieve is complete"
function is_prime(n, spf_vec)
    if n <= 1
        return false
    else
        return n == spf_vec[n]
    end
end

function spf(n)
    for i in 2:Int(ceil(sqrt(n)))
        if n % i == 0
            return i
        end
    end
    return n
end

"TODO: I should replace this by a linear-sieve"
function smallest_prime_factors(n)
    return map(spf, 1:n)
end

function prime_factors(n, spf_vec)
    d = Dict{Int, Int}()
    x = n
    while spf_vec[x] != x
        p = spf_vec[x]
        d[p] = get(d, p, 0) + 1
        x = div(x, spf_vec[x])
    end
    p = spf_vec[x]
    d[p] = get(d, p, 0) + 1
    return d
end

function pf2num(d)
    num = 1
    for (p, e) in d
        num = num * (p ^ e)
    end
    return num
end

function divisors(n, spf_vec)
    ps = prime_factors(n, spf_vec)
    as = all_combinations(ps)
    map(pf2num, as)
end

function non_trivial_divisors(n, spf_vec)
    ds = divisors(n, spf_vec)
    return view(sort(ds), 2:length(ds)-1)
end

function which_power(n, ps)
    expo = gcd(collect(values(ps)))
    for p in keys(ps)
        ps[p] = div(ps[p], expo)
    end
    return (pf2num(ps), expo)
end

function totient(n, spf_vec)
    if (n == 1)
        return 1
    else
        pfs = prime_factors(n, spf_vec)
        phi = 1
        for (p, k) in pairs(pfs)
            phi *= p^(k-1)*(p-1)
        end
        return phi
    end
end

end #endmodule
