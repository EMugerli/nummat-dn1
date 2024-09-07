module VzorecVaje
"""
    y = lininter(x, a, b, fa, fb)

Izračunaj linearno interpolacijo neznane funkcije, ki je podana z vrednostmi
`f(a) = fa` in `f(b) = fb` na krajiščih intervala `[a, b]`.
"""
function lininter(x, a, b, fa, fb)
    # y - fa = k(x - a); k = (fb - fa) 
    return (fb - fa) / (b - a) * (x - a) + fa
end

export lininter
end # module VzorecVaje
