# I made a lot of assumptions
# - recurring occurs when there is a prime factor that is not 2 or 5.
# - length of composites will not be greater than those of prime factors
# - if recurring length is x, then mod(10^x-1, n) == 0, x is the smallest such exponent

# ps = filter(is_prime, 1:1000)
# pl = map(p -> (p, filter(x -> mod(BigInt(10)^x-1, p) == 0, 1:10000)[1]), view(ps, 5:length(ps)))
# foldl(((p1, l1), (p2, l2)) -> l1 < l2 ? (p2, l2) ! (p1, l1), pl)
