function to_digits(s)
    return map(c -> c - '0', collect(s))
end

function read_nums(file, nrows, ncols)
    a = Array{Int, 2}(undef, nrows, ncols)
    i = 1
    for line in eachline(file)
        a[i, :] = to_digits(line)
        i += 1
    end
    return a
end

function add_nums(m)
    s = reduce(+, m, dims=1)
    carry = 0
    for i in length(s):-1:1
        s[i] += carry
        carry = div(s[i], 10)
        s[i] = mod(s[i], 10)
    end
    print(carry)
    print(s[1:10])
end

