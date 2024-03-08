"rolling my own powermod"
function powermod_1(base, expo, m)
    r = 1
    for i in 1:expo
        r = mod(r*base, m)
    end
    return r
end
