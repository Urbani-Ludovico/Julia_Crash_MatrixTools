using Test, crash_MatrixTools

@testset verbose=true "TOT" begin
    @testset verbose=true "crash_Pivot" begin
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
    end

    @testset verbose=true "crash_Matrix" begin
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

        @testset verbose=true "Matrix_IsInStair" begin
            @testset "Success" begin
                @test Matrix_IsInStair([3.0 0 0; 0 2 0; 0 0 1])
                @test Matrix_IsInStair([0.0 3 0 0; 0 0 2 0; 0 0 0 1])
                @test Matrix_IsInStair([0.0 3 0 0 0 ; 0 0 0 1 0; 0 0 0 0 1])
                @test Matrix_IsInStair([0.0 3 0])
                @test Matrix_IsInStair([3.0 ;;])
                @test false == Matrix_IsInStair([0.0 3 0 0; 0 1 2 0; 0 0 0 1])
                @test false == Matrix_IsInStair([1.0; 2 ;;])
                @test false == Matrix_IsInStair([1.0 0 0; 0 2 0; 3 0 1])
            end
    
            @testset "Zeros" begin
                @test false == Matrix_IsInStair(zeros(0, 0))
                @test false == Matrix_IsInStair(zeros(2, 0))
                @test false == Matrix_IsInStair(zeros(0, 2))
                @test false == Matrix_IsInStair(zeros(2, 3))
            end
        end
    end

    @testset verbose=true "crash_ElementaryOperations" begin
        @testset verbose=true "Matrix_EO1" begin
            @testset "Success" begin
                @test [5.0 6 7; 3 4 5; 0 2 3] == Matrix_EO1([0.0 2 3; 3 4 5; 5 6 7], 1, 3)
            end

            @testset "Zeros" begin
                @test [0.0 0 0; 0 0 0] == Matrix_EO1([0.0 0 0; 0 0 0], 1, 2)
                @test zeros(5, 0) == Matrix_EO1(zeros(5, 0), 1, 2)
            end

            @testset "Indexes out" begin
                @test_throws DomainError Matrix_EO1(zeros(0, 1), 1, 1)
                @test_throws DomainError Matrix_EO1(zeros(0, 1), 1, 2)
                @test_throws DomainError Matrix_EO1(zeros(1, 1), 1, 2)
                @test_throws DomainError Matrix_EO1(zeros(1, 1), 2, 1)
            end
        end

        @testset verbose=true "Matrix_EO2" begin
            @testset "Success" begin
                @test [0.0 0 0; 0 0 0] == Matrix_EO2([0.0 0 0; 0 0 0], 1, 2.0)
                @test [0.0 4 6; 3 4 5; 5 6 7] == Matrix_EO2([0.0 2 3; 3 4 5; 5 6 7], 1, 2.0)
                @test [0.0 2 3; 1 2 4; 5 6 7] == Matrix_EO2([0.0 2 3; 2 4 8; 5 6 7], 2, 0.5)
            end

            @testset "Zeros" begin
                @test zeros(5, 0) == Matrix_EO2(zeros(5, 0), 1, 2.0)
            end

            @testset "Indexes out" begin
                @test_throws DomainError Matrix_EO2(zeros(0, 1), 1, 1.0)
                @test_throws DomainError Matrix_EO2(zeros(0, 1), 1, 2.0)
                @test_throws DomainError Matrix_EO2(zeros(1, 1), 3, 2.0)
                @test_throws DomainError Matrix_EO2(zeros(1, 1), 2, 1.0)
            end
        end
    end

    @testset verbose=true "crash_GaussStepping" begin
        @testset verbose=true "Gauss_ReduceTwoRows" begin
            @testset "Success" begin
                @test [0.0 0 0; 1 2 5; 0 0 1; 0 -2 -10] == Gauss_ReduceTwoRows([0.0 0 0; 1 2 5; 0 0 1; 3 4 5], 2, 4)
                @test [4.0 6 2; 0 2 5; 0 -8 -4] == Gauss_ReduceTwoRows([4.0 6 2; 0 2 5; 8 4 0], 1, 3)
            end
    
            @testset "Out of range" begin
                @test_throws DomainError Gauss_ReduceTwoRows(zeros(1, 1), 1, 2)
                @test_throws DomainError Gauss_ReduceTwoRows(zeros(1, 1), 2, 2)
            end

            @testset "Same rows" begin
                @test_throws ArgumentError Gauss_ReduceTwoRows(zeros(2, 1), 1, 1)
            end

            @testset "Different pivot" begin
                @test_throws DomainError Gauss_ReduceTwoRows([0.0 1 2 3; 0 0 3 4], 1, 2)
            end
        end

        @testset verbose=true "Gauss_Stepping" begin
            @testset "Success" begin
                @test [1.0 2 5; 0 -2 -10; 0 0 1] == Gauss_Stepping([0.0 0 0; 1 2 5; 0 0 1; 3 4 5])
                @test [4.0 3 5; 0 2 5; 0 0 -5] == Gauss_Stepping([4.0 3 5; 0 2 5; 8 4 0])
            end
    
            @testset "Empty" begin
                @test_throws DimensionMismatch Gauss_Stepping(zeros(0, 0))
                @test_throws DimensionMismatch Gauss_Stepping(zeros(1, 0))
                @test_throws DimensionMismatch Gauss_Stepping(zeros(0, 1))
                @test_throws DimensionMismatch Gauss_Stepping(zeros(2, 3))
            end
    
            @testset "No operation" begin
                @test [1 2 5; 0 2 1; 0 0 5] == Gauss_Stepping([0.0 0 0; 1 2 5; 0 2 1; 0 0 5])
                @test [1 2 5; 0 2 1; 0 0 5] == Gauss_Stepping([0.0 0 0; 1 2 5; 0 0 0; 0 2 1; 0 0 0; 0 0 5; 0 0 0])
            end
        end
    end
end