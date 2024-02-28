function digit_seq(ub)
    s = [(9, 1)]
    x = 1
    while(9*10^x < ub)
        push!(s, (9*10^x, (x+1)))
        x = x+1
    end
    return s
end

function find_nth_digit(seq, n)
    digit_cursor = 1
    for (nums, num_size) in seq
        if digit_cursor + nums*num_size > n
            index_in_block = n - digit_cursor + 1
            number_index = div(index_in_block, num_size)+1
            num = 10^(num_size-1)+number_index-1
            return reverse(digits(num))[mod(index_in_block, num_size)+1]
        else
            digit_cursor += nums*num_size
        end
    end
    error("input sequence is smaller than required.")
end

fn(s, n) = n == 1 ? 1 : find_nth_digit(s, n-1) # some reason everything shifted left by1

