function max_prod(as, k)
    p = prod(as[1:k])
    m = p
    for i = (k+1):length(as)
        new = as[i]
        old = as[i-k]
        if old == 0
            p = prod(as[(i-k+1):i]) # cases with 0 could be handled more efficiently
            # but the complexity would be high, we must keep track of right most 0
            # in the window, and keep partial product of those right of it
            # this will suffice for now.
        else
            p = div(p * new, old)
        end
        if p > m
            m = p
        end
    end
    return m
end

function read_digits_as_array(file, ignore_chars="\n")
    io = open(file, "r")
    as = []
    while(!eof(io))
        c = read(io, Char)
        if !(c in ignore_chars)
          push!(as, c)  
        end
    end
    return map(x -> x - '0', as)
end
