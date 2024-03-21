"transitions to compute the continuted fraction"
function cftrans(D, (x, y))
    d = isqrt(D)
    β = (D-x*x)÷y
    α′ = div(2*d, β)*β - x
    α = (α′ <= d) ? α′ : (α′-β)
    return (div(α+x, β), (α, β))
end

"compute the continued fraction (a_0; periodicpart)"
function cf(D)
    d = isqrt(D)
    (a, t) = cftrans(D, (d, 1))
    r = Int[a]
    while t != (d, 1)
        (a, t) = cftrans(D, t)
        push!(r, a)
    end
    return (d, r)
end

"given [a0; a1, ..., an] find the convergent of continued fraction [h, k]"
function convergent(as)
    mapfoldl(x -> [x 1; 1 0], *, as) * [1, 0]
end

"fundamental solution to x²-Dy²=1"
function pellfundamental(D)
    (d, r) = cf(D)
    p = length(r)
    l = (p%2 == 0) ? (p-1) : (2*p-1)
    m = cld(l, p)
    v = vcat([d], repeat(r, m))[1:l+1]
    return convergent(v)
end

function test_pellfundamental(D)
    p = pellfundamental(D)
    return transpose(p) * [1 0 ; 0 -D] * p
end
