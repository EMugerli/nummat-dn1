# 1. Domača naloga - SOR iteracija za razpršene matrike
Elian Mugerli, 7.9.2024

Naloga zahteva implementacijo `sor` metode. Ta izvaja iteracijo za reševanje sistema linearnih enačb 
$Ax = b$,
kjer je A razpršena matrika.

Razpršena matrika je matrika, ki je ločena na dve matriki:
#' - matrika indeksov `I`, ki vsebuje indekse vrednosti v matriki `V`
#' Vsaka vrstica matrike `V` vsebuje ničelne elemente iz vrstice v prvotni matriki.
#' V matriki `I` so indeksi stolpcev teh neničelnih elementov.

Metoda `sor` je iteraticna, ki uporablja relaksacijski parameter omega za hitrejšo konvergenco k rešitvi. Ustavi se, ko je dosežena določena toleranca napake.

V tem direktoriju se nahajajo datoteke potrebne za delovanje 1. domače naloge. Nalogo poženemo, tako da pokličemo `include("docs/demo.jl")`. V njem se nahaja rešitev za podani problem. Še pred tem je potrebno poklicati `activate Domaca01`. 

## Testi

Teste poženemo, tako da pokličemo tako, da v `pkg` načinu poženemo ukaz `test`

## Dokumentacija

Poročilo generiramo s paketom [Weave.jl](https://github.com/JunoLab/Weave.jl). Podrobnosti so v datoteki `makedocs.jl`.

Zgornja ukaza iz komentarjev in kode v `demo.jl` generirata PDF datoteko, ki se ob generiranju nahaja znotraj direktorija `build` v datoteki `demo.pdf`.