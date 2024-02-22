function palindrome(n)
    ds = digits(n)
    l = length(ds)
    return all(map(==, ds, reverse(ds)))
end

println(maximum(filter(palindrome, [(i*j) for i in 999:-1:900, j = 999:-1:900])))

