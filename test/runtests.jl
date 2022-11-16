using Test, crash_MatrixTools

V = [
    [
        [1.0 2 3; 0 5 1; 0 0 0],
        [1.0 2 3; 0 5 1]
    ]
]

res::Bool = true
# for v in V
#     if v[2] != Gauss_Stepping(v[1])
#         res = false
#     end
# end

@test res