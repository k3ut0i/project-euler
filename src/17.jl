const wc :: Dict{Int, String} = Dict([
    1 => "one", 2 => "two", 3 => "three", 4 => "four", 5 => "five",
    6 => "six", 7 => "seven", 8 => "eight", 9 => "nine", 10 => "ten",
    11 => "eleven", 12 => "twelve", 13 => "thirteen", 14 => "fourteen",
    15 => "fifteen", 16 => "sixteen", 17 => "seventeen", 18 => "eighteen",
    19 => "nineteen", 20 => "twenty", 30 => "thirty", 40 => "forty",
    50 => "fifty", 60 => "sixty", 70 => "seventy", 80 => "eighty",
    90 => "ninety", 100 => "hundred", 1000 => "thousand"
])

function num2words(n)
    if n > 9999
        error("function does not support > 9999")
    else
        ds = [n%10, n%100-n%10, n%1000-n%100, n%10_000-n%1000]
        fourth = ds[4] == 0 ? "" : wc[div(ds[4], 1000)] * " " * wc[1000]
        third = ds[3] == 0 ? "" : wc[div(ds[3], 100)] * " " * wc[100]
        if(ds[2] == 10)
            if(ds[4] == 0 && ds[3] == 0)
                return wc[10+ds[1]]
            else
                return fourth * " " * third * " and " * wc[10+ds[1]]
            end
        elseif(ds[2] == 0 && ds[1] == 0)
            return fourth * " " * third
        else
            second = ds[2] == 0 ? "" : wc[ds[2]]
            first = ds[1] == 0 ? "" : wc[ds[1]]
            if(ds[4] == 0 && ds[3] == 0)
                return second * " " * first
            else
                return fourth * " " * third * " and " * second * " " * first
            end
        end
    end
end

function sum_of_letters_upto(n)
    f = Base.Unicode.isletter
    return sum(map(i -> count(f, num2words(i)), 1:n))
end
