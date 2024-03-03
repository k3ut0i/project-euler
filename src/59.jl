function read_ciphertext(file) :: Vector{Int8}
    s = read(file, String)
    is = map(c -> parse(Int8, c), split(s, ","))
    return is
end

function decrypt(cipher :: Vector{Int8}, key :: Vector{Int8})
    map(xor, cipher, repeat(key, div(length(cipher), length(key))))
end

tostring(x :: Vector{Int8}) = String(map(Char, x))

function possible(text :: String) :: Bool
    return contains(text, "the ")
end

function search(cipher :: Vector{Int8})
    l = length(cipher)
    to_c(x) = Int8(x+97-1)
    result = []
    for a in 1:26, b in 1:26, c in 1:26
        cs = map(to_c, Int8[a, b, c])
        plain = tostring(decrypt(cipher, cs))
        if possible(plain)
            push!(result, plain)
        end
    end
    return result
end
