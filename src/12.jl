using .NumberTheory

function num_tri_divs(n, vs)
    fd_n = prime_factors(n, vs)
    fd_n1 = prime_factors(n+1, vs)
    fd = mergewith(+, fd_n, fd_n1)
    fd[2] = fd[2] - 1 # n*(n+1) is always divisible by 2
    return prod(map(x -> x + 1, values(fd)))
end

function find_tri_num_with_ndivs(n)
    vs = smallest_prime_factors(1_000_000)
    x = 2
    while(true)
        if num_tri_divs(x, vs) > n
            return (x, div(x*(x+1), 2))
        end
        x += 1
    end
end
