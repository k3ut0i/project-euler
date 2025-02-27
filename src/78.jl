function intparts(ub, m)
    a = zeros(Int, ub)
    a[1] = 1
    p(x) = x < 0 ? 0 : (x == 0 ? 1 : a[x])
    for n in 2:ub
        for k in 1:ub
            k1 = div(k*(3*k-1), 2)
            k2 = div(k*(3*k+1), 2)
            if k1 > n && k2 > n # we can stop when we reach all zeros
                break
            else
                s = p(n-k1) + p(n-k2)
                a[n] = (a[n] + ((mod(k, 2) == 1) ? 1 : -1) * s) % m
            end
        end
        if a[n] == 0
            return n
        end
    end
    return nothing
end
