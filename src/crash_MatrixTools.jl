module crash_MatrixTools

function Pivot_GetRowIndex(V::Vector{Float64})::Int64
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
        p = Pivot_GetRowIndex(vec(M[[r], :]))
        if MinPivot < 0 || p < MinPivot
            MinPivot = p
            MinPivot_Row = r
        end
    end

    return MinPivot_Row
end

end # module crash_MatrixTools
