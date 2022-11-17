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

    @testset verbose=true "Matrix_IsNull" begin
        @testset "Success" begin
            @test true == Matrix_IsNull([0.0 0 0; 0 0 0])
            @test true == Matrix_IsNull([0.0; 0 ;;])
            @test true == Matrix_IsNull([0.0 ;;])
            @test false == Matrix_IsNull([0.0 0 2; 0 0 0])
            @test false == Matrix_IsNull([2.0; 0 ;;])
            @test false == Matrix_IsNull([2.0 ;;])
        end

        @testset "Zeros" begin
            @test true == Matrix_IsNull(zeros(0, 0))
            @test true == Matrix_IsNull(zeros(2, 0))
            @test true == Matrix_IsNull(zeros(0, 2))
            @test true == Matrix_IsNull(zeros(2, 2))
        end
    end

    @testset verbose=true "Matrix_SwapRows" begin
        @testset "Success" begin
            @test true == Matrix_IsNull([0.0 0 0; 0 0 0])
            @test true == Matrix_IsNull([0.0; 0 ;;])
            @test true == Matrix_IsNull([0.0 ;;])
            @test false == Matrix_IsNull([0.0 0 2; 0 0 0])
            @test false == Matrix_IsNull([2.0; 0 ;;])
            @test false == Matrix_IsNull([2.0 ;;])
        end

        @testset "Indexes out" begin
            @test_throws DomainError Matrix_SwapRows(zeros(0, 1), 1, 1)
            @test_throws DomainError Matrix_SwapRows(zeros(0, 1), 1, 2)
            @test_throws DomainError Matrix_SwapRows(zeros(1, 1), 1, 2)
            @test_throws DomainError Matrix_SwapRows(zeros(1, 1), 2, 1)
        end
    end

    @testset verbose=true "Matrix_RemoveRows" begin
        @testset "Success" begin
            @test [1.0 2; 5 6] == Matrix_RemoveRows([1.0 2; 3 4; 5 6], [2])
            @test [1.0 2; ] == Matrix_RemoveRows([1.0 2; 3 4; 5 6], [2, 3, 4])
        end

        @testset "Zeros" begin
            @test zeros(0, 2) == Matrix_RemoveRows([1.0 2; 5 6], [1, 2])
            @test zeros(0, 2) == Matrix_RemoveRows(zeros(0, 2), [1, 2])
        end
    end

    @testset verbose=true "Matrix_ClearEmptyRow" begin
        @testset "Success" begin
            @test [1.0 2 3; 0 0 5] == Matrix_ClearEmptyRow([0.0 0 0; 1.0 2 3; 0 0 5])
            @test [0.0 0 1; 0 0 5] == Matrix_ClearEmptyRow([0.0 0 0; 0 0 1; 0 0 0; 0 0 5])
        end
        @testset "Zeros" begin
            @test zeros(0, 3) == Matrix_ClearEmptyRow([0.0 0 0; 0 0 0; 0 0 0])
            @test zeros(0, 3) == Matrix_ClearEmptyRow(zeros(0, 3))
            @test zeros(0, 0) == Matrix_ClearEmptyRow(zeros(3, 0))
        end
    end
end