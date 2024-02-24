module Utils
export todigits

function todigits(x::Int)
    v = Vector{Int8}()
    while x != 0
        push!(v, x%10)
        x = div(x, 10)
    end
    return v
end

end
