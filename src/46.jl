using .NumberTheory: is_prime, smallest_prime_factors

is_square(x) = x == isqrt(x)^2

function search(ub)
    spf_vec = smallest_prime_factors(ub)
    primes = filter(x -> is_prime(x, spf_vec), 2:ub)
    primes_below(x) = filter(i -> i <= x, primes)
    for n in 34:ub
        if(!is_prime(n, spf_vec))
            if !any(is_square, map(p -> div(n-p, 2), primes_below(n)))
                return n
            end
        end
    end
end
