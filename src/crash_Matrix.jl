module crash_Matrix

    include("crash_Pivot.jl")

    export Matrix_IsNull, Matrix_RemoveRows, Matrix_ClearEmptyRow, Matrix_IsInStair, Matrix_MinorRemove

    function Matrix_IsNull(M::Matrix{Float64})::Bool
        for i in eachindex(M) 
            if M[i] != 0
                return false
            end
        end
        return true
    end

    function Matrix_RemoveRows(M::Matrix{Float64}, rows::Vector{Int64})::Matrix{Float64}
        return M[[i for i in 1:size(M, 1) if i ∉ rows], :]
    end

    function Matrix_ClearEmptyRow(M::Matrix{Float64})::Matrix{Float64}
        notEmpty = Vector{Int64}()
        for r in 1:size(M,1)
            row = M[[r],:]
            if (count(!=(0), row) != 0)
                append!(notEmpty, r)
            end
        end
        return M[notEmpty, :];
    end

    function Matrix_IsInStair(M::Matrix{Float64})::Bool
        if (Matrix_IsNull(M))
            return false
        end

        PivotCounter = -1
        for r in 1:size(M,1)
            p = crash_Pivot.Pivot_GetIndexRow(vec(M[[r], :]))
            if p < 0
                return false
            elseif p > PivotCounter
                PivotCounter = p
            else
                return false
            end
        end
        return true
    end

    function Matrix_MinorRemove(M::Matrix{Float64}, R::Vector{Int64}, C::Vector{Int64})::Matrix{Float64}
        return M[1:end .∉ [R], 1:end .∉ [C]]
    end

end # end crash_Matrix