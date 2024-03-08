using .NumberTheory: is_prime, smallest_prime_factors, prime_factors
using Random: shuffle

sidelen(n) = 2*n+1

function diagonals(n)
    x = sidelen(n)
    sq = (x-2)*(x-2)
    c = x-1
    return [sq+c, sq+2*c, sq+3*c, sq+4*c]
end

function ratio_brute(ub)
    spf_vec = smallest_prime_factors((2*ub+1)^2)
    isp(x) = is_prime(x, spf_vec)
    primecount = 0
    for i in 1:ub
        primecount += count(isp, diagonals(i))
    end
    primecount//(1+4*ub)
end

"check for primality of n, given that (n-1)=n1a*n1b"
function lucas_primality_test(n, n1a, n1b, spf_vec)
    if n <= 3 # this is tripping due to prime_factors(1) = {1}
        return (true, n)
    end
    pf(x) = prime_factors(x, spf_vec)
    ps = keys(merge(pf(n1a), pf(n1b)))
    for a in (2:n-1)
        if powermod(a, n-1, n) != 1
            return (false, a) # a is fermat witness for composite
        elseif all(p -> powermod(a, div(n-1, p), n) != 1, ps)
            return (true, a) 
        end
    end
    return (false, nothing)
end

d1(n) = (2*n*(2*n-1)+1, 2*n-1, 2*n)
d2(n) = (4*n*n+1, 2*n, 2*n)
d3(n) = (2*n*(2*n+1)+1, 2*n, 2*n+1)

function primes_in_layer(l, spf_vec)
    count = 0
    for f in [d1, d2, d3]
        (n, n1a, n1b) = f(l)
        (status, witness) = lucas_primality_test(n, n1a, n1b, spf_vec)
        count += (status ? 1 : 0)
    end
    return count
end

function ratio(ub, threshold)
    spf_vec = smallest_prime_factors((2*ub+1))
    primecount = 0
    for i in 1:ub
        primecount += primes_in_layer(i, spf_vec)
        if (primecount//(1+4*i)) < threshold
            return 2*i+1
        end
    end
end
