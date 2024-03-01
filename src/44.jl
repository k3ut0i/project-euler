pentanum(n) = div(n*(3*n-1), 2)
is_pentanum(x) = pentanum(div(1+isqrt(1+24*x), 6)) == x
pentanum_i(x) = div(1+isqrt(1+24*x), 6) # which pentagon number is x?

function search_min(ub)
    for d in 1:ub
        pd = pentanum(d)
        ub_a = div(pd-1, 3)
        for a in (d+1):ub_a
            for b in (a-d+1):a
                pa = pentanum(a); pb = pentanum(b)
                if (pd ==  pa - pb) && is_pentanum(pa+pb)
                    return (a, b, pentanum_i(pa+pb), d)
                end
            end
        end
        print(d, "..")
    end
end


function search_min_full_brute(ub)
    result = []
    for a in 1:ub
        for b in 1:(a-1)
            pa = pentanum(a); pb = pentanum(b)
            if is_pentanum(pa-pb) && is_pentanum(pa+pb)
                push!(result, (a, b, pentanum_i(pa+pb), pentanum_i(pa-pb)))
            end
        end
    end
    return result
end
