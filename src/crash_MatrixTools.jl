module crash_MatrixTools

    include("crash_Matrix.jl")
    const MatrixT = crash_Matrix
    export MatrixT

    include("crash_Pivot.jl")
    const Pivot = crash_Pivot
    export Pivot

    include("crash_ElementaryOperations.jl")
    const ElementaryOperations = crash_ElementaryOperations
    const EO = crash_ElementaryOperations
    export ElementaryOperations, EO

    include("crash_GaussStepping.jl")
    const GaussStepping = crash_GaussStepping
    export GaussStepping

    include("crash_Rank.jl")
    const Rank = crash_Rank
    export Rank

    include("crash_Det.jl")
    const Det = crash_Det
    export Det

end # module crash_MatrixTools
