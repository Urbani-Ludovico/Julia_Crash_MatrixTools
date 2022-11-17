module crash_MatrixTools

include("crash_Matrix.jl")
export Matrix_IsNull, Matrix_SwapRows, Matrix_RemoveRows, Matrix_ClearEmptyRow, Matrix_IsInStair

include("crash_Pivot.jl")
export Pivot_GetIndexRow, Pivot_GetRowIndex_MinPivot_First

include("crash_ElementaryOperations.jl")
export Matrix_EO1, Matrix_EO2, Matrix_EO3, ElementaryOperations_SwapRows, ElementaryOperations_RowProductConst


end # module crash_MatrixTools
