digits2num(as) = foldl((acc, x) -> 10*acc+x, as)
reverse_num(x) = digits2num(digits(x))
f(x) = x + reverse_num(x)

ispalindrome(n) = digits(n) == reverse(digits(n))

function iter(ub, f, x, until_f)
    a = f(BigInt(x)) # overuns otherwise
    for i in 2:ub
        if until_f(a)
            return (a, true, i-1)
        else
            a = f(a)
        end
    end
    return (a, false, ub)
end

islychrelpseudo(n) = !iter(50, f, n, ispalindrome)[2]
