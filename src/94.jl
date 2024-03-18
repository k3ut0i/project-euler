"All solutions to pells equation x²-3y²=1, untill f(x, y) is true."
function pells_3(f)
    m = [2; 1]
    t = [2 3; 1 2]
    r = Vector{Int}[]
    while !f(m[1], m[2])
        push!(r, m)
        m = t*m
    end
    return r
end

"given [x, y] such that x²-3y²=1, does that give us an almost equilateral triangle?"
function isalmost△(m)
    if mod(2*m[1]-1, 3) == 0
        n = div(2*m[1]-1, 3)
        n1 = n-1
        x = m[2]
        if mod(n1*x, 2) == 0
            return (true, 3*n-1)
        end
    end
    if mod(2*m[1]+1, 3) == 0
        n = div(2*m[1]+1, 3)
        n1 = n+1
        x = m[2]
        if mod(n1*x, 2) == 0
            return (true, 3*n+1)
        end
    end
    return (false, 0)
end
