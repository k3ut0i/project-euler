# prime number theorem
# p_n ~ nlogn
# we want the 10_001st prime number, so I'm going to assume 10_001 * log10_001

function is_prime(n)
    if n == 2
        return true
    end
    for i in 2:ceil(sqrt(n))
        if n%i == 0
            return false
        end
    end
    return true
end

function nth_prime(n)
    p_n = ceil(n * log(n))
    ub = Int(ceil(1.3*p_n)) # upper bound
    count = 0
    for i = 2:ub
        if is_prime(i)
            count += 1
            if count == n
                return i
            end
        end
    end
end
