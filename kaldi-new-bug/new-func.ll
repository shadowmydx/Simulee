; ModuleID = 'new-func'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.dim3 = type { i32, i32, i32 }

@blockIdx = external global %struct.dim3
@blockDim = external global %struct.dim3
@threadIdx = external global %struct.dim3
@_ZZ20_trace_mat_mat_transPKfS0_iiiiPfE4ssum = internal global [256 x float] zeroinitializer, section "__shared__", align 16
@gridDim = external global %struct.dim3
@warpSize = external constant i32

define void @_Z13_copy_low_uppPfii(float* %A, i32 %rows, i32 %stride) nounwind uwtable noinline {
  %1 = alloca float*, align 8
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  %index_1 = alloca i32, align 4
  %index_2 = alloca i32, align 4
  store float* %A, float** %1, align 8
  call void @llvm.dbg.declare(metadata !{float** %1}, metadata !33), !dbg !34
  store i32 %rows, i32* %2, align 4
  call void @llvm.dbg.declare(metadata !{i32* %2}, metadata !35), !dbg !34
  store i32 %stride, i32* %3, align 4
  call void @llvm.dbg.declare(metadata !{i32* %3}, metadata !36), !dbg !34
  call void @llvm.dbg.declare(metadata !{i32* %i}, metadata !37), !dbg !39
  %4 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 0), align 4, !dbg !39
  %5 = load i32* getelementptr inbounds (%struct.dim3* @blockDim, i32 0, i32 0), align 4, !dbg !39
  %6 = mul i32 %4, %5, !dbg !39
  %7 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !39
  %8 = add i32 %6, %7, !dbg !39
  store i32 %8, i32* %i, align 4, !dbg !39
  call void @llvm.dbg.declare(metadata !{i32* %j}, metadata !40), !dbg !41
  %9 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 1), align 4, !dbg !41
  %10 = load i32* getelementptr inbounds (%struct.dim3* @blockDim, i32 0, i32 1), align 4, !dbg !41
  %11 = mul i32 %9, %10, !dbg !41
  %12 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 1), align 4, !dbg !41
  %13 = add i32 %11, %12, !dbg !41
  store i32 %13, i32* %j, align 4, !dbg !41
  %14 = load i32* %i, align 4, !dbg !42
  %15 = load i32* %j, align 4, !dbg !42
  %16 = icmp sle i32 %14, %15, !dbg !42
  br i1 %16, label %21, label %17, !dbg !42

; <label>:17                                      ; preds = %0
  %18 = load i32* %i, align 4, !dbg !42
  %19 = load i32* %2, align 4, !dbg !42
  %20 = icmp sge i32 %18, %19, !dbg !42
  br i1 %20, label %21, label %22, !dbg !42

; <label>:21                                      ; preds = %17, %0
  br label %42, !dbg !43

; <label>:22                                      ; preds = %17
  call void @llvm.dbg.declare(metadata !{i32* %index_1}, metadata !44), !dbg !45
  %23 = load i32* %i, align 4, !dbg !45
  %24 = load i32* %3, align 4, !dbg !45
  %25 = mul nsw i32 %23, %24, !dbg !45
  %26 = load i32* %j, align 4, !dbg !45
  %27 = add nsw i32 %25, %26, !dbg !45
  store i32 %27, i32* %index_1, align 4, !dbg !45
  call void @llvm.dbg.declare(metadata !{i32* %index_2}, metadata !46), !dbg !47
  %28 = load i32* %j, align 4, !dbg !47
  %29 = load i32* %3, align 4, !dbg !47
  %30 = mul nsw i32 %28, %29, !dbg !47
  %31 = load i32* %i, align 4, !dbg !47
  %32 = add nsw i32 %30, %31, !dbg !47
  store i32 %32, i32* %index_2, align 4, !dbg !47
  %33 = load i32* %index_1, align 4, !dbg !48
  %34 = sext i32 %33 to i64, !dbg !48
  %35 = load float** %1, align 8, !dbg !48
  %36 = getelementptr inbounds float* %35, i64 %34, !dbg !48
  %37 = load float* %36, align 4, !dbg !48
  %38 = load i32* %index_2, align 4, !dbg !48
  %39 = sext i32 %38 to i64, !dbg !48
  %40 = load float** %1, align 8, !dbg !48
  %41 = getelementptr inbounds float* %40, i64 %39, !dbg !48
  store float %37, float* %41, align 4, !dbg !48
  br label %42, !dbg !49

; <label>:42                                      ; preds = %22, %21
  ret void, !dbg !49
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
  call void @llvm.dbg.declare(metadata !{float** %1}, metadata !50), !dbg !51
  store i32 %rows, i32* %2, align 4
  call void @llvm.dbg.declare(metadata !{i32* %2}, metadata !52), !dbg !51
  store i32 %stride, i32* %3, align 4
  call void @llvm.dbg.declare(metadata !{i32* %3}, metadata !53), !dbg !51
  call void @llvm.dbg.declare(metadata !{i32* %i}, metadata !54), !dbg !56
  %4 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 0), align 4, !dbg !56
  %5 = load i32* getelementptr inbounds (%struct.dim3* @blockDim, i32 0, i32 0), align 4, !dbg !56
  %6 = mul i32 %4, %5, !dbg !56
  %7 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !56
  %8 = add i32 %6, %7, !dbg !56
  store i32 %8, i32* %i, align 4, !dbg !56
  call void @llvm.dbg.declare(metadata !{i32* %j}, metadata !57), !dbg !58
  %9 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 1), align 4, !dbg !58
  %10 = load i32* getelementptr inbounds (%struct.dim3* @blockDim, i32 0, i32 1), align 4, !dbg !58
  %11 = mul i32 %9, %10, !dbg !58
  %12 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 1), align 4, !dbg !58
  %13 = add i32 %11, %12, !dbg !58
  store i32 %13, i32* %j, align 4, !dbg !58
  %14 = load i32* %j, align 4, !dbg !59
  %15 = load i32* %i, align 4, !dbg !59
  %16 = icmp sle i32 %14, %15, !dbg !59
  br i1 %16, label %21, label %17, !dbg !59

; <label>:17                                      ; preds = %0
  %18 = load i32* %j, align 4, !dbg !59
  %19 = load i32* %2, align 4, !dbg !59
  %20 = icmp sge i32 %18, %19, !dbg !59
  br i1 %20, label %21, label %22, !dbg !59

; <label>:21                                      ; preds = %17, %0
  br label %42, !dbg !60

; <label>:22                                      ; preds = %17
  call void @llvm.dbg.declare(metadata !{i32* %index_1}, metadata !61), !dbg !62
  %23 = load i32* %i, align 4, !dbg !62
  %24 = load i32* %3, align 4, !dbg !62
  %25 = mul nsw i32 %23, %24, !dbg !62
  %26 = load i32* %j, align 4, !dbg !62
  %27 = add nsw i32 %25, %26, !dbg !62
  store i32 %27, i32* %index_1, align 4, !dbg !62
  call void @llvm.dbg.declare(metadata !{i32* %index_2}, metadata !63), !dbg !64
  %28 = load i32* %j, align 4, !dbg !64
  %29 = load i32* %3, align 4, !dbg !64
  %30 = mul nsw i32 %28, %29, !dbg !64
  %31 = load i32* %i, align 4, !dbg !64
  %32 = add nsw i32 %30, %31, !dbg !64
  store i32 %32, i32* %index_2, align 4, !dbg !64
  %33 = load i32* %index_1, align 4, !dbg !65
  %34 = sext i32 %33 to i64, !dbg !65
  %35 = load float** %1, align 8, !dbg !65
  %36 = getelementptr inbounds float* %35, i64 %34, !dbg !65
  %37 = load float* %36, align 4, !dbg !65
  %38 = load i32* %index_2, align 4, !dbg !65
  %39 = sext i32 %38 to i64, !dbg !65
  %40 = load float** %1, align 8, !dbg !65
  %41 = getelementptr inbounds float* %40, i64 %39, !dbg !65
  store float %37, float* %41, align 4, !dbg !65
  br label %42, !dbg !66

; <label>:42                                      ; preds = %22, %21
  ret void, !dbg !66
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
  call void @llvm.dbg.declare(metadata !{float* %1}, metadata !67), !dbg !68
  store float* %mat, float** %2, align 8
  call void @llvm.dbg.declare(metadata !{float** %2}, metadata !69), !dbg !68
  store i32 %stride, i32* %3, align 4
  call void @llvm.dbg.declare(metadata !{i32* %3}, metadata !70), !dbg !68
  store i32 %rows, i32* %4, align 4
  call void @llvm.dbg.declare(metadata !{i32* %4}, metadata !71), !dbg !68
  store i32 %cols, i32* %5, align 4
  call void @llvm.dbg.declare(metadata !{i32* %5}, metadata !72), !dbg !68
  store float* %vec, float** %6, align 8
  call void @llvm.dbg.declare(metadata !{float** %6}, metadata !73), !dbg !74
  store float* %mat2, float** %7, align 8
  call void @llvm.dbg.declare(metadata !{float** %7}, metadata !75), !dbg !74
  store i32 %mat2_row_stride, i32* %8, align 4
  call void @llvm.dbg.declare(metadata !{i32* %8}, metadata !76), !dbg !77
  store i32 %mat2_col_stride, i32* %9, align 4
  call void @llvm.dbg.declare(metadata !{i32* %9}, metadata !78), !dbg !77
  store float %beta, float* %10, align 4
  call void @llvm.dbg.declare(metadata !{float* %10}, metadata !79), !dbg !80
  call void @llvm.dbg.declare(metadata !{i32* %i}, metadata !81), !dbg !83
  %11 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 0), align 4, !dbg !83
  %12 = load i32* getelementptr inbounds (%struct.dim3* @blockDim, i32 0, i32 0), align 4, !dbg !83
  %13 = mul i32 %11, %12, !dbg !83
  %14 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !83
  %15 = add i32 %13, %14, !dbg !83
  store i32 %15, i32* %i, align 4, !dbg !83
  call void @llvm.dbg.declare(metadata !{i32* %j}, metadata !84), !dbg !85
  %16 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 1), align 4, !dbg !85
  %17 = load i32* getelementptr inbounds (%struct.dim3* @blockDim, i32 0, i32 1), align 4, !dbg !85
  %18 = mul i32 %16, %17, !dbg !85
  %19 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 1), align 4, !dbg !85
  %20 = add i32 %18, %19, !dbg !85
  store i32 %20, i32* %j, align 4, !dbg !85
  call void @llvm.dbg.declare(metadata !{i32* %index}, metadata !86), !dbg !87
  %21 = load i32* %j, align 4, !dbg !88
  %22 = load i32* %3, align 4, !dbg !88
  %23 = mul nsw i32 %21, %22, !dbg !88
  %24 = load i32* %i, align 4, !dbg !88
  %25 = add nsw i32 %23, %24, !dbg !88
  store i32 %25, i32* %index, align 4, !dbg !88
  call void @llvm.dbg.declare(metadata !{i32* %index2}, metadata !89), !dbg !87
  %26 = load i32* %j, align 4, !dbg !88
  %27 = load i32* %8, align 4, !dbg !88
  %28 = mul nsw i32 %26, %27, !dbg !88
  %29 = load i32* %i, align 4, !dbg !88
  %30 = load i32* %9, align 4, !dbg !88
  %31 = mul nsw i32 %29, %30, !dbg !88
  %32 = add nsw i32 %28, %31, !dbg !88
  store i32 %32, i32* %index2, align 4, !dbg !88
  %33 = load i32* %i, align 4, !dbg !90
  %34 = load i32* %5, align 4, !dbg !90
  %35 = icmp slt i32 %33, %34, !dbg !90
  br i1 %35, label %36, label %66, !dbg !90

; <label>:36                                      ; preds = %0
  %37 = load i32* %j, align 4, !dbg !90
  %38 = load i32* %4, align 4, !dbg !90
  %39 = icmp slt i32 %37, %38, !dbg !90
  br i1 %39, label %40, label %66, !dbg !90

; <label>:40                                      ; preds = %36
  %41 = load float* %1, align 4, !dbg !91
  %42 = load i32* %j, align 4, !dbg !91
  %43 = sext i32 %42 to i64, !dbg !91
  %44 = load float** %6, align 8, !dbg !91
  %45 = getelementptr inbounds float* %44, i64 %43, !dbg !91
  %46 = load float* %45, align 4, !dbg !91
  %47 = fmul float %41, %46, !dbg !91
  %48 = load i32* %index2, align 4, !dbg !91
  %49 = sext i32 %48 to i64, !dbg !91
  %50 = load float** %7, align 8, !dbg !91
  %51 = getelementptr inbounds float* %50, i64 %49, !dbg !91
  %52 = load float* %51, align 4, !dbg !91
  %53 = fmul float %47, %52, !dbg !91
  %54 = load float* %10, align 4, !dbg !91
  %55 = load i32* %index, align 4, !dbg !91
  %56 = sext i32 %55 to i64, !dbg !91
  %57 = load float** %2, align 8, !dbg !91
  %58 = getelementptr inbounds float* %57, i64 %56, !dbg !91
  %59 = load float* %58, align 4, !dbg !91
  %60 = fmul float %54, %59, !dbg !91
  %61 = fadd float %53, %60, !dbg !91
  %62 = load i32* %index, align 4, !dbg !91
  %63 = sext i32 %62 to i64, !dbg !91
  %64 = load float** %2, align 8, !dbg !91
  %65 = getelementptr inbounds float* %64, i64 %63, !dbg !91
  store float %61, float* %65, align 4, !dbg !91
  br label %66, !dbg !93

; <label>:66                                      ; preds = %40, %36, %0
  ret void, !dbg !94
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
  call void @llvm.dbg.declare(metadata !{float** %1}, metadata !95), !dbg !96
  store float* %B, float** %2, align 8
  call void @llvm.dbg.declare(metadata !{float** %2}, metadata !97), !dbg !96
  store i32 %dmat_cols, i32* %3, align 4
  call void @llvm.dbg.declare(metadata !{i32* %3}, metadata !98), !dbg !96
  store i32 %dmat_rows, i32* %4, align 4
  call void @llvm.dbg.declare(metadata !{i32* %4}, metadata !99), !dbg !96
  store i32 %dmat_stride, i32* %5, align 4
  call void @llvm.dbg.declare(metadata !{i32* %5}, metadata !100), !dbg !96
  call void @llvm.dbg.declare(metadata !{i32* %i}, metadata !101), !dbg !103
  %6 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 0), align 4, !dbg !103
  %7 = load i32* getelementptr inbounds (%struct.dim3* @blockDim, i32 0, i32 0), align 4, !dbg !103
  %8 = mul i32 %6, %7, !dbg !103
  %9 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !103
  %10 = add i32 %8, %9, !dbg !103
  store i32 %10, i32* %i, align 4, !dbg !103
  call void @llvm.dbg.declare(metadata !{i32* %j}, metadata !104), !dbg !105
  %11 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 1), align 4, !dbg !105
  %12 = load i32* getelementptr inbounds (%struct.dim3* @blockDim, i32 0, i32 1), align 4, !dbg !105
  %13 = mul i32 %11, %12, !dbg !105
  %14 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 1), align 4, !dbg !105
  %15 = add i32 %13, %14, !dbg !105
  store i32 %15, i32* %j, align 4, !dbg !105
  %16 = load i32* %i, align 4, !dbg !106
  %17 = load i32* %3, align 4, !dbg !106
  %18 = icmp slt i32 %16, %17, !dbg !106
  br i1 %18, label %19, label %55, !dbg !106

; <label>:19                                      ; preds = %0
  %20 = load i32* %j, align 4, !dbg !106
  %21 = load i32* %4, align 4, !dbg !106
  %22 = icmp slt i32 %20, %21, !dbg !106
  br i1 %22, label %23, label %55, !dbg !106

; <label>:23                                      ; preds = %19
  call void @llvm.dbg.declare(metadata !{i32* %index_B}, metadata !107), !dbg !109
  %24 = load i32* %j, align 4, !dbg !109
  %25 = load i32* %j, align 4, !dbg !109
  %26 = add nsw i32 %25, 1, !dbg !109
  %27 = mul nsw i32 %24, %26, !dbg !109
  %28 = sdiv i32 %27, 2, !dbg !109
  %29 = load i32* %i, align 4, !dbg !109
  %30 = add nsw i32 %28, %29, !dbg !109
  store i32 %30, i32* %index_B, align 4, !dbg !109
  call void @llvm.dbg.declare(metadata !{i32* %index_A}, metadata !110), !dbg !111
  %31 = load i32* %j, align 4, !dbg !111
  %32 = load i32* %5, align 4, !dbg !111
  %33 = mul nsw i32 %31, %32, !dbg !111
  %34 = load i32* %i, align 4, !dbg !111
  %35 = add nsw i32 %33, %34, !dbg !111
  store i32 %35, i32* %index_A, align 4, !dbg !111
  %36 = load i32* %i, align 4, !dbg !112
  %37 = load i32* %j, align 4, !dbg !112
  %38 = icmp sle i32 %36, %37, !dbg !112
  br i1 %38, label %39, label %49, !dbg !112

; <label>:39                                      ; preds = %23
  %40 = load i32* %index_B, align 4, !dbg !113
  %41 = sext i32 %40 to i64, !dbg !113
  %42 = load float** %2, align 8, !dbg !113
  %43 = getelementptr inbounds float* %42, i64 %41, !dbg !113
  %44 = load float* %43, align 4, !dbg !113
  %45 = load i32* %index_A, align 4, !dbg !113
  %46 = sext i32 %45 to i64, !dbg !113
  %47 = load float** %1, align 8, !dbg !113
  %48 = getelementptr inbounds float* %47, i64 %46, !dbg !113
  store float %44, float* %48, align 4, !dbg !113
  br label %54, !dbg !115

; <label>:49                                      ; preds = %23
  %50 = load i32* %index_A, align 4, !dbg !116
  %51 = sext i32 %50 to i64, !dbg !116
  %52 = load float** %1, align 8, !dbg !116
  %53 = getelementptr inbounds float* %52, i64 %51, !dbg !116
  store float 0.000000e+00, float* %53, align 4, !dbg !116
  br label %54

; <label>:54                                      ; preds = %49, %39
  br label %55, !dbg !118

; <label>:55                                      ; preds = %54, %19, %0
  ret void, !dbg !119
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
  call void @llvm.dbg.declare(metadata !{float** %1}, metadata !120), !dbg !121
  store float* %mat_in, float** %2, align 8
  call void @llvm.dbg.declare(metadata !{float** %2}, metadata !122), !dbg !121
  store i32 %d_out_stride, i32* %3, align 4
  call void @llvm.dbg.declare(metadata !{i32* %3}, metadata !123), !dbg !124
  store i32 %d_out_rows, i32* %4, align 4
  call void @llvm.dbg.declare(metadata !{i32* %4}, metadata !125), !dbg !124
  store i32 %d_out_cols, i32* %5, align 4
  call void @llvm.dbg.declare(metadata !{i32* %5}, metadata !126), !dbg !124
  store i32 %d_in_stride, i32* %6, align 4
  call void @llvm.dbg.declare(metadata !{i32* %6}, metadata !127), !dbg !124
  call void @llvm.dbg.declare(metadata !{i32* %i}, metadata !128), !dbg !130
  %7 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 0), align 4, !dbg !130
  %8 = load i32* getelementptr inbounds (%struct.dim3* @blockDim, i32 0, i32 0), align 4, !dbg !130
  %9 = mul i32 %7, %8, !dbg !130
  %10 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !130
  %11 = add i32 %9, %10, !dbg !130
  store i32 %11, i32* %i, align 4, !dbg !130
  call void @llvm.dbg.declare(metadata !{i32* %j}, metadata !131), !dbg !132
  %12 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 1), align 4, !dbg !132
  %13 = load i32* getelementptr inbounds (%struct.dim3* @blockDim, i32 0, i32 1), align 4, !dbg !132
  %14 = mul i32 %12, %13, !dbg !132
  %15 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 1), align 4, !dbg !132
  %16 = add i32 %14, %15, !dbg !132
  store i32 %16, i32* %j, align 4, !dbg !132
  call void @llvm.dbg.declare(metadata !{i32* %index_out}, metadata !133), !dbg !134
  %17 = load i32* %i, align 4, !dbg !134
  %18 = load i32* %j, align 4, !dbg !134
  %19 = load i32* %3, align 4, !dbg !134
  %20 = mul nsw i32 %18, %19, !dbg !134
  %21 = add nsw i32 %17, %20, !dbg !134
  store i32 %21, i32* %index_out, align 4, !dbg !134
  call void @llvm.dbg.declare(metadata !{i32* %index_in}, metadata !135), !dbg !136
  %22 = load i32* %i, align 4, !dbg !136
  %23 = load i32* %j, align 4, !dbg !136
  %24 = load i32* %6, align 4, !dbg !136
  %25 = mul nsw i32 %23, %24, !dbg !136
  %26 = add nsw i32 %22, %25, !dbg !136
  store i32 %26, i32* %index_in, align 4, !dbg !136
  %27 = load i32* %i, align 4, !dbg !137
  %28 = load i32* %5, align 4, !dbg !137
  %29 = icmp slt i32 %27, %28, !dbg !137
  br i1 %29, label %30, label %44, !dbg !137

; <label>:30                                      ; preds = %0
  %31 = load i32* %j, align 4, !dbg !137
  %32 = load i32* %4, align 4, !dbg !137
  %33 = icmp slt i32 %31, %32, !dbg !137
  br i1 %33, label %34, label %44, !dbg !137

; <label>:34                                      ; preds = %30
  %35 = load i32* %index_in, align 4, !dbg !138
  %36 = sext i32 %35 to i64, !dbg !138
  %37 = load float** %2, align 8, !dbg !138
  %38 = getelementptr inbounds float* %37, i64 %36, !dbg !138
  %39 = load float* %38, align 4, !dbg !138
  %40 = load i32* %index_out, align 4, !dbg !138
  %41 = sext i32 %40 to i64, !dbg !138
  %42 = load float** %1, align 8, !dbg !138
  %43 = getelementptr inbounds float* %42, i64 %41, !dbg !138
  store float %39, float* %43, align 4, !dbg !138
  br label %44, !dbg !138

; <label>:44                                      ; preds = %34, %30, %0
  ret void, !dbg !139
}

define void @_Z20_trace_mat_mat_transPKfS0_iiiiPf(float* %A, float* %B, i32 %dA_rows, i32 %dA_cols, i32 %dA_stride, i32 %B_stride, float* %value) uwtable noinline {
  %1 = alloca float*, align 8
  %2 = alloca float*, align 8
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca float*, align 8
  %tid = alloca i32, align 4
  %j = alloca i32, align 4
  %grid_height = alloca i32, align 4
  %i = alloca i32, align 4
  %tsum = alloca float, align 4
  %shift = alloca i32, align 4
  %shift1 = alloca i32, align 4
  store float* %A, float** %1, align 8
  call void @llvm.dbg.declare(metadata !{float** %1}, metadata !140), !dbg !141
  store float* %B, float** %2, align 8
  call void @llvm.dbg.declare(metadata !{float** %2}, metadata !142), !dbg !141
  store i32 %dA_rows, i32* %3, align 4
  call void @llvm.dbg.declare(metadata !{i32* %3}, metadata !143), !dbg !141
  store i32 %dA_cols, i32* %4, align 4
  call void @llvm.dbg.declare(metadata !{i32* %4}, metadata !144), !dbg !141
  store i32 %dA_stride, i32* %5, align 4
  call void @llvm.dbg.declare(metadata !{i32* %5}, metadata !145), !dbg !141
  store i32 %B_stride, i32* %6, align 4
  call void @llvm.dbg.declare(metadata !{i32* %6}, metadata !146), !dbg !147
  store float* %value, float** %7, align 8
  call void @llvm.dbg.declare(metadata !{float** %7}, metadata !148), !dbg !147
  call void @llvm.dbg.declare(metadata !{i32* %tid}, metadata !149), !dbg !152
  %8 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 1), align 4, !dbg !152
  %9 = load i32* getelementptr inbounds (%struct.dim3* @blockDim, i32 0, i32 0), align 4, !dbg !152
  %10 = mul i32 %8, %9, !dbg !152
  %11 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !152
  %12 = add i32 %10, %11, !dbg !152
  store i32 %12, i32* %tid, align 4, !dbg !152
  call void @llvm.dbg.declare(metadata !{i32* %j}, metadata !153), !dbg !154
  %13 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 0), align 4, !dbg !154
  %14 = load i32* getelementptr inbounds (%struct.dim3* @blockDim, i32 0, i32 0), align 4, !dbg !154
  %15 = mul i32 %13, %14, !dbg !154
  %16 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !154
  %17 = add i32 %15, %16, !dbg !154
  store i32 %17, i32* %j, align 4, !dbg !154
  call void @llvm.dbg.declare(metadata !{i32* %grid_height}, metadata !155), !dbg !156
  %18 = load i32* getelementptr inbounds (%struct.dim3* @gridDim, i32 0, i32 1), align 4, !dbg !156
  %19 = load i32* getelementptr inbounds (%struct.dim3* @blockDim, i32 0, i32 1), align 4, !dbg !156
  %20 = mul i32 %18, %19, !dbg !156
  store i32 %20, i32* %grid_height, align 4, !dbg !156
  call void @llvm.dbg.declare(metadata !{i32* %i}, metadata !157), !dbg !158
  %21 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 1), align 4, !dbg !158
  %22 = load i32* getelementptr inbounds (%struct.dim3* @blockDim, i32 0, i32 1), align 4, !dbg !158
  %23 = mul i32 %21, %22, !dbg !158
  %24 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 1), align 4, !dbg !158
  %25 = add i32 %23, %24, !dbg !158
  store i32 %25, i32* %i, align 4, !dbg !158
  call void @llvm.dbg.declare(metadata !{float* %tsum}, metadata !159), !dbg !160
  store float 0.000000e+00, float* %tsum, align 4, !dbg !160
  %26 = load i32* %j, align 4, !dbg !161
  %27 = load i32* %4, align 4, !dbg !161
  %28 = icmp slt i32 %26, %27, !dbg !161
  br i1 %28, label %29, label %60, !dbg !161

; <label>:29                                      ; preds = %0
  br label %30, !dbg !162

; <label>:30                                      ; preds = %34, %29
  %31 = load i32* %i, align 4, !dbg !162
  %32 = load i32* %3, align 4, !dbg !162
  %33 = icmp slt i32 %31, %32, !dbg !162
  br i1 %33, label %34, label %59, !dbg !162

; <label>:34                                      ; preds = %30
  %35 = load i32* %i, align 4, !dbg !164
  %36 = load i32* %5, align 4, !dbg !164
  %37 = mul nsw i32 %35, %36, !dbg !164
  %38 = load i32* %j, align 4, !dbg !164
  %39 = add nsw i32 %37, %38, !dbg !164
  %40 = sext i32 %39 to i64, !dbg !164
  %41 = load float** %1, align 8, !dbg !164
  %42 = getelementptr inbounds float* %41, i64 %40, !dbg !164
  %43 = load float* %42, align 4, !dbg !164
  %44 = load i32* %i, align 4, !dbg !164
  %45 = load i32* %6, align 4, !dbg !164
  %46 = mul nsw i32 %44, %45, !dbg !164
  %47 = load i32* %j, align 4, !dbg !164
  %48 = add nsw i32 %46, %47, !dbg !164
  %49 = sext i32 %48 to i64, !dbg !164
  %50 = load float** %2, align 8, !dbg !164
  %51 = getelementptr inbounds float* %50, i64 %49, !dbg !164
  %52 = load float* %51, align 4, !dbg !164
  %53 = fmul float %43, %52, !dbg !164
  %54 = load float* %tsum, align 4, !dbg !164
  %55 = fadd float %54, %53, !dbg !164
  store float %55, float* %tsum, align 4, !dbg !164
  %56 = load i32* %grid_height, align 4, !dbg !166
  %57 = load i32* %i, align 4, !dbg !166
  %58 = add nsw i32 %57, %56, !dbg !166
  store i32 %58, i32* %i, align 4, !dbg !166
  br label %30, !dbg !167

; <label>:59                                      ; preds = %30
  br label %60, !dbg !168

; <label>:60                                      ; preds = %59, %0
  %61 = load float* %tsum, align 4, !dbg !169
  %62 = load i32* %tid, align 4, !dbg !169
  %63 = sext i32 %62 to i64, !dbg !169
  %64 = getelementptr inbounds [256 x float]* @_ZZ20_trace_mat_mat_transPKfS0_iiiiPfE4ssum, i32 0, i64 %63, !dbg !169
  store float %61, float* %64, align 4, !dbg !169
  call void @__syncthreads(), !dbg !170
  call void @llvm.dbg.declare(metadata !{i32* %shift}, metadata !171), !dbg !173
  store i32 128, i32* %shift, align 4, !dbg !173
  br label %65, !dbg !173

; <label>:65                                      ; preds = %86, %60
  %66 = load i32* %shift, align 4, !dbg !173
  %67 = load i32* @warpSize, align 4, !dbg !173
  %68 = icmp sgt i32 %66, %67, !dbg !173
  br i1 %68, label %69, label %89, !dbg !173

; <label>:69                                      ; preds = %65
  %70 = load i32* %tid, align 4, !dbg !174
  %71 = load i32* %shift, align 4, !dbg !174
  %72 = icmp slt i32 %70, %71, !dbg !174
  br i1 %72, label %73, label %85, !dbg !174

; <label>:73                                      ; preds = %69
  %74 = load i32* %tid, align 4, !dbg !176
  %75 = load i32* %shift, align 4, !dbg !176
  %76 = add nsw i32 %74, %75, !dbg !176
  %77 = sext i32 %76 to i64, !dbg !176
  %78 = getelementptr inbounds [256 x float]* @_ZZ20_trace_mat_mat_transPKfS0_iiiiPfE4ssum, i32 0, i64 %77, !dbg !176
  %79 = load float* %78, align 4, !dbg !176
  %80 = load i32* %tid, align 4, !dbg !176
  %81 = sext i32 %80 to i64, !dbg !176
  %82 = getelementptr inbounds [256 x float]* @_ZZ20_trace_mat_mat_transPKfS0_iiiiPfE4ssum, i32 0, i64 %81, !dbg !176
  %83 = load float* %82, align 4, !dbg !176
  %84 = fadd float %83, %79, !dbg !176
  store float %84, float* %82, align 4, !dbg !176
  br label %85, !dbg !176

; <label>:85                                      ; preds = %73, %69
  call void @__syncthreads(), !dbg !177
  br label %86, !dbg !178

; <label>:86                                      ; preds = %85
  %87 = load i32* %shift, align 4, !dbg !173
  %88 = ashr i32 %87, 1, !dbg !173
  store i32 %88, i32* %shift, align 4, !dbg !173
  br label %65, !dbg !173

; <label>:89                                      ; preds = %65
  %90 = load i32* %tid, align 4, !dbg !179
  %91 = load i32* @warpSize, align 4, !dbg !179
  %92 = icmp slt i32 %90, %91, !dbg !179
  br i1 %92, label %93, label %114, !dbg !179

; <label>:93                                      ; preds = %89
  call void @llvm.dbg.declare(metadata !{i32* %shift1}, metadata !180), !dbg !183
  %94 = load i32* @warpSize, align 4, !dbg !183
  store i32 %94, i32* %shift1, align 4, !dbg !183
  br label %95, !dbg !183

; <label>:95                                      ; preds = %110, %93
  %96 = load i32* %shift1, align 4, !dbg !183
  %97 = icmp sgt i32 %96, 0, !dbg !183
  br i1 %97, label %98, label %113, !dbg !183

; <label>:98                                      ; preds = %95
  %99 = load i32* %tid, align 4, !dbg !184
  %100 = load i32* %shift1, align 4, !dbg !184
  %101 = add nsw i32 %99, %100, !dbg !184
  %102 = sext i32 %101 to i64, !dbg !184
  %103 = getelementptr inbounds [256 x float]* @_ZZ20_trace_mat_mat_transPKfS0_iiiiPfE4ssum, i32 0, i64 %102, !dbg !184
  %104 = load float* %103, align 4, !dbg !184
  %105 = load i32* %tid, align 4, !dbg !184
  %106 = sext i32 %105 to i64, !dbg !184
  %107 = getelementptr inbounds [256 x float]* @_ZZ20_trace_mat_mat_transPKfS0_iiiiPfE4ssum, i32 0, i64 %106, !dbg !184
  %108 = load float* %107, align 4, !dbg !184
  %109 = fadd float %108, %104, !dbg !184
  store float %109, float* %107, align 4, !dbg !184
  br label %110, !dbg !186

; <label>:110                                     ; preds = %98
  %111 = load i32* %shift1, align 4, !dbg !183
  %112 = ashr i32 %111, 1, !dbg !183
  store i32 %112, i32* %shift1, align 4, !dbg !183
  br label %95, !dbg !183

; <label>:113                                     ; preds = %95
  br label %114, !dbg !187

; <label>:114                                     ; preds = %113, %89
  %115 = load i32* %tid, align 4, !dbg !188
  %116 = icmp eq i32 %115, 0, !dbg !188
  br i1 %116, label %117, label %127, !dbg !188

; <label>:117                                     ; preds = %114
  %118 = load float* getelementptr inbounds ([256 x float]* @_ZZ20_trace_mat_mat_transPKfS0_iiiiPfE4ssum, i32 0, i64 0), align 4, !dbg !189
  %119 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 1), align 4, !dbg !189
  %120 = load i32* getelementptr inbounds (%struct.dim3* @gridDim, i32 0, i32 0), align 4, !dbg !189
  %121 = mul i32 %119, %120, !dbg !189
  %122 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 0), align 4, !dbg !189
  %123 = add i32 %121, %122, !dbg !189
  %124 = zext i32 %123 to i64, !dbg !189
  %125 = load float** %7, align 8, !dbg !189
  %126 = getelementptr inbounds float* %125, i64 %124, !dbg !189
  store float %118, float* %126, align 4, !dbg !189
  br label %127, !dbg !191

; <label>:127                                     ; preds = %117, %114
  ret void, !dbg !192
}

declare void @__syncthreads() section "__device__"

!llvm.dbg.cu = !{!0}

!0 = metadata !{i32 786449, i32 0, i32 4, metadata !"new-func.cpp", metadata !"/home/mingyuanwu/kaldi-new-bug", metadata !"clang version 3.2 (tags/RELEASE_32/final)", i1 true, i1 false, metadata !"", i32 0, metadata !1, metadata !1, metadata !3, metadata !27} ; [ DW_TAG_compile_unit ] [/home/mingyuanwu/kaldi-new-bug/new-func.cpp] [DW_LANG_C_plus_plus]
!1 = metadata !{metadata !2}
!2 = metadata !{i32 0}
!3 = metadata !{metadata !4}
!4 = metadata !{metadata !5, metadata !12, metadata !13, metadata !18, metadata !21, metadata !24}
!5 = metadata !{i32 786478, i32 0, metadata !6, metadata !"_copy_low_upp", metadata !"_copy_low_upp", metadata !"_Z13_copy_low_uppPfii", metadata !6, i32 4, metadata !7, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, void (float*, i32, i32)* @_Z13_copy_low_uppPfii, null, null, metadata !1, i32 4} ; [ DW_TAG_subprogram ] [line 4] [def] [_copy_low_upp]
!6 = metadata !{i32 786473, metadata !"new-func.cpp", metadata !"/home/mingyuanwu/kaldi-new-bug", null} ; [ DW_TAG_file_type ]
!7 = metadata !{i32 786453, i32 0, metadata !"", i32 0, i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !8, i32 0, i32 0} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!8 = metadata !{null, metadata !9, metadata !11, metadata !11}
!9 = metadata !{i32 786447, null, metadata !"", null, i32 0, i64 64, i64 64, i64 0, i32 0, metadata !10} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from float]
!10 = metadata !{i32 786468, null, metadata !"float", null, i32 0, i64 32, i64 32, i64 0, i32 0, i32 4} ; [ DW_TAG_base_type ] [float] [line 0, size 32, align 32, offset 0, enc DW_ATE_float]
!11 = metadata !{i32 786468, null, metadata !"int", null, i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!12 = metadata !{i32 786478, i32 0, metadata !6, metadata !"_copy_upp_low", metadata !"_copy_upp_low", metadata !"_Z13_copy_upp_lowPfii", metadata !6, i32 21, metadata !7, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, void (float*, i32, i32)* @_Z13_copy_upp_lowPfii, null, null, metadata !1, i32 21} ; [ DW_TAG_subprogram ] [line 21] [def] [_copy_upp_low]
!13 = metadata !{i32 786478, i32 0, metadata !6, metadata !"_add_diag_vec_mat", metadata !"_add_diag_vec_mat", metadata !"_Z17_add_diag_vec_matfPfiiiPKfS1_iif", metadata !6, i32 33, metadata !14, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, void (float, float*, i32, i32, i32, float*, float*, i32, i32, float)* @_Z17_add_diag_vec_matfPfiiiPKfS1_iif, null, null, metadata !1, i32 36} ; [ DW_TAG_subprogram ] [line 33] [def] [scope 36] [_add_diag_vec_mat]
!14 = metadata !{i32 786453, i32 0, metadata !"", i32 0, i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !15, i32 0, i32 0} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!15 = metadata !{null, metadata !10, metadata !9, metadata !11, metadata !11, metadata !11, metadata !16, metadata !16, metadata !11, metadata !11, metadata !10}
!16 = metadata !{i32 786447, null, metadata !"", null, i32 0, i64 64, i64 64, i64 0, i32 0, metadata !17} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from ]
!17 = metadata !{i32 786470, null, metadata !"", null, i32 0, i64 0, i64 0, i64 0, i32 0, metadata !10} ; [ DW_TAG_const_type ] [line 0, size 0, align 0, offset 0] [from float]
!18 = metadata !{i32 786478, i32 0, metadata !6, metadata !"_copy_from_tp", metadata !"_copy_from_tp", metadata !"_Z13_copy_from_tpPfPKfiii", metadata !6, i32 49, metadata !19, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, void (float*, float*, i32, i32, i32)* @_Z13_copy_from_tpPfPKfiii, null, null, metadata !1, i32 49} ; [ DW_TAG_subprogram ] [line 49] [def] [_copy_from_tp]
!19 = metadata !{i32 786453, i32 0, metadata !"", i32 0, i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !20, i32 0, i32 0} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!20 = metadata !{null, metadata !9, metadata !16, metadata !11, metadata !11, metadata !11}
!21 = metadata !{i32 786478, i32 0, metadata !6, metadata !"_copy_from_mat", metadata !"_copy_from_mat", metadata !"_Z14_copy_from_matPfPKfiiii", metadata !6, i32 65, metadata !22, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, void (float*, float*, i32, i32, i32, i32)* @_Z14_copy_from_matPfPKfiiii, null, null, metadata !1, i32 66} ; [ DW_TAG_subprogram ] [line 65] [def] [scope 66] [_copy_from_mat]
!22 = metadata !{i32 786453, i32 0, metadata !"", i32 0, i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !23, i32 0, i32 0} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!23 = metadata !{null, metadata !9, metadata !16, metadata !11, metadata !11, metadata !11, metadata !11}
!24 = metadata !{i32 786478, i32 0, metadata !6, metadata !"_trace_mat_mat_trans", metadata !"_trace_mat_mat_trans", metadata !"_Z20_trace_mat_mat_transPKfS0_iiiiPf", metadata !6, i32 77, metadata !25, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, void (float*, float*, i32, i32, i32, i32, float*)* @_Z20_trace_mat_mat_transPKfS0_iiiiPf, null, null, metadata !1, i32 78} ; [ DW_TAG_subprogram ] [line 77] [def] [scope 78] [_trace_mat_mat_trans]
!25 = metadata !{i32 786453, i32 0, metadata !"", i32 0, i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !26, i32 0, i32 0} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!26 = metadata !{null, metadata !16, metadata !16, metadata !11, metadata !11, metadata !11, metadata !11, metadata !9}
!27 = metadata !{metadata !28}
!28 = metadata !{metadata !29}
!29 = metadata !{i32 786484, i32 0, metadata !24, metadata !"ssum", metadata !"ssum", metadata !"", metadata !6, i32 79, metadata !30, i32 1, i32 1, [256 x float]* @_ZZ20_trace_mat_mat_transPKfS0_iiiiPfE4ssum} ; [ DW_TAG_variable ] [ssum] [line 79] [local] [def]
!30 = metadata !{i32 786433, null, metadata !"", null, i32 0, i64 8192, i64 32, i32 0, i32 0, metadata !10, metadata !31, i32 0, i32 0} ; [ DW_TAG_array_type ] [line 0, size 8192, align 32, offset 0] [from float]
!31 = metadata !{metadata !32}
!32 = metadata !{i32 786465, i64 0, i64 255}      ; [ DW_TAG_subrange_type ] [0, 255]
!33 = metadata !{i32 786689, metadata !5, metadata !"A", metadata !6, i32 16777220, metadata !9, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [A] [line 4]
!34 = metadata !{i32 4, i32 0, metadata !5, null}
!35 = metadata !{i32 786689, metadata !5, metadata !"rows", metadata !6, i32 33554436, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [rows] [line 4]
!36 = metadata !{i32 786689, metadata !5, metadata !"stride", metadata !6, i32 50331652, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [stride] [line 4]
!37 = metadata !{i32 786688, metadata !38, metadata !"i", metadata !6, i32 5, metadata !11, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [i] [line 5]
!38 = metadata !{i32 786443, metadata !5, i32 4, i32 0, metadata !6, i32 0} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/kaldi-new-bug/new-func.cpp]
!39 = metadata !{i32 5, i32 0, metadata !38, null}
!40 = metadata !{i32 786688, metadata !38, metadata !"j", metadata !6, i32 6, metadata !11, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [j] [line 6]
!41 = metadata !{i32 6, i32 0, metadata !38, null}
!42 = metadata !{i32 7, i32 0, metadata !38, null}
!43 = metadata !{i32 8, i32 0, metadata !38, null}
!44 = metadata !{i32 786688, metadata !38, metadata !"index_1", metadata !6, i32 9, metadata !11, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [index_1] [line 9]
!45 = metadata !{i32 9, i32 0, metadata !38, null}
!46 = metadata !{i32 786688, metadata !38, metadata !"index_2", metadata !6, i32 10, metadata !11, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [index_2] [line 10]
!47 = metadata !{i32 10, i32 0, metadata !38, null}
!48 = metadata !{i32 11, i32 0, metadata !38, null}
!49 = metadata !{i32 12, i32 0, metadata !38, null}
!50 = metadata !{i32 786689, metadata !12, metadata !"A", metadata !6, i32 16777237, metadata !9, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [A] [line 21]
!51 = metadata !{i32 21, i32 0, metadata !12, null}
!52 = metadata !{i32 786689, metadata !12, metadata !"rows", metadata !6, i32 33554453, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [rows] [line 21]
!53 = metadata !{i32 786689, metadata !12, metadata !"stride", metadata !6, i32 50331669, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [stride] [line 21]
!54 = metadata !{i32 786688, metadata !55, metadata !"i", metadata !6, i32 22, metadata !11, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [i] [line 22]
!55 = metadata !{i32 786443, metadata !12, i32 21, i32 0, metadata !6, i32 1} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/kaldi-new-bug/new-func.cpp]
!56 = metadata !{i32 22, i32 0, metadata !55, null}
!57 = metadata !{i32 786688, metadata !55, metadata !"j", metadata !6, i32 23, metadata !11, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [j] [line 23]
!58 = metadata !{i32 23, i32 0, metadata !55, null}
!59 = metadata !{i32 24, i32 0, metadata !55, null}
!60 = metadata !{i32 25, i32 0, metadata !55, null}
!61 = metadata !{i32 786688, metadata !55, metadata !"index_1", metadata !6, i32 26, metadata !11, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [index_1] [line 26]
!62 = metadata !{i32 26, i32 0, metadata !55, null}
!63 = metadata !{i32 786688, metadata !55, metadata !"index_2", metadata !6, i32 27, metadata !11, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [index_2] [line 27]
!64 = metadata !{i32 27, i32 0, metadata !55, null}
!65 = metadata !{i32 28, i32 0, metadata !55, null}
!66 = metadata !{i32 29, i32 0, metadata !55, null}
!67 = metadata !{i32 786689, metadata !13, metadata !"alpha", metadata !6, i32 16777249, metadata !10, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [alpha] [line 33]
!68 = metadata !{i32 33, i32 0, metadata !13, null}
!69 = metadata !{i32 786689, metadata !13, metadata !"mat", metadata !6, i32 33554465, metadata !9, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [mat] [line 33]
!70 = metadata !{i32 786689, metadata !13, metadata !"stride", metadata !6, i32 50331681, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [stride] [line 33]
!71 = metadata !{i32 786689, metadata !13, metadata !"rows", metadata !6, i32 67108897, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [rows] [line 33]
!72 = metadata !{i32 786689, metadata !13, metadata !"cols", metadata !6, i32 83886113, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [cols] [line 33]
!73 = metadata !{i32 786689, metadata !13, metadata !"vec", metadata !6, i32 100663330, metadata !16, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [vec] [line 34]
!74 = metadata !{i32 34, i32 0, metadata !13, null}
!75 = metadata !{i32 786689, metadata !13, metadata !"mat2", metadata !6, i32 117440546, metadata !16, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [mat2] [line 34]
!76 = metadata !{i32 786689, metadata !13, metadata !"mat2_row_stride", metadata !6, i32 134217763, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [mat2_row_stride] [line 35]
!77 = metadata !{i32 35, i32 0, metadata !13, null}
!78 = metadata !{i32 786689, metadata !13, metadata !"mat2_col_stride", metadata !6, i32 150994979, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [mat2_col_stride] [line 35]
!79 = metadata !{i32 786689, metadata !13, metadata !"beta", metadata !6, i32 167772196, metadata !10, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [beta] [line 36]
!80 = metadata !{i32 36, i32 0, metadata !13, null}
!81 = metadata !{i32 786688, metadata !82, metadata !"i", metadata !6, i32 37, metadata !11, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [i] [line 37]
!82 = metadata !{i32 786443, metadata !13, i32 36, i32 0, metadata !6, i32 2} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/kaldi-new-bug/new-func.cpp]
!83 = metadata !{i32 37, i32 0, metadata !82, null}
!84 = metadata !{i32 786688, metadata !82, metadata !"j", metadata !6, i32 38, metadata !11, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [j] [line 38]
!85 = metadata !{i32 38, i32 0, metadata !82, null}
!86 = metadata !{i32 786688, metadata !82, metadata !"index", metadata !6, i32 40, metadata !11, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [index] [line 40]
!87 = metadata !{i32 40, i32 0, metadata !82, null}
!88 = metadata !{i32 41, i32 0, metadata !82, null}
!89 = metadata !{i32 786688, metadata !82, metadata !"index2", metadata !6, i32 40, metadata !11, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [index2] [line 40]
!90 = metadata !{i32 43, i32 0, metadata !82, null}
!91 = metadata !{i32 44, i32 0, metadata !92, null}
!92 = metadata !{i32 786443, metadata !82, i32 43, i32 0, metadata !6, i32 3} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/kaldi-new-bug/new-func.cpp]
!93 = metadata !{i32 45, i32 0, metadata !92, null}
!94 = metadata !{i32 46, i32 0, metadata !82, null}
!95 = metadata !{i32 786689, metadata !18, metadata !"A", metadata !6, i32 16777265, metadata !9, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [A] [line 49]
!96 = metadata !{i32 49, i32 0, metadata !18, null}
!97 = metadata !{i32 786689, metadata !18, metadata !"B", metadata !6, i32 33554481, metadata !16, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [B] [line 49]
!98 = metadata !{i32 786689, metadata !18, metadata !"dmat_cols", metadata !6, i32 50331697, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [dmat_cols] [line 49]
!99 = metadata !{i32 786689, metadata !18, metadata !"dmat_rows", metadata !6, i32 67108913, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [dmat_rows] [line 49]
!100 = metadata !{i32 786689, metadata !18, metadata !"dmat_stride", metadata !6, i32 83886129, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [dmat_stride] [line 49]
!101 = metadata !{i32 786688, metadata !102, metadata !"i", metadata !6, i32 50, metadata !11, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [i] [line 50]
!102 = metadata !{i32 786443, metadata !18, i32 49, i32 0, metadata !6, i32 4} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/kaldi-new-bug/new-func.cpp]
!103 = metadata !{i32 50, i32 0, metadata !102, null}
!104 = metadata !{i32 786688, metadata !102, metadata !"j", metadata !6, i32 51, metadata !11, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [j] [line 51]
!105 = metadata !{i32 51, i32 0, metadata !102, null}
!106 = metadata !{i32 52, i32 0, metadata !102, null}
!107 = metadata !{i32 786688, metadata !108, metadata !"index_B", metadata !6, i32 53, metadata !11, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [index_B] [line 53]
!108 = metadata !{i32 786443, metadata !102, i32 52, i32 0, metadata !6, i32 5} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/kaldi-new-bug/new-func.cpp]
!109 = metadata !{i32 53, i32 0, metadata !108, null}
!110 = metadata !{i32 786688, metadata !108, metadata !"index_A", metadata !6, i32 54, metadata !11, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [index_A] [line 54]
!111 = metadata !{i32 54, i32 0, metadata !108, null}
!112 = metadata !{i32 55, i32 0, metadata !108, null}
!113 = metadata !{i32 56, i32 0, metadata !114, null}
!114 = metadata !{i32 786443, metadata !108, i32 55, i32 0, metadata !6, i32 6} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/kaldi-new-bug/new-func.cpp]
!115 = metadata !{i32 57, i32 0, metadata !114, null}
!116 = metadata !{i32 58, i32 0, metadata !117, null}
!117 = metadata !{i32 786443, metadata !108, i32 57, i32 0, metadata !6, i32 7} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/kaldi-new-bug/new-func.cpp]
!118 = metadata !{i32 60, i32 0, metadata !108, null}
!119 = metadata !{i32 61, i32 0, metadata !102, null}
!120 = metadata !{i32 786689, metadata !21, metadata !"mat_out", metadata !6, i32 16777281, metadata !9, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [mat_out] [line 65]
!121 = metadata !{i32 65, i32 0, metadata !21, null}
!122 = metadata !{i32 786689, metadata !21, metadata !"mat_in", metadata !6, i32 33554497, metadata !16, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [mat_in] [line 65]
!123 = metadata !{i32 786689, metadata !21, metadata !"d_out_stride", metadata !6, i32 50331714, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [d_out_stride] [line 66]
!124 = metadata !{i32 66, i32 0, metadata !21, null}
!125 = metadata !{i32 786689, metadata !21, metadata !"d_out_rows", metadata !6, i32 67108930, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [d_out_rows] [line 66]
!126 = metadata !{i32 786689, metadata !21, metadata !"d_out_cols", metadata !6, i32 83886146, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [d_out_cols] [line 66]
!127 = metadata !{i32 786689, metadata !21, metadata !"d_in_stride", metadata !6, i32 100663362, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [d_in_stride] [line 66]
!128 = metadata !{i32 786688, metadata !129, metadata !"i", metadata !6, i32 67, metadata !11, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [i] [line 67]
!129 = metadata !{i32 786443, metadata !21, i32 66, i32 0, metadata !6, i32 8} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/kaldi-new-bug/new-func.cpp]
!130 = metadata !{i32 67, i32 0, metadata !129, null}
!131 = metadata !{i32 786688, metadata !129, metadata !"j", metadata !6, i32 68, metadata !11, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [j] [line 68]
!132 = metadata !{i32 68, i32 0, metadata !129, null}
!133 = metadata !{i32 786688, metadata !129, metadata !"index_out", metadata !6, i32 69, metadata !11, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [index_out] [line 69]
!134 = metadata !{i32 69, i32 0, metadata !129, null}
!135 = metadata !{i32 786688, metadata !129, metadata !"index_in", metadata !6, i32 70, metadata !11, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [index_in] [line 70]
!136 = metadata !{i32 70, i32 0, metadata !129, null}
!137 = metadata !{i32 71, i32 0, metadata !129, null}
!138 = metadata !{i32 72, i32 0, metadata !129, null}
!139 = metadata !{i32 73, i32 0, metadata !129, null}
!140 = metadata !{i32 786689, metadata !24, metadata !"A", metadata !6, i32 16777293, metadata !16, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [A] [line 77]
!141 = metadata !{i32 77, i32 0, metadata !24, null}
!142 = metadata !{i32 786689, metadata !24, metadata !"B", metadata !6, i32 33554509, metadata !16, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [B] [line 77]
!143 = metadata !{i32 786689, metadata !24, metadata !"dA_rows", metadata !6, i32 50331725, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [dA_rows] [line 77]
!144 = metadata !{i32 786689, metadata !24, metadata !"dA_cols", metadata !6, i32 67108941, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [dA_cols] [line 77]
!145 = metadata !{i32 786689, metadata !24, metadata !"dA_stride", metadata !6, i32 83886157, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [dA_stride] [line 77]
!146 = metadata !{i32 786689, metadata !24, metadata !"B_stride", metadata !6, i32 100663374, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [B_stride] [line 78]
!147 = metadata !{i32 78, i32 0, metadata !24, null}
!148 = metadata !{i32 786689, metadata !24, metadata !"value", metadata !6, i32 117440590, metadata !9, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [value] [line 78]
!149 = metadata !{i32 786688, metadata !150, metadata !"tid", metadata !6, i32 81, metadata !151, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [tid] [line 81]
!150 = metadata !{i32 786443, metadata !24, i32 78, i32 0, metadata !6, i32 9} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/kaldi-new-bug/new-func.cpp]
!151 = metadata !{i32 786470, null, metadata !"", null, i32 0, i64 0, i64 0, i64 0, i32 0, metadata !11} ; [ DW_TAG_const_type ] [line 0, size 0, align 0, offset 0] [from int]
!152 = metadata !{i32 81, i32 0, metadata !150, null}
!153 = metadata !{i32 786688, metadata !150, metadata !"j", metadata !6, i32 82, metadata !151, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [j] [line 82]
!154 = metadata !{i32 82, i32 0, metadata !150, null}
!155 = metadata !{i32 786688, metadata !150, metadata !"grid_height", metadata !6, i32 83, metadata !151, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [grid_height] [line 83]
!156 = metadata !{i32 83, i32 0, metadata !150, null}
!157 = metadata !{i32 786688, metadata !150, metadata !"i", metadata !6, i32 84, metadata !11, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [i] [line 84]
!158 = metadata !{i32 84, i32 0, metadata !150, null}
!159 = metadata !{i32 786688, metadata !150, metadata !"tsum", metadata !6, i32 87, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [tsum] [line 87]
!160 = metadata !{i32 87, i32 0, metadata !150, null}
!161 = metadata !{i32 88, i32 0, metadata !150, null}
!162 = metadata !{i32 89, i32 0, metadata !163, null}
!163 = metadata !{i32 786443, metadata !150, i32 88, i32 0, metadata !6, i32 10} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/kaldi-new-bug/new-func.cpp]
!164 = metadata !{i32 90, i32 0, metadata !165, null}
!165 = metadata !{i32 786443, metadata !163, i32 89, i32 0, metadata !6, i32 11} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/kaldi-new-bug/new-func.cpp]
!166 = metadata !{i32 91, i32 0, metadata !165, null}
!167 = metadata !{i32 92, i32 0, metadata !165, null}
!168 = metadata !{i32 93, i32 0, metadata !163, null}
!169 = metadata !{i32 94, i32 0, metadata !150, null}
!170 = metadata !{i32 95, i32 0, metadata !150, null}
!171 = metadata !{i32 786688, metadata !172, metadata !"shift", metadata !6, i32 98, metadata !11, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [shift] [line 98]
!172 = metadata !{i32 786443, metadata !150, i32 98, i32 0, metadata !6, i32 12} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/kaldi-new-bug/new-func.cpp]
!173 = metadata !{i32 98, i32 0, metadata !172, null}
!174 = metadata !{i32 99, i32 0, metadata !175, null}
!175 = metadata !{i32 786443, metadata !172, i32 98, i32 0, metadata !6, i32 13} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/kaldi-new-bug/new-func.cpp]
!176 = metadata !{i32 100, i32 0, metadata !175, null}
!177 = metadata !{i32 101, i32 0, metadata !175, null}
!178 = metadata !{i32 102, i32 0, metadata !175, null}
!179 = metadata !{i32 105, i32 0, metadata !150, null}
!180 = metadata !{i32 786688, metadata !181, metadata !"shift", metadata !6, i32 106, metadata !11, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [shift] [line 106]
!181 = metadata !{i32 786443, metadata !182, i32 106, i32 0, metadata !6, i32 15} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/kaldi-new-bug/new-func.cpp]
!182 = metadata !{i32 786443, metadata !150, i32 105, i32 0, metadata !6, i32 14} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/kaldi-new-bug/new-func.cpp]
!183 = metadata !{i32 106, i32 0, metadata !181, null}
!184 = metadata !{i32 107, i32 0, metadata !185, null}
!185 = metadata !{i32 786443, metadata !181, i32 106, i32 0, metadata !6, i32 16} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/kaldi-new-bug/new-func.cpp]
!186 = metadata !{i32 108, i32 0, metadata !185, null}
!187 = metadata !{i32 109, i32 0, metadata !182, null}
!188 = metadata !{i32 112, i32 0, metadata !150, null}
!189 = metadata !{i32 113, i32 0, metadata !190, null}
!190 = metadata !{i32 786443, metadata !150, i32 112, i32 0, metadata !6, i32 17} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/kaldi-new-bug/new-func.cpp]
!191 = metadata !{i32 114, i32 0, metadata !190, null}
!192 = metadata !{i32 115, i32 0, metadata !150, null}
