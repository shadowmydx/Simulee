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
  call void @llvm.dbg.declare(metadata !{float** %1}, metadata !38), !dbg !39
  store i32 %rows, i32* %2, align 4
  call void @llvm.dbg.declare(metadata !{i32* %2}, metadata !40), !dbg !39
  store i32 %stride, i32* %3, align 4
  call void @llvm.dbg.declare(metadata !{i32* %3}, metadata !41), !dbg !39
  call void @llvm.dbg.declare(metadata !{i32* %i}, metadata !42), !dbg !44
  %4 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 0), align 4, !dbg !44
  %5 = load i32* getelementptr inbounds (%struct.dim3* @blockDim, i32 0, i32 0), align 4, !dbg !44
  %6 = mul i32 %4, %5, !dbg !44
  %7 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !44
  %8 = add i32 %6, %7, !dbg !44
  store i32 %8, i32* %i, align 4, !dbg !44
  call void @llvm.dbg.declare(metadata !{i32* %j}, metadata !45), !dbg !46
  %9 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 1), align 4, !dbg !46
  %10 = load i32* getelementptr inbounds (%struct.dim3* @blockDim, i32 0, i32 1), align 4, !dbg !46
  %11 = mul i32 %9, %10, !dbg !46
  %12 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 1), align 4, !dbg !46
  %13 = add i32 %11, %12, !dbg !46
  store i32 %13, i32* %j, align 4, !dbg !46
  %14 = load i32* %i, align 4, !dbg !47
  %15 = load i32* %j, align 4, !dbg !47
  %16 = icmp sle i32 %14, %15, !dbg !47
  br i1 %16, label %21, label %17, !dbg !47

; <label>:17                                      ; preds = %0
  %18 = load i32* %i, align 4, !dbg !47
  %19 = load i32* %2, align 4, !dbg !47
  %20 = icmp sge i32 %18, %19, !dbg !47
  br i1 %20, label %21, label %22, !dbg !47

; <label>:21                                      ; preds = %17, %0
  br label %42, !dbg !48

; <label>:22                                      ; preds = %17
  call void @llvm.dbg.declare(metadata !{i32* %index_1}, metadata !49), !dbg !50
  %23 = load i32* %i, align 4, !dbg !50
  %24 = load i32* %3, align 4, !dbg !50
  %25 = mul nsw i32 %23, %24, !dbg !50
  %26 = load i32* %j, align 4, !dbg !50
  %27 = add nsw i32 %25, %26, !dbg !50
  store i32 %27, i32* %index_1, align 4, !dbg !50
  call void @llvm.dbg.declare(metadata !{i32* %index_2}, metadata !51), !dbg !52
  %28 = load i32* %j, align 4, !dbg !52
  %29 = load i32* %3, align 4, !dbg !52
  %30 = mul nsw i32 %28, %29, !dbg !52
  %31 = load i32* %i, align 4, !dbg !52
  %32 = add nsw i32 %30, %31, !dbg !52
  store i32 %32, i32* %index_2, align 4, !dbg !52
  %33 = load i32* %index_1, align 4, !dbg !53
  %34 = sext i32 %33 to i64, !dbg !53
  %35 = load float** %1, align 8, !dbg !53
  %36 = getelementptr inbounds float* %35, i64 %34, !dbg !53
  %37 = load float* %36, align 4, !dbg !53
  %38 = load i32* %index_2, align 4, !dbg !53
  %39 = sext i32 %38 to i64, !dbg !53
  %40 = load float** %1, align 8, !dbg !53
  %41 = getelementptr inbounds float* %40, i64 %39, !dbg !53
  store float %37, float* %41, align 4, !dbg !53
  br label %42, !dbg !54

; <label>:42                                      ; preds = %22, %21
  ret void, !dbg !54
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
  call void @llvm.dbg.declare(metadata !{float** %1}, metadata !55), !dbg !56
  store i32 %rows, i32* %2, align 4
  call void @llvm.dbg.declare(metadata !{i32* %2}, metadata !57), !dbg !56
  store i32 %stride, i32* %3, align 4
  call void @llvm.dbg.declare(metadata !{i32* %3}, metadata !58), !dbg !56
  call void @llvm.dbg.declare(metadata !{i32* %i}, metadata !59), !dbg !61
  %4 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 0), align 4, !dbg !61
  %5 = load i32* getelementptr inbounds (%struct.dim3* @blockDim, i32 0, i32 0), align 4, !dbg !61
  %6 = mul i32 %4, %5, !dbg !61
  %7 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !61
  %8 = add i32 %6, %7, !dbg !61
  store i32 %8, i32* %i, align 4, !dbg !61
  call void @llvm.dbg.declare(metadata !{i32* %j}, metadata !62), !dbg !63
  %9 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 1), align 4, !dbg !63
  %10 = load i32* getelementptr inbounds (%struct.dim3* @blockDim, i32 0, i32 1), align 4, !dbg !63
  %11 = mul i32 %9, %10, !dbg !63
  %12 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 1), align 4, !dbg !63
  %13 = add i32 %11, %12, !dbg !63
  store i32 %13, i32* %j, align 4, !dbg !63
  %14 = load i32* %j, align 4, !dbg !64
  %15 = load i32* %i, align 4, !dbg !64
  %16 = icmp sle i32 %14, %15, !dbg !64
  br i1 %16, label %21, label %17, !dbg !64

; <label>:17                                      ; preds = %0
  %18 = load i32* %j, align 4, !dbg !64
  %19 = load i32* %2, align 4, !dbg !64
  %20 = icmp sge i32 %18, %19, !dbg !64
  br i1 %20, label %21, label %22, !dbg !64

; <label>:21                                      ; preds = %17, %0
  br label %42, !dbg !65

; <label>:22                                      ; preds = %17
  call void @llvm.dbg.declare(metadata !{i32* %index_1}, metadata !66), !dbg !67
  %23 = load i32* %i, align 4, !dbg !67
  %24 = load i32* %3, align 4, !dbg !67
  %25 = mul nsw i32 %23, %24, !dbg !67
  %26 = load i32* %j, align 4, !dbg !67
  %27 = add nsw i32 %25, %26, !dbg !67
  store i32 %27, i32* %index_1, align 4, !dbg !67
  call void @llvm.dbg.declare(metadata !{i32* %index_2}, metadata !68), !dbg !69
  %28 = load i32* %j, align 4, !dbg !69
  %29 = load i32* %3, align 4, !dbg !69
  %30 = mul nsw i32 %28, %29, !dbg !69
  %31 = load i32* %i, align 4, !dbg !69
  %32 = add nsw i32 %30, %31, !dbg !69
  store i32 %32, i32* %index_2, align 4, !dbg !69
  %33 = load i32* %index_1, align 4, !dbg !70
  %34 = sext i32 %33 to i64, !dbg !70
  %35 = load float** %1, align 8, !dbg !70
  %36 = getelementptr inbounds float* %35, i64 %34, !dbg !70
  %37 = load float* %36, align 4, !dbg !70
  %38 = load i32* %index_2, align 4, !dbg !70
  %39 = sext i32 %38 to i64, !dbg !70
  %40 = load float** %1, align 8, !dbg !70
  %41 = getelementptr inbounds float* %40, i64 %39, !dbg !70
  store float %37, float* %41, align 4, !dbg !70
  br label %42, !dbg !71

; <label>:42                                      ; preds = %22, %21
  ret void, !dbg !71
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
  call void @llvm.dbg.declare(metadata !{float* %1}, metadata !72), !dbg !73
  store float* %mat, float** %2, align 8
  call void @llvm.dbg.declare(metadata !{float** %2}, metadata !74), !dbg !73
  store i32 %stride, i32* %3, align 4
  call void @llvm.dbg.declare(metadata !{i32* %3}, metadata !75), !dbg !73
  store i32 %rows, i32* %4, align 4
  call void @llvm.dbg.declare(metadata !{i32* %4}, metadata !76), !dbg !73
  store i32 %cols, i32* %5, align 4
  call void @llvm.dbg.declare(metadata !{i32* %5}, metadata !77), !dbg !73
  store float* %vec, float** %6, align 8
  call void @llvm.dbg.declare(metadata !{float** %6}, metadata !78), !dbg !79
  store float* %mat2, float** %7, align 8
  call void @llvm.dbg.declare(metadata !{float** %7}, metadata !80), !dbg !79
  store i32 %mat2_row_stride, i32* %8, align 4
  call void @llvm.dbg.declare(metadata !{i32* %8}, metadata !81), !dbg !82
  store i32 %mat2_col_stride, i32* %9, align 4
  call void @llvm.dbg.declare(metadata !{i32* %9}, metadata !83), !dbg !82
  store float %beta, float* %10, align 4
  call void @llvm.dbg.declare(metadata !{float* %10}, metadata !84), !dbg !85
  call void @llvm.dbg.declare(metadata !{i32* %i}, metadata !86), !dbg !88
  %11 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 0), align 4, !dbg !88
  %12 = load i32* getelementptr inbounds (%struct.dim3* @blockDim, i32 0, i32 0), align 4, !dbg !88
  %13 = mul i32 %11, %12, !dbg !88
  %14 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !88
  %15 = add i32 %13, %14, !dbg !88
  store i32 %15, i32* %i, align 4, !dbg !88
  call void @llvm.dbg.declare(metadata !{i32* %j}, metadata !89), !dbg !90
  %16 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 1), align 4, !dbg !90
  %17 = load i32* getelementptr inbounds (%struct.dim3* @blockDim, i32 0, i32 1), align 4, !dbg !90
  %18 = mul i32 %16, %17, !dbg !90
  %19 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 1), align 4, !dbg !90
  %20 = add i32 %18, %19, !dbg !90
  store i32 %20, i32* %j, align 4, !dbg !90
  call void @llvm.dbg.declare(metadata !{i32* %index}, metadata !91), !dbg !92
  %21 = load i32* %j, align 4, !dbg !93
  %22 = load i32* %3, align 4, !dbg !93
  %23 = mul nsw i32 %21, %22, !dbg !93
  %24 = load i32* %i, align 4, !dbg !93
  %25 = add nsw i32 %23, %24, !dbg !93
  store i32 %25, i32* %index, align 4, !dbg !93
  call void @llvm.dbg.declare(metadata !{i32* %index2}, metadata !94), !dbg !92
  %26 = load i32* %j, align 4, !dbg !93
  %27 = load i32* %8, align 4, !dbg !93
  %28 = mul nsw i32 %26, %27, !dbg !93
  %29 = load i32* %i, align 4, !dbg !93
  %30 = load i32* %9, align 4, !dbg !93
  %31 = mul nsw i32 %29, %30, !dbg !93
  %32 = add nsw i32 %28, %31, !dbg !93
  store i32 %32, i32* %index2, align 4, !dbg !93
  %33 = load i32* %i, align 4, !dbg !95
  %34 = load i32* %5, align 4, !dbg !95
  %35 = icmp slt i32 %33, %34, !dbg !95
  br i1 %35, label %36, label %66, !dbg !95

; <label>:36                                      ; preds = %0
  %37 = load i32* %j, align 4, !dbg !95
  %38 = load i32* %4, align 4, !dbg !95
  %39 = icmp slt i32 %37, %38, !dbg !95
  br i1 %39, label %40, label %66, !dbg !95

; <label>:40                                      ; preds = %36
  %41 = load float* %1, align 4, !dbg !96
  %42 = load i32* %j, align 4, !dbg !96
  %43 = sext i32 %42 to i64, !dbg !96
  %44 = load float** %6, align 8, !dbg !96
  %45 = getelementptr inbounds float* %44, i64 %43, !dbg !96
  %46 = load float* %45, align 4, !dbg !96
  %47 = fmul float %41, %46, !dbg !96
  %48 = load i32* %index2, align 4, !dbg !96
  %49 = sext i32 %48 to i64, !dbg !96
  %50 = load float** %7, align 8, !dbg !96
  %51 = getelementptr inbounds float* %50, i64 %49, !dbg !96
  %52 = load float* %51, align 4, !dbg !96
  %53 = fmul float %47, %52, !dbg !96
  %54 = load float* %10, align 4, !dbg !96
  %55 = load i32* %index, align 4, !dbg !96
  %56 = sext i32 %55 to i64, !dbg !96
  %57 = load float** %2, align 8, !dbg !96
  %58 = getelementptr inbounds float* %57, i64 %56, !dbg !96
  %59 = load float* %58, align 4, !dbg !96
  %60 = fmul float %54, %59, !dbg !96
  %61 = fadd float %53, %60, !dbg !96
  %62 = load i32* %index, align 4, !dbg !96
  %63 = sext i32 %62 to i64, !dbg !96
  %64 = load float** %2, align 8, !dbg !96
  %65 = getelementptr inbounds float* %64, i64 %63, !dbg !96
  store float %61, float* %65, align 4, !dbg !96
  br label %66, !dbg !98

; <label>:66                                      ; preds = %40, %36, %0
  ret void, !dbg !99
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
  call void @llvm.dbg.declare(metadata !{float** %1}, metadata !100), !dbg !101
  store float* %B, float** %2, align 8
  call void @llvm.dbg.declare(metadata !{float** %2}, metadata !102), !dbg !101
  store i32 %dmat_cols, i32* %3, align 4
  call void @llvm.dbg.declare(metadata !{i32* %3}, metadata !103), !dbg !101
  store i32 %dmat_rows, i32* %4, align 4
  call void @llvm.dbg.declare(metadata !{i32* %4}, metadata !104), !dbg !101
  store i32 %dmat_stride, i32* %5, align 4
  call void @llvm.dbg.declare(metadata !{i32* %5}, metadata !105), !dbg !101
  call void @llvm.dbg.declare(metadata !{i32* %i}, metadata !106), !dbg !108
  %6 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 0), align 4, !dbg !108
  %7 = load i32* getelementptr inbounds (%struct.dim3* @blockDim, i32 0, i32 0), align 4, !dbg !108
  %8 = mul i32 %6, %7, !dbg !108
  %9 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !108
  %10 = add i32 %8, %9, !dbg !108
  store i32 %10, i32* %i, align 4, !dbg !108
  call void @llvm.dbg.declare(metadata !{i32* %j}, metadata !109), !dbg !110
  %11 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 1), align 4, !dbg !110
  %12 = load i32* getelementptr inbounds (%struct.dim3* @blockDim, i32 0, i32 1), align 4, !dbg !110
  %13 = mul i32 %11, %12, !dbg !110
  %14 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 1), align 4, !dbg !110
  %15 = add i32 %13, %14, !dbg !110
  store i32 %15, i32* %j, align 4, !dbg !110
  %16 = load i32* %i, align 4, !dbg !111
  %17 = load i32* %3, align 4, !dbg !111
  %18 = icmp slt i32 %16, %17, !dbg !111
  br i1 %18, label %19, label %55, !dbg !111

; <label>:19                                      ; preds = %0
  %20 = load i32* %j, align 4, !dbg !111
  %21 = load i32* %4, align 4, !dbg !111
  %22 = icmp slt i32 %20, %21, !dbg !111
  br i1 %22, label %23, label %55, !dbg !111

; <label>:23                                      ; preds = %19
  call void @llvm.dbg.declare(metadata !{i32* %index_B}, metadata !112), !dbg !114
  %24 = load i32* %j, align 4, !dbg !114
  %25 = load i32* %j, align 4, !dbg !114
  %26 = add nsw i32 %25, 1, !dbg !114
  %27 = mul nsw i32 %24, %26, !dbg !114
  %28 = sdiv i32 %27, 2, !dbg !114
  %29 = load i32* %i, align 4, !dbg !114
  %30 = add nsw i32 %28, %29, !dbg !114
  store i32 %30, i32* %index_B, align 4, !dbg !114
  call void @llvm.dbg.declare(metadata !{i32* %index_A}, metadata !115), !dbg !116
  %31 = load i32* %j, align 4, !dbg !116
  %32 = load i32* %5, align 4, !dbg !116
  %33 = mul nsw i32 %31, %32, !dbg !116
  %34 = load i32* %i, align 4, !dbg !116
  %35 = add nsw i32 %33, %34, !dbg !116
  store i32 %35, i32* %index_A, align 4, !dbg !116
  %36 = load i32* %i, align 4, !dbg !117
  %37 = load i32* %j, align 4, !dbg !117
  %38 = icmp sle i32 %36, %37, !dbg !117
  br i1 %38, label %39, label %49, !dbg !117

; <label>:39                                      ; preds = %23
  %40 = load i32* %index_B, align 4, !dbg !118
  %41 = sext i32 %40 to i64, !dbg !118
  %42 = load float** %2, align 8, !dbg !118
  %43 = getelementptr inbounds float* %42, i64 %41, !dbg !118
  %44 = load float* %43, align 4, !dbg !118
  %45 = load i32* %index_A, align 4, !dbg !118
  %46 = sext i32 %45 to i64, !dbg !118
  %47 = load float** %1, align 8, !dbg !118
  %48 = getelementptr inbounds float* %47, i64 %46, !dbg !118
  store float %44, float* %48, align 4, !dbg !118
  br label %54, !dbg !120

; <label>:49                                      ; preds = %23
  %50 = load i32* %index_A, align 4, !dbg !121
  %51 = sext i32 %50 to i64, !dbg !121
  %52 = load float** %1, align 8, !dbg !121
  %53 = getelementptr inbounds float* %52, i64 %51, !dbg !121
  store float 0.000000e+00, float* %53, align 4, !dbg !121
  br label %54

; <label>:54                                      ; preds = %49, %39
  br label %55, !dbg !123

; <label>:55                                      ; preds = %54, %19, %0
  ret void, !dbg !124
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
  call void @llvm.dbg.declare(metadata !{float** %1}, metadata !125), !dbg !126
  store float* %mat_in, float** %2, align 8
  call void @llvm.dbg.declare(metadata !{float** %2}, metadata !127), !dbg !126
  store i32 %d_out_stride, i32* %3, align 4
  call void @llvm.dbg.declare(metadata !{i32* %3}, metadata !128), !dbg !129
  store i32 %d_out_rows, i32* %4, align 4
  call void @llvm.dbg.declare(metadata !{i32* %4}, metadata !130), !dbg !129
  store i32 %d_out_cols, i32* %5, align 4
  call void @llvm.dbg.declare(metadata !{i32* %5}, metadata !131), !dbg !129
  store i32 %d_in_stride, i32* %6, align 4
  call void @llvm.dbg.declare(metadata !{i32* %6}, metadata !132), !dbg !129
  call void @llvm.dbg.declare(metadata !{i32* %i}, metadata !133), !dbg !135
  %7 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 0), align 4, !dbg !135
  %8 = load i32* getelementptr inbounds (%struct.dim3* @blockDim, i32 0, i32 0), align 4, !dbg !135
  %9 = mul i32 %7, %8, !dbg !135
  %10 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !135
  %11 = add i32 %9, %10, !dbg !135
  store i32 %11, i32* %i, align 4, !dbg !135
  call void @llvm.dbg.declare(metadata !{i32* %j}, metadata !136), !dbg !137
  %12 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 1), align 4, !dbg !137
  %13 = load i32* getelementptr inbounds (%struct.dim3* @blockDim, i32 0, i32 1), align 4, !dbg !137
  %14 = mul i32 %12, %13, !dbg !137
  %15 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 1), align 4, !dbg !137
  %16 = add i32 %14, %15, !dbg !137
  store i32 %16, i32* %j, align 4, !dbg !137
  call void @llvm.dbg.declare(metadata !{i32* %index_out}, metadata !138), !dbg !139
  %17 = load i32* %i, align 4, !dbg !139
  %18 = load i32* %j, align 4, !dbg !139
  %19 = load i32* %3, align 4, !dbg !139
  %20 = mul nsw i32 %18, %19, !dbg !139
  %21 = add nsw i32 %17, %20, !dbg !139
  store i32 %21, i32* %index_out, align 4, !dbg !139
  call void @llvm.dbg.declare(metadata !{i32* %index_in}, metadata !140), !dbg !141
  %22 = load i32* %i, align 4, !dbg !141
  %23 = load i32* %j, align 4, !dbg !141
  %24 = load i32* %6, align 4, !dbg !141
  %25 = mul nsw i32 %23, %24, !dbg !141
  %26 = add nsw i32 %22, %25, !dbg !141
  store i32 %26, i32* %index_in, align 4, !dbg !141
  %27 = load i32* %i, align 4, !dbg !142
  %28 = load i32* %5, align 4, !dbg !142
  %29 = icmp slt i32 %27, %28, !dbg !142
  br i1 %29, label %30, label %44, !dbg !142

; <label>:30                                      ; preds = %0
  %31 = load i32* %j, align 4, !dbg !142
  %32 = load i32* %4, align 4, !dbg !142
  %33 = icmp slt i32 %31, %32, !dbg !142
  br i1 %33, label %34, label %44, !dbg !142

; <label>:34                                      ; preds = %30
  %35 = load i32* %index_in, align 4, !dbg !143
  %36 = sext i32 %35 to i64, !dbg !143
  %37 = load float** %2, align 8, !dbg !143
  %38 = getelementptr inbounds float* %37, i64 %36, !dbg !143
  %39 = load float* %38, align 4, !dbg !143
  %40 = load i32* %index_out, align 4, !dbg !143
  %41 = sext i32 %40 to i64, !dbg !143
  %42 = load float** %1, align 8, !dbg !143
  %43 = getelementptr inbounds float* %42, i64 %41, !dbg !143
  store float %39, float* %43, align 4, !dbg !143
  br label %44, !dbg !143

; <label>:44                                      ; preds = %34, %30, %0
  ret void, !dbg !144
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
  call void @llvm.dbg.declare(metadata !{float** %1}, metadata !145), !dbg !146
  store float* %B, float** %2, align 8
  call void @llvm.dbg.declare(metadata !{float** %2}, metadata !147), !dbg !146
  store i32 %dA_rows, i32* %3, align 4
  call void @llvm.dbg.declare(metadata !{i32* %3}, metadata !148), !dbg !146
  store i32 %dA_cols, i32* %4, align 4
  call void @llvm.dbg.declare(metadata !{i32* %4}, metadata !149), !dbg !146
  store i32 %dA_stride, i32* %5, align 4
  call void @llvm.dbg.declare(metadata !{i32* %5}, metadata !150), !dbg !146
  store i32 %B_stride, i32* %6, align 4
  call void @llvm.dbg.declare(metadata !{i32* %6}, metadata !151), !dbg !152
  store float* %value, float** %7, align 8
  call void @llvm.dbg.declare(metadata !{float** %7}, metadata !153), !dbg !152
  call void @llvm.dbg.declare(metadata !{i32* %tid}, metadata !154), !dbg !156
  %8 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 1), align 4, !dbg !156
  %9 = load i32* getelementptr inbounds (%struct.dim3* @blockDim, i32 0, i32 0), align 4, !dbg !156
  %10 = mul i32 %8, %9, !dbg !156
  %11 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !156
  %12 = add i32 %10, %11, !dbg !156
  store i32 %12, i32* %tid, align 4, !dbg !156
  call void @llvm.dbg.declare(metadata !{i32* %j}, metadata !157), !dbg !158
  %13 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 0), align 4, !dbg !158
  %14 = load i32* getelementptr inbounds (%struct.dim3* @blockDim, i32 0, i32 0), align 4, !dbg !158
  %15 = mul i32 %13, %14, !dbg !158
  %16 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !158
  %17 = add i32 %15, %16, !dbg !158
  store i32 %17, i32* %j, align 4, !dbg !158
  call void @llvm.dbg.declare(metadata !{i32* %grid_height}, metadata !159), !dbg !160
  %18 = load i32* getelementptr inbounds (%struct.dim3* @gridDim, i32 0, i32 1), align 4, !dbg !160
  %19 = load i32* getelementptr inbounds (%struct.dim3* @blockDim, i32 0, i32 1), align 4, !dbg !160
  %20 = mul i32 %18, %19, !dbg !160
  store i32 %20, i32* %grid_height, align 4, !dbg !160
  call void @llvm.dbg.declare(metadata !{i32* %i}, metadata !161), !dbg !162
  %21 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 1), align 4, !dbg !162
  %22 = load i32* getelementptr inbounds (%struct.dim3* @blockDim, i32 0, i32 1), align 4, !dbg !162
  %23 = mul i32 %21, %22, !dbg !162
  %24 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 1), align 4, !dbg !162
  %25 = add i32 %23, %24, !dbg !162
  store i32 %25, i32* %i, align 4, !dbg !162
  call void @llvm.dbg.declare(metadata !{float* %tsum}, metadata !163), !dbg !164
  store float 0.000000e+00, float* %tsum, align 4, !dbg !164
  %26 = load i32* %j, align 4, !dbg !165
  %27 = load i32* %4, align 4, !dbg !165
  %28 = icmp slt i32 %26, %27, !dbg !165
  br i1 %28, label %29, label %60, !dbg !165

; <label>:29                                      ; preds = %0
  br label %30, !dbg !166

; <label>:30                                      ; preds = %34, %29
  %31 = load i32* %i, align 4, !dbg !166
  %32 = load i32* %3, align 4, !dbg !166
  %33 = icmp slt i32 %31, %32, !dbg !166
  br i1 %33, label %34, label %59, !dbg !166

; <label>:34                                      ; preds = %30
  %35 = load i32* %i, align 4, !dbg !168
  %36 = load i32* %5, align 4, !dbg !168
  %37 = mul nsw i32 %35, %36, !dbg !168
  %38 = load i32* %j, align 4, !dbg !168
  %39 = add nsw i32 %37, %38, !dbg !168
  %40 = sext i32 %39 to i64, !dbg !168
  %41 = load float** %1, align 8, !dbg !168
  %42 = getelementptr inbounds float* %41, i64 %40, !dbg !168
  %43 = load float* %42, align 4, !dbg !168
  %44 = load i32* %i, align 4, !dbg !168
  %45 = load i32* %6, align 4, !dbg !168
  %46 = mul nsw i32 %44, %45, !dbg !168
  %47 = load i32* %j, align 4, !dbg !168
  %48 = add nsw i32 %46, %47, !dbg !168
  %49 = sext i32 %48 to i64, !dbg !168
  %50 = load float** %2, align 8, !dbg !168
  %51 = getelementptr inbounds float* %50, i64 %49, !dbg !168
  %52 = load float* %51, align 4, !dbg !168
  %53 = fmul float %43, %52, !dbg !168
  %54 = load float* %tsum, align 4, !dbg !168
  %55 = fadd float %54, %53, !dbg !168
  store float %55, float* %tsum, align 4, !dbg !168
  %56 = load i32* %grid_height, align 4, !dbg !170
  %57 = load i32* %i, align 4, !dbg !170
  %58 = add nsw i32 %57, %56, !dbg !170
  store i32 %58, i32* %i, align 4, !dbg !170
  br label %30, !dbg !171

; <label>:59                                      ; preds = %30
  br label %60, !dbg !172

; <label>:60                                      ; preds = %59, %0
  %61 = load float* %tsum, align 4, !dbg !173
  %62 = load i32* %tid, align 4, !dbg !173
  %63 = sext i32 %62 to i64, !dbg !173
  %64 = getelementptr inbounds [256 x float]* @_ZZ20_trace_mat_mat_transPKfS0_iiiiPfE4ssum, i32 0, i64 %63, !dbg !173
  store float %61, float* %64, align 4, !dbg !173
  call void @__syncthreads(), !dbg !174
  call void @llvm.dbg.declare(metadata !{i32* %shift}, metadata !175), !dbg !177
  store i32 128, i32* %shift, align 4, !dbg !177
  br label %65, !dbg !177

; <label>:65                                      ; preds = %86, %60
  %66 = load i32* %shift, align 4, !dbg !177
  %67 = load i32* @warpSize, align 4, !dbg !177
  %68 = icmp sgt i32 %66, %67, !dbg !177
  br i1 %68, label %69, label %89, !dbg !177

; <label>:69                                      ; preds = %65
  %70 = load i32* %tid, align 4, !dbg !178
  %71 = load i32* %shift, align 4, !dbg !178
  %72 = icmp slt i32 %70, %71, !dbg !178
  br i1 %72, label %73, label %85, !dbg !178

; <label>:73                                      ; preds = %69
  %74 = load i32* %tid, align 4, !dbg !180
  %75 = load i32* %shift, align 4, !dbg !180
  %76 = add nsw i32 %74, %75, !dbg !180
  %77 = sext i32 %76 to i64, !dbg !180
  %78 = getelementptr inbounds [256 x float]* @_ZZ20_trace_mat_mat_transPKfS0_iiiiPfE4ssum, i32 0, i64 %77, !dbg !180
  %79 = load float* %78, align 4, !dbg !180
  %80 = load i32* %tid, align 4, !dbg !180
  %81 = sext i32 %80 to i64, !dbg !180
  %82 = getelementptr inbounds [256 x float]* @_ZZ20_trace_mat_mat_transPKfS0_iiiiPfE4ssum, i32 0, i64 %81, !dbg !180
  %83 = load float* %82, align 4, !dbg !180
  %84 = fadd float %83, %79, !dbg !180
  store float %84, float* %82, align 4, !dbg !180
  br label %85, !dbg !180

; <label>:85                                      ; preds = %73, %69
  call void @__syncthreads(), !dbg !181
  br label %86, !dbg !182

; <label>:86                                      ; preds = %85
  %87 = load i32* %shift, align 4, !dbg !177
  %88 = ashr i32 %87, 1, !dbg !177
  store i32 %88, i32* %shift, align 4, !dbg !177
  br label %65, !dbg !177

; <label>:89                                      ; preds = %65
  %90 = load i32* %tid, align 4, !dbg !183
  %91 = load i32* @warpSize, align 4, !dbg !183
  %92 = icmp slt i32 %90, %91, !dbg !183
  br i1 %92, label %93, label %114, !dbg !183

; <label>:93                                      ; preds = %89
  call void @llvm.dbg.declare(metadata !{i32* %shift1}, metadata !184), !dbg !187
  %94 = load i32* @warpSize, align 4, !dbg !187
  store i32 %94, i32* %shift1, align 4, !dbg !187
  br label %95, !dbg !187

; <label>:95                                      ; preds = %110, %93
  %96 = load i32* %shift1, align 4, !dbg !187
  %97 = icmp sgt i32 %96, 0, !dbg !187
  br i1 %97, label %98, label %113, !dbg !187

; <label>:98                                      ; preds = %95
  %99 = load i32* %tid, align 4, !dbg !188
  %100 = load i32* %shift1, align 4, !dbg !188
  %101 = add nsw i32 %99, %100, !dbg !188
  %102 = sext i32 %101 to i64, !dbg !188
  %103 = getelementptr inbounds [256 x float]* @_ZZ20_trace_mat_mat_transPKfS0_iiiiPfE4ssum, i32 0, i64 %102, !dbg !188
  %104 = load float* %103, align 4, !dbg !188
  %105 = load i32* %tid, align 4, !dbg !188
  %106 = sext i32 %105 to i64, !dbg !188
  %107 = getelementptr inbounds [256 x float]* @_ZZ20_trace_mat_mat_transPKfS0_iiiiPfE4ssum, i32 0, i64 %106, !dbg !188
  %108 = load float* %107, align 4, !dbg !188
  %109 = fadd float %108, %104, !dbg !188
  store float %109, float* %107, align 4, !dbg !188
  br label %110, !dbg !190

; <label>:110                                     ; preds = %98
  %111 = load i32* %shift1, align 4, !dbg !187
  %112 = ashr i32 %111, 1, !dbg !187
  store i32 %112, i32* %shift1, align 4, !dbg !187
  br label %95, !dbg !187

; <label>:113                                     ; preds = %95
  br label %114, !dbg !191

; <label>:114                                     ; preds = %113, %89
  %115 = load i32* %tid, align 4, !dbg !192
  %116 = icmp eq i32 %115, 0, !dbg !192
  br i1 %116, label %117, label %127, !dbg !192

; <label>:117                                     ; preds = %114
  %118 = load float* getelementptr inbounds ([256 x float]* @_ZZ20_trace_mat_mat_transPKfS0_iiiiPfE4ssum, i32 0, i64 0), align 4, !dbg !193
  %119 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 1), align 4, !dbg !193
  %120 = load i32* getelementptr inbounds (%struct.dim3* @gridDim, i32 0, i32 0), align 4, !dbg !193
  %121 = mul i32 %119, %120, !dbg !193
  %122 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 0), align 4, !dbg !193
  %123 = add i32 %121, %122, !dbg !193
  %124 = zext i32 %123 to i64, !dbg !193
  %125 = load float** %7, align 8, !dbg !193
  %126 = getelementptr inbounds float* %125, i64 %124, !dbg !193
  store float %118, float* %126, align 4, !dbg !193
  br label %127, !dbg !195

; <label>:127                                     ; preds = %117, %114
  ret void, !dbg !196
}

declare void @__syncthreads() section "__device__"

define void @_Z7_splicePfPKfPKiiiiiii(float* %y, float* %x, i32* %off, i32 %d_out_cols, i32 %d_out_rows, i32 %d_out_stride, i32 %d_in_cols, i32 %d_in_rows, i32 %d_in_stride) nounwind uwtable noinline {
  %1 = alloca float*, align 8
  %2 = alloca float*, align 8
  %3 = alloca i32*, align 8
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  %index = alloca i32, align 4
  %src_col = alloca i32, align 4
  %src_row = alloca i32, align 4
  store float* %y, float** %1, align 8
  call void @llvm.dbg.declare(metadata !{float** %1}, metadata !197), !dbg !198
  store float* %x, float** %2, align 8
  call void @llvm.dbg.declare(metadata !{float** %2}, metadata !199), !dbg !198
  store i32* %off, i32** %3, align 8
  call void @llvm.dbg.declare(metadata !{i32** %3}, metadata !200), !dbg !198
  store i32 %d_out_cols, i32* %4, align 4
  call void @llvm.dbg.declare(metadata !{i32* %4}, metadata !201), !dbg !202
  store i32 %d_out_rows, i32* %5, align 4
  call void @llvm.dbg.declare(metadata !{i32* %5}, metadata !203), !dbg !202
  store i32 %d_out_stride, i32* %6, align 4
  call void @llvm.dbg.declare(metadata !{i32* %6}, metadata !204), !dbg !202
  store i32 %d_in_cols, i32* %7, align 4
  call void @llvm.dbg.declare(metadata !{i32* %7}, metadata !205), !dbg !206
  store i32 %d_in_rows, i32* %8, align 4
  call void @llvm.dbg.declare(metadata !{i32* %8}, metadata !207), !dbg !206
  store i32 %d_in_stride, i32* %9, align 4
  call void @llvm.dbg.declare(metadata !{i32* %9}, metadata !208), !dbg !206
  call void @llvm.dbg.declare(metadata !{i32* %i}, metadata !209), !dbg !211
  %10 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 0), align 4, !dbg !211
  %11 = load i32* getelementptr inbounds (%struct.dim3* @blockDim, i32 0, i32 0), align 4, !dbg !211
  %12 = mul i32 %10, %11, !dbg !211
  %13 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !211
  %14 = add i32 %12, %13, !dbg !211
  store i32 %14, i32* %i, align 4, !dbg !211
  call void @llvm.dbg.declare(metadata !{i32* %j}, metadata !212), !dbg !213
  %15 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 1), align 4, !dbg !213
  %16 = load i32* getelementptr inbounds (%struct.dim3* @blockDim, i32 0, i32 1), align 4, !dbg !213
  %17 = mul i32 %15, %16, !dbg !213
  %18 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 1), align 4, !dbg !213
  %19 = add i32 %17, %18, !dbg !213
  store i32 %19, i32* %j, align 4, !dbg !213
  call void @llvm.dbg.declare(metadata !{i32* %index}, metadata !214), !dbg !215
  %20 = load i32* %i, align 4, !dbg !215
  %21 = load i32* %j, align 4, !dbg !215
  %22 = load i32* %6, align 4, !dbg !215
  %23 = mul nsw i32 %21, %22, !dbg !215
  %24 = add nsw i32 %20, %23, !dbg !215
  store i32 %24, i32* %index, align 4, !dbg !215
  %25 = load i32* %i, align 4, !dbg !216
  %26 = load i32* %4, align 4, !dbg !216
  %27 = icmp slt i32 %25, %26, !dbg !216
  br i1 %27, label %28, label %69, !dbg !216

; <label>:28                                      ; preds = %0
  %29 = load i32* %j, align 4, !dbg !216
  %30 = load i32* %5, align 4, !dbg !216
  %31 = icmp slt i32 %29, %30, !dbg !216
  br i1 %31, label %32, label %69, !dbg !216

; <label>:32                                      ; preds = %28
  call void @llvm.dbg.declare(metadata !{i32* %src_col}, metadata !217), !dbg !219
  %33 = load i32* %i, align 4, !dbg !219
  %34 = load i32* %7, align 4, !dbg !219
  %35 = srem i32 %33, %34, !dbg !219
  store i32 %35, i32* %src_col, align 4, !dbg !219
  call void @llvm.dbg.declare(metadata !{i32* %src_row}, metadata !220), !dbg !221
  %36 = load i32* %j, align 4, !dbg !221
  %37 = load i32* %i, align 4, !dbg !221
  %38 = load i32* %7, align 4, !dbg !221
  %39 = sdiv i32 %37, %38, !dbg !221
  %40 = sext i32 %39 to i64, !dbg !221
  %41 = load i32** %3, align 8, !dbg !221
  %42 = getelementptr inbounds i32* %41, i64 %40, !dbg !221
  %43 = load i32* %42, align 4, !dbg !221
  %44 = add nsw i32 %36, %43, !dbg !221
  store i32 %44, i32* %src_row, align 4, !dbg !221
  %45 = load i32* %src_row, align 4, !dbg !222
  %46 = icmp slt i32 %45, 0, !dbg !222
  br i1 %46, label %47, label %48, !dbg !222

; <label>:47                                      ; preds = %32
  store i32 0, i32* %src_row, align 4, !dbg !223
  br label %48, !dbg !223

; <label>:48                                      ; preds = %47, %32
  %49 = load i32* %src_row, align 4, !dbg !224
  %50 = load i32* %8, align 4, !dbg !224
  %51 = icmp sge i32 %49, %50, !dbg !224
  br i1 %51, label %52, label %55, !dbg !224

; <label>:52                                      ; preds = %48
  %53 = load i32* %8, align 4, !dbg !225
  %54 = sub nsw i32 %53, 1, !dbg !225
  store i32 %54, i32* %src_row, align 4, !dbg !225
  br label %55, !dbg !225

; <label>:55                                      ; preds = %52, %48
  %56 = load i32* %src_col, align 4, !dbg !226
  %57 = load i32* %src_row, align 4, !dbg !226
  %58 = load i32* %9, align 4, !dbg !226
  %59 = mul nsw i32 %57, %58, !dbg !226
  %60 = add nsw i32 %56, %59, !dbg !226
  %61 = sext i32 %60 to i64, !dbg !226
  %62 = load float** %2, align 8, !dbg !226
  %63 = getelementptr inbounds float* %62, i64 %61, !dbg !226
  %64 = load float* %63, align 4, !dbg !226
  %65 = load i32* %index, align 4, !dbg !226
  %66 = sext i32 %65 to i64, !dbg !226
  %67 = load float** %1, align 8, !dbg !226
  %68 = getelementptr inbounds float* %67, i64 %66, !dbg !226
  store float %64, float* %68, align 4, !dbg !226
  br label %69, !dbg !227

; <label>:69                                      ; preds = %55, %28, %0
  ret void, !dbg !228
}

!llvm.dbg.cu = !{!0}

!0 = metadata !{i32 786449, i32 0, i32 4, metadata !"new-func.cpp", metadata !"/home/mingyuanwu/kaldi-new-bug", metadata !"clang version 3.2 (tags/RELEASE_32/final)", i1 true, i1 false, metadata !"", i32 0, metadata !1, metadata !1, metadata !3, metadata !32} ; [ DW_TAG_compile_unit ] [/home/mingyuanwu/kaldi-new-bug/new-func.cpp] [DW_LANG_C_plus_plus]
!1 = metadata !{metadata !2}
!2 = metadata !{i32 0}
!3 = metadata !{metadata !4}
!4 = metadata !{metadata !5, metadata !12, metadata !13, metadata !18, metadata !21, metadata !24, metadata !27}
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
!27 = metadata !{i32 786478, i32 0, metadata !6, metadata !"_splice", metadata !"_splice", metadata !"_Z7_splicePfPKfPKiiiiiii", metadata !6, i32 119, metadata !28, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, void (float*, float*, i32*, i32, i32, i32, i32, i32, i32)* @_Z7_splicePfPKfPKiiiiiii, null, null, metadata !1, i32 121} ; [ DW_TAG_subprogram ] [line 119] [def] [scope 121] [_splice]
!28 = metadata !{i32 786453, i32 0, metadata !"", i32 0, i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !29, i32 0, i32 0} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!29 = metadata !{null, metadata !9, metadata !16, metadata !30, metadata !11, metadata !11, metadata !11, metadata !11, metadata !11, metadata !11}
!30 = metadata !{i32 786447, null, metadata !"", null, i32 0, i64 64, i64 64, i64 0, i32 0, metadata !31} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from ]
!31 = metadata !{i32 786470, null, metadata !"", null, i32 0, i64 0, i64 0, i64 0, i32 0, metadata !11} ; [ DW_TAG_const_type ] [line 0, size 0, align 0, offset 0] [from int]
!32 = metadata !{metadata !33}
!33 = metadata !{metadata !34}
!34 = metadata !{i32 786484, i32 0, metadata !24, metadata !"ssum", metadata !"ssum", metadata !"", metadata !6, i32 79, metadata !35, i32 1, i32 1, [256 x float]* @_ZZ20_trace_mat_mat_transPKfS0_iiiiPfE4ssum} ; [ DW_TAG_variable ] [ssum] [line 79] [local] [def]
!35 = metadata !{i32 786433, null, metadata !"", null, i32 0, i64 8192, i64 32, i32 0, i32 0, metadata !10, metadata !36, i32 0, i32 0} ; [ DW_TAG_array_type ] [line 0, size 8192, align 32, offset 0] [from float]
!36 = metadata !{metadata !37}
!37 = metadata !{i32 786465, i64 0, i64 255}      ; [ DW_TAG_subrange_type ] [0, 255]
!38 = metadata !{i32 786689, metadata !5, metadata !"A", metadata !6, i32 16777220, metadata !9, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [A] [line 4]
!39 = metadata !{i32 4, i32 0, metadata !5, null}
!40 = metadata !{i32 786689, metadata !5, metadata !"rows", metadata !6, i32 33554436, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [rows] [line 4]
!41 = metadata !{i32 786689, metadata !5, metadata !"stride", metadata !6, i32 50331652, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [stride] [line 4]
!42 = metadata !{i32 786688, metadata !43, metadata !"i", metadata !6, i32 5, metadata !11, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [i] [line 5]
!43 = metadata !{i32 786443, metadata !5, i32 4, i32 0, metadata !6, i32 0} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/kaldi-new-bug/new-func.cpp]
!44 = metadata !{i32 5, i32 0, metadata !43, null}
!45 = metadata !{i32 786688, metadata !43, metadata !"j", metadata !6, i32 6, metadata !11, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [j] [line 6]
!46 = metadata !{i32 6, i32 0, metadata !43, null}
!47 = metadata !{i32 7, i32 0, metadata !43, null}
!48 = metadata !{i32 8, i32 0, metadata !43, null}
!49 = metadata !{i32 786688, metadata !43, metadata !"index_1", metadata !6, i32 9, metadata !11, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [index_1] [line 9]
!50 = metadata !{i32 9, i32 0, metadata !43, null}
!51 = metadata !{i32 786688, metadata !43, metadata !"index_2", metadata !6, i32 10, metadata !11, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [index_2] [line 10]
!52 = metadata !{i32 10, i32 0, metadata !43, null}
!53 = metadata !{i32 11, i32 0, metadata !43, null}
!54 = metadata !{i32 12, i32 0, metadata !43, null}
!55 = metadata !{i32 786689, metadata !12, metadata !"A", metadata !6, i32 16777237, metadata !9, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [A] [line 21]
!56 = metadata !{i32 21, i32 0, metadata !12, null}
!57 = metadata !{i32 786689, metadata !12, metadata !"rows", metadata !6, i32 33554453, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [rows] [line 21]
!58 = metadata !{i32 786689, metadata !12, metadata !"stride", metadata !6, i32 50331669, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [stride] [line 21]
!59 = metadata !{i32 786688, metadata !60, metadata !"i", metadata !6, i32 22, metadata !11, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [i] [line 22]
!60 = metadata !{i32 786443, metadata !12, i32 21, i32 0, metadata !6, i32 1} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/kaldi-new-bug/new-func.cpp]
!61 = metadata !{i32 22, i32 0, metadata !60, null}
!62 = metadata !{i32 786688, metadata !60, metadata !"j", metadata !6, i32 23, metadata !11, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [j] [line 23]
!63 = metadata !{i32 23, i32 0, metadata !60, null}
!64 = metadata !{i32 24, i32 0, metadata !60, null}
!65 = metadata !{i32 25, i32 0, metadata !60, null}
!66 = metadata !{i32 786688, metadata !60, metadata !"index_1", metadata !6, i32 26, metadata !11, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [index_1] [line 26]
!67 = metadata !{i32 26, i32 0, metadata !60, null}
!68 = metadata !{i32 786688, metadata !60, metadata !"index_2", metadata !6, i32 27, metadata !11, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [index_2] [line 27]
!69 = metadata !{i32 27, i32 0, metadata !60, null}
!70 = metadata !{i32 28, i32 0, metadata !60, null}
!71 = metadata !{i32 29, i32 0, metadata !60, null}
!72 = metadata !{i32 786689, metadata !13, metadata !"alpha", metadata !6, i32 16777249, metadata !10, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [alpha] [line 33]
!73 = metadata !{i32 33, i32 0, metadata !13, null}
!74 = metadata !{i32 786689, metadata !13, metadata !"mat", metadata !6, i32 33554465, metadata !9, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [mat] [line 33]
!75 = metadata !{i32 786689, metadata !13, metadata !"stride", metadata !6, i32 50331681, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [stride] [line 33]
!76 = metadata !{i32 786689, metadata !13, metadata !"rows", metadata !6, i32 67108897, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [rows] [line 33]
!77 = metadata !{i32 786689, metadata !13, metadata !"cols", metadata !6, i32 83886113, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [cols] [line 33]
!78 = metadata !{i32 786689, metadata !13, metadata !"vec", metadata !6, i32 100663330, metadata !16, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [vec] [line 34]
!79 = metadata !{i32 34, i32 0, metadata !13, null}
!80 = metadata !{i32 786689, metadata !13, metadata !"mat2", metadata !6, i32 117440546, metadata !16, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [mat2] [line 34]
!81 = metadata !{i32 786689, metadata !13, metadata !"mat2_row_stride", metadata !6, i32 134217763, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [mat2_row_stride] [line 35]
!82 = metadata !{i32 35, i32 0, metadata !13, null}
!83 = metadata !{i32 786689, metadata !13, metadata !"mat2_col_stride", metadata !6, i32 150994979, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [mat2_col_stride] [line 35]
!84 = metadata !{i32 786689, metadata !13, metadata !"beta", metadata !6, i32 167772196, metadata !10, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [beta] [line 36]
!85 = metadata !{i32 36, i32 0, metadata !13, null}
!86 = metadata !{i32 786688, metadata !87, metadata !"i", metadata !6, i32 37, metadata !11, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [i] [line 37]
!87 = metadata !{i32 786443, metadata !13, i32 36, i32 0, metadata !6, i32 2} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/kaldi-new-bug/new-func.cpp]
!88 = metadata !{i32 37, i32 0, metadata !87, null}
!89 = metadata !{i32 786688, metadata !87, metadata !"j", metadata !6, i32 38, metadata !11, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [j] [line 38]
!90 = metadata !{i32 38, i32 0, metadata !87, null}
!91 = metadata !{i32 786688, metadata !87, metadata !"index", metadata !6, i32 40, metadata !11, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [index] [line 40]
!92 = metadata !{i32 40, i32 0, metadata !87, null}
!93 = metadata !{i32 41, i32 0, metadata !87, null}
!94 = metadata !{i32 786688, metadata !87, metadata !"index2", metadata !6, i32 40, metadata !11, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [index2] [line 40]
!95 = metadata !{i32 43, i32 0, metadata !87, null}
!96 = metadata !{i32 44, i32 0, metadata !97, null}
!97 = metadata !{i32 786443, metadata !87, i32 43, i32 0, metadata !6, i32 3} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/kaldi-new-bug/new-func.cpp]
!98 = metadata !{i32 45, i32 0, metadata !97, null}
!99 = metadata !{i32 46, i32 0, metadata !87, null}
!100 = metadata !{i32 786689, metadata !18, metadata !"A", metadata !6, i32 16777265, metadata !9, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [A] [line 49]
!101 = metadata !{i32 49, i32 0, metadata !18, null}
!102 = metadata !{i32 786689, metadata !18, metadata !"B", metadata !6, i32 33554481, metadata !16, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [B] [line 49]
!103 = metadata !{i32 786689, metadata !18, metadata !"dmat_cols", metadata !6, i32 50331697, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [dmat_cols] [line 49]
!104 = metadata !{i32 786689, metadata !18, metadata !"dmat_rows", metadata !6, i32 67108913, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [dmat_rows] [line 49]
!105 = metadata !{i32 786689, metadata !18, metadata !"dmat_stride", metadata !6, i32 83886129, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [dmat_stride] [line 49]
!106 = metadata !{i32 786688, metadata !107, metadata !"i", metadata !6, i32 50, metadata !11, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [i] [line 50]
!107 = metadata !{i32 786443, metadata !18, i32 49, i32 0, metadata !6, i32 4} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/kaldi-new-bug/new-func.cpp]
!108 = metadata !{i32 50, i32 0, metadata !107, null}
!109 = metadata !{i32 786688, metadata !107, metadata !"j", metadata !6, i32 51, metadata !11, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [j] [line 51]
!110 = metadata !{i32 51, i32 0, metadata !107, null}
!111 = metadata !{i32 52, i32 0, metadata !107, null}
!112 = metadata !{i32 786688, metadata !113, metadata !"index_B", metadata !6, i32 53, metadata !11, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [index_B] [line 53]
!113 = metadata !{i32 786443, metadata !107, i32 52, i32 0, metadata !6, i32 5} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/kaldi-new-bug/new-func.cpp]
!114 = metadata !{i32 53, i32 0, metadata !113, null}
!115 = metadata !{i32 786688, metadata !113, metadata !"index_A", metadata !6, i32 54, metadata !11, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [index_A] [line 54]
!116 = metadata !{i32 54, i32 0, metadata !113, null}
!117 = metadata !{i32 55, i32 0, metadata !113, null}
!118 = metadata !{i32 56, i32 0, metadata !119, null}
!119 = metadata !{i32 786443, metadata !113, i32 55, i32 0, metadata !6, i32 6} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/kaldi-new-bug/new-func.cpp]
!120 = metadata !{i32 57, i32 0, metadata !119, null}
!121 = metadata !{i32 58, i32 0, metadata !122, null}
!122 = metadata !{i32 786443, metadata !113, i32 57, i32 0, metadata !6, i32 7} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/kaldi-new-bug/new-func.cpp]
!123 = metadata !{i32 60, i32 0, metadata !113, null}
!124 = metadata !{i32 61, i32 0, metadata !107, null}
!125 = metadata !{i32 786689, metadata !21, metadata !"mat_out", metadata !6, i32 16777281, metadata !9, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [mat_out] [line 65]
!126 = metadata !{i32 65, i32 0, metadata !21, null}
!127 = metadata !{i32 786689, metadata !21, metadata !"mat_in", metadata !6, i32 33554497, metadata !16, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [mat_in] [line 65]
!128 = metadata !{i32 786689, metadata !21, metadata !"d_out_stride", metadata !6, i32 50331714, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [d_out_stride] [line 66]
!129 = metadata !{i32 66, i32 0, metadata !21, null}
!130 = metadata !{i32 786689, metadata !21, metadata !"d_out_rows", metadata !6, i32 67108930, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [d_out_rows] [line 66]
!131 = metadata !{i32 786689, metadata !21, metadata !"d_out_cols", metadata !6, i32 83886146, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [d_out_cols] [line 66]
!132 = metadata !{i32 786689, metadata !21, metadata !"d_in_stride", metadata !6, i32 100663362, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [d_in_stride] [line 66]
!133 = metadata !{i32 786688, metadata !134, metadata !"i", metadata !6, i32 67, metadata !11, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [i] [line 67]
!134 = metadata !{i32 786443, metadata !21, i32 66, i32 0, metadata !6, i32 8} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/kaldi-new-bug/new-func.cpp]
!135 = metadata !{i32 67, i32 0, metadata !134, null}
!136 = metadata !{i32 786688, metadata !134, metadata !"j", metadata !6, i32 68, metadata !11, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [j] [line 68]
!137 = metadata !{i32 68, i32 0, metadata !134, null}
!138 = metadata !{i32 786688, metadata !134, metadata !"index_out", metadata !6, i32 69, metadata !11, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [index_out] [line 69]
!139 = metadata !{i32 69, i32 0, metadata !134, null}
!140 = metadata !{i32 786688, metadata !134, metadata !"index_in", metadata !6, i32 70, metadata !11, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [index_in] [line 70]
!141 = metadata !{i32 70, i32 0, metadata !134, null}
!142 = metadata !{i32 71, i32 0, metadata !134, null}
!143 = metadata !{i32 72, i32 0, metadata !134, null}
!144 = metadata !{i32 73, i32 0, metadata !134, null}
!145 = metadata !{i32 786689, metadata !24, metadata !"A", metadata !6, i32 16777293, metadata !16, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [A] [line 77]
!146 = metadata !{i32 77, i32 0, metadata !24, null}
!147 = metadata !{i32 786689, metadata !24, metadata !"B", metadata !6, i32 33554509, metadata !16, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [B] [line 77]
!148 = metadata !{i32 786689, metadata !24, metadata !"dA_rows", metadata !6, i32 50331725, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [dA_rows] [line 77]
!149 = metadata !{i32 786689, metadata !24, metadata !"dA_cols", metadata !6, i32 67108941, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [dA_cols] [line 77]
!150 = metadata !{i32 786689, metadata !24, metadata !"dA_stride", metadata !6, i32 83886157, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [dA_stride] [line 77]
!151 = metadata !{i32 786689, metadata !24, metadata !"B_stride", metadata !6, i32 100663374, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [B_stride] [line 78]
!152 = metadata !{i32 78, i32 0, metadata !24, null}
!153 = metadata !{i32 786689, metadata !24, metadata !"value", metadata !6, i32 117440590, metadata !9, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [value] [line 78]
!154 = metadata !{i32 786688, metadata !155, metadata !"tid", metadata !6, i32 81, metadata !31, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [tid] [line 81]
!155 = metadata !{i32 786443, metadata !24, i32 78, i32 0, metadata !6, i32 9} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/kaldi-new-bug/new-func.cpp]
!156 = metadata !{i32 81, i32 0, metadata !155, null}
!157 = metadata !{i32 786688, metadata !155, metadata !"j", metadata !6, i32 82, metadata !31, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [j] [line 82]
!158 = metadata !{i32 82, i32 0, metadata !155, null}
!159 = metadata !{i32 786688, metadata !155, metadata !"grid_height", metadata !6, i32 83, metadata !31, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [grid_height] [line 83]
!160 = metadata !{i32 83, i32 0, metadata !155, null}
!161 = metadata !{i32 786688, metadata !155, metadata !"i", metadata !6, i32 84, metadata !11, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [i] [line 84]
!162 = metadata !{i32 84, i32 0, metadata !155, null}
!163 = metadata !{i32 786688, metadata !155, metadata !"tsum", metadata !6, i32 87, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [tsum] [line 87]
!164 = metadata !{i32 87, i32 0, metadata !155, null}
!165 = metadata !{i32 88, i32 0, metadata !155, null}
!166 = metadata !{i32 89, i32 0, metadata !167, null}
!167 = metadata !{i32 786443, metadata !155, i32 88, i32 0, metadata !6, i32 10} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/kaldi-new-bug/new-func.cpp]
!168 = metadata !{i32 90, i32 0, metadata !169, null}
!169 = metadata !{i32 786443, metadata !167, i32 89, i32 0, metadata !6, i32 11} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/kaldi-new-bug/new-func.cpp]
!170 = metadata !{i32 91, i32 0, metadata !169, null}
!171 = metadata !{i32 92, i32 0, metadata !169, null}
!172 = metadata !{i32 93, i32 0, metadata !167, null}
!173 = metadata !{i32 94, i32 0, metadata !155, null}
!174 = metadata !{i32 95, i32 0, metadata !155, null}
!175 = metadata !{i32 786688, metadata !176, metadata !"shift", metadata !6, i32 98, metadata !11, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [shift] [line 98]
!176 = metadata !{i32 786443, metadata !155, i32 98, i32 0, metadata !6, i32 12} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/kaldi-new-bug/new-func.cpp]
!177 = metadata !{i32 98, i32 0, metadata !176, null}
!178 = metadata !{i32 99, i32 0, metadata !179, null}
!179 = metadata !{i32 786443, metadata !176, i32 98, i32 0, metadata !6, i32 13} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/kaldi-new-bug/new-func.cpp]
!180 = metadata !{i32 100, i32 0, metadata !179, null}
!181 = metadata !{i32 101, i32 0, metadata !179, null}
!182 = metadata !{i32 102, i32 0, metadata !179, null}
!183 = metadata !{i32 105, i32 0, metadata !155, null}
!184 = metadata !{i32 786688, metadata !185, metadata !"shift", metadata !6, i32 106, metadata !11, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [shift] [line 106]
!185 = metadata !{i32 786443, metadata !186, i32 106, i32 0, metadata !6, i32 15} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/kaldi-new-bug/new-func.cpp]
!186 = metadata !{i32 786443, metadata !155, i32 105, i32 0, metadata !6, i32 14} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/kaldi-new-bug/new-func.cpp]
!187 = metadata !{i32 106, i32 0, metadata !185, null}
!188 = metadata !{i32 107, i32 0, metadata !189, null}
!189 = metadata !{i32 786443, metadata !185, i32 106, i32 0, metadata !6, i32 16} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/kaldi-new-bug/new-func.cpp]
!190 = metadata !{i32 108, i32 0, metadata !189, null}
!191 = metadata !{i32 109, i32 0, metadata !186, null}
!192 = metadata !{i32 112, i32 0, metadata !155, null}
!193 = metadata !{i32 113, i32 0, metadata !194, null}
!194 = metadata !{i32 786443, metadata !155, i32 112, i32 0, metadata !6, i32 17} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/kaldi-new-bug/new-func.cpp]
!195 = metadata !{i32 114, i32 0, metadata !194, null}
!196 = metadata !{i32 115, i32 0, metadata !155, null}
!197 = metadata !{i32 786689, metadata !27, metadata !"y", metadata !6, i32 16777335, metadata !9, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [y] [line 119]
!198 = metadata !{i32 119, i32 0, metadata !27, null}
!199 = metadata !{i32 786689, metadata !27, metadata !"x", metadata !6, i32 33554551, metadata !16, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [x] [line 119]
!200 = metadata !{i32 786689, metadata !27, metadata !"off", metadata !6, i32 50331767, metadata !30, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [off] [line 119]
!201 = metadata !{i32 786689, metadata !27, metadata !"d_out_cols", metadata !6, i32 67108984, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [d_out_cols] [line 120]
!202 = metadata !{i32 120, i32 0, metadata !27, null}
!203 = metadata !{i32 786689, metadata !27, metadata !"d_out_rows", metadata !6, i32 83886200, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [d_out_rows] [line 120]
!204 = metadata !{i32 786689, metadata !27, metadata !"d_out_stride", metadata !6, i32 100663416, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [d_out_stride] [line 120]
!205 = metadata !{i32 786689, metadata !27, metadata !"d_in_cols", metadata !6, i32 117440633, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [d_in_cols] [line 121]
!206 = metadata !{i32 121, i32 0, metadata !27, null}
!207 = metadata !{i32 786689, metadata !27, metadata !"d_in_rows", metadata !6, i32 134217849, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [d_in_rows] [line 121]
!208 = metadata !{i32 786689, metadata !27, metadata !"d_in_stride", metadata !6, i32 150995065, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [d_in_stride] [line 121]
!209 = metadata !{i32 786688, metadata !210, metadata !"i", metadata !6, i32 122, metadata !11, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [i] [line 122]
!210 = metadata !{i32 786443, metadata !27, i32 121, i32 0, metadata !6, i32 18} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/kaldi-new-bug/new-func.cpp]
!211 = metadata !{i32 122, i32 0, metadata !210, null}
!212 = metadata !{i32 786688, metadata !210, metadata !"j", metadata !6, i32 123, metadata !11, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [j] [line 123]
!213 = metadata !{i32 123, i32 0, metadata !210, null}
!214 = metadata !{i32 786688, metadata !210, metadata !"index", metadata !6, i32 124, metadata !11, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [index] [line 124]
!215 = metadata !{i32 124, i32 0, metadata !210, null}
!216 = metadata !{i32 125, i32 0, metadata !210, null}
!217 = metadata !{i32 786688, metadata !218, metadata !"src_col", metadata !6, i32 126, metadata !11, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [src_col] [line 126]
!218 = metadata !{i32 786443, metadata !210, i32 125, i32 0, metadata !6, i32 19} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/kaldi-new-bug/new-func.cpp]
!219 = metadata !{i32 126, i32 0, metadata !218, null}
!220 = metadata !{i32 786688, metadata !218, metadata !"src_row", metadata !6, i32 127, metadata !11, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [src_row] [line 127]
!221 = metadata !{i32 127, i32 0, metadata !218, null}
!222 = metadata !{i32 128, i32 0, metadata !218, null}
!223 = metadata !{i32 129, i32 0, metadata !218, null}
!224 = metadata !{i32 130, i32 0, metadata !218, null}
!225 = metadata !{i32 131, i32 0, metadata !218, null}
!226 = metadata !{i32 132, i32 0, metadata !218, null}
!227 = metadata !{i32 133, i32 0, metadata !218, null}
!228 = metadata !{i32 134, i32 0, metadata !210, null}
