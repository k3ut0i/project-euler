function fibonacci(n)
    g = BigFloat((1+sqrt(5))/2)
    return round((g^n)/sqrt(5))
end

function fibo_above(n)
    i = ceil(log(n*sqrt(5))/log((1+sqrt(5))/2))
    return i
end

#fibo_above(BigInt(10)^999-1)
