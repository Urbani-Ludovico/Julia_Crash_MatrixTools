using Test, crash_MatrixTools

@testset verbose=true "TOT" begin
    include("Pivot_test.jl")
    include("Matrix_test.jl")
    include("ElementaryOperations_test.jl")
    include("GaussStepping_test.jl")
    include("Rank_test.jl")
    include("Det_test.jl")
end