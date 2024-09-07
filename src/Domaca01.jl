module Domaca01

using LinearAlgebra
export RazprsenaMatrika, sor, optimize_omega


import Base: *, lastindex,firstindex, getindex, setindex!

mutable struct RazprsenaMatrika
    V
    I::Matrix{Int64}
end

"""
    RazprsenaMatrika(M)
    Funkcija matriko `M` pretvori v razpršeno matriko.
"""
function RazprsenaMatrika(M)
    max_nonzeros_per_row = 1
    for i=1:size(M, 1)
        nonzero_count = 0
        for j=1:length(M[i, :])
            if M[i, j] != 0
                nonzero_count += 1
            end
        end
        if nonzero_count > max_nonzeros_per_row
            max_nonzeros_per_row = nonzero_count
        end
    end

    V = zeros(size(M, 1), max_nonzeros_per_row)
    I = zeros(size(M, 1), max_nonzeros_per_row)
    vr = 1
    for i=1:size(M, 1)
        count = 1
        for j=1:length(M[i, :])
            if M[i, j] != 0
                V[vr, count] = M[i, j]
                I[vr, count] = j
                count += 1
            end
        end
        vr += 1
    end       

    return RazprsenaMatrika(V, I)
end

"""
    firstindex(A::RazprsenaMatrika)
    Funkcija vrne prvi indeks matrike `A`.
"""
function firstindex(A::RazprsenaMatrika)
    return (1, 1)
end

"""
    lastindex(A::RazprsenaMatrika)
    Funkcija vrne zadnji indeks matrike `A`.
"""
function getindex(A::RazprsenaMatrika, i::Int64, j::Int64)
    if i > size(A.V, 1) || j > size(A.V, 1) || i < 1 || j < 1
        throw(BoundsError(A, (i, j)))
    end
    for k = 1:size(A.I, 2)
        if A.I[i, k] == j
            return A.V[i, k]
        end
    end
    return 0.0
end

"""
    setindex!(A::RazprsenaMatrika, val, i::Int, j::Int)
    Funkcija nastavi vrednost `val` na indeksu `(i, j)` v matriki `A`.
"""
function setindex!(A::RazprsenaMatrika, val, i::Int, j::Int)
    if i > size(A.V, 1) || j > size(A.I, 2) || i < 1 || j < 1
        throw(BoundsError(A, (i, j)))
    end

    # Poišči mesto za vstavljanje ali spreminjanje
    for k = 1:size(A.I, 2)
        if A.I[i, k] == j
            A.V[i, k] = val  # Spreminjamo obstoječo vrednost
            return A
        end
    end

    # Če je stolpec j nov, poiščimo prazen prostor (kjer je indeks 0)
    for k = 1:size(A.I, 2)
        if A.I[i, k] == 0  # prazen prostor
            A.I[i, k] = j  # dodaj nov indeks
            A.V[i, k] = val  # dodaj novo vrednost
            return A
        end
    end

    # Če ni več prostora, razširimo matriko, da omogočimo novo vstavljanje
    new_columns = size(A.I, 2) + 1
    new_I = zeros(Int, size(A.I, 1), new_columns)
    new_V = zeros(size(A.V, 1), new_columns)

    # Kopiramo stare vrednosti v novo matriko
    new_I[:, 1:end-1] = A.I
    new_V[:, 1:end-1] = A.V

    # Dodamo novo vrednost v prvo prosto mesto
    new_I[i, end] = j
    new_V[i, end] = val

    # Posodobimo obstoječe matrike
    A.I = new_I
    A.V = new_V

    return A
end

"""
    *(A::RazprsenaMatrika, x::Vector)
    Funkcija matriko `A` pomnoži z vektorjem `x`.
"""
function *(A::RazprsenaMatrika, x::Vector)
    if size(A.V, 1) != length(x)
        throw(error("Dimenzije se ne ujemajo!"))
    end

    b = zeros(length(x))
    for i = 1:size(A.V, 1)
        for j = 1:size(A.V, 2)
            if A.I[i, j] != 0
                b[i] += A.V[i, j] * x[A.I[i, j]]
            end
        end
    end
    return b
end

"""
    sor(A::RazprsenaMatrika, b::Vector, x0::Vector, omega, tol=1e-10, maxiter=1000)
    Funkcija reši sistem enačb `Ax = b` z uporabo SOR iteracije.
"""
function sor(A::RazprsenaMatrika, b::Vector, x0::Vector, omega, tol=1e-10, maxiter=1000)
    n = length(b)
    x = copy(x0)
    
    for it = 1:maxiter
        for i = 1:n
            sum = 0.0
            for k = 1:size(A.I, 2)
                j = A.I[i, k]
                if j != 0 && i != j
                    sum += A.V[i, k] * x[j]
                end
            end
            x[i] = (1 - omega) * x[i] + omega / getindex(A, i, i) * (b[i] - sum)
        end
        
        if norm(A * x - b) < tol
            return x, it
        end
    end
    return x, maxiter
end

"""
    optimize_omega(A::RazprsenaMatrika, b::Vector, x0::Vector, tol=1e-10, omegas=0.1:0.1:1.9)
    Funkcija poišče najboljši omega faktor za SOR iteracijo.
"""
function optimize_omega(A::RazprsenaMatrika, b::Vector, x0::Vector, tol=1e-10, omegas=0.1:0.1:1.9)
    best_omega = 0.0
    fewest_iter = Inf
    for omega in omegas
        _, it = sor(A, b, x0, omega)
        if it < fewest_iter
            fewest_iter = it
            best_omega = omega
        end
    end
    return best_omega
end

end # module Domaca01
