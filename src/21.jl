using .NumberTheory

function d(n, spf_vec)
    ds = divisors(n, spf_vec)
    return sum(ds) - n
end

function is_amicable_number(n, spf_vec)
    an = d(n, spf_vec)
    if an == n
        return false
    else
        return n == d(an, spf_vec)
    end
end

function sum_of_amicable_below(n)
    spf_vec = smallest_prime_factors(3*n) # sum of divisors can get bigger than n
    return sum(filter(x -> is_amicable_number(x, spf_vec), 1:(n-1)))
end
