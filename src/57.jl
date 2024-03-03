f(n) = n == 0 ? BigInt(0) : BigInt(1)//(2+f(n-1))
s(n) = 1+f(n)
numgtden(q) = ndigits(numerator(q)) > ndigits(denominator(q))
