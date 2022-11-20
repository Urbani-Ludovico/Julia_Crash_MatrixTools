
@testset verbose=true "crash_GaussStepping" begin
    @testset verbose=true "Gauss_ReduceTwoRows" begin
        @testset "Success" begin
            @test [0.0 0 0; 1 2 5; 0 0 1; 0 -2 -10] == GaussStepping.Gauss_ReduceTwoRows([0.0 0 0; 1 2 5; 0 0 1; 3 4 5], 2, 4)
            @test [4.0 6 2; 0 2 5; 0 -8 -4] == GaussStepping.Gauss_ReduceTwoRows([4.0 6 2; 0 2 5; 8 4 0], 1, 3)
        end

        @testset "Out of range" begin
            @test_throws DomainError GaussStepping.Gauss_ReduceTwoRows(zeros(1, 1), 1, 2)
            @test_throws DomainError GaussStepping.Gauss_ReduceTwoRows(zeros(1, 1), 2, 2)
        end

        @testset "Same rows" begin
            @test_throws ArgumentError GaussStepping.Gauss_ReduceTwoRows(zeros(2, 1), 1, 1)
        end

        @testset "Different pivot" begin
            @test_throws DomainError GaussStepping.Gauss_ReduceTwoRows([0.0 1 2 3; 0 0 3 4], 1, 2)
        end
    end

    @testset verbose=true "Gauss_Stepping" begin
        @testset "Success" begin
            @test [1.0 2 5; 0 -2 -10; 0 0 1] == GaussStepping.Gauss_Stepping([0.0 0 0; 1 2 5; 0 0 1; 3 4 5])
            @test [4.0 3 5; 0 2 5; 0 0 -5] == GaussStepping.Gauss_Stepping([4.0 3 5; 0 2 5; 8 4 0])
        end

        @testset "Empty" begin
            @test_throws DimensionMismatch GaussStepping.Gauss_Stepping(zeros(0, 0))
            @test_throws DimensionMismatch GaussStepping.Gauss_Stepping(zeros(1, 0))
            @test_throws DimensionMismatch GaussStepping.Gauss_Stepping(zeros(0, 1))
            @test_throws DimensionMismatch GaussStepping.Gauss_Stepping(zeros(2, 3))
        end

        @testset "No operation" begin
            @test [1 2 5; 0 2 1; 0 0 5] == GaussStepping.Gauss_Stepping([0.0 0 0; 1 2 5; 0 2 1; 0 0 5])
            @test [1 2 5; 0 2 1; 0 0 5] == GaussStepping.Gauss_Stepping([0.0 0 0; 1 2 5; 0 0 0; 0 2 1; 0 0 0; 0 0 5; 0 0 0])
        end
    end
end