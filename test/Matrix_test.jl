
@testset verbose=true "crash_Matrix" begin
    @testset verbose=true "Matrix_IsNull" begin
        @testset "Success" begin
            @test true == MatrixT.Matrix_IsNull([0.0 0 0; 0 0 0])
            @test true == MatrixT.Matrix_IsNull([0.0; 0 ;;])
            @test true == MatrixT.Matrix_IsNull([0.0 ;;])
            @test false == MatrixT.Matrix_IsNull([0.0 0 2; 0 0 0])
            @test false == MatrixT.Matrix_IsNull([2.0; 0 ;;])
            @test false == MatrixT.Matrix_IsNull([2.0 ;;])
        end

        @testset "Zeros" begin
            @test true == MatrixT.Matrix_IsNull(zeros(0, 0))
            @test true == MatrixT.Matrix_IsNull(zeros(2, 0))
            @test true == MatrixT.Matrix_IsNull(zeros(0, 2))
            @test true == MatrixT.Matrix_IsNull(zeros(2, 2))
        end
    end

    @testset verbose=true "Matrix_RemoveRows" begin
        @testset "Success" begin
            @test [1.0 2; 5 6] == MatrixT.Matrix_RemoveRows([1.0 2; 3 4; 5 6], [2])
            @test [1.0 2; ] == MatrixT.Matrix_RemoveRows([1.0 2; 3 4; 5 6], [2, 3, 4])
        end

        @testset "Zeros" begin
            @test zeros(0, 2) == MatrixT.Matrix_RemoveRows([1.0 2; 5 6], [1, 2])
            @test zeros(0, 2) == MatrixT.Matrix_RemoveRows(zeros(0, 2), [1, 2])
        end
    end

    @testset verbose=true "Matrix_ClearEmptyRow" begin
        @testset "Success" begin
            @test [1.0 2 3; 0 0 5] == MatrixT.Matrix_ClearEmptyRow([0.0 0 0; 1.0 2 3; 0 0 5])
            @test [0.0 0 1; 0 0 5] == MatrixT.Matrix_ClearEmptyRow([0.0 0 0; 0 0 1; 0 0 0; 0 0 5])
        end
        @testset "Zeros" begin
            @test zeros(0, 3) == MatrixT.Matrix_ClearEmptyRow([0.0 0 0; 0 0 0; 0 0 0])
            @test zeros(0, 3) == MatrixT.Matrix_ClearEmptyRow(zeros(0, 3))
            @test zeros(0, 0) == MatrixT.Matrix_ClearEmptyRow(zeros(3, 0))
        end
    end

    @testset verbose=true "Matrix_IsInStair" begin
        @testset "Success" begin
            @test MatrixT.Matrix_IsInStair([3.0 0 0; 0 2 0; 0 0 1])
            @test MatrixT.Matrix_IsInStair([0.0 3 0 0; 0 0 2 0; 0 0 0 1])
            @test MatrixT.Matrix_IsInStair([0.0 3 0 0 0 ; 0 0 0 1 0; 0 0 0 0 1])
            @test MatrixT.Matrix_IsInStair([0.0 3 0])
            @test MatrixT.Matrix_IsInStair([3.0 ;;])
            @test false == MatrixT.Matrix_IsInStair([0.0 3 0 0; 0 1 2 0; 0 0 0 1])
            @test false == MatrixT.Matrix_IsInStair([1.0; 2 ;;])
            @test false == MatrixT.Matrix_IsInStair([1.0 0 0; 0 2 0; 3 0 1])
        end

        @testset "Zeros" begin
            @test false == MatrixT.Matrix_IsInStair(zeros(0, 0))
            @test false == MatrixT.Matrix_IsInStair(zeros(2, 0))
            @test false == MatrixT.Matrix_IsInStair(zeros(0, 2))
            @test false == MatrixT.Matrix_IsInStair(zeros(2, 3))
        end
    end

    @testset verbose=true "Matrix_MinorRemove" begin
        @test [2.0 3; 3 4] == MatrixT.Matrix_MinorRemove([0.0 1 2; 1 2 3; 2 3 4], [1], [1])
        @test [4.0 ;;] == MatrixT.Matrix_MinorRemove([0.0 1 2; 1 2 3; 2 3 4], [1,2], [1,2])
    end
end