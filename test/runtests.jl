using Test, crash_MatrixTools

@testset verbose=true "TOT" begin
    @testset verbose=true "Pivot_GetRowIndex" begin
        @testset "Success" begin
            @test 3 == Pivot_GetIndexRow([0.0, 0, 1, 0, 0, 2])
            @test 3 == Pivot_GetIndexRow([0.0, 0, 1, 0, 0, 2])
            @test 1 == Pivot_GetIndexRow([1.0, 0, 0, 0])
            @test 1 == Pivot_GetIndexRow([2.0])
            @test 4 == Pivot_GetIndexRow([0.0, 0, 0, 2, 3])
        end
    
        @testset "No pivot" begin
            @test -1 == Pivot_GetIndexRow([0.0, 0, 0, 0])
            @test -1 == Pivot_GetIndexRow([0.0])
        end
    
        @testset "Empty" begin
            @test_throws DimensionMismatch Pivot_GetIndexRow(Vector{Float64}())
        end
    end
    
    @testset verbose=true "Pivot_GetRowIndex_MinPivot_First" begin
        @testset "Success" begin
            @test 1 == Pivot_GetRowIndex_MinPivot_First([1.0 0 0; 0 0 1; 0 1 0])
            @test 1 == Pivot_GetRowIndex_MinPivot_First([1.0 0 0; 1 0 1; 0 1 0])
            @test 2 == Pivot_GetRowIndex_MinPivot_First([0.0 0 2; 0 1 1; 0 1 0])
        end

        @testset "Zeros" begin
            @test -1 == Pivot_GetRowIndex_MinPivot_First(zeros(1,1))
            @test -1 == Pivot_GetRowIndex_MinPivot_First(zeros(2,2))
            @test -1 == Pivot_GetRowIndex_MinPivot_First(zeros(3,3))
            @test -1 == Pivot_GetRowIndex_MinPivot_First(zeros(1,3))
            @test -1 == Pivot_GetRowIndex_MinPivot_First(zeros(3,1))
        end
    end

    @testset verbose=true "Matrix_IsNumm" begin
        @testset "Success" begin
            @test true == Matrix_IsNumm([0.0 0 0; 0 0 0])
            @test true == Matrix_IsNumm([0.0; 0 ;;])
            @test true == Matrix_IsNumm([0.0 ;;])
            @test false == Matrix_IsNumm([0.0 0 2; 0 0 0])
            @test false == Matrix_IsNumm([2.0; 0 ;;])
            @test false == Matrix_IsNumm([2.0 ;;])
        end

        @testset "Zeros" begin
            @test true == Matrix_IsNumm(zeros(0, 0))
            @test true == Matrix_IsNumm(zeros(2, 0))
            @test true == Matrix_IsNumm(zeros(0, 2))
            @test true == Matrix_IsNumm(zeros(2, 2))
        end
    end
end