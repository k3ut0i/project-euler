module LongNums
export add, mul, len, get_i, pow, LongNum, digitsum

struct LongNum
    data :: Vector{Int8} #smallest index is smallest 10thpower, little endian
end

function todigits(x::Int)
    v = Vector{Int8}()
    while x != 0
        push!(v, x%10)
        x = div(x, 10)
    end
    return v
end

function tostr(x::LongNum)
    reduce(*, reverse(map(repr, x.data)))
end

Base.show(io::IO, ::MIME"text/plain", n::LongNum) = print(tostr(n))

function len(x::LongNum)
    return length(x.data)
end

function get_i(x::LongNum, i) :: Int8
    return get(x.data, i, 0)
end

function add(x::LongNum, y::LongNum)
    v = Vector{Int8}()
    carry = 0
    for i in 1:max(len(x), len(y))
        s = get_i(x, i) + get_i(y, i) + carry
        carry = div(s, 10)
        d = mod(s, 10)
        push!(v, d)
    end
    if carry != 0
        push!(v, carry)
    end
    return LongNum(v)
end

function mul10p(x::LongNum, p::Int) :: LongNum
    LongNum(append!(fill(0, p), x.data))
end

function mul(x::LongNum, y::Integer) :: LongNum
    v = Vector{Int8}()
    carry = 0
    for i in 1:len(x)
        s = y*get_i(x, i) + carry
        carry = div(s, 10)
        d = mod(s, 10)
        push!(v, d)
    end
    for d in todigits(carry)
        push!(v, d)
    end
    LongNum(v)
end

function mul(x::LongNum, y::LongNum)
    parts = Vector{LongNum}()
    for i in 1:len(x)
        push!(parts, mul(y, get_i(x, i)))
    end
    reduce(add, map((v, i) -> mul10p(v, i-1), parts, 1:length(parts)))
end

function pow(x::LongNum, y::Integer)
    r = x
    for i in 2:y
        r = mul(r , x)
    end
    return r
end

function digitsum(x::LongNum)
    r = Int64(0)
    for a in x.data
        r += a
    end
    return r
end

end
