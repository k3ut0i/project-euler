function sum_brute(ub, m)
    sum = 0
    for k in 1:ub
        sum = mod(sum + powermod(k, k, m), m)
    end
    return sum
end
