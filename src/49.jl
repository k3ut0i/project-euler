using .NumberTheory
using .Combinatorics

dl(n) = length(digits(n)) # ceil(log(10, n)) isn't working for n = 1000
digit2num(ds) = foldl((acc, x) -> 10*acc+x, ds)
num_perms(n) = map(digit2num, map(p -> view(digits(n), p), permutations(dl(n))))

function is_arith(as)
    d = as[2] - as[1]
    if d == 0
        return false
    else
        for i in 3:length(as)
            if (as[i] - as[i-1]) != d
                return false
            end
        end
        return true
    end
end

function search()
    result = []
    spf_vec = smallest_prime_factors(10_000)
    isp(x) = is_prime(x, spf_vec)
    for n in filter(isp, 1000:9999)
        ps = filter(isp, num_perms(n))
        if length(ps) >= 3
            cs = filter(c -> is_arith(c), choose(ps, 3))
            if !isempty(cs)
                push!(result, cs)
            end
        end
    end
    return result
end
