using DelimitedFiles: readdlm

function down(i, j)
    [(i, j), (i+1, j), (i+2, j), (i+3, j)]
end

function right(i, j)
    [(i, j), (i, j+1), (i, j+2), (i, j+3)]
end

function diag(i, j)
    [(i, j), (i+1, j+1), (i+2, j+2), (i+3, j+3)]
end

function diag1(i, j)
    [(i, j), (i+1, j-1), (i+2, j-2), (i+3, j-3)]
end

function gprod(m)
    (nrows, ncols) = size(m)
    p = 0
    function f((i, j))
        return checkbounds(Bool, m, i, j)
    end
    for i in 1:nrows, j in 1:ncols
        pdown = 0; pright = 0; pdiag = 0; pdiag1 = 0
        if all(f, down(i, j))
            pdown = prod([m[i, j] for (i, j) in down(i, j)])
        end
        if all(f, right(i, j))
            pright = prod([m[i, j] for (i, j) in right(i, j)])
        end
        if all(f, diag(i, j))
            pdiag = prod([m[i, j] for (i, j) in diag(i, j)])
        end
        if all(f, diag1(i, j))
            pdiag1 = prod([m[i, j] for (i, j) in diag1(i, j)])
        end
        p = maximum([p, pdown, pright, pdiag, pdiag1])
    end
    p
end
