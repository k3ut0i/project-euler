using .NumberTheory

digit2num(ds) =  foldl((acc, x) -> 10*acc+x, ds)

function is_truncatable_prime(n, spf_vec)
    ds = reverse(digits(n))
    l = length(ds)
    all_ranges = collect(Iterators.flatmap(i -> [1:i, i:l], 1:l))
    all_nums = map(r -> digit2num(view(ds, r)), all_ranges)
    return all(p -> is_prime(p, spf_vec), all_nums)
end

function truncatable_primes(ub)
    spf_vec = smallest_prime_factors(ub)
    return filter(n -> is_truncatable_prime(n, spf_vec), 10:ub)
end
