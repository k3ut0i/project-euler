function readgraph(file)
    v = Vector{Vector{Int}}()
    for line in eachline(file)
        push!(v, map(x -> parse(Int, x), split(line)))
    end
    return v
end

function traverse(v)
    s = Vector{Vector{Int}}([v[1]]) # sum of starting node 
    for i in 2:length(v)
        ws = Vector{Int}([s[i-1][1] + v[i][1]])
        for j in 1:(i-2)
            push!(ws, max(s[i-1][j], s[i-1][j+1]) + v[i][j+1])
        end
        push!(ws, s[i-1][i-1]+v[i][i])
        push!(s, ws)
    end
    s
end
