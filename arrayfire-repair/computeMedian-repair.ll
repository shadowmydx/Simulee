define void @_Z13computeMedianj(i32 %iterations) uwtable noinline {%1 = alloca i32, align 4
%tid = alloca i32, align 4
%bid = alloca i32, align 4
%i = alloca i32, align 4
store i32 %iterations, i32* %1, align 4
%2 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !24
store i32 %2, i32* %tid, align 4, !dbg !24
%3 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 0), align 4, !dbg !26
store i32 %3, i32* %bid, align 4, !dbg !26
%4 = load i32* %bid, align 4, !dbg !28
%5 = load i32* getelementptr inbounds (%struct.dim3* @blockDim, i32 0, i32 0), align 4, !dbg !28
%6 = mul i32 %4, %5, !dbg !28
%7 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !28
%8 = add i32 %6, %7, !dbg !28
store i32 %8, i32* %i, align 4, !dbg !28
%9 = load i32* %tid, align 4, !dbg !29
%10 = zext i32 %9 to i64, !dbg !29
%11 = getelementptr inbounds [256 x float]* @_ZZ13computeMedianjE8s_median, i32 0, i64 %10, !dbg !29
store float 2.560000e+02, float* %11, align 4, !dbg !29
%12 = load i32* %tid, align 4, !dbg !30
%13 = zext i32 %12 to i64, !dbg !30
%14 = getelementptr inbounds [256 x i32]* @_ZZ13computeMedianjE5s_idx, i32 0, i64 %13, !dbg !30
store i32 0, i32* %14, align 4, !dbg !30
%15 = load i32* %i, align 4, !dbg !32
%16 = load i32* %1, align 4, !dbg !32
%17 = icmp ult i32 %15, %16, !dbg !32
br i1 %17, label %18, label %26, !dbg !32
; <label>:18                                      ; preds = %0
%19 = load i32* %i, align 4, !dbg !33
%20 = load i32* %tid, align 4, !dbg !33
%21 = zext i32 %20 to i64, !dbg !33
%22 = getelementptr inbounds [256 x i32]* @_ZZ13computeMedianjE5s_idx, i32 0, i64 %21, !dbg !33
store i32 %19, i32* %22, align 4, !dbg !33
%23 = load i32* %tid, align 4, !dbg !35
%24 = zext i32 %23 to i64, !dbg !35
%25 = getelementptr inbounds [256 x float]* @_ZZ13computeMedianjE8s_median, i32 0, i64 %24, !dbg !35
store float 2.000000e+00, float* %25, align 4, !dbg !35
br label %26, !dbg !36
; <label>:26                                      ; preds = %18, %0
ret void, !dbg !37}
