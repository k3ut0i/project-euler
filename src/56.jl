using .LongNums
function max(a, b)
    m = 0
    for i in 1:a
        x = LongNum([i])
        for j in 1:b-1
            x = mul(x, i)
            if digitsum(x) > m
                m = digitsum(x)
            end
        end
    end
    return m
end
