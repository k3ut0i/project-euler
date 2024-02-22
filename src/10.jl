using .NumberTheory
function sum_of_primes(n)
    return sum([x for x in 2:n if is_prime(x)])
end
