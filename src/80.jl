function isqrt_(x)
    l = 0; r = x+1;
    while ( l != r-1)
        m = (l+r)÷2
        if (m*m < x)
            l = m
        else
            r = m
        end
    end
    return l
end

sd(x) = sum(digits(isqrt_(x)))

f(x) = sd(x*BigInt(10)^198)
