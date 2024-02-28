using .Combinatorics

function num_partitions_with_12(n)
    return 1+div(n, 2)
end

function num_partitions_with(n, as)
    maxs = map(a -> div(n, a), as)
    choices = [[(y, x) for x in 0:div(n, y)] for y in as]
    count = 0
    for cs in select_from_each(choices)
        sum = foldl((acc, (x, y)) -> acc+x*y, cs; init=0)
        if sum == n
            count += 1
        elseif sum < n
            count += num_partitions_with_12(n-sum)
        end
    end
    return count
end
