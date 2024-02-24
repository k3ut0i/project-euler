function isleap(year)
    if year % 400 == 0
        return true
    elseif year % 100 == 0
        return false
    elseif year % 4 == 0
        return true
    else
        return false
    end
end

function days_of_month(n, year)
    n in [4, 6, 9, 11] && return 30
    (n == 2) && return 28 + (isleap(year) ? 1 : 0)
    return 31
end

function year2months(year)
    return map(i -> days_of_month(i, year), 1:12)
end

function count_sundays(from, to, m)
    return filter(d -> m == mod(d, 7),
                  accumulate(+, Iterators.flatmap(year2months, from:to); init = 1)) |> length 
end
