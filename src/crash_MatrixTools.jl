module crash_MatrixTools

    include("crash_Matrix.jl")
    const Matrix = crash_Matrix
    export Matrix

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


end # module crash_MatrixTools
