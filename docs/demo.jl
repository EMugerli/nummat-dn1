#' # Linearna interpolacija - demo
#' 
#' Prikaz uporabe linearne interpolacije v programskem jeziku [julia](https://julialang.org/).

using VzorecVaje

a = 1
b = 2
fa = 3
fb = 2

y = VzorecVaje.lininter(1.5, a, b, fa, fb)

#' ## Grafični Prikaz
#' 
#' Linearno interpolacijo prikažemo grafično

using Plots

scatter([a, b], [fa, fb], ylims=[0, 4], xlims=[0.5, 2.5], label="f(a), f(b)")
plot!(x -> VzorecVaje.lininter(x, a, b, fa, fb), 1, 2, title="Linearna interpolacija",
  label="interpolant")