
module crash_ElementaryOperations
    export Matrix_EO1, Matrix_EO2, Matrix_EO3, ElementaryOperations_SwapRows, ElementaryOperations_RowProductConst, ElementaryOperations_RowCOther

    function Matrix_EO1(M::Matrix{Float64}, r1::Int64, r2::Int64)::Matrix{Float64}
        if r1 > size(M, 1) || r2 > size(M, 1)
            throw(DomainError("Rows indexes out of range!"))
        end

        if r1 != r2
            for c in 1:size(M, 2)
                M[r1,c], M[r2, c] = M[r2, c], M[r1, c]
            end
        end

        return M
    end

    function Matrix_EO2(M::Matrix{Float64}, r::Int64, c::Float64)::Matrix{Float64}
        if r > size(M, 1)
            throw(DomainError("Row index out of range!"))
        end

        for i in 1:size(M, 2)
            M[r, i] *= c
        end

        return M
    end

    function Matrix_EO3(M::Matrix{Float64}, R_cost::Int64, R_var::Int64, C::Float64)::Matrix{Float64}
        if R_cost > size(M, 1) || R_var > size(M, 1)
            throw(DomainError("Row indexes out of range!"))
        end
        if R_cost == R_var
            throw(ArgumentError("Two indexes must different!"))
        end
        
        for i in 1:size(M,2)
            M[R_var,i] = M[R_var,i] + C * M[R_cost,i]
        end

        return M
    end

    function ElementaryOperations_SwapRows(M::Matrix{Float64}, r1::Int64, r2::Int64)::Matrix{Float64}
        return Matrix_EO1(M, r1, r2)
    end

    function ElementaryOperations_RowProductConst(M::Matrix{Float64}, r::Int64, c::Int64)::Matrix{Float64}
        return Matrix_EO2(M, r, c)
    end

    function ElementaryOperations_RowCOther(M::Matrix{Float64}, R_cost::Int64, R_var::Int64, C::Float64)::Matrix{Float64}
        return Matrix_EO3(M, R_cost, R_var, C)
    end
end # end crash_ElementaryOperations