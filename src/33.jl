function is_digit_cancelling((n, d))
    n1 = mod(n, 10); n2 = div(n, 10)
    d1 = mod(d, 10); d2 = div(d, 10)
    if n == d # trivial case of 11 multiples
        return false
    else
        return (n//d == n1//d2 && n2 == d1) || (n//d == n2//d1 && n1 == d2)
    end
end
