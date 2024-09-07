#' # SOR iteracija za razpršene matrike
#' Elian Mugerli, 7.9.2024
#' 
#'
#'

using .Domaca01

#' ## Opis problema

#' Naloga rešuje problem SOR iteracije na razpršenih matrikah. Razpršena matrika je matrika, ki je ločena na dve matriki:
#' - matrika indeksov `I`, ki vsebuje indekse vrednosti v matriki `V`
#' Vsaka vrstica matrike `V` vsebuje ničelne elemente iz vrstice v prvotni matriki.
#' V matriki `I` so indeksi stolpcev teh neničelnih elementov.

#' ## Opis rešitve

A = RazprsenaMatrika([[4 -1 0 0]; [-1 4 -1 0]; [0 -1 4 -1]; [0 0 -1 3]])
AOsnovna = [[4 -1 0 0]; [-1 4 -1 0]; [0 -1 4 -1]; [0 0 -1 3]]
x = [1, 1, 1, 1]
b = AOsnovna * x
sor(A, b, zeros(size(A.V, 1)), 1)[1]
AOsnovna \ b

AOsnovna \ b ≈ sor(A, b, zeros(size(A.V, 1)), 1)[1]

#' Poglejmo še pridobljeni optimiziran omega faktor.
omega = optimize_omega(A, b, zeros(size(A.V, 1)))

#' 
#' 
#' 

using Plots