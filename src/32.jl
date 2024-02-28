import .NumberTheory

function is_all_9(as)
    check = fill!(Vector{Bool}(undef, 9), false)
    for a in as
        if a == 0
            return false
        end
        check[a] = true
    end
    return all(check)
end

function is_pandigital(n, spf_vec)
    ds = divisors(n, spf_vec)
    for d in ds
        q = div(n, d)
        if is_all_9(vcat(digits(d), digits(q), digits(n)))
            # return (d, q, n)
            return true
        end
    end
    return false
end
