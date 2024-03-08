f(x, acc) = 1//(x + acc)
es(k) = collect(Iterators.flatmap(i -> [1, 2*i, 1], 1:ceil(Int, k/3)))
e(n) = BigInt(2) + foldr(f, es(n)[1:n]; init=BigInt(0))

