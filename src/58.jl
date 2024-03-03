using .NumberTheory: is_prime, smallest_prime_factors

sidelen(n) = 2*n+1
function diagonals(n)
    x = sidelen(n)
    sq = (x-2)*(x-2)
    c = x-1
    return [sq+c, sq+2*c, sq+3*c, sq+4*c]
end

function ratio(ub)
    spf_vec = smallest_prime_factors((2*ub+1)^2)
    isp(x) = is_prime(x, spf_vec)
    primecount = 0
    for i in 1:ub
        primecount += count(isp, diagonals(i))
    end
    primecount//(1+4*ub)
end

function primecount(n, spf_vec)
    
end
    
