
@testset verbose=true "crash_Det" begin
    @testset verbose=true "Det_Std" begin
        @testset "Success" begin
            @test (-7) == Det.Det_Std([1.0 3; 4 5])
            @test 22 == Det.Det_Std([5.0 0 (-3); 2 1 (-1); 3 2 3])
        end
    
        @testset "Not square" begin
            @test_throws DimensionMismatch Det.Det_Std(zeros(2, 3))
        end

        @testset "Empty" begin
            @test 0 == Det.Det_Std(zeros(0, 0))
        end

        @testset "1 x 1" begin
            @test 0 == Det.Det_Std(zeros(1, 1))
            @test 2 == Det.Det_Std([2.0 ;;])
        end
    end
end