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
  call void @llvm.dbg.declare(metadata !{float** %1}, metadata !21), !dbg !22
  store i32 %rows, i32* %2, align 4
  call void @llvm.dbg.declare(metadata !{i32* %2}, metadata !23), !dbg !22
  store i32 %stride, i32* %3, align 4
  call void @llvm.dbg.declare(metadata !{i32* %3}, metadata !24), !dbg !22
  call void @llvm.dbg.declare(metadata !{i32* %i}, metadata !25), !dbg !27
  %4 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 0), align 4, !dbg !27
  %5 = load i32* getelementptr inbounds (%struct.dim3* @blockDim, i32 0, i32 0), align 4, !dbg !27
  %6 = mul i32 %4, %5, !dbg !27
  %7 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !27
  %8 = add i32 %6, %7, !dbg !27
  store i32 %8, i32* %i, align 4, !dbg !27
  call void @llvm.dbg.declare(metadata !{i32* %j}, metadata !28), !dbg !29
  %9 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 1), align 4, !dbg !29
  %10 = load i32* getelementptr inbounds (%struct.dim3* @blockDim, i32 0, i32 1), align 4, !dbg !29
  %11 = mul i32 %9, %10, !dbg !29
  %12 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 1), align 4, !dbg !29
  %13 = add i32 %11, %12, !dbg !29
  store i32 %13, i32* %j, align 4, !dbg !29
  %14 = load i32* %i, align 4, !dbg !30
  %15 = load i32* %j, align 4, !dbg !30
  %16 = icmp sle i32 %14, %15, !dbg !30
  br i1 %16, label %21, label %17, !dbg !30

; <label>:17                                      ; preds = %0
  %18 = load i32* %i, align 4, !dbg !30
  %19 = load i32* %2, align 4, !dbg !30
  %20 = icmp sge i32 %18, %19, !dbg !30
  br i1 %20, label %21, label %22, !dbg !30

; <label>:21                                      ; preds = %17, %0
  br label %42, !dbg !31

; <label>:22                                      ; preds = %17
  call void @llvm.dbg.declare(metadata !{i32* %index_1}, metadata !32), !dbg !33
  %23 = load i32* %i, align 4, !dbg !33
  %24 = load i32* %3, align 4, !dbg !33
  %25 = mul nsw i32 %23, %24, !dbg !33
  %26 = load i32* %j, align 4, !dbg !33
  %27 = add nsw i32 %25, %26, !dbg !33
  store i32 %27, i32* %index_1, align 4, !dbg !33
  call void @llvm.dbg.declare(metadata !{i32* %index_2}, metadata !34), !dbg !35
  %28 = load i32* %j, align 4, !dbg !35
  %29 = load i32* %3, align 4, !dbg !35
  %30 = mul nsw i32 %28, %29, !dbg !35
  %31 = load i32* %i, align 4, !dbg !35
  %32 = add nsw i32 %30, %31, !dbg !35
  store i32 %32, i32* %index_2, align 4, !dbg !35
  %33 = load i32* %index_1, align 4, !dbg !36
  %34 = sext i32 %33 to i64, !dbg !36
  %35 = load float** %1, align 8, !dbg !36
  %36 = getelementptr inbounds float* %35, i64 %34, !dbg !36
  %37 = load float* %36, align 4, !dbg !36
  %38 = load i32* %index_2, align 4, !dbg !36
  %39 = sext i32 %38 to i64, !dbg !36
  %40 = load float** %1, align 8, !dbg !36
  %41 = getelementptr inbounds float* %40, i64 %39, !dbg !36
  store float %37, float* %41, align 4, !dbg !36
  br label %42, !dbg !37

; <label>:42                                      ; preds = %22, %21
  ret void, !dbg !37
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
  %14 = load i32* %j, align 4, !dbg !47
  %15 = load i32* %i, align 4, !dbg !47
  %16 = icmp sle i32 %14, %15, !dbg !47
  br i1 %16, label %21, label %17, !dbg !47

; <label>:17                                      ; preds = %0
  %18 = load i32* %j, align 4, !dbg !47
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
  call void @llvm.dbg.declare(metadata !{float* %1}, metadata !55), !dbg !56
  store float* %mat, float** %2, align 8
  call void @llvm.dbg.declare(metadata !{float** %2}, metadata !57), !dbg !56
  store i32 %stride, i32* %3, align 4
  call void @llvm.dbg.declare(metadata !{i32* %3}, metadata !58), !dbg !56
  store i32 %rows, i32* %4, align 4
  call void @llvm.dbg.declare(metadata !{i32* %4}, metadata !59), !dbg !56
  store i32 %cols, i32* %5, align 4
  call void @llvm.dbg.declare(metadata !{i32* %5}, metadata !60), !dbg !56
  store float* %vec, float** %6, align 8
  call void @llvm.dbg.declare(metadata !{float** %6}, metadata !61), !dbg !62
  store float* %mat2, float** %7, align 8
  call void @llvm.dbg.declare(metadata !{float** %7}, metadata !63), !dbg !62
  store i32 %mat2_row_stride, i32* %8, align 4
  call void @llvm.dbg.declare(metadata !{i32* %8}, metadata !64), !dbg !65
  store i32 %mat2_col_stride, i32* %9, align 4
  call void @llvm.dbg.declare(metadata !{i32* %9}, metadata !66), !dbg !65
  store float %beta, float* %10, align 4
  call void @llvm.dbg.declare(metadata !{float* %10}, metadata !67), !dbg !68
  call void @llvm.dbg.declare(metadata !{i32* %i}, metadata !69), !dbg !71
  %11 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 0), align 4, !dbg !71
  %12 = load i32* getelementptr inbounds (%struct.dim3* @blockDim, i32 0, i32 0), align 4, !dbg !71
  %13 = mul i32 %11, %12, !dbg !71
  %14 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !71
  %15 = add i32 %13, %14, !dbg !71
  store i32 %15, i32* %i, align 4, !dbg !71
  call void @llvm.dbg.declare(metadata !{i32* %j}, metadata !72), !dbg !73
  %16 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 1), align 4, !dbg !73
  %17 = load i32* getelementptr inbounds (%struct.dim3* @blockDim, i32 0, i32 1), align 4, !dbg !73
  %18 = mul i32 %16, %17, !dbg !73
  %19 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 1), align 4, !dbg !73
  %20 = add i32 %18, %19, !dbg !73
  store i32 %20, i32* %j, align 4, !dbg !73
  call void @llvm.dbg.declare(metadata !{i32* %index}, metadata !74), !dbg !75
  %21 = load i32* %j, align 4, !dbg !76
  %22 = load i32* %3, align 4, !dbg !76
  %23 = mul nsw i32 %21, %22, !dbg !76
  %24 = load i32* %i, align 4, !dbg !76
  %25 = add nsw i32 %23, %24, !dbg !76
  store i32 %25, i32* %index, align 4, !dbg !76
  call void @llvm.dbg.declare(metadata !{i32* %index2}, metadata !77), !dbg !75
  %26 = load i32* %j, align 4, !dbg !76
  %27 = load i32* %8, align 4, !dbg !76
  %28 = mul nsw i32 %26, %27, !dbg !76
  %29 = load i32* %i, align 4, !dbg !76
  %30 = load i32* %9, align 4, !dbg !76
  %31 = mul nsw i32 %29, %30, !dbg !76
  %32 = add nsw i32 %28, %31, !dbg !76
  store i32 %32, i32* %index2, align 4, !dbg !76
  %33 = load i32* %i, align 4, !dbg !78
  %34 = load i32* %5, align 4, !dbg !78
  %35 = icmp slt i32 %33, %34, !dbg !78
  br i1 %35, label %36, label %66, !dbg !78

; <label>:36                                      ; preds = %0
  %37 = load i32* %j, align 4, !dbg !78
  %38 = load i32* %4, align 4, !dbg !78
  %39 = icmp slt i32 %37, %38, !dbg !78
  br i1 %39, label %40, label %66, !dbg !78

; <label>:40                                      ; preds = %36
  %41 = load float* %1, align 4, !dbg !79
  %42 = load i32* %j, align 4, !dbg !79
  %43 = sext i32 %42 to i64, !dbg !79
  %44 = load float** %6, align 8, !dbg !79
  %45 = getelementptr inbounds float* %44, i64 %43, !dbg !79
  %46 = load float* %45, align 4, !dbg !79
  %47 = fmul float %41, %46, !dbg !79
  %48 = load i32* %index2, align 4, !dbg !79
  %49 = sext i32 %48 to i64, !dbg !79
  %50 = load float** %7, align 8, !dbg !79
  %51 = getelementptr inbounds float* %50, i64 %49, !dbg !79
  %52 = load float* %51, align 4, !dbg !79
  %53 = fmul float %47, %52, !dbg !79
  %54 = load float* %10, align 4, !dbg !79
  %55 = load i32* %index, align 4, !dbg !79
  %56 = sext i32 %55 to i64, !dbg !79
  %57 = load float** %2, align 8, !dbg !79
  %58 = getelementptr inbounds float* %57, i64 %56, !dbg !79
  %59 = load float* %58, align 4, !dbg !79
  %60 = fmul float %54, %59, !dbg !79
  %61 = fadd float %53, %60, !dbg !79
  %62 = load i32* %index, align 4, !dbg !79
  %63 = sext i32 %62 to i64, !dbg !79
  %64 = load float** %2, align 8, !dbg !79
  %65 = getelementptr inbounds float* %64, i64 %63, !dbg !79
  store float %61, float* %65, align 4, !dbg !79
  br label %66, !dbg !81

; <label>:66                                      ; preds = %40, %36, %0
  ret void, !dbg !82
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
  call void @llvm.dbg.declare(metadata !{float** %1}, metadata !83), !dbg !84
  store float* %B, float** %2, align 8
  call void @llvm.dbg.declare(metadata !{float** %2}, metadata !85), !dbg !84
  store i32 %dmat_cols, i32* %3, align 4
  call void @llvm.dbg.declare(metadata !{i32* %3}, metadata !86), !dbg !84
  store i32 %dmat_rows, i32* %4, align 4
  call void @llvm.dbg.declare(metadata !{i32* %4}, metadata !87), !dbg !84
  store i32 %dmat_stride, i32* %5, align 4
  call void @llvm.dbg.declare(metadata !{i32* %5}, metadata !88), !dbg !84
  call void @llvm.dbg.declare(metadata !{i32* %i}, metadata !89), !dbg !91
  %6 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 0), align 4, !dbg !91
  %7 = load i32* getelementptr inbounds (%struct.dim3* @blockDim, i32 0, i32 0), align 4, !dbg !91
  %8 = mul i32 %6, %7, !dbg !91
  %9 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !91
  %10 = add i32 %8, %9, !dbg !91
  store i32 %10, i32* %i, align 4, !dbg !91
  call void @llvm.dbg.declare(metadata !{i32* %j}, metadata !92), !dbg !93
  %11 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 1), align 4, !dbg !93
  %12 = load i32* getelementptr inbounds (%struct.dim3* @blockDim, i32 0, i32 1), align 4, !dbg !93
  %13 = mul i32 %11, %12, !dbg !93
  %14 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 1), align 4, !dbg !93
  %15 = add i32 %13, %14, !dbg !93
  store i32 %15, i32* %j, align 4, !dbg !93
  %16 = load i32* %i, align 4, !dbg !94
  %17 = load i32* %3, align 4, !dbg !94
  %18 = icmp slt i32 %16, %17, !dbg !94
  br i1 %18, label %19, label %55, !dbg !94

; <label>:19                                      ; preds = %0
  %20 = load i32* %j, align 4, !dbg !94
  %21 = load i32* %4, align 4, !dbg !94
  %22 = icmp slt i32 %20, %21, !dbg !94
  br i1 %22, label %23, label %55, !dbg !94

; <label>:23                                      ; preds = %19
  call void @llvm.dbg.declare(metadata !{i32* %index_B}, metadata !95), !dbg !97
  %24 = load i32* %j, align 4, !dbg !97
  %25 = load i32* %j, align 4, !dbg !97
  %26 = add nsw i32 %25, 1, !dbg !97
  %27 = mul nsw i32 %24, %26, !dbg !97
  %28 = sdiv i32 %27, 2, !dbg !97
  %29 = load i32* %i, align 4, !dbg !97
  %30 = add nsw i32 %28, %29, !dbg !97
  store i32 %30, i32* %index_B, align 4, !dbg !97
  call void @llvm.dbg.declare(metadata !{i32* %index_A}, metadata !98), !dbg !99
  %31 = load i32* %j, align 4, !dbg !99
  %32 = load i32* %5, align 4, !dbg !99
  %33 = mul nsw i32 %31, %32, !dbg !99
  %34 = load i32* %i, align 4, !dbg !99
  %35 = add nsw i32 %33, %34, !dbg !99
  store i32 %35, i32* %index_A, align 4, !dbg !99
  %36 = load i32* %i, align 4, !dbg !100
  %37 = load i32* %j, align 4, !dbg !100
  %38 = icmp sle i32 %36, %37, !dbg !100
  br i1 %38, label %39, label %49, !dbg !100

; <label>:39                                      ; preds = %23
  %40 = load i32* %index_B, align 4, !dbg !101
  %41 = sext i32 %40 to i64, !dbg !101
  %42 = load float** %2, align 8, !dbg !101
  %43 = getelementptr inbounds float* %42, i64 %41, !dbg !101
  %44 = load float* %43, align 4, !dbg !101
  %45 = load i32* %index_A, align 4, !dbg !101
  %46 = sext i32 %45 to i64, !dbg !101
  %47 = load float** %1, align 8, !dbg !101
  %48 = getelementptr inbounds float* %47, i64 %46, !dbg !101
  store float %44, float* %48, align 4, !dbg !101
  br label %54, !dbg !103

; <label>:49                                      ; preds = %23
  %50 = load i32* %index_A, align 4, !dbg !104
  %51 = sext i32 %50 to i64, !dbg !104
  %52 = load float** %1, align 8, !dbg !104
  %53 = getelementptr inbounds float* %52, i64 %51, !dbg !104
  store float 0.000000e+00, float* %53, align 4, !dbg !104
  br label %54

; <label>:54                                      ; preds = %49, %39
  br label %55, !dbg !106

; <label>:55                                      ; preds = %54, %19, %0
  ret void, !dbg !107
}

!llvm.dbg.cu = !{!0}

!0 = metadata !{i32 786449, i32 0, i32 4, metadata !"new-func.cpp", metadata !"/home/mingyuanwu/kaldi-new-bug", metadata !"clang version 3.2 (tags/RELEASE_32/final)", i1 true, i1 false, metadata !"", i32 0, metadata !1, metadata !1, metadata !3, metadata !1} ; [ DW_TAG_compile_unit ] [/home/mingyuanwu/kaldi-new-bug/new-func.cpp] [DW_LANG_C_plus_plus]
!1 = metadata !{metadata !2}
!2 = metadata !{i32 0}
!3 = metadata !{metadata !4}
!4 = metadata !{metadata !5, metadata !12, metadata !13, metadata !18}
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
!21 = metadata !{i32 786689, metadata !5, metadata !"A", metadata !6, i32 16777218, metadata !9, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [A] [line 2]
!22 = metadata !{i32 2, i32 0, metadata !5, null}
!23 = metadata !{i32 786689, metadata !5, metadata !"rows", metadata !6, i32 33554434, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [rows] [line 2]
!24 = metadata !{i32 786689, metadata !5, metadata !"stride", metadata !6, i32 50331650, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [stride] [line 2]
!25 = metadata !{i32 786688, metadata !26, metadata !"i", metadata !6, i32 3, metadata !11, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [i] [line 3]
!26 = metadata !{i32 786443, metadata !5, i32 2, i32 0, metadata !6, i32 0} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/kaldi-new-bug/new-func.cpp]
!27 = metadata !{i32 3, i32 0, metadata !26, null}
!28 = metadata !{i32 786688, metadata !26, metadata !"j", metadata !6, i32 4, metadata !11, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [j] [line 4]
!29 = metadata !{i32 4, i32 0, metadata !26, null}
!30 = metadata !{i32 5, i32 0, metadata !26, null}
!31 = metadata !{i32 6, i32 0, metadata !26, null}
!32 = metadata !{i32 786688, metadata !26, metadata !"index_1", metadata !6, i32 7, metadata !11, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [index_1] [line 7]
!33 = metadata !{i32 7, i32 0, metadata !26, null}
!34 = metadata !{i32 786688, metadata !26, metadata !"index_2", metadata !6, i32 8, metadata !11, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [index_2] [line 8]
!35 = metadata !{i32 8, i32 0, metadata !26, null}
!36 = metadata !{i32 9, i32 0, metadata !26, null}
!37 = metadata !{i32 10, i32 0, metadata !26, null}
!38 = metadata !{i32 786689, metadata !12, metadata !"A", metadata !6, i32 16777235, metadata !9, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [A] [line 19]
!39 = metadata !{i32 19, i32 0, metadata !12, null}
!40 = metadata !{i32 786689, metadata !12, metadata !"rows", metadata !6, i32 33554451, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [rows] [line 19]
!41 = metadata !{i32 786689, metadata !12, metadata !"stride", metadata !6, i32 50331667, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [stride] [line 19]
!42 = metadata !{i32 786688, metadata !43, metadata !"i", metadata !6, i32 20, metadata !11, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [i] [line 20]
!43 = metadata !{i32 786443, metadata !12, i32 19, i32 0, metadata !6, i32 1} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/kaldi-new-bug/new-func.cpp]
!44 = metadata !{i32 20, i32 0, metadata !43, null}
!45 = metadata !{i32 786688, metadata !43, metadata !"j", metadata !6, i32 21, metadata !11, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [j] [line 21]
!46 = metadata !{i32 21, i32 0, metadata !43, null}
!47 = metadata !{i32 22, i32 0, metadata !43, null}
!48 = metadata !{i32 23, i32 0, metadata !43, null}
!49 = metadata !{i32 786688, metadata !43, metadata !"index_1", metadata !6, i32 24, metadata !11, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [index_1] [line 24]
!50 = metadata !{i32 24, i32 0, metadata !43, null}
!51 = metadata !{i32 786688, metadata !43, metadata !"index_2", metadata !6, i32 25, metadata !11, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [index_2] [line 25]
!52 = metadata !{i32 25, i32 0, metadata !43, null}
!53 = metadata !{i32 26, i32 0, metadata !43, null}
!54 = metadata !{i32 27, i32 0, metadata !43, null}
!55 = metadata !{i32 786689, metadata !13, metadata !"alpha", metadata !6, i32 16777247, metadata !10, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [alpha] [line 31]
!56 = metadata !{i32 31, i32 0, metadata !13, null}
!57 = metadata !{i32 786689, metadata !13, metadata !"mat", metadata !6, i32 33554463, metadata !9, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [mat] [line 31]
!58 = metadata !{i32 786689, metadata !13, metadata !"stride", metadata !6, i32 50331679, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [stride] [line 31]
!59 = metadata !{i32 786689, metadata !13, metadata !"rows", metadata !6, i32 67108895, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [rows] [line 31]
!60 = metadata !{i32 786689, metadata !13, metadata !"cols", metadata !6, i32 83886111, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [cols] [line 31]
!61 = metadata !{i32 786689, metadata !13, metadata !"vec", metadata !6, i32 100663328, metadata !16, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [vec] [line 32]
!62 = metadata !{i32 32, i32 0, metadata !13, null}
!63 = metadata !{i32 786689, metadata !13, metadata !"mat2", metadata !6, i32 117440544, metadata !16, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [mat2] [line 32]
!64 = metadata !{i32 786689, metadata !13, metadata !"mat2_row_stride", metadata !6, i32 134217761, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [mat2_row_stride] [line 33]
!65 = metadata !{i32 33, i32 0, metadata !13, null}
!66 = metadata !{i32 786689, metadata !13, metadata !"mat2_col_stride", metadata !6, i32 150994977, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [mat2_col_stride] [line 33]
!67 = metadata !{i32 786689, metadata !13, metadata !"beta", metadata !6, i32 167772194, metadata !10, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [beta] [line 34]
!68 = metadata !{i32 34, i32 0, metadata !13, null}
!69 = metadata !{i32 786688, metadata !70, metadata !"i", metadata !6, i32 35, metadata !11, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [i] [line 35]
!70 = metadata !{i32 786443, metadata !13, i32 34, i32 0, metadata !6, i32 2} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/kaldi-new-bug/new-func.cpp]
!71 = metadata !{i32 35, i32 0, metadata !70, null}
!72 = metadata !{i32 786688, metadata !70, metadata !"j", metadata !6, i32 36, metadata !11, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [j] [line 36]
!73 = metadata !{i32 36, i32 0, metadata !70, null}
!74 = metadata !{i32 786688, metadata !70, metadata !"index", metadata !6, i32 38, metadata !11, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [index] [line 38]
!75 = metadata !{i32 38, i32 0, metadata !70, null}
!76 = metadata !{i32 39, i32 0, metadata !70, null}
!77 = metadata !{i32 786688, metadata !70, metadata !"index2", metadata !6, i32 38, metadata !11, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [index2] [line 38]
!78 = metadata !{i32 41, i32 0, metadata !70, null}
!79 = metadata !{i32 42, i32 0, metadata !80, null}
!80 = metadata !{i32 786443, metadata !70, i32 41, i32 0, metadata !6, i32 3} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/kaldi-new-bug/new-func.cpp]
!81 = metadata !{i32 43, i32 0, metadata !80, null}
!82 = metadata !{i32 44, i32 0, metadata !70, null}
!83 = metadata !{i32 786689, metadata !18, metadata !"A", metadata !6, i32 16777263, metadata !9, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [A] [line 47]
!84 = metadata !{i32 47, i32 0, metadata !18, null}
!85 = metadata !{i32 786689, metadata !18, metadata !"B", metadata !6, i32 33554479, metadata !16, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [B] [line 47]
!86 = metadata !{i32 786689, metadata !18, metadata !"dmat_cols", metadata !6, i32 50331695, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [dmat_cols] [line 47]
!87 = metadata !{i32 786689, metadata !18, metadata !"dmat_rows", metadata !6, i32 67108911, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [dmat_rows] [line 47]
!88 = metadata !{i32 786689, metadata !18, metadata !"dmat_stride", metadata !6, i32 83886127, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [dmat_stride] [line 47]
!89 = metadata !{i32 786688, metadata !90, metadata !"i", metadata !6, i32 48, metadata !11, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [i] [line 48]
!90 = metadata !{i32 786443, metadata !18, i32 47, i32 0, metadata !6, i32 4} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/kaldi-new-bug/new-func.cpp]
!91 = metadata !{i32 48, i32 0, metadata !90, null}
!92 = metadata !{i32 786688, metadata !90, metadata !"j", metadata !6, i32 49, metadata !11, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [j] [line 49]
!93 = metadata !{i32 49, i32 0, metadata !90, null}
!94 = metadata !{i32 50, i32 0, metadata !90, null}
!95 = metadata !{i32 786688, metadata !96, metadata !"index_B", metadata !6, i32 51, metadata !11, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [index_B] [line 51]
!96 = metadata !{i32 786443, metadata !90, i32 50, i32 0, metadata !6, i32 5} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/kaldi-new-bug/new-func.cpp]
!97 = metadata !{i32 51, i32 0, metadata !96, null}
!98 = metadata !{i32 786688, metadata !96, metadata !"index_A", metadata !6, i32 52, metadata !11, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [index_A] [line 52]
!99 = metadata !{i32 52, i32 0, metadata !96, null}
!100 = metadata !{i32 53, i32 0, metadata !96, null}
!101 = metadata !{i32 54, i32 0, metadata !102, null}
!102 = metadata !{i32 786443, metadata !96, i32 53, i32 0, metadata !6, i32 6} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/kaldi-new-bug/new-func.cpp]
!103 = metadata !{i32 55, i32 0, metadata !102, null}
!104 = metadata !{i32 56, i32 0, metadata !105, null}
!105 = metadata !{i32 786443, metadata !96, i32 55, i32 0, metadata !6, i32 7} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/kaldi-new-bug/new-func.cpp]
!106 = metadata !{i32 58, i32 0, metadata !96, null}
!107 = metadata !{i32 59, i32 0, metadata !90, null}
