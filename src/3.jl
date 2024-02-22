const num = 600851475143

function smallest_prime_factor(n)
    for i = 2:ceil(sqrt(n))
        if n % i == 0
            return Int(i)
        end
    end
    return n
end

function largest_prime_factor(n)
    n1 = n
    p = smallest_prime_factor(n1)
    while p != n1
        n1 = div(n1, p)
        p = smallest_prime_factor(n1)
    end
    return p
end
