using .NumberTheory

function digit2num(ds)
    return foldl((x, y) -> 10*x+y, ds)
end

function is_circular_prime(n, spf_vec)
    return all(p -> is_prime(p, spf_vec), map(digit2num, all_rotations(digits(n))))
end

function all_rotations(as)
    map(i -> circshift(as, i), 1:length(as))
end

function all_circular_primes(ub)
    spf_vec = smallest_prime_factors(ub)
    return filter(n -> is_circular_prime(n, spf_vec), 2:ub)
end
