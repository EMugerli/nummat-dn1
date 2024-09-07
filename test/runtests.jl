using VzorecVaje
using Test

@testset "Linearna interpolacija" begin
  @test VzorecVaje.lininter(0.5, 0, 1, 0, 1) ≈ 0.5
end