
@testset verbose=true "crash_ElementaryOperations" begin
    @testset verbose=true "Matrix_EO1" begin
        @testset "Success" begin
            @test [5.0 6 7; 3 4 5; 0 2 3] == EO.Matrix_EO1([0.0 2 3; 3 4 5; 5 6 7], 1, 3)
        end

        @testset "Zeros" begin
            @test [0.0 0 0; 0 0 0] == EO.Matrix_EO1([0.0 0 0; 0 0 0], 1, 2)
            @test zeros(5, 0) == EO.Matrix_EO1(zeros(5, 0), 1, 2)
        end

        @testset "Indexes out" begin
            @test_throws DomainError EO.Matrix_EO1(zeros(0, 1), 1, 1)
            @test_throws DomainError EO.Matrix_EO1(zeros(0, 1), 1, 2)
            @test_throws DomainError EO.Matrix_EO1(zeros(1, 1), 1, 2)
            @test_throws DomainError EO.Matrix_EO1(zeros(1, 1), 2, 1)
        end
    end

    @testset verbose=true "Matrix_EO2" begin
        @testset "Success" begin
            @test [0.0 0 0; 0 0 0] == EO.Matrix_EO2([0.0 0 0; 0 0 0], 1, 2.0)
            @test [0.0 4 6; 3 4 5; 5 6 7] == EO.Matrix_EO2([0.0 2 3; 3 4 5; 5 6 7], 1, 2.0)
            @test [0.0 2 3; 1 2 4; 5 6 7] == EO.Matrix_EO2([0.0 2 3; 2 4 8; 5 6 7], 2, 0.5)
        end

        @testset "Zeros" begin
            @test zeros(5, 0) == EO.Matrix_EO2(zeros(5, 0), 1, 2.0)
        end

        @testset "Indexes out" begin
            @test_throws DomainError EO.Matrix_EO2(zeros(0, 1), 1, 1.0)
            @test_throws DomainError EO.Matrix_EO2(zeros(0, 1), 1, 2.0)
            @test_throws DomainError EO.Matrix_EO2(zeros(1, 1), 3, 2.0)
            @test_throws DomainError EO.Matrix_EO2(zeros(1, 1), 2, 1.0)
        end
    end

    @testset verbose=true "Matrix_EO3" begin
        @testset "Success" begin
            @test [0.0 0 0; 1 2 5; 0 0 1; 4 6 10] == EO.Matrix_EO3([0.0 0 0; 1 2 5; 0 0 1; 3 4 5], 2, 4, 1.0)
            @test [4.0 6 2; 0 2 5; 20 22 6] == EO.Matrix_EO3([4.0 6 2; 0 2 5; 8 4 0], 1, 3, 3.0)
        end

        @testset "Out of range" begin
            @test_throws DomainError EO.Matrix_EO3(zeros(1, 1), 1, 2, 3.0)
            @test_throws DomainError EO.Matrix_EO3(zeros(1, 1), 2, 2, 3.0)
        end

        @testset "Same rows" begin
            @test_throws ArgumentError EO.Matrix_EO3(zeros(2, 1), 1, 1, 3.0)
        end
    end
end