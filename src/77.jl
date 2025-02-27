p(x) = is_prime(x, spf_vec)

function a(n, k)
    if k == 0 || n < 0
        return 0
    elseif n == 0
        return 1
    elseif is_prime(k, spf_vec)
        return a(n-k, k)+a(n,k-1)
    else
        return a(n, k-1)
    end
end

