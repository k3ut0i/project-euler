function nth_lexi_perm(n, nums)
    if factorial(length(nums)) < n
        error("not that many permutations")
    elseif n == 1 || nums == []
        return nums
    else
        block_len = factorial(length(nums) - 1)
        if mod(n, block_len) == 0
            i = div(n, block_len)
            return vcat([nums[i]], view(nums, reverse([1:(i-1); (i+1):length(nums)])))
        else
            i = div(n, block_len) + 1
            next_nums = view(nums, [1:(i-1); (i+1):length(nums)])
            return vcat([nums[i]], nth_lexi_perm(n-(i-1)*block_len, next_nums))
        end
    end
end
