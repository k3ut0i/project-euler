function is_palindrome(as)
    all(map(==, as, reverse(as)))
end

function is_db_palindrome(n)
    return is_palindrome(digits(n)) && is_palindrome(digits(n; base=2))
end
