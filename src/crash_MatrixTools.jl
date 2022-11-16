module crash_MatrixTools

export Pivot_GetIndexRow, Pivot_GetRowIndex_MinPivot_First, Matrix_IsNull, Matrix_SwapRows

function Pivot_GetIndexRow(V::Vector{Float64})::Int64
    if size(V, 1) == 0
        throw(DimensionMismatch("Vector size must be greather thank 0!"))
    end

    for (i,v) in enumerate(V)
        if v != 0.0
            return i
        end
    end

    return -1
end

function Pivot_GetRowIndex_MinPivot_First(M::Matrix{Float64})::Int64
    MinPivot::Int64 = -1
    MinPivot_Row::Int64 = -1

    for r in 1:size(M,1)
        p = Pivot_GetIndexRow(vec(M[[r], :]))
        if p != -1 && (MinPivot < 0 || p < MinPivot)
            MinPivot = p
            MinPivot_Row = r
        end
    end

    return MinPivot_Row
end

function Matrix_IsNull(M::Matrix{Float64})::Bool
    for i in eachindex(M) 
        if M[i] != 0
            return false
        end
    end
    return true
end

function Matrix_SwapRows(M::Matrix{Float64}, r1::Int64, r2::Int64)::Matrix{Float64}
    if r1 > size(M, 1) || r2 > size(M, 1)
        throw(DomainError("Row indexes out of range!"))
    end

    if r1 != r2
        for c in 1:size(M, 2)
            M[r1,c], M[r2, c] = M[r2, c], M[r1, c]
        end
    end

    return M
end

end # module crash_MatrixTools
