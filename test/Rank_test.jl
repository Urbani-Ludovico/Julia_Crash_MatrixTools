
@testset verbose=true "crash_Rank" begin
    @testset verbose=true "Rank_CalcMethod_Echelon" begin
        @testset "Success" begin
            @test 2 == Rank.Rank_CalcMethod_Echelon([0.0 1 2; 1 2 1; 2 7 8])
        end
    
        @testset "Empty" begin
            @test 0 == Rank.Rank_CalcMethod_Echelon(zeros(2, 3))
            @test 0 == Rank.Rank_CalcMethod_Echelon(zeros(1, 1))
            @test 0 == Rank.Rank_CalcMethod_Echelon(zeros(0, 0))
        end
    end
end