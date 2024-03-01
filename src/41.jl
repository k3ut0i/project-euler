using .Combinatorics: permutations
using .NumberTheory: is_prime

digits2num(ds) = foldl((acc, x) -> 10*acc+x, ds)
    
function check_ndigit(n)
    result = []
    for p in permutations(n)
        num = digits2num(p)
        if is_prime(num)
            push!(result, num)
        end
    end
    return result
end
