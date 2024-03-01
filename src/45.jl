triangular_i(n) = div(isqrt(1+8*n)-1, 2)
triangular(n) = div(n*(n+1), 2)
is_triangular(x) = x == triangular(triangular_i(x))

pentanum_i(x) = div(1+isqrt(1+24*x), 6)
pentanum(x) = div(x*(3*x-1), 2)
is_pentanum(x) = x == pentanum(pentanum_i(x))

hexanum(n) = n*(2*n-1)

function search_min(ub)
    for n in 144:ub
        hn = hexanum(n)
        if is_triangular(hn) && is_pentanum(hn)
            return (triangular_i(hn), pentanum_i(hn), n, hn)
        end
    end
end
