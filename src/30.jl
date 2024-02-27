function is_digit_nth_power(n, e)
    return n == sum(map(x -> x^e, digits(n)))
end

# filter below a million
