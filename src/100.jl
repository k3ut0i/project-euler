function generate_until(f)
    m = [1; 1]
    t = [3 4; 2 3]
    while !f(m)
        m = t*m
    end
    return m
end


function find(ub)
    f(m) = (m[1]+1)/2 > ub
    m = generate_until(f)
    return (m[2]+1)÷2
end
