using .Domaca01
using Test

@testset "getindex" begin 
  A = RazprsenaMatrika([[0 0 1 0]; [0 5 0 3]; [7 0 0 0]; [0 4 0 6]])
  @test getindex(A, 1, 3) == 1
  @test_throws BoundsError getindex(A, 0, 0)
  @test getindex(A, 2, 4) == 3
  @test A[4, 4] == 6
  @test A[3, 2] == 0
end

@testset "setindex" begin 
  A = RazprsenaMatrika([[0 0 1 0]; [0 5 0 3]; [7 0 0 0]; [0 4 0 6]])
  A[1, 3] = 2
  @test A[1, 3] == 2
  A[2, 4] = 4
  @test A[2, 4] == 4
  A[4, 1] = 5
  @test A[4, 1] == 5
  A[3, 3] = 9
  @test A[3, 3] == 9
end

@testset "firstindex" begin
  A = RazprsenaMatrika([[0 2 0 4]; [1 0 3 0]; [0 0 0 5]; [0 0 0 0]])
  @test firstindex(A) == (1, 1)
end

@testset "lastindex" begin
  A = RazprsenaMatrika([[0 2 0 4]; [1 0 3 0]; [0 0 0 5]; [0 0 0 0]])
  @test lastindex(A) == (4, 4)
end

@testset "*" begin
  A = RazprsenaMatrika([[1 0 0]; [0 2 0]; [0 0 3]])
  v = [1, 1, 1]
  @test *(A, v) == [1.0, 2.0, 3.0]
  
  v = [2, 3, 4]
  @test *(A, v) == [2.0, 6.0, 12.0]

  v = [-1, 0, 1]
  @test *(A, v) == [-1.0, 0.0, 3.0]
end

@testset "sor" begin
  A = RazprsenaMatrika([[4 -1 0 0]; [-1 4 -1 0]; [0 -1 4 -1]; [0 0 -1 3]])
  AOsnovna = [[4 -1 0 0]; [-1 4 -1 0]; [0 -1 4 -1]; [0 0 -1 3]]

  x = [1, 1, 1, 1]
  b = AOsnovna * x
  @test AOsnovna \ b ≈ sor(A, b, zeros(size(A.V, 1)), 1)[1]

  x = [1, 2, 3, 4]
  b = AOsnovna * x
  @test AOsnovna \ b ≈ sor(A, b, zeros(size(A.V, 1)), 1.2)[1]

  x = [-1, -2, -3, -4]
  b = AOsnovna * x
  @test AOsnovna \ b ≈ sor(A, b, zeros(size(A.V, 1)), 1.5)[1]
end
