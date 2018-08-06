; ModuleID = 'new-func'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.dim3 = type { i32, i32, i32 }

@blockIdx = external global %struct.dim3
@blockDim = external global %struct.dim3
@threadIdx = external global %struct.dim3

define void @_Z13_copy_low_uppPfii(float* %A, i32 %rows, i32 %stride) nounwind uwtable noinline {
  %1 = alloca float*, align 8
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  %index_1 = alloca i32, align 4
  %index_2 = alloca i32, align 4
  store float* %A, float** %1, align 8
  call void @llvm.dbg.declare(metadata !{float** %1}, metadata !24), !dbg !25
  store i32 %rows, i32* %2, align 4
  call void @llvm.dbg.declare(metadata !{i32* %2}, metadata !26), !dbg !25
  store i32 %stride, i32* %3, align 4
  call void @llvm.dbg.declare(metadata !{i32* %3}, metadata !27), !dbg !25
  call void @llvm.dbg.declare(metadata !{i32* %i}, metadata !28), !dbg !30
  %4 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 0), align 4, !dbg !30
  %5 = load i32* getelementptr inbounds (%struct.dim3* @blockDim, i32 0, i32 0), align 4, !dbg !30
  %6 = mul i32 %4, %5, !dbg !30
  %7 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !30
  %8 = add i32 %6, %7, !dbg !30
  store i32 %8, i32* %i, align 4, !dbg !30
  call void @llvm.dbg.declare(metadata !{i32* %j}, metadata !31), !dbg !32
  %9 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 1), align 4, !dbg !32
  %10 = load i32* getelementptr inbounds (%struct.dim3* @blockDim, i32 0, i32 1), align 4, !dbg !32
  %11 = mul i32 %9, %10, !dbg !32
  %12 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 1), align 4, !dbg !32
  %13 = add i32 %11, %12, !dbg !32
  store i32 %13, i32* %j, align 4, !dbg !32
  %14 = load i32* %i, align 4, !dbg !33
  %15 = load i32* %j, align 4, !dbg !33
  %16 = icmp sle i32 %14, %15, !dbg !33
  br i1 %16, label %21, label %17, !dbg !33

; <label>:17                                      ; preds = %0
  %18 = load i32* %i, align 4, !dbg !33
  %19 = load i32* %2, align 4, !dbg !33
  %20 = icmp sge i32 %18, %19, !dbg !33
  br i1 %20, label %21, label %22, !dbg !33

; <label>:21                                      ; preds = %17, %0
  br label %42, !dbg !34

; <label>:22                                      ; preds = %17
  call void @llvm.dbg.declare(metadata !{i32* %index_1}, metadata !35), !dbg !36
  %23 = load i32* %i, align 4, !dbg !36
  %24 = load i32* %3, align 4, !dbg !36
  %25 = mul nsw i32 %23, %24, !dbg !36
  %26 = load i32* %j, align 4, !dbg !36
  %27 = add nsw i32 %25, %26, !dbg !36
  store i32 %27, i32* %index_1, align 4, !dbg !36
  call void @llvm.dbg.declare(metadata !{i32* %index_2}, metadata !37), !dbg !38
  %28 = load i32* %j, align 4, !dbg !38
  %29 = load i32* %3, align 4, !dbg !38
  %30 = mul nsw i32 %28, %29, !dbg !38
  %31 = load i32* %i, align 4, !dbg !38
  %32 = add nsw i32 %30, %31, !dbg !38
  store i32 %32, i32* %index_2, align 4, !dbg !38
  %33 = load i32* %index_1, align 4, !dbg !39
  %34 = sext i32 %33 to i64, !dbg !39
  %35 = load float** %1, align 8, !dbg !39
  %36 = getelementptr inbounds float* %35, i64 %34, !dbg !39
  %37 = load float* %36, align 4, !dbg !39
  %38 = load i32* %index_2, align 4, !dbg !39
  %39 = sext i32 %38 to i64, !dbg !39
  %40 = load float** %1, align 8, !dbg !39
  %41 = getelementptr inbounds float* %40, i64 %39, !dbg !39
  store float %37, float* %41, align 4, !dbg !39
  br label %42, !dbg !40

; <label>:42                                      ; preds = %22, %21
  ret void, !dbg !40
}

declare void @llvm.dbg.declare(metadata, metadata) nounwind readnone

define void @_Z13_copy_upp_lowPfii(float* %A, i32 %rows, i32 %stride) nounwind uwtable noinline {
  %1 = alloca float*, align 8
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  %index_1 = alloca i32, align 4
  %index_2 = alloca i32, align 4
  store float* %A, float** %1, align 8
  call void @llvm.dbg.declare(metadata !{float** %1}, metadata !41), !dbg !42
  store i32 %rows, i32* %2, align 4
  call void @llvm.dbg.declare(metadata !{i32* %2}, metadata !43), !dbg !42
  store i32 %stride, i32* %3, align 4
  call void @llvm.dbg.declare(metadata !{i32* %3}, metadata !44), !dbg !42
  call void @llvm.dbg.declare(metadata !{i32* %i}, metadata !45), !dbg !47
  %4 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 0), align 4, !dbg !47
  %5 = load i32* getelementptr inbounds (%struct.dim3* @blockDim, i32 0, i32 0), align 4, !dbg !47
  %6 = mul i32 %4, %5, !dbg !47
  %7 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !47
  %8 = add i32 %6, %7, !dbg !47
  store i32 %8, i32* %i, align 4, !dbg !47
  call void @llvm.dbg.declare(metadata !{i32* %j}, metadata !48), !dbg !49
  %9 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 1), align 4, !dbg !49
  %10 = load i32* getelementptr inbounds (%struct.dim3* @blockDim, i32 0, i32 1), align 4, !dbg !49
  %11 = mul i32 %9, %10, !dbg !49
  %12 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 1), align 4, !dbg !49
  %13 = add i32 %11, %12, !dbg !49
  store i32 %13, i32* %j, align 4, !dbg !49
  %14 = load i32* %j, align 4, !dbg !50
  %15 = load i32* %i, align 4, !dbg !50
  %16 = icmp sle i32 %14, %15, !dbg !50
  br i1 %16, label %21, label %17, !dbg !50

; <label>:17                                      ; preds = %0
  %18 = load i32* %j, align 4, !dbg !50
  %19 = load i32* %2, align 4, !dbg !50
  %20 = icmp sge i32 %18, %19, !dbg !50
  br i1 %20, label %21, label %22, !dbg !50

; <label>:21                                      ; preds = %17, %0
  br label %42, !dbg !51

; <label>:22                                      ; preds = %17
  call void @llvm.dbg.declare(metadata !{i32* %index_1}, metadata !52), !dbg !53
  %23 = load i32* %i, align 4, !dbg !53
  %24 = load i32* %3, align 4, !dbg !53
  %25 = mul nsw i32 %23, %24, !dbg !53
  %26 = load i32* %j, align 4, !dbg !53
  %27 = add nsw i32 %25, %26, !dbg !53
  store i32 %27, i32* %index_1, align 4, !dbg !53
  call void @llvm.dbg.declare(metadata !{i32* %index_2}, metadata !54), !dbg !55
  %28 = load i32* %j, align 4, !dbg !55
  %29 = load i32* %3, align 4, !dbg !55
  %30 = mul nsw i32 %28, %29, !dbg !55
  %31 = load i32* %i, align 4, !dbg !55
  %32 = add nsw i32 %30, %31, !dbg !55
  store i32 %32, i32* %index_2, align 4, !dbg !55
  %33 = load i32* %index_1, align 4, !dbg !56
  %34 = sext i32 %33 to i64, !dbg !56
  %35 = load float** %1, align 8, !dbg !56
  %36 = getelementptr inbounds float* %35, i64 %34, !dbg !56
  %37 = load float* %36, align 4, !dbg !56
  %38 = load i32* %index_2, align 4, !dbg !56
  %39 = sext i32 %38 to i64, !dbg !56
  %40 = load float** %1, align 8, !dbg !56
  %41 = getelementptr inbounds float* %40, i64 %39, !dbg !56
  store float %37, float* %41, align 4, !dbg !56
  br label %42, !dbg !57

; <label>:42                                      ; preds = %22, %21
  ret void, !dbg !57
}

define void @_Z17_add_diag_vec_matfPfiiiPKfS1_iif(float %alpha, float* %mat, i32 %stride, i32 %rows, i32 %cols, float* %vec, float* %mat2, i32 %mat2_row_stride, i32 %mat2_col_stride, float %beta) nounwind uwtable noinline {
  %1 = alloca float, align 4
  %2 = alloca float*, align 8
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca float*, align 8
  %7 = alloca float*, align 8
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca float, align 4
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  %index = alloca i32, align 4
  %index2 = alloca i32, align 4
  store float %alpha, float* %1, align 4
  call void @llvm.dbg.declare(metadata !{float* %1}, metadata !58), !dbg !59
  store float* %mat, float** %2, align 8
  call void @llvm.dbg.declare(metadata !{float** %2}, metadata !60), !dbg !59
  store i32 %stride, i32* %3, align 4
  call void @llvm.dbg.declare(metadata !{i32* %3}, metadata !61), !dbg !59
  store i32 %rows, i32* %4, align 4
  call void @llvm.dbg.declare(metadata !{i32* %4}, metadata !62), !dbg !59
  store i32 %cols, i32* %5, align 4
  call void @llvm.dbg.declare(metadata !{i32* %5}, metadata !63), !dbg !59
  store float* %vec, float** %6, align 8
  call void @llvm.dbg.declare(metadata !{float** %6}, metadata !64), !dbg !65
  store float* %mat2, float** %7, align 8
  call void @llvm.dbg.declare(metadata !{float** %7}, metadata !66), !dbg !65
  store i32 %mat2_row_stride, i32* %8, align 4
  call void @llvm.dbg.declare(metadata !{i32* %8}, metadata !67), !dbg !68
  store i32 %mat2_col_stride, i32* %9, align 4
  call void @llvm.dbg.declare(metadata !{i32* %9}, metadata !69), !dbg !68
  store float %beta, float* %10, align 4
  call void @llvm.dbg.declare(metadata !{float* %10}, metadata !70), !dbg !71
  call void @llvm.dbg.declare(metadata !{i32* %i}, metadata !72), !dbg !74
  %11 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 0), align 4, !dbg !74
  %12 = load i32* getelementptr inbounds (%struct.dim3* @blockDim, i32 0, i32 0), align 4, !dbg !74
  %13 = mul i32 %11, %12, !dbg !74
  %14 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !74
  %15 = add i32 %13, %14, !dbg !74
  store i32 %15, i32* %i, align 4, !dbg !74
  call void @llvm.dbg.declare(metadata !{i32* %j}, metadata !75), !dbg !76
  %16 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 1), align 4, !dbg !76
  %17 = load i32* getelementptr inbounds (%struct.dim3* @blockDim, i32 0, i32 1), align 4, !dbg !76
  %18 = mul i32 %16, %17, !dbg !76
  %19 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 1), align 4, !dbg !76
  %20 = add i32 %18, %19, !dbg !76
  store i32 %20, i32* %j, align 4, !dbg !76
  call void @llvm.dbg.declare(metadata !{i32* %index}, metadata !77), !dbg !78
  %21 = load i32* %j, align 4, !dbg !79
  %22 = load i32* %3, align 4, !dbg !79
  %23 = mul nsw i32 %21, %22, !dbg !79
  %24 = load i32* %i, align 4, !dbg !79
  %25 = add nsw i32 %23, %24, !dbg !79
  store i32 %25, i32* %index, align 4, !dbg !79
  call void @llvm.dbg.declare(metadata !{i32* %index2}, metadata !80), !dbg !78
  %26 = load i32* %j, align 4, !dbg !79
  %27 = load i32* %8, align 4, !dbg !79
  %28 = mul nsw i32 %26, %27, !dbg !79
  %29 = load i32* %i, align 4, !dbg !79
  %30 = load i32* %9, align 4, !dbg !79
  %31 = mul nsw i32 %29, %30, !dbg !79
  %32 = add nsw i32 %28, %31, !dbg !79
  store i32 %32, i32* %index2, align 4, !dbg !79
  %33 = load i32* %i, align 4, !dbg !81
  %34 = load i32* %5, align 4, !dbg !81
  %35 = icmp slt i32 %33, %34, !dbg !81
  br i1 %35, label %36, label %66, !dbg !81

; <label>:36                                      ; preds = %0
  %37 = load i32* %j, align 4, !dbg !81
  %38 = load i32* %4, align 4, !dbg !81
  %39 = icmp slt i32 %37, %38, !dbg !81
  br i1 %39, label %40, label %66, !dbg !81

; <label>:40                                      ; preds = %36
  %41 = load float* %1, align 4, !dbg !82
  %42 = load i32* %j, align 4, !dbg !82
  %43 = sext i32 %42 to i64, !dbg !82
  %44 = load float** %6, align 8, !dbg !82
  %45 = getelementptr inbounds float* %44, i64 %43, !dbg !82
  %46 = load float* %45, align 4, !dbg !82
  %47 = fmul float %41, %46, !dbg !82
  %48 = load i32* %index2, align 4, !dbg !82
  %49 = sext i32 %48 to i64, !dbg !82
  %50 = load float** %7, align 8, !dbg !82
  %51 = getelementptr inbounds float* %50, i64 %49, !dbg !82
  %52 = load float* %51, align 4, !dbg !82
  %53 = fmul float %47, %52, !dbg !82
  %54 = load float* %10, align 4, !dbg !82
  %55 = load i32* %index, align 4, !dbg !82
  %56 = sext i32 %55 to i64, !dbg !82
  %57 = load float** %2, align 8, !dbg !82
  %58 = getelementptr inbounds float* %57, i64 %56, !dbg !82
  %59 = load float* %58, align 4, !dbg !82
  %60 = fmul float %54, %59, !dbg !82
  %61 = fadd float %53, %60, !dbg !82
  %62 = load i32* %index, align 4, !dbg !82
  %63 = sext i32 %62 to i64, !dbg !82
  %64 = load float** %2, align 8, !dbg !82
  %65 = getelementptr inbounds float* %64, i64 %63, !dbg !82
  store float %61, float* %65, align 4, !dbg !82
  br label %66, !dbg !84

; <label>:66                                      ; preds = %40, %36, %0
  ret void, !dbg !85
}

define void @_Z13_copy_from_tpPfPKfiii(float* %A, float* %B, i32 %dmat_cols, i32 %dmat_rows, i32 %dmat_stride) nounwind uwtable noinline {
  %1 = alloca float*, align 8
  %2 = alloca float*, align 8
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  %index_B = alloca i32, align 4
  %index_A = alloca i32, align 4
  store float* %A, float** %1, align 8
  call void @llvm.dbg.declare(metadata !{float** %1}, metadata !86), !dbg !87
  store float* %B, float** %2, align 8
  call void @llvm.dbg.declare(metadata !{float** %2}, metadata !88), !dbg !87
  store i32 %dmat_cols, i32* %3, align 4
  call void @llvm.dbg.declare(metadata !{i32* %3}, metadata !89), !dbg !87
  store i32 %dmat_rows, i32* %4, align 4
  call void @llvm.dbg.declare(metadata !{i32* %4}, metadata !90), !dbg !87
  store i32 %dmat_stride, i32* %5, align 4
  call void @llvm.dbg.declare(metadata !{i32* %5}, metadata !91), !dbg !87
  call void @llvm.dbg.declare(metadata !{i32* %i}, metadata !92), !dbg !94
  %6 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 0), align 4, !dbg !94
  %7 = load i32* getelementptr inbounds (%struct.dim3* @blockDim, i32 0, i32 0), align 4, !dbg !94
  %8 = mul i32 %6, %7, !dbg !94
  %9 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !94
  %10 = add i32 %8, %9, !dbg !94
  store i32 %10, i32* %i, align 4, !dbg !94
  call void @llvm.dbg.declare(metadata !{i32* %j}, metadata !95), !dbg !96
  %11 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 1), align 4, !dbg !96
  %12 = load i32* getelementptr inbounds (%struct.dim3* @blockDim, i32 0, i32 1), align 4, !dbg !96
  %13 = mul i32 %11, %12, !dbg !96
  %14 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 1), align 4, !dbg !96
  %15 = add i32 %13, %14, !dbg !96
  store i32 %15, i32* %j, align 4, !dbg !96
  %16 = load i32* %i, align 4, !dbg !97
  %17 = load i32* %3, align 4, !dbg !97
  %18 = icmp slt i32 %16, %17, !dbg !97
  br i1 %18, label %19, label %55, !dbg !97

; <label>:19                                      ; preds = %0
  %20 = load i32* %j, align 4, !dbg !97
  %21 = load i32* %4, align 4, !dbg !97
  %22 = icmp slt i32 %20, %21, !dbg !97
  br i1 %22, label %23, label %55, !dbg !97

; <label>:23                                      ; preds = %19
  call void @llvm.dbg.declare(metadata !{i32* %index_B}, metadata !98), !dbg !100
  %24 = load i32* %j, align 4, !dbg !100
  %25 = load i32* %j, align 4, !dbg !100
  %26 = add nsw i32 %25, 1, !dbg !100
  %27 = mul nsw i32 %24, %26, !dbg !100
  %28 = sdiv i32 %27, 2, !dbg !100
  %29 = load i32* %i, align 4, !dbg !100
  %30 = add nsw i32 %28, %29, !dbg !100
  store i32 %30, i32* %index_B, align 4, !dbg !100
  call void @llvm.dbg.declare(metadata !{i32* %index_A}, metadata !101), !dbg !102
  %31 = load i32* %j, align 4, !dbg !102
  %32 = load i32* %5, align 4, !dbg !102
  %33 = mul nsw i32 %31, %32, !dbg !102
  %34 = load i32* %i, align 4, !dbg !102
  %35 = add nsw i32 %33, %34, !dbg !102
  store i32 %35, i32* %index_A, align 4, !dbg !102
  %36 = load i32* %i, align 4, !dbg !103
  %37 = load i32* %j, align 4, !dbg !103
  %38 = icmp sle i32 %36, %37, !dbg !103
  br i1 %38, label %39, label %49, !dbg !103

; <label>:39                                      ; preds = %23
  %40 = load i32* %index_B, align 4, !dbg !104
  %41 = sext i32 %40 to i64, !dbg !104
  %42 = load float** %2, align 8, !dbg !104
  %43 = getelementptr inbounds float* %42, i64 %41, !dbg !104
  %44 = load float* %43, align 4, !dbg !104
  %45 = load i32* %index_A, align 4, !dbg !104
  %46 = sext i32 %45 to i64, !dbg !104
  %47 = load float** %1, align 8, !dbg !104
  %48 = getelementptr inbounds float* %47, i64 %46, !dbg !104
  store float %44, float* %48, align 4, !dbg !104
  br label %54, !dbg !106

; <label>:49                                      ; preds = %23
  %50 = load i32* %index_A, align 4, !dbg !107
  %51 = sext i32 %50 to i64, !dbg !107
  %52 = load float** %1, align 8, !dbg !107
  %53 = getelementptr inbounds float* %52, i64 %51, !dbg !107
  store float 0.000000e+00, float* %53, align 4, !dbg !107
  br label %54

; <label>:54                                      ; preds = %49, %39
  br label %55, !dbg !109

; <label>:55                                      ; preds = %54, %19, %0
  ret void, !dbg !110
}

define void @_Z14_copy_from_matPfPKfiiii(float* %mat_out, float* %mat_in, i32 %d_out_stride, i32 %d_out_rows, i32 %d_out_cols, i32 %d_in_stride) nounwind uwtable noinline {
  %1 = alloca float*, align 8
  %2 = alloca float*, align 8
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  %index_out = alloca i32, align 4
  %index_in = alloca i32, align 4
  store float* %mat_out, float** %1, align 8
  call void @llvm.dbg.declare(metadata !{float** %1}, metadata !111), !dbg !112
  store float* %mat_in, float** %2, align 8
  call void @llvm.dbg.declare(metadata !{float** %2}, metadata !113), !dbg !112
  store i32 %d_out_stride, i32* %3, align 4
  call void @llvm.dbg.declare(metadata !{i32* %3}, metadata !114), !dbg !115
  store i32 %d_out_rows, i32* %4, align 4
  call void @llvm.dbg.declare(metadata !{i32* %4}, metadata !116), !dbg !115
  store i32 %d_out_cols, i32* %5, align 4
  call void @llvm.dbg.declare(metadata !{i32* %5}, metadata !117), !dbg !115
  store i32 %d_in_stride, i32* %6, align 4
  call void @llvm.dbg.declare(metadata !{i32* %6}, metadata !118), !dbg !115
  call void @llvm.dbg.declare(metadata !{i32* %i}, metadata !119), !dbg !121
  %7 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 0), align 4, !dbg !121
  %8 = load i32* getelementptr inbounds (%struct.dim3* @blockDim, i32 0, i32 0), align 4, !dbg !121
  %9 = mul i32 %7, %8, !dbg !121
  %10 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !121
  %11 = add i32 %9, %10, !dbg !121
  store i32 %11, i32* %i, align 4, !dbg !121
  call void @llvm.dbg.declare(metadata !{i32* %j}, metadata !122), !dbg !123
  %12 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 1), align 4, !dbg !123
  %13 = load i32* getelementptr inbounds (%struct.dim3* @blockDim, i32 0, i32 1), align 4, !dbg !123
  %14 = mul i32 %12, %13, !dbg !123
  %15 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 1), align 4, !dbg !123
  %16 = add i32 %14, %15, !dbg !123
  store i32 %16, i32* %j, align 4, !dbg !123
  call void @llvm.dbg.declare(metadata !{i32* %index_out}, metadata !124), !dbg !125
  %17 = load i32* %i, align 4, !dbg !125
  %18 = load i32* %j, align 4, !dbg !125
  %19 = load i32* %3, align 4, !dbg !125
  %20 = mul nsw i32 %18, %19, !dbg !125
  %21 = add nsw i32 %17, %20, !dbg !125
  store i32 %21, i32* %index_out, align 4, !dbg !125
  call void @llvm.dbg.declare(metadata !{i32* %index_in}, metadata !126), !dbg !127
  %22 = load i32* %i, align 4, !dbg !127
  %23 = load i32* %j, align 4, !dbg !127
  %24 = load i32* %6, align 4, !dbg !127
  %25 = mul nsw i32 %23, %24, !dbg !127
  %26 = add nsw i32 %22, %25, !dbg !127
  store i32 %26, i32* %index_in, align 4, !dbg !127
  %27 = load i32* %i, align 4, !dbg !128
  %28 = load i32* %5, align 4, !dbg !128
  %29 = icmp slt i32 %27, %28, !dbg !128
  br i1 %29, label %30, label %44, !dbg !128

; <label>:30                                      ; preds = %0
  %31 = load i32* %j, align 4, !dbg !128
  %32 = load i32* %4, align 4, !dbg !128
  %33 = icmp slt i32 %31, %32, !dbg !128
  br i1 %33, label %34, label %44, !dbg !128

; <label>:34                                      ; preds = %30
  %35 = load i32* %index_in, align 4, !dbg !129
  %36 = sext i32 %35 to i64, !dbg !129
  %37 = load float** %2, align 8, !dbg !129
  %38 = getelementptr inbounds float* %37, i64 %36, !dbg !129
  %39 = load float* %38, align 4, !dbg !129
  %40 = load i32* %index_out, align 4, !dbg !129
  %41 = sext i32 %40 to i64, !dbg !129
  %42 = load float** %1, align 8, !dbg !129
  %43 = getelementptr inbounds float* %42, i64 %41, !dbg !129
  store float %39, float* %43, align 4, !dbg !129
  br label %44, !dbg !129

; <label>:44                                      ; preds = %34, %30, %0
  ret void, !dbg !130
}

!llvm.dbg.cu = !{!0}

!0 = metadata !{i32 786449, i32 0, i32 4, metadata !"new-func.cpp", metadata !"/home/mingyuanwu/kaldi-new-bug", metadata !"clang version 3.2 (tags/RELEASE_32/final)", i1 true, i1 false, metadata !"", i32 0, metadata !1, metadata !1, metadata !3, metadata !1} ; [ DW_TAG_compile_unit ] [/home/mingyuanwu/kaldi-new-bug/new-func.cpp] [DW_LANG_C_plus_plus]
!1 = metadata !{metadata !2}
!2 = metadata !{i32 0}
!3 = metadata !{metadata !4}
!4 = metadata !{metadata !5, metadata !12, metadata !13, metadata !18, metadata !21}
!5 = metadata !{i32 786478, i32 0, metadata !6, metadata !"_copy_low_upp", metadata !"_copy_low_upp", metadata !"_Z13_copy_low_uppPfii", metadata !6, i32 2, metadata !7, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, void (float*, i32, i32)* @_Z13_copy_low_uppPfii, null, null, metadata !1, i32 2} ; [ DW_TAG_subprogram ] [line 2] [def] [_copy_low_upp]
!6 = metadata !{i32 786473, metadata !"new-func.cpp", metadata !"/home/mingyuanwu/kaldi-new-bug", null} ; [ DW_TAG_file_type ]
!7 = metadata !{i32 786453, i32 0, metadata !"", i32 0, i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !8, i32 0, i32 0} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!8 = metadata !{null, metadata !9, metadata !11, metadata !11}
!9 = metadata !{i32 786447, null, metadata !"", null, i32 0, i64 64, i64 64, i64 0, i32 0, metadata !10} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from float]
!10 = metadata !{i32 786468, null, metadata !"float", null, i32 0, i64 32, i64 32, i64 0, i32 0, i32 4} ; [ DW_TAG_base_type ] [float] [line 0, size 32, align 32, offset 0, enc DW_ATE_float]
!11 = metadata !{i32 786468, null, metadata !"int", null, i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!12 = metadata !{i32 786478, i32 0, metadata !6, metadata !"_copy_upp_low", metadata !"_copy_upp_low", metadata !"_Z13_copy_upp_lowPfii", metadata !6, i32 19, metadata !7, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, void (float*, i32, i32)* @_Z13_copy_upp_lowPfii, null, null, metadata !1, i32 19} ; [ DW_TAG_subprogram ] [line 19] [def] [_copy_upp_low]
!13 = metadata !{i32 786478, i32 0, metadata !6, metadata !"_add_diag_vec_mat", metadata !"_add_diag_vec_mat", metadata !"_Z17_add_diag_vec_matfPfiiiPKfS1_iif", metadata !6, i32 31, metadata !14, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, void (float, float*, i32, i32, i32, float*, float*, i32, i32, float)* @_Z17_add_diag_vec_matfPfiiiPKfS1_iif, null, null, metadata !1, i32 34} ; [ DW_TAG_subprogram ] [line 31] [def] [scope 34] [_add_diag_vec_mat]
!14 = metadata !{i32 786453, i32 0, metadata !"", i32 0, i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !15, i32 0, i32 0} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!15 = metadata !{null, metadata !10, metadata !9, metadata !11, metadata !11, metadata !11, metadata !16, metadata !16, metadata !11, metadata !11, metadata !10}
!16 = metadata !{i32 786447, null, metadata !"", null, i32 0, i64 64, i64 64, i64 0, i32 0, metadata !17} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from ]
!17 = metadata !{i32 786470, null, metadata !"", null, i32 0, i64 0, i64 0, i64 0, i32 0, metadata !10} ; [ DW_TAG_const_type ] [line 0, size 0, align 0, offset 0] [from float]
!18 = metadata !{i32 786478, i32 0, metadata !6, metadata !"_copy_from_tp", metadata !"_copy_from_tp", metadata !"_Z13_copy_from_tpPfPKfiii", metadata !6, i32 47, metadata !19, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, void (float*, float*, i32, i32, i32)* @_Z13_copy_from_tpPfPKfiii, null, null, metadata !1, i32 47} ; [ DW_TAG_subprogram ] [line 47] [def] [_copy_from_tp]
!19 = metadata !{i32 786453, i32 0, metadata !"", i32 0, i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !20, i32 0, i32 0} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!20 = metadata !{null, metadata !9, metadata !16, metadata !11, metadata !11, metadata !11}
!21 = metadata !{i32 786478, i32 0, metadata !6, metadata !"_copy_from_mat", metadata !"_copy_from_mat", metadata !"_Z14_copy_from_matPfPKfiiii", metadata !6, i32 63, metadata !22, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, void (float*, float*, i32, i32, i32, i32)* @_Z14_copy_from_matPfPKfiiii, null, null, metadata !1, i32 64} ; [ DW_TAG_subprogram ] [line 63] [def] [scope 64] [_copy_from_mat]
!22 = metadata !{i32 786453, i32 0, metadata !"", i32 0, i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !23, i32 0, i32 0} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!23 = metadata !{null, metadata !9, metadata !16, metadata !11, metadata !11, metadata !11, metadata !11}
!24 = metadata !{i32 786689, metadata !5, metadata !"A", metadata !6, i32 16777218, metadata !9, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [A] [line 2]
!25 = metadata !{i32 2, i32 0, metadata !5, null}
!26 = metadata !{i32 786689, metadata !5, metadata !"rows", metadata !6, i32 33554434, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [rows] [line 2]
!27 = metadata !{i32 786689, metadata !5, metadata !"stride", metadata !6, i32 50331650, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [stride] [line 2]
!28 = metadata !{i32 786688, metadata !29, metadata !"i", metadata !6, i32 3, metadata !11, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [i] [line 3]
!29 = metadata !{i32 786443, metadata !5, i32 2, i32 0, metadata !6, i32 0} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/kaldi-new-bug/new-func.cpp]
!30 = metadata !{i32 3, i32 0, metadata !29, null}
!31 = metadata !{i32 786688, metadata !29, metadata !"j", metadata !6, i32 4, metadata !11, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [j] [line 4]
!32 = metadata !{i32 4, i32 0, metadata !29, null}
!33 = metadata !{i32 5, i32 0, metadata !29, null}
!34 = metadata !{i32 6, i32 0, metadata !29, null}
!35 = metadata !{i32 786688, metadata !29, metadata !"index_1", metadata !6, i32 7, metadata !11, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [index_1] [line 7]
!36 = metadata !{i32 7, i32 0, metadata !29, null}
!37 = metadata !{i32 786688, metadata !29, metadata !"index_2", metadata !6, i32 8, metadata !11, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [index_2] [line 8]
!38 = metadata !{i32 8, i32 0, metadata !29, null}
!39 = metadata !{i32 9, i32 0, metadata !29, null}
!40 = metadata !{i32 10, i32 0, metadata !29, null}
!41 = metadata !{i32 786689, metadata !12, metadata !"A", metadata !6, i32 16777235, metadata !9, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [A] [line 19]
!42 = metadata !{i32 19, i32 0, metadata !12, null}
!43 = metadata !{i32 786689, metadata !12, metadata !"rows", metadata !6, i32 33554451, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [rows] [line 19]
!44 = metadata !{i32 786689, metadata !12, metadata !"stride", metadata !6, i32 50331667, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [stride] [line 19]
!45 = metadata !{i32 786688, metadata !46, metadata !"i", metadata !6, i32 20, metadata !11, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [i] [line 20]
!46 = metadata !{i32 786443, metadata !12, i32 19, i32 0, metadata !6, i32 1} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/kaldi-new-bug/new-func.cpp]
!47 = metadata !{i32 20, i32 0, metadata !46, null}
!48 = metadata !{i32 786688, metadata !46, metadata !"j", metadata !6, i32 21, metadata !11, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [j] [line 21]
!49 = metadata !{i32 21, i32 0, metadata !46, null}
!50 = metadata !{i32 22, i32 0, metadata !46, null}
!51 = metadata !{i32 23, i32 0, metadata !46, null}
!52 = metadata !{i32 786688, metadata !46, metadata !"index_1", metadata !6, i32 24, metadata !11, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [index_1] [line 24]
!53 = metadata !{i32 24, i32 0, metadata !46, null}
!54 = metadata !{i32 786688, metadata !46, metadata !"index_2", metadata !6, i32 25, metadata !11, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [index_2] [line 25]
!55 = metadata !{i32 25, i32 0, metadata !46, null}
!56 = metadata !{i32 26, i32 0, metadata !46, null}
!57 = metadata !{i32 27, i32 0, metadata !46, null}
!58 = metadata !{i32 786689, metadata !13, metadata !"alpha", metadata !6, i32 16777247, metadata !10, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [alpha] [line 31]
!59 = metadata !{i32 31, i32 0, metadata !13, null}
!60 = metadata !{i32 786689, metadata !13, metadata !"mat", metadata !6, i32 33554463, metadata !9, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [mat] [line 31]
!61 = metadata !{i32 786689, metadata !13, metadata !"stride", metadata !6, i32 50331679, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [stride] [line 31]
!62 = metadata !{i32 786689, metadata !13, metadata !"rows", metadata !6, i32 67108895, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [rows] [line 31]
!63 = metadata !{i32 786689, metadata !13, metadata !"cols", metadata !6, i32 83886111, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [cols] [line 31]
!64 = metadata !{i32 786689, metadata !13, metadata !"vec", metadata !6, i32 100663328, metadata !16, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [vec] [line 32]
!65 = metadata !{i32 32, i32 0, metadata !13, null}
!66 = metadata !{i32 786689, metadata !13, metadata !"mat2", metadata !6, i32 117440544, metadata !16, i3