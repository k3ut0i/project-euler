using .Combinatorics

same_digits(a, b) = Set(digits(a)) == Set(digits(b)) && ndigits(a) == ndigits(b)

function multiples_same_digits(num, range)
    return all(n -> same_digits(num, n*num), 2:range)
end
