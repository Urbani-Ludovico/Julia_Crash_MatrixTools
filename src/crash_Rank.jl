module crash_Rank

    include("crash_Matrix.jl")
    include("crash_GaussStepping.jl")

    export Rank_Calc

    Methods::Dict{String, Function} = Dict{String, Function}()

    function Rank_Calc(M::Matrix{Float64}; method::String = "echelon")
        if mathod in keys(Methods)
            return Methods[method](M)
        else
            throw(ArgumentError("Method unknown"))
        end
    end

    function Rank_CalcMethod_Echelon(M::Matrix{Float64})
        if crash_Matrix.Matrix_IsNull(M)
            return 0
        end

        M = crash_Matrix.Matrix_ClearEmptyRow(crash_GaussStepping.Gauss_Stepping(M))

        return size(M, 1)
    end
    Methods["echelon"] = Rank_CalcMethod_Echelon

end # end crash_Rank