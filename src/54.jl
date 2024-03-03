@enum Hand high one two three straight flush full four straight_flush royal_flush
@enum Suite spade=Int('S') club=Int('C') diamond=Int('D') heart=Int('H')

struct Card
    num :: Int8
    suite :: Suite
end

card_en = Dict("T" => 10, "J" => 11, "Q" => 12, "K" => 13, "A" => 14)

function new_card(c_str) :: Card
    l = length(c_str)
    num_c = c_str[1:l-1]
    suite = Suite(Int(c_str[l]))
    if isdigit(num_c[1])
        return Card(parse(Int8, num_c), suite)
    else
        return Card(card_en[num_c], suite)
    end
end

parse_hand(s_str) = map(new_card, split(s_str))

function count_freq(as)
    d = Dict()
    for a in as
        d[a] = get(d, a, 0) + 1
    end
    return d
end

function card_isless(c1, c2, hand_freq)
    f1 = hand_freq[c1.num]; f2 = hand_freq[c2.num]
    if f1 < f2
        true
    elseif f1 == f2
        return c1.num < c2.num
    else
        return false
    end
end

"is the sorted input sequence `as` an arithmetic sequence with steps `d`"
function is_arith(as, d)
    for i in 1:length(as)-1
        if as[i] + d != as[i+1]
            return false
        end
    end
    return true
end

function score(hand)
    suites = map(c -> c.suite, hand)
    nums = sort(map(c -> c.num, hand))
    hand_freq = count_freq(map(c -> c.num, hand))
    cd = sort(collect(values(hand_freq)))
    cil(c1, c2) = card_isless(c1, c2, hand_freq)
    ret_ord = map(c -> c.num, sort(hand; lt=cil, rev=true))
    if cd == [1, 1, 1, 1, 1]
        if allequal(suites) # flushes
            if nums == [10, 11, 12, 13, 14]
                return (royal_flush, reverse(nums))
            elseif is_arith(nums, 1)
                return (straight_flush, reverse(nums))
            else
                return (flush, reverse(nums))
            end
        elseif is_arith(nums, 1) # straight
            (straight, reverse(nums))
        else # high card
            (high, reverse(nums))
        end
    elseif cd == [1, 1, 1, 2] # one pair
        (one, ret_ord)
    elseif cd == [1, 2, 2] #two pair
        (two, ret_ord)
    elseif cd == [1, 1, 3] #three of a kind
        (three, ret_ord)
    elseif cd == [2, 3] # full house
        (full, ret_ord)
    elseif cd == [1, 4] # four of a kind
        (four, ret_ord)
    else
        error("Don't know how to score this hand.")
    end
end

read_game(l) = (parse_hand(view(l, 1:14)), parse_hand(view(l, 15:29)))
whowins(h1, h2) = isless(score(h1), score(h2)) ? 2 : 1

function score_all_game(filename)
    w = [0, 0]
    for line in eachline(filename)
        (h1, h2) = read_game(line)
        w[whowins(h1, h2)] += 1 # some might be draws; only first player wins are good
    end
    return w
end
