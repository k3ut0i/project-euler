digit_fact(n) = sum(map(factorial, digits(n)))

function all_transitions(ub)
    a_ub = ceil(Int, (1+log10(ub))*factorial(9))
    a = zeros(Int, a_ub)
    for i in 1:ub
        while a[i] == 0 # for all i which are not initialized traverse
            a[i] = digit_fact(i)
            i = a[i]
        end
    end
    return a
end

function chain_from(n, ts)
    nset = Set()
    nseq = Int[]
    x = n
    while !(x in nset)
        push!(nset, x)
        push!(nseq, x)
        x = ts[x]
    end
    return (nseq, x)
end

chain_length(n, ts) = length(chain_from(n, ts)[1])
