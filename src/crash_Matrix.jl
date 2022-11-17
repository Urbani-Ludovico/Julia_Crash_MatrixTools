# module crash_Matrix

export Matrix_IsNull, Matrix_SwapRows, Matrix_RemoveRows, Matrix_ClearEmptyRow

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

# end # crash_Matrix