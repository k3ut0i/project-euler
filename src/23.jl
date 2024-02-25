using .NumberTheory

function is_abundant(n, spf_vec)
    ds = divisors(n, spf_vec) # all divisors, including n
    return n < (sum(ds) - n)
end

function all_abundant()
    ub = 28123 # upperbounds
    spf_vec = smallest_prime_factors(ub)
    nums = filter(n -> is_abundant(n, spf_vec), 1:ub)
    return nums
end

function all_sums()
    nums = all_abundant()
    return unique(sort([x+y for x in nums for y in nums if (x+y < 28123)]))
end

