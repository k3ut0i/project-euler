module NumberTheory
export is_prime
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

end #endmodule
