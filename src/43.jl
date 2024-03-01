subranges = map(i -> i:i+2, 2:8) 
divisors = [2, 3, 5, 7, 11, 13, 17]
tonum(ds) = foldl((acc, x) -> 10*acc+x, ds)

function possible_nums()
    d = Vector{Int}(undef, 10)
    result = []
    for d[6] in [0, 5]
        for d[4] in [0, 2, 4, 6, 8]
            rs = collect(setdiff(Set(0:9), Set([d[4], d[6]])))
            for p in permutations(8)
                (d[1], d[2], d[3], d[5], d[7], d[8], d[9], d[10]) = rs[p]
                
                if all(map((r, x) -> mod(tonum(view(d, r)), x) == 0, subranges, divisors))
                    push!(result, tonum(d))
                end
                       
            end
        end
    end
    return result
end
