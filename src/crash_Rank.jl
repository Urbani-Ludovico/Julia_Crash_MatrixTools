module crash_Rank

    include("crash_Matrix.jl")
    include("crash_GaussStepping.jl")

    function Rank_CalcMethod_Echelon(M::Matrix{Float64}) {
        if crash_Matrix.Matrix_IsNull(M)
            return 0
        end

        M = crash_Matrix.Matrix_ClearEmptyRow(crash_GaussStepping.Gauss_Stepping(M))

        return size(M, 1)
    }

end # end crash_Rank