function buildC(ub, threshold)
    array = zeros(Int64, ub, ub)
    foreach(n -> array[n, 1] = n, 1:ub)
    foreach(i -> array[i, i] = 1, 1:ub)
    for n in 3:ub
        for k in 2:(n-1)
            a1 = array[n-1, k-1]; a2 = array[n-1, k]
            array[n, k] = a1 + a2 > threshold ? threshold : a1 + a2
        end
    end
    return array
end

