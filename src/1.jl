sum = 0
x = 0
while (x < 1000)
    if x % 3 == 0
        sum += x
    elseif x % 5 == 0
        sum += x
    end
    x = x + 1
end

println(sum)
