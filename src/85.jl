f(a, b) = div(a*b*(a+1)*(b+1), 4)
tri(n) = div(n*(n+1), 2)

function nearest_nums(n)
    x = (sqrt(1+8n)-1)/2
    c = ceil(Int, x)
    f = floor(Int, x)
    if c == f
        return (true, c, c)
    else
        return (false, f, c)
    end
end

function search(n)
    possible = []
    for i in 2:isqrt(n)
        ti = tri(i)
        (q, r) = divrem(n, ti)
        (status, f, c) = nearest_nums(q)
        if status
            push!(possible, (r, i, c))
        else
            fi = tri(f)
            ci = tri(c)
            fr = n - ti*fi
            cr = ti*ci-n
            push!(possible, (fr, i, f))
            push!(possible, (cr, i, c))
        end
    end
    return minimum(possible) #filter(x -> x[1] == 2, possible)
end
