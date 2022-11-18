
module crash_GaussStepping
    include("crash_Matrix.jl")
    include("crash_ElementaryOperations.jl")
    include("crash_Pivot.jl")

    export Gauss_Stepping, Gauss_ReduceTwoRows

    function Gauss_Stepping(M::Matrix{Float64})::Matrix{Float64}
        M = crash_Matrix.Matrix_ClearEmptyRow(M)
        
        if crash_Matrix.Matrix_IsNull(M)
            throw(DimensionMismatch("Vector size must be greather thank 0!"))
        end

        RowStep = 1
        PivotStep = -1
        while !(crash_Matrix.Matrix_IsInStair(M)) && RowStep < size(M, 1)
            M2 = crash_Matrix.Matrix_RemoveRows(M, collect(1:(RowStep-1)))
            P_min = crash_Pivot.Pivot_GetRowIndex_MinPivot_First(M2) + RowStep - 1
            M = crash_ElementaryOperations.ElementaryOperations_SwapRows(M, RowStep, P_min)
            
            PivotStep = Pivot_GetIndexRow(vec(M[[RowStep], :]))

            for i in (RowStep+1):size(M, 1)
                if crash_Pivot.Pivot_GetIndexRow(vec(M[[i], :])) <= PivotStep
                    M = Gauss_ReduceTwoRows(M, RowStep, i)
                end
            end

            M = crash_Matrix.Matrix_ClearEmptyRow(M)
            RowStep += 1
        end

        return M
    end

    function Gauss_ReduceTwoRows(M::Matrix{Float64}, R_cost::Int64, R_var::Int64)::Matrix{Float64}
        if R_cost > size(M, 1) || R_var > size(M, 1)
            throw(DomainError("Row indexes out of range!"))
        end
        if R_cost == R_var
            throw(ArgumentError("Two indexes must different!"))
        end

        R_cost_p = crash_Pivot.Pivot_GetIndexRow(vec(M[R_cost, :]))
        R_var_p = crash_Pivot.Pivot_GetIndexRow(vec(M[R_var, :]))

        if (R_cost_p != R_var_p)
            throw(DomainError("Row of the two indexes must have same pivot!"))
        end
        
        c::Float64 = M[R_var, R_var_p] / M[R_cost, R_cost_p]
        return crash_ElementaryOperations.ElementaryOperations_RowCOther(M, R_cost, R_var, 0-c)
    end
end # end crash_GaussStepping