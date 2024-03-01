using .NumberTheory
using .Combinatorics
using .Iterators: flatmap

function replace_digit(x, i, n)
    current = x%10^i - (i > 0 ? (x%10^(i-1)) : 0)
    return x - current + n*10^(i-1)
end

replace_digits(num, is, x) = foldl((num, i) -> replace_digit(num, i, x), is; init=num)
all_equal(as) = all(x -> x == as[1], as[2:length(as)])

function search(fl, ub)
    spf_vec = smallest_prime_factors(ub)
    ps = [x for x in 2:ub if is_prime(x, spf_vec)]
    isp(x) = is_prime(x, spf_vec)
    result = []
    for p in ps
        l = ndigits(p)
        for i in 1:l-1
            for c in choose(1:l, i)
                replaced = map(n -> replace_digits(p, c, n), 0:9)
                possible = unique(filter(isp, replaced))
                if length(possible) >= fl && all_equal(map(ndigits, possible))
                    return possible
                end
            end
        end
    end
    return false
end
