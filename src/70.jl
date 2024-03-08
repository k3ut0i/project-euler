using .NumberTheory
using .Utils

isdigitperm(n1, n2) = count_freq(digits(n1)) == count_freq(digits(n2))

istotientperm(n, spf_vec) = isdigitperm(n, totient(n, spf_vec))
