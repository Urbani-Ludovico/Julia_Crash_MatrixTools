module crash_Det

    include("crash_Matrix.jl")

    function Det_Std(M::Matrix{Float64})::Float64
        if size(M, 1) != size(M, 2)
            throw(DimensionMismatch("Matrix must be square matrix"))
        end

        if size(M, 1) == 0
            return 0;
        elseif size(M, 1) == 1
            return M[1]
        else
            s::Float64 = 0
            for j in 1:size(M,1)
                s += ((-1)^(1+j)) * M[1, j] * Det_Std(crash_Matrix.Matrix_MinorRemove(M, [1], [j]))
            end
            return s
        end
    end

end # moduel crash_Det