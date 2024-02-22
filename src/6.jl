function sum_of_squares(n)
    return div(n*(n+1)*(2*n+1), 6)
end

function sum_of(n)
    return n*(n+1)/2
end

let n = 100, sn = sum_of(n)
    println(sn*sn-sum_of_squares(n))
end

    
    
