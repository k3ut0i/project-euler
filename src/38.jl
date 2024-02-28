digit2num(ds) = foldl((acc, d) -> 10*acc+d, ds)
is_pandigital(n) = Set(digits(n)) == Set(1:9) && length(digits(n)) == 9
concat_prod(n, k) = digit2num(foldl(vcat, map(i -> reverse(digits(i*n)), 1:k)))

function pandigital_search()
    return maximum(filter(is_pandigital, [concat_prod(num, k) for k in 2:9 for num in 9999:-1:1]))
end
