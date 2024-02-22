function special_pyth(n, s)
    for i in 1:n, j in 1:n
        c = sqrt(i*i+j*j)
        if (i*i+j*j == c*c) && (i+j+c == s)
            return i*j*c
        end
    end
end
