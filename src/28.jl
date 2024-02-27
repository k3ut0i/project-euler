function sum_diag_on(n)
    if n == 1
        return 1
    else
        return 4*n*n-6*n+6
    end
end

function sum_all_diag_below(x)
    return sum(map(sum_diag_on, 1:2:x))
end
