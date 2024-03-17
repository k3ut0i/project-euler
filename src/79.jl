function read_nums(file)
    return map(s -> parse(Int, s), eachline(file))
end

function analyze(nums)
    d(n) = reverse(digits(n))
    cd = Dict{Int, Vector{Int}}()
    for n in nums
        dn = d(n)
        for (i, c) in enumerate(dn)
            cd[c] = vcat(get(cd, c, []), view(dn, (i+1):length(dn)))
        end
    end
    cds = Dict{Int, Set{Int}}()
    for (k, v) in pairs(cd)
        cds[k] = Set(v)
    end
    return cds
end
