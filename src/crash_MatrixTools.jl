module crash_MatrixTools

include("crash_Matrix.jl")
export Matrix_IsNull, Matrix_SwapRows, Matrix_RemoveRows, Matrix_ClearEmptyRow

include("crash_Pivot.jl")
export Pivot_GetIndexRow, Pivot_GetRowIndex_MinPivot_First


end # module crash_MatrixTools
