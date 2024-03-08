function nrange_for(d)
    ns = []
    for i in (2d+1):(3d-1)
        if mod(i, 6) == 0
            if gcd(div(i, 6), d) == 1
                push!(ns, div(i, 6))
            end
        end
    end
    return ns
end
