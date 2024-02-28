function is_digit_fac(num)
    ds = digits(num)
    return sum(map(factorial, ds)) == num
end
