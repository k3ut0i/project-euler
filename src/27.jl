using .NumberTheory

"return the number of sequential primes generated by `n^2+an+b` for n=0,1..."
function num_primes(a, b)
    nprimes = 0
    for n in 0:b
        x = n*n+a*n+b
        if x > 0 && is_prime(x)
            nprimes += 1
        else
            break
        end
    end
    return nprimes
end

"given ranges for a and b, find number of primes generated by n^2+an+b"
function find_coeff(ar, br)
    return [(a, b, num_primes(a, b)) for a in ar for b in filter(is_prime, br)]
end
