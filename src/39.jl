function right_triangles(p)
    ts = []
    for x in 1:p
        for y in 1:(x-1)
            z = p - (x+y)
            if z > 0 && x*x + y*y == z*z
                push!(ts, (x, y, z))
            end
        end
    end
    return length(ts)
end

