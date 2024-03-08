module PellsEquation

brahmagupta_compose(N, (a1, b1, k1), (a2, b2, k2)) =
    (a1*a2+N*b1*b2, a1*b2+a2*b1, k1*k2)
chakravala_step(N, (a, b, k)) = m -> ((a*m+N*b)/k, (a+b*m)/k, (m*m - N)/k)

end #module
