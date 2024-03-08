function transition(N, (a, b, c))
    a1 = a*c
    c1 = a*a*N-b*b
    b1r = mod((-1 * b* c), c1)
    b1q = div(a1*isqrt(N) - b1r, c1)
    b1 = b1r+b1q*c1
    q = div(b*c+b1, c1)
    if mod(c1, a1) == 0
        b1 = div(b1, a1); c1 = div(c1, a1); a1 = 1
        return ((a1, b1, c1), q)
    else
        error("'a' doesn't divide 'c' in this transition")
    end
end

function find_cf(N)
    a = 1; c = 1; b = isqrt(N)
    ss = Set()
    s = (a, b, c)
    qs = []
    while !(s in ss)
        push!(ss, s)
        (s, q) = transition(N, s)
        push!(qs, q)
    end
    return qs
end

