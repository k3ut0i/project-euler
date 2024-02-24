using .LongNums

function factorial(n::Integer) :: LongNum
    x = LongNum([1])
    for i in 1:n
        x = mul(x, i)
    end
    return x
end
