; ModuleID = 'new-func'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.dim3 = type { i32, i32, i32 }

@blockIdx = external global %struct.dim3
@_ZZ8scan_bfsPiS_S_S_E12shared_count = internal global [32 x i32] zeroinitializer, section "__shared__", align 16
@threadIdx = external global %struct.dim3
@blockDim = external global %struct.dim3
@_ZZ10dfs_reducePfS_S_PiS0_iE10shared_imp = internal global [100 x float] zeroinitializer, section "__shared__", align 16
@gridDim = external global %struct.dim3

define void @_Z6reducePfPiS0_S_S0_S0_i(float* %imp_min_2d, i32* %split_2d, i32* %min_feature_idx_2d, float* %imp_min, i32* %split, i32* %min_feature, i32 %nblocks) nounwind uwtable noinline {
  %1 = alloca float*, align 8
  %2 = alloca i32*, align 8
  %3 = alloca i32*, align 8
  %4 = alloca float*, align 8
  %5 = alloca i32*, align 8
  %6 = alloca i32*, align 8
  %7 = alloca i32, align 4
  %offset = alloca i32, align 4
  %reg_min_split = alloca i32, align 4
  %reg_min_left = alloca float, align 4
  %reg_min_right = alloca float, align 4
  %reg_min_fidx = alloca i32, align 4
  %i = alloca i32, align 4
  %left = alloca float, align 4
  %right = alloca float, align 4
  store float* %imp_min_2d, float** %1, align 8
  call void @llvm.dbg.declare(metadata !{float** %1}, metadata !38), !dbg !39
  store i32* %split_2d, i32** %2, align 8
  call void @llvm.dbg.declare(metadata !{i32** %2}, metadata !40), !dbg !41
  store i32* %min_feature_idx_2d, i32** %3, align 8
  call void @llvm.dbg.declare(metadata !{i32** %3}, metadata !42), !dbg !43
  store float* %imp_min, float** %4, align 8
  call void @llvm.dbg.declare(metadata !{float** %4}, metadata !44), !dbg !45
  store i32* %split, i32** %5, align 8
  call void @llvm.dbg.declare(metadata !{i32** %5}, metadata !46), !dbg !47
  store i32* %min_feature, i32** %6, align 8
  call void @llvm.dbg.declare(metadata !{i32** %6}, metadata !48), !dbg !49
  store i32 %nblocks, i32* %7, align 4
  call void @llvm.dbg.declare(metadata !{i32* %7}, metadata !50), !dbg !51
  call void @llvm.dbg.declare(metadata !{i32* %offset}, metadata !52), !dbg !54
  %8 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 0), align 4, !dbg !54
  %9 = load i32* %7, align 4, !dbg !54
  %10 = mul i32 %8, %9, !dbg !54
  store i32 %10, i32* %offset, align 4, !dbg !54
  call void @llvm.dbg.declare(metadata !{i32* %reg_min_split}, metadata !55), !dbg !56
  call void @llvm.dbg.declare(metadata !{float* %reg_min_left}, metadata !57), !dbg !58
  store float 4.000000e+00, float* %reg_min_left, align 4, !dbg !58
  call void @llvm.dbg.declare(metadata !{float* %reg_min_right}, metadata !59), !dbg !60
  store float 4.000000e+00, float* %reg_min_right, align 4, !dbg !60
  call void @llvm.dbg.declare(metadata !{i32* %reg_min_fidx}, metadata !61), !dbg !62
  store i32 0, i32* %reg_min_fidx, align 4, !dbg !62
  call void @llvm.dbg.declare(metadata !{i32* %i}, metadata !63), !dbg !65
  store i32 0, i32* %i, align 4, !dbg !65
  br label %11, !dbg !65

; <label>:11                                      ; preds = %58, %0
  %12 = load i32* %i, align 4, !dbg !65
  %13 = load i32* %7, align 4, !dbg !65
  %14 = icmp slt i32 %12, %13, !dbg !65
  br i1 %14, label %15, label %61, !dbg !65

; <label>:15                                      ; preds = %11
  call void @llvm.dbg.declare(metadata !{float* %left}, metadata !66), !dbg !68
  %16 = load i32* %offset, align 4, !dbg !68
  %17 = load i32* %i, align 4, !dbg !68
  %18 = add nsw i32 %16, %17, !dbg !68
  %19 = mul nsw i32 2, %18, !dbg !68
  %20 = sext i32 %19 to i64, !dbg !68
  %21 = load float** %1, align 8, !dbg !68
  %22 = getelementptr inbounds float* %21, i64 %20, !dbg !68
  %23 = load float* %22, align 4, !dbg !68
  store float %23, float* %left, align 4, !dbg !68
  call void @llvm.dbg.declare(metadata !{float* %right}, metadata !69), !dbg !70
  %24 = load i32* %offset, align 4, !dbg !70
  %25 = load i32* %i, align 4, !dbg !70
  %26 = add nsw i32 %24, %25, !dbg !70
  %27 = mul nsw i32 2, %26, !dbg !70
  %28 = add nsw i32 %27, 1, !dbg !70
  %29 = sext i32 %28 to i64, !dbg !70
  %30 = load float** %1, align 8, !dbg !70
  %31 = getelementptr inbounds float* %30, i64 %29, !dbg !70
  %32 = load float* %31, align 4, !dbg !70
  store float %32, float* %right, align 4, !dbg !70
  %33 = load float* %reg_min_left, align 4, !dbg !71
  %34 = load float* %reg_min_right, align 4, !dbg !71
  %35 = fadd float %33, %34, !dbg !71
  %36 = load float* %left, align 4, !dbg !71
  %37 = load float* %right, align 4, !dbg !71
  %38 = fadd float %36, %37, !dbg !71
  %39 = fcmp ogt float %35, %38, !dbg !71
  br i1 %39, label %40, label %57, !dbg !71

; <label>:40                                      ; preds = %15
  %41 = load float* %left, align 4, !dbg !72
  store float %41, float* %reg_min_left, align 4, !dbg !72
  %42 = load float* %right, align 4, !dbg !74
  store float %42, float* %reg_min_right, align 4, !dbg !74
  %43 = load i32* %offset, align 4, !dbg !75
  %44 = load i32* %i, align 4, !dbg !75
  %45 = add nsw i32 %43, %44, !dbg !75
  %46 = sext i32 %45 to i64, !dbg !75
  %47 = load i32** %3, align 8, !dbg !75
  %48 = getelementptr inbounds i32* %47, i64 %46, !dbg !75
  %49 = load i32* %48, align 4, !dbg !75
  store i32 %49, i32* %reg_min_fidx, align 4, !dbg !75
  %50 = load i32* %offset, align 4, !dbg !76
  %51 = load i32* %i, align 4, !dbg !76
  %52 = add nsw i32 %50, %51, !dbg !76
  %53 = sext i32 %52 to i64, !dbg !76
  %54 = load i32** %2, align 8, !dbg !76
  %55 = getelementptr inbounds i32* %54, i64 %53, !dbg !76
  %56 = load i32* %55, align 4, !dbg !76
  store i32 %56, i32* %reg_min_split, align 4, !dbg !76
  br label %57, !dbg !77

; <label>:57                                      ; preds = %40, %15
  br label %58, !dbg !78

; <label>:58                                      ; preds = %57
  %59 = load i32* %i, align 4, !dbg !65
  %60 = add nsw i32 %59, 1, !dbg !65
  store i32 %60, i32* %i, align 4, !dbg !65
  br label %11, !dbg !65

; <label>:61                                      ; preds = %11
  %62 = load i32* %reg_min_split, align 4, !dbg !79
  %63 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 0), align 4, !dbg !79
  %64 = zext i32 %63 to i64, !dbg !79
  %65 = load i32** %5, align 8, !dbg !79
  %66 = getelementptr inbounds i32* %65, i64 %64, !dbg !79
  store i32 %62, i32* %66, align 4, !dbg !79
  %67 = load i32* %reg_min_fidx, align 4, !dbg !80
  %68 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 0), align 4, !dbg !80
  %69 = zext i32 %68 to i64, !dbg !80
  %70 = load i32** %6, align 8, !dbg !80
  %71 = getelementptr inbounds i32* %70, i64 %69, !dbg !80
  store i32 %67, i32* %71, align 4, !dbg !80
  %72 = load float* %reg_min_left, align 4, !dbg !81
  %73 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 0), align 4, !dbg !81
  %74 = mul i32 2, %73, !dbg !81
  %75 = zext i32 %74 to i64, !dbg !81
  %76 = load float** %4, align 8, !dbg !81
  %77 = getelementptr inbounds float* %76, i64 %75, !dbg !81
  store float %72, float* %77, align 4, !dbg !81
  %78 = load float* %reg_min_right, align 4, !dbg !82
  %79 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 0), align 4, !dbg !82
  %80 = mul i32 2, %79, !dbg !82
  %81 = add i32 %80, 1, !dbg !82
  %82 = zext i32 %81 to i64, !dbg !82
  %83 = load float** %4, align 8, !dbg !82
  %84 = getelementptr inbounds float* %83, i64 %82, !dbg !82
  store float %78, float* %84, align 4, !dbg !82
  ret void, !dbg !83
}

declare void @llvm.dbg.declare(metadata, metadata) nounwind readnone

define void @_Z8scan_bfsPiS_S_S_(i32* %labels, i32* %label_total, i32* %si_idx, i32* %begin_stop_idx) uwtable noinline {
  %1 = alloca i32*, align 8
  %2 = alloca i32*, align 8
  %3 = alloca i32*, align 8
  %4 = alloca i32*, align 8
  %reg_start_idx = alloca i32, align 4
  %reg_stop_idx = alloca i32, align 4
  %i = alloca i32, align 4
  %reg_si_idx = alloca i32, align 4
  %i1 = alloca i32, align 4
  store i32* %labels, i32** %1, align 8
  call void @llvm.dbg.declare(metadata !{i32** %1}, metadata !84), !dbg !85
  store i32* %label_total, i32** %2, align 8
  call void @llvm.dbg.declare(metadata !{i32** %2}, metadata !86), !dbg !87
  store i32* %si_idx, i32** %3, align 8
  call void @llvm.dbg.declare(metadata !{i32** %3}, metadata !88), !dbg !89
  store i32* %begin_stop_idx, i32** %4, align 8
  call void @llvm.dbg.declare(metadata !{i32** %4}, metadata !90), !dbg !91
  call void @llvm.dbg.declare(metadata !{i32* %reg_start_idx}, metadata !92), !dbg !94
  call void @llvm.dbg.declare(metadata !{i32* %reg_stop_idx}, metadata !95), !dbg !96
  call void @llvm.dbg.declare(metadata !{i32* %i}, metadata !97), !dbg !99
  %5 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !99
  store i32 %5, i32* %i, align 4, !dbg !99
  br label %6, !dbg !99

; <label>:6                                       ; preds = %13, %0
  %7 = load i32* %i, align 4, !dbg !99
  %8 = icmp slt i32 %7, 32, !dbg !99
  br i1 %8, label %9, label %17, !dbg !99

; <label>:9                                       ; preds = %6
  %10 = load i32* %i, align 4, !dbg !100
  %11 = sext i32 %10 to i64, !dbg !100
  %12 = getelementptr inbounds [32 x i32]* @_ZZ8scan_bfsPiS_S_S_E12shared_count, i32 0, i64 %11, !dbg !100
  store i32 0, i32* %12, align 4, !dbg !100
  br label %13, !dbg !100

; <label>:13                                      ; preds = %9
  %14 = load i32* getelementptr inbounds (%struct.dim3* @blockDim, i32 0, i32 0), align 4, !dbg !99
  %15 = load i32* %i, align 4, !dbg !99
  %16 = add i32 %15, %14, !dbg !99
  store i32 %16, i32* %i, align 4, !dbg !99
  br label %6, !dbg !99

; <label>:17                                      ; preds = %6
  %18 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 0), align 4, !dbg !101
  %19 = mul i32 2, %18, !dbg !101
  %20 = zext i32 %19 to i64, !dbg !101
  %21 = load i32** %4, align 8, !dbg !101
  %22 = getelementptr inbounds i32* %21, i64 %20, !dbg !101
  %23 = load i32* %22, align 4, !dbg !101
  store i32 %23, i32* %reg_start_idx, align 4, !dbg !101
  %24 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 0), align 4, !dbg !102
  %25 = mul i32 2, %24, !dbg !102
  %26 = add i32 %25, 1, !dbg !102
  %27 = zext i32 %26 to i64, !dbg !102
  %28 = load i32** %4, align 8, !dbg !102
  %29 = getelementptr inbounds i32* %28, i64 %27, !dbg !102
  %30 = load i32* %29, align 4, !dbg !102
  store i32 %30, i32* %reg_stop_idx, align 4, !dbg !102
  call void @llvm.dbg.declare(metadata !{i32* %reg_si_idx}, metadata !103), !dbg !104
  %31 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 0), align 4, !dbg !104
  %32 = zext i32 %31 to i64, !dbg !104
  %33 = load i32** %3, align 8, !dbg !104
  %34 = getelementptr inbounds i32* %33, i64 %32, !dbg !104
  %35 = load i32* %34, align 4, !dbg !104
  store i32 %35, i32* %reg_si_idx, align 4, !dbg !104
  call void @__syncthreads(), !dbg !105
  call void @llvm.dbg.declare(metadata !{i32* %i1}, metadata !106), !dbg !108
  %36 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !108
  store i32 %36, i32* %i1, align 4, !dbg !108
  br label %37, !dbg !108

; <label>:37                                      ; preds = %52, %17
  %38 = load i32* %i1, align 4, !dbg !108
  %39 = icmp slt i32 %38, 32, !dbg !108
  br i1 %39, label %40, label %56, !dbg !108

; <label>:40                                      ; preds = %37
  %41 = load i32* %i1, align 4, !dbg !109
  %42 = sext i32 %41 to i64, !dbg !109
  %43 = getelementptr inbounds [32 x i32]* @_ZZ8scan_bfsPiS_S_S_E12shared_count, i32 0, i64 %42, !dbg !109
  %44 = load i32* %43, align 4, !dbg !109
  %45 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 0), align 4, !dbg !109
  %46 = mul i32 %45, 32, !dbg !109
  %47 = load i32* %i1, align 4, !dbg !109
  %48 = add i32 %46, %47, !dbg !109
  %49 = zext i32 %48 to i64, !dbg !109
  %50 = load i32** %2, align 8, !dbg !109
  %51 = getelementptr inbounds i32* %50, i64 %49, !dbg !109
  store i32 %44, i32* %51, align 4, !dbg !109
  br label %52, !dbg !109

; <label>:52                                      ; preds = %40
  %53 = load i32* getelementptr inbounds (%struct.dim3* @blockDim, i32 0, i32 0), align 4, !dbg !108
  %54 = load i32* %i1, align 4, !dbg !108
  %55 = add i32 %54, %53, !dbg !108
  store i32 %55, i32* %i1, align 4, !dbg !108
  br label %37, !dbg !108

; <label>:56                                      ; preds = %37
  ret void, !dbg !110
}

declare void @__syncthreads() section "__device__"

define void @_Z10dfs_reducePfS_S_PiS0_i(float* %impurity_2d, float* %impurity_left, float* %impurity_right, i32* %split_2d, i32* %split_1d, i32 %n_block) uwtable noinline {
  %1 = alloca float*, align 8
  %2 = alloca float*, align 8
  %3 = alloca float*, align 8
  %4 = alloca i32*, align 8
  %5 = alloca i32*, align 8
  %6 = alloca i32, align 4
  %imp_offset = alloca i32, align 4
  %split_offset = alloca i32, align 4
  %t = alloca i32, align 4
  %min_left = alloca float, align 4
  %min_right = alloca float, align 4
  %min_idx = alloca i32, align 4
  %i = alloca i32, align 4
  store float* %impurity_2d, float** %1, align 8
  call void @llvm.dbg.declare(metadata !{float** %1}, metadata !111), !dbg !112
  store float* %impurity_left, float** %2, align 8
  call void @llvm.dbg.declare(metadata !{float** %2}, metadata !113), !dbg !114
  store float* %impurity_right, float** %3, align 8
  call void @llvm.dbg.declare(metadata !{float** %3}, metadata !115), !dbg !116
  store i32* %split_2d, i32** %4, align 8
  call void @llvm.dbg.declare(metadata !{i32** %4}, metadata !117), !dbg !118
  store i32* %split_1d, i32** %5, align 8
  call void @llvm.dbg.declare(metadata !{i32** %5}, metadata !119), !dbg !120
  store i32 %n_block, i32* %6, align 4
  call void @llvm.dbg.declare(metadata !{i32* %6}, metadata !121), !dbg !122
  call void @llvm.dbg.declare(metadata !{i32* %imp_offset}, metadata !123), !dbg !126
  %7 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 0), align 4, !dbg !126
  %8 = mul i32 %7, 50, !dbg !126
  %9 = mul i32 %8, 2, !dbg !126
  store i32 %9, i32* %imp_offset, align 4, !dbg !126
  call void @llvm.dbg.declare(metadata !{i32* %split_offset}, metadata !127), !dbg !128
  %10 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 0), align 4, !dbg !128
  %11 = mul i32 %10, 50, !dbg !128
  store i32 %11, i32* %split_offset, align 4, !dbg !128
  call void @llvm.dbg.declare(metadata !{i32* %t}, metadata !129), !dbg !131
  %12 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !131
  store i32 %12, i32* %t, align 4, !dbg !131
  br label %13, !dbg !131

; <label>:13                                      ; preds = %29, %0
  %14 = load i32* %t, align 4, !dbg !131
  %15 = load i32* %6, align 4, !dbg !131
  %16 = mul nsw i32 %15, 2, !dbg !131
  %17 = icmp slt i32 %14, %16, !dbg !131
  br i1 %17, label %18, label %33, !dbg !131

; <label>:18                                      ; preds = %13
  %19 = load i32* %imp_offset, align 4, !dbg !132
  %20 = load i32* %t, align 4, !dbg !132
  %21 = add nsw i32 %19, %20, !dbg !132
  %22 = sext i32 %21 to i64, !dbg !132
  %23 = load float** %1, align 8, !dbg !132
  %24 = getelementptr inbounds float* %23, i64 %22, !dbg !132
  %25 = load float* %24, align 4, !dbg !132
  %26 = load i32* %t, align 4, !dbg !132
  %27 = sext i32 %26 to i64, !dbg !132
  %28 = getelementptr inbounds [100 x float]* @_ZZ10dfs_reducePfS_S_PiS0_iE10shared_imp, i32 0, i64 %27, !dbg !132
  store float %25, float* %28, align 4, !dbg !132
  br label %29, !dbg !132

; <label>:29                                      ; preds = %18
  %30 = load i32* getelementptr inbounds (%struct.dim3* @blockDim, i32 0, i32 0), align 4, !dbg !131
  %31 = load i32* %t, align 4, !dbg !131
  %32 = add i32 %31, %30, !dbg !131
  store i32 %32, i32* %t, align 4, !dbg !131
  br label %13, !dbg !131

; <label>:33                                      ; preds = %13
  call void @__syncthreads(), !dbg !133
  %34 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !134
  %35 = icmp eq i32 %34, 0, !dbg !134
  br i1 %35, label %36, label %97, !dbg !134

; <label>:36                                      ; preds = %33
  call void @llvm.dbg.declare(metadata !{float* %min_left}, metadata !135), !dbg !137
  store float 2.000000e+00, float* %min_left, align 4, !dbg !137
  call void @llvm.dbg.declare(metadata !{float* %min_right}, metadata !138), !dbg !139
  store float 2.000000e+00, float* %min_right, align 4, !dbg !139
  call void @llvm.dbg.declare(metadata !{i32* %min_idx}, metadata !140), !dbg !141
  store i32 0, i32* %min_idx, align 4, !dbg !141
  call void @llvm.dbg.declare(metadata !{i32* %i}, metadata !142), !dbg !144
  store i32 0, i32* %i, align 4, !dbg !144
  br label %37, !dbg !144

; <label>:37                                      ; preds = %72, %36
  %38 = load i32* %i, align 4, !dbg !144
  %39 = load i32* %6, align 4, !dbg !144
  %40 = icmp slt i32 %38, %39, !dbg !144
  br i1 %40, label %41, label %75, !dbg !144

; <label>:41                                      ; preds = %37
  %42 = load float* %min_left, align 4, !dbg !145
  %43 = load float* %min_right, align 4, !dbg !145
  %44 = fadd float %42, %43, !dbg !145
  %45 = load i32* %i, align 4, !dbg !145
  %46 = mul nsw i32 %45, 2, !dbg !145
  %47 = sext i32 %46 to i64, !dbg !145
  %48 = getelementptr inbounds [100 x float]* @_ZZ10dfs_reducePfS_S_PiS0_iE10shared_imp, i32 0, i64 %47, !dbg !145
  %49 = load float* %48, align 4, !dbg !145
  %50 = load i32* %i, align 4, !dbg !145
  %51 = mul nsw i32 2, %50, !dbg !145
  %52 = add nsw i32 %51, 1, !dbg !145
  %53 = sext i32 %52 to i64, !dbg !145
  %54 = getelementptr inbounds [100 x float]* @_ZZ10dfs_reducePfS_S_PiS0_iE10shared_imp, i32 0, i64 %53, !dbg !145
  %55 = load float* %54, align 4, !dbg !145
  %56 = fadd float %49, %55, !dbg !145
  %57 = fcmp ogt float %44, %56, !dbg !145
  br i1 %57, label %58, label %71, !dbg !145

; <label>:58                                      ; preds = %41
  %59 = load i32* %i, align 4, !dbg !146
  %60 = mul nsw i32 %59, 2, !dbg !146
  %61 = sext i32 %60 to i64, !dbg !146
  %62 = getelementptr inbounds [100 x float]* @_ZZ10dfs_reducePfS_S_PiS0_iE10shared_imp, i32 0, i64 %61, !dbg !146
  %63 = load float* %62, align 4, !dbg !146
  store float %63, float* %min_left, align 4, !dbg !146
  %64 = load i32* %i, align 4, !dbg !148
  %65 = mul nsw i32 2, %64, !dbg !148
  %66 = add nsw i32 %65, 1, !dbg !148
  %67 = sext i32 %66 to i64, !dbg !148
  %68 = getelementptr inbounds [100 x float]* @_ZZ10dfs_reducePfS_S_PiS0_iE10shared_imp, i32 0, i64 %67, !dbg !148
  %69 = load float* %68, align 4, !dbg !148
  store float %69, float* %min_right, align 4, !dbg !148
  %70 = load i32* %i, align 4, !dbg !149
  store i32 %70, i32* %min_idx, align 4, !dbg !149
  br label %71, !dbg !150

; <label>:71                                      ; preds = %58, %41
  br label %72, !dbg !150

; <label>:72                                      ; preds = %71
  %73 = load i32* %i, align 4, !dbg !144
  %74 = add nsw i32 %73, 1, !dbg !144
  store i32 %74, i32* %i, align 4, !dbg !144
  br label %37, !dbg !144

; <label>:75                                      ; preds = %37
  %76 = load float* %min_left, align 4, !dbg !151
  %77 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 0), align 4, !dbg !151
  %78 = zext i32 %77 to i64, !dbg !151
  %79 = load float** %2, align 8, !dbg !151
  %80 = getelementptr inbounds float* %79, i64 %78, !dbg !151
  store float %76, float* %80, align 4, !dbg !151
  %81 = load float* %min_right, align 4, !dbg !152
  %82 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 0), align 4, !dbg !152
  %83 = zext i32 %82 to i64, !dbg !152
  %84 = load float** %3, align 8, !dbg !152
  %85 = getelementptr inbounds float* %84, i64 %83, !dbg !152
  store float %81, float* %85, align 4, !dbg !152
  %86 = load i32* %split_offset, align 4, !dbg !153
  %87 = load i32* %min_idx, align 4, !dbg !153
  %88 = add nsw i32 %86, %87, !dbg !153
  %89 = sext i32 %88 to i64, !dbg !153
  %90 = load i32** %4, align 8, !dbg !153
  %91 = getelementptr inbounds i32* %90, i64 %89, !dbg !153
  %92 = load i32* %91, align 4, !dbg !153
  %93 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 0), align 4, !dbg !153
  %94 = zext i32 %93 to i64, !dbg !153
  %95 = load i32** %5, align 8, !dbg !153
  %96 = getelementptr inbounds i32* %95, i64 %94, !dbg !153
  store i32 %92, i32* %96, align 4, !dbg !153
  br label %97, !dbg !154

; <label>:97                                      ; preds = %75, %33
  ret void, !dbg !155
}

define void @_Z7predictPjS_PtPfPiS2_S2_ii(i32* %left_child_arr, i32* %right_child_arr, i16* %feature_array, float* %threshold_array, i32* %value_array, i32* %predict_array, i32* %predict_res, i32 %n_features, i32 %n_predict) nounwind uwtable noinline {
  %1 = alloca i32*, align 8
  %2 = alloca i32*, align 8
  %3 = alloca i16*, align 8
  %4 = alloca float*, align 8
  %5 = alloca i32*, align 8
  %6 = alloca i32*, align 8
  %7 = alloca i32*, align 8
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %lane_id = alloca i32, align 4
  %warp_id = alloca i32, align 4
  %predict_idx = alloca i32, align 4
  %offset = alloca i32, align 4
  %idx = alloca i32, align 4
  %left_idx = alloca i32, align 4
  %right_idx = alloca i32, align 4
  %threshold = alloca float, align 4
  %feature_idx = alloca i16, align 2
  store i32* %left_child_arr, i32** %1, align 8
  call void @llvm.dbg.declare(metadata !{i32** %1}, metadata !156), !dbg !157
  store i32* %right_child_arr, i32** %2, align 8
  call void @llvm.dbg.declare(metadata !{i32** %2}, metadata !158), !dbg !159
  store i16* %feature_array, i16** %3, align 8
  call void @llvm.dbg.declare(metadata !{i16** %3}, metadata !160), !dbg !161
  store float* %threshold_array, float** %4, align 8
  call void @llvm.dbg.declare(metadata !{float** %4}, metadata !162), !dbg !163
  store i32* %value_array, i32** %5, align 8
  call void @llvm.dbg.declare(metadata !{i32** %5}, metadata !164), !dbg !165
  store i32* %predict_array, i32** %6, align 8
  call void @llvm.dbg.declare(metadata !{i32** %6}, metadata !166), !dbg !167
  store i32* %predict_res, i32** %7, align 8
  call void @llvm.dbg.declare(metadata !{i32** %7}, metadata !168), !dbg !169
  store i32 %n_features, i32* %8, align 4
  call void @llvm.dbg.declare(metadata !{i32* %8}, metadata !170), !dbg !171
  store i32 %n_predict, i32* %9, align 4
  call void @llvm.dbg.declare(metadata !{i32* %9}, metadata !172), !dbg !173
  call void @llvm.dbg.declare(metadata !{i32* %lane_id}, metadata !174), !dbg !176
  %10 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !176
  %11 = and i32 %10, 31, !dbg !176
  store i32 %11, i32* %lane_id, align 4, !dbg !176
  call void @llvm.dbg.declare(metadata !{i32* %warp_id}, metadata !177), !dbg !178
  %12 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !178
  %13 = udiv i32 %12, 32, !dbg !178
  store i32 %13, i32* %warp_id, align 4, !dbg !178
  %14 = load i32* %lane_id, align 4, !dbg !179
  %15 = icmp ne i32 %14, 0, !dbg !179
  br i1 %15, label %16, label %17, !dbg !179

; <label>:16                                      ; preds = %0
  br label %88, !dbg !180

; <label>:17                                      ; preds = %0
  call void @llvm.dbg.declare(metadata !{i32* %predict_idx}, metadata !181), !dbg !182
  %18 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 0), align 4, !dbg !182
  %19 = load i32* getelementptr inbounds (%struct.dim3* @gridDim, i32 0, i32 1), align 4, !dbg !182
  %20 = mul i32 %18, %19, !dbg !182
  %21 = mul i32 %20, 16, !dbg !182
  %22 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 1), align 4, !dbg !182
  %23 = mul i32 %22, 16, !dbg !182
  %24 = add i32 %21, %23, !dbg !182
  %25 = load i32* %warp_id, align 4, !dbg !182
  %26 = add i32 %24, %25, !dbg !182
  store i32 %26, i32* %predict_idx, align 4, !dbg !182
  call void @llvm.dbg.declare(metadata !{i32* %offset}, metadata !183), !dbg !184
  %27 = load i32* %predict_idx, align 4, !dbg !184
  %28 = load i32* %8, align 4, !dbg !184
  %29 = mul nsw i32 %27, %28, !dbg !184
  store i32 %29, i32* %offset, align 4, !dbg !184
  call void @llvm.dbg.declare(metadata !{i32* %idx}, metadata !185), !dbg !186
  store i32 0, i32* %idx, align 4, !dbg !186
  %30 = load i32* %predict_idx, align 4, !dbg !187
  %31 = load i32* %9, align 4, !dbg !187
  %32 = icmp sge i32 %30, %31, !dbg !187
  br i1 %32, label %33, label %34, !dbg !187

; <label>:33                                      ; preds = %17
  br label %88, !dbg !188

; <label>:34                                      ; preds = %17
  br label %35, !dbg !189

; <label>:35                                      ; preds = %87, %34
  call void @llvm.dbg.declare(metadata !{i32* %left_idx}, metadata !190), !dbg !192
  %36 = load i32* %idx, align 4, !dbg !192
  %37 = sext i32 %36 to i64, !dbg !192
  %38 = load i32** %1, align 8, !dbg !192
  %39 = getelementptr inbounds i32* %38, i64 %37, !dbg !192
  %40 = load i32* %39, align 4, !dbg !192
  store i32 %40, i32* %left_idx, align 4, !dbg !192
  call void @llvm.dbg.declare(metadata !{i32* %right_idx}, metadata !193), !dbg !194
  %41 = load i32* %idx, align 4, !dbg !194
  %42 = sext i32 %41 to i64, !dbg !194
  %43 = load i32** %2, align 8, !dbg !194
  %44 = getelementptr inbounds i32* %43, i64 %42, !dbg !194
  %45 = load i32* %44, align 4, !dbg !194
  store i32 %45, i32* %right_idx, align 4, !dbg !194
  %46 = load i32* %left_idx, align 4, !dbg !195
  %47 = icmp eq i32 %46, 0, !dbg !195
  br i1 %47, label %51, label %48, !dbg !195

; <label>:48                                      ; preds = %35
  %49 = load i32* %right_idx, align 4, !dbg !195
  %50 = icmp eq i32 %49, 0, !dbg !195
  br i1 %50, label %51, label %61, !dbg !195

; <label>:51                                      ; preds = %48, %35
  %52 = load i32* %idx, align 4, !dbg !196
  %53 = sext i32 %52 to i64, !dbg !196
  %54 = load i32** %5, align 8, !dbg !196
  %55 = getelementptr inbounds i32* %54, i64 %53, !dbg !196
  %56 = load i32* %55, align 4, !dbg !196
  %57 = load i32* %predict_idx, align 4, !dbg !196
  %58 = sext i32 %57 to i64, !dbg !196
  %59 = load i32** %7, align 8, !dbg !196
  %60 = getelementptr inbounds i32* %59, i64 %58, !dbg !196
  store i32 %56, i32* %60, align 4, !dbg !196
  br label %88, !dbg !198

; <label>:61                                      ; preds = %48
  call void @llvm.dbg.declare(metadata !{float* %threshold}, metadata !199), !dbg !200
  %62 = load i32* %idx, align 4, !dbg !200
  %63 = sext i32 %62 to i64, !dbg !200
  %64 = load float** %4, align 8, !dbg !200
  %65 = getelementptr inbounds float* %64, i64 %63, !dbg !200
  %66 = load float* %65, align 4, !dbg !200
  store float %66, float* %threshold, align 4, !dbg !200
  call void @llvm.dbg.declare(metadata !{i16* %feature_idx}, metadata !201), !dbg !202
  %67 = load i32* %idx, align 4, !dbg !202
  %68 = sext i32 %67 to i64, !dbg !202
  %69 = load i16** %3, align 8, !dbg !202
  %70 = getelementptr inbounds i16* %69, i64 %68, !dbg !202
  %71 = load i16* %70, align 2, !dbg !202
  store i16 %71, i16* %feature_idx, align 2, !dbg !202
  %72 = load i32* %offset, align 4, !dbg !203
  %73 = load i16* %feature_idx, align 2, !dbg !203
  %74 = zext i16 %73 to i32, !dbg !203
  %75 = add nsw i32 %72, %74, !dbg !203
  %76 = sext i32 %75 to i64, !dbg !203
  %77 = load i32** %6, align 8, !dbg !203
  %78 = getelementptr inbounds i32* %77, i64 %76, !dbg !203
  %79 = load i32* %78, align 4, !dbg !203
  %80 = sitofp i32 %79 to float, !dbg !203
  %81 = load float* %threshold, align 4, !dbg !203
  %82 = fcmp olt float %80, %81, !dbg !203
  br i1 %82, label %83, label %85, !dbg !203

; <label>:83                                      ; preds = %61
  %84 = load i32* %left_idx, align 4, !dbg !204
  store i32 %84, i32* %idx, align 4, !dbg !204
  br label %87, !dbg !204

; <label>:85                                      ; preds = %61
  %86 = load i32* %right_idx, align 4, !dbg !205
  store i32 %86, i32* %idx, align 4, !dbg !205
  br label %87

; <label>:87                                      ; preds = %85, %83
  br label %35, !dbg !206

; <label>:88                                      ; preds = %51, %33, %16
  ret void, !dbg !207
}

!llvm.dbg.cu = !{!0}

!0 = metadata !{i32 786449, i32 0, i32 4, metadata !"new-func.cpp", metadata !"/home/mingyuanwu/cudatree", metadata !"clang version 3.2 (tags/RELEASE_32/final)", i1 true, i1 false, metadata !"", i32 0, metadata !1, metadata !1, metadata !3, metadata !28} ; [ DW_TAG_compile_unit ] [/home/mingyuanwu/cudatree/new-func.cpp] [DW_LANG_C_plus_plus]
!1 = metadata !{metadata !2}
!2 = metadata !{i32 0}
!3 = metadata !{metadata !4}
!4 = metadata !{metadata !5, metadata !13, metadata !16, metadata !19}
!5 = metadata !{i32 786478, i32 0, metadata !6, metadata !"reduce", metadata !"reduce", metadata !"_Z6reducePfPiS0_S_S0_S0_i", metadata !6, i32 5, metadata !7, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, void (float*, i32*, i32*, float*, i32*, i32*, i32)* @_Z6reducePfPiS0_S_S0_S0_i, null, null, metadata !1, i32 11} ; [ DW_TAG_subprogram ] [line 5] [def] [scope 11] [reduce]
!6 = metadata !{i32 786473, metadata !"new-func.cpp", metadata !"/home/mingyuanwu/cudatree", null} ; [ DW_TAG_file_type ]
!7 = metadata !{i32 786453, i32 0, metadata !"", i32 0, i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !8, i32 0, i32 0} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!8 = metadata !{null, metadata !9, metadata !11, metadata !11, metadata !9, metadata !11, metadata !11, metadata !12}
!9 = metadata !{i32 786447, null, metadata !"", null, i32 0, i64 64, i64 64, i64 0, i32 0, metadata !10} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from float]
!10 = metadata !{i32 786468, null, metadata !"float", null, i32 0, i64 32, i64 32, i64 0, i32 0, i32 4} ; [ DW_TAG_base_type ] [float] [line 0, size 32, align 32, offset 0, enc DW_ATE_float]
!11 = metadata !{i32 786447, null, metadata !"", null, i32 0, i64 64, i64 64, i64 0, i32 0, metadata !12} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from int]
!12 = metadata !{i32 786468, null, metadata !"int", null, i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!13 = metadata !{i32 786478, i32 0, metadata !6, metadata !"scan_bfs", metadata !"scan_bfs", metadata !"_Z8scan_bfsPiS_S_S_", metadata !6, i32 37, metadata !14, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, void (i32*, i32*, i32*, i32*)* @_Z8scan_bfsPiS_S_S_, null, null, metadata !1, i32 42} ; [ DW_TAG_subprogram ] [line 37] [def] [scope 42] [scan_bfs]
!14 = metadata !{i32 786453, i32 0, metadata !"", i32 0, i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !15, i32 0, i32 0} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!15 = metadata !{null, metadata !11, metadata !11, metadata !11, metadata !11}
!16 = metadata !{i32 786478, i32 0, metadata !6, metadata !"dfs_reduce", metadata !"dfs_reduce", metadata !"_Z10dfs_reducePfS_S_PiS0_i", metadata !6, i32 66, metadata !17, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, void (float*, float*, float*, i32*, i32*, i32)* @_Z10dfs_reducePfS_S_PiS0_i, null, null, metadata !1, i32 73} ; [ DW_TAG_subprogram ] [line 66] [def] [scope 73] [dfs_reduce]
!17 = metadata !{i32 786453, i32 0, metadata !"", i32 0, i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !18, i32 0, i32 0} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!18 = metadata !{null, metadata !9, metadata !9, metadata !9, metadata !11, metadata !11, metadata !12}
!19 = metadata !{i32 786478, i32 0, metadata !6, metadata !"predict", metadata !"predict", metadata !"_Z7predictPjS_PtPfPiS2_S2_ii", metadata !6, i32 102, metadata !20, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, void (i32*, i32*, i16*, float*, i32*, i32*, i32*, i32, i32)* @_Z7predictPjS_PtPfPiS2_S2_ii, null, null, metadata !1, i32 111} ; [ DW_TAG_subprogram ] [line 102] [def] [scope 111] [predict]
!20 = metadata !{i32 786453, i32 0, metadata !"", i32 0, i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !21, i32 0, i32 0} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!21 = metadata !{null, metadata !22, metadata !22, metadata !25, metadata !9, metadata !11, metadata !11, metadata !11, metadata !12, metadata !12}
!22 = metadata !{i32 786447, null, metadata !"", null, i32 0, i64 64, i64 64, i64 0, i32 0, metadata !23} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from uint32_t]
!23 = metadata !{i32 786454, null, metadata !"uint32_t", metadata !6, i32 51, i64 0, i64 0, i64 0, i32 0, metadata !24} ; [ DW_TAG_typedef ] [uint32_t] [line 51, size 0, align 0, offset 0] [from unsigned int]
!24 = metadata !{i32 786468, null, metadata !"unsigned int", null, i32 0, i64 32, i64 32, i64 0, i32 0, i32 7} ; [ DW_TAG_base_type ] [unsigned int] [line 0, size 32, align 32, offset 0, enc DW_ATE_unsigned]
!25 = metadata !{i32 786447, null, metadata !"", null, i32 0, i64 64, i64 64, i64 0, i32 0, metadata !26} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from uint16_t]
!26 = metadata !{i32 786454, null, metadata !"uint16_t", metadata !6, i32 49, i64 0, i64 0, i64 0, i32 0, metadata !27} ; [ DW_TAG_typedef ] [uint16_t] [line 49, size 0, align 0, offset 0] [from unsigned short]
!27 = metadata !{i32 786468, null, metadata !"unsigned short", null, i32 0, i64 16, i64 16, i64 0, i32 0, i32 7} ; [ DW_TAG_base_type ] [unsigned short] [line 0, size 16, align 16, offset 0, enc DW_ATE_unsigned]
!28 = metadata !{metadata !29}
!29 = metadata !{metadata !30, metadata !34}
!30 = metadata !{i32 786484, i32 0, metadata !13, metadata !"shared_count", metadata !"shared_count", metadata !"", metadata !6, i32 46, metadata !31, i32 1, i32 1, [32 x i32]* @_ZZ8scan_bfsPiS_S_S_E12shared_count} ; [ DW_TAG_variable ] [shared_count] [line 46] [local] [def]
!31 = metadata !{i32 786433, null, metadata !"", null, i32 0, i64 1024, i64 32, i32 0, i32 0, metadata !12, metadata !32, i32 0, i32 0} ; [ DW_TAG_array_type ] [line 0, size 1024, align 32, offset 0] [from int]
!32 = metadata !{metadata !33}
!33 = metadata !{i32 786465, i64 0, i64 31}       ; [ DW_TAG_subrange_type ] [0, 31]
!34 = metadata !{i32 786484, i32 0, metadata !16, metadata !"shared_imp", metadata !"shared_imp", metadata !"", metadata !6, i32 76, metadata !35, i32 1, i32 1, [100 x float]* @_ZZ10dfs_reducePfS_S_PiS0_iE10shared_imp} ; [ DW_TAG_variable ] [shared_imp] [line 76] [local] [def]
!35 = metadata !{i32 786433, null, metadata !"", null, i32 0, i64 3200, i64 32, i32 0, i32 0, metadata !10, metadata !36, i32 0, i32 0} ; [ DW_TAG_array_type ] [line 0, size 3200, align 32, offset 0] [from float]
!36 = metadata !{metadata !37}
!37 = metadata !{i32 786465, i64 0, i64 99}       ; [ DW_TAG_subrange_type ] [0, 99]
!38 = metadata !{i32 786689, metadata !5, metadata !"imp_min_2d", metadata !6, i32 16777221, metadata !9, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [imp_min_2d] [line 5]
!39 = metadata !{i32 5, i32 0, metadata !5, null}
!40 = metadata !{i32 786689, metadata !5, metadata !"split_2d", metadata !6, i32 33554438, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [split_2d] [line 6]
!41 = metadata !{i32 6, i32 0, metadata !5, null}
!42 = metadata !{i32 786689, metadata !5, metadata !"min_feature_idx_2d", metadata !6, i32 50331655, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [min_feature_idx_2d] [line 7]
!43 = metadata !{i32 7, i32 0, metadata !5, null}
!44 = metadata !{i32 786689, metadata !5, metadata !"imp_min", metadata !6, i32 67108872, metadata !9, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [imp_min] [line 8]
!45 = metadata !{i32 8, i32 0, metadata !5, null}
!46 = metadata !{i32 786689, metadata !5, metadata !"split", metadata !6, i32 83886089, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [split] [line 9]
!47 = metadata !{i32 9, i32 0, metadata !5, null}
!48 = metadata !{i32 786689, metadata !5, metadata !"min_feature", metadata !6, i32 100663306, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [min_feature] [line 10]
!49 = metadata !{i32 10, i32 0, metadata !5, null}
!50 = metadata !{i32 786689, metadata !5, metadata !"nblocks", metadata !6, i32 117440523, metadata !12, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [nblocks] [line 11]
!51 = metadata !{i32 11, i32 0, metadata !5, null}
!52 = metadata !{i32 786688, metadata !53, metadata !"offset", metadata !6, i32 13, metadata !12, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [offset] [line 13]
!53 = metadata !{i32 786443, metadata !5, i32 11, i32 0, metadata !6, i32 0} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/cudatree/new-func.cpp]
!54 = metadata !{i32 13, i32 0, metadata !53, null}
!55 = metadata !{i32 786688, metadata !53, metadata !"reg_min_split", metadata !6, i32 14, metadata !12, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [reg_min_split] [line 14]
!56 = metadata !{i32 14, i32 0, metadata !53, null}
!57 = metadata !{i32 786688, metadata !53, metadata !"reg_min_left", metadata !6, i32 15, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [reg_min_left] [line 15]
!58 = metadata !{i32 15, i32 0, metadata !53, null}
!59 = metadata !{i32 786688, metadata !53, metadata !"reg_min_right", metadata !6, i32 16, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [reg_min_right] [line 16]
!60 = metadata !{i32 16, i32 0, metadata !53, null}
!61 = metadata !{i32 786688, metadata !53, metadata !"reg_min_fidx", metadata !6, i32 17, metadata !12, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [reg_min_fidx] [line 17]
!62 = metadata !{i32 17, i32 0, metadata !53, null}
!63 = metadata !{i32 786688, metadata !64, metadata !"i", metadata !6, i32 19, metadata !12, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [i] [line 19]
!64 = metadata !{i32 786443, metadata !53, i32 19, i32 0, metadata !6, i32 1} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/cudatree/new-func.cpp]
!65 = metadata !{i32 19, i32 0, metadata !64, null}
!66 = metadata !{i32 786688, metadata !67, metadata !"left", metadata !6, i32 20, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [left] [line 20]
!67 = metadata !{i32 786443, metadata !64, i32 19, i32 0, metadata !6, i32 2} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/cudatree/new-func.cpp]
!68 = metadata !{i32 20, i32 0, metadata !67, null}
!69 = metadata !{i32 786688, metadata !67, metadata !"right", metadata !6, i32 21, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [right] [line 21]
!70 = metadata !{i32 21, i32 0, metadata !67, null}
!71 = metadata !{i32 22, i32 0, metadata !67, null}
!72 = metadata !{i32 23, i32 0, metadata !73, null}
!73 = metadata !{i32 786443, metadata !67, i32 22, i32 0, metadata !6, i32 3} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/cudatree/new-func.cpp]
!74 = metadata !{i32 24, i32 0, metadata !73, null}
!75 = metadata !{i32 25, i32 0, metadata !73, null}
!76 = metadata !{i32 26, i32 0, metadata !73, null}
!77 = metadata !{i32 27, i32 0, metadata !73, null}
!78 = metadata !{i32 28, i32 0, metadata !67, null}
!79 = metadata !{i32 30, i32 0, metadata !53, null}
!80 = metadata !{i32 31, i32 0, metadata !53, null}
!81 = metadata !{i32 32, i32 0, metadata !53, null}
!82 = metadata !{i32 33, i32 0, metadata !53, null}
!83 = metadata !{i32 34, i32 0, metadata !53, null}
!84 = metadata !{i32 786689, metadata !13, metadata !"labels", metadata !6, i32 16777254, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [labels] [line 38]
!85 = metadata !{i32 38, i32 0, metadata !13, null}
!86 = metadata !{i32 786689, metadata !13, metadata !"label_total", metadata !6, i32 33554471, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [label_total] [line 39]
!87 = metadata !{i32 39, i32 0, metadata !13, null}
!88 = metadata !{i32 786689, metadata !13, metadata !"si_idx", metadata !6, i32 50331688, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [si_idx] [line 40]
!89 = metadata !{i32 40, i32 0, metadata !13, null}
!90 = metadata !{i32 786689, metadata !13, metadata !"begin_stop_idx", metadata !6, i32 67108905, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [begin_stop_idx] [line 41]
!91 = metadata !{i32 41, i32 0, metadata !13, null}
!92 = metadata !{i32 786688, metadata !93, metadata !"reg_start_idx", metadata !6, i32 44, metadata !12, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [reg_start_idx] [line 44]
!93 = metadata !{i32 786443, metadata !13, i32 42, i32 0, metadata !6, i32 4} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/cudatree/new-func.cpp]
!94 = metadata !{i32 44, i32 0, metadata !93, null}
!95 = metadata !{i32 786688, metadata !93, metadata !"reg_stop_idx", metadata !6, i32 45, metadata !12, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [reg_stop_idx] [line 45]
!96 = metadata !{i32 45, i32 0, metadata !93, null}
!97 = metadata !{i32 786688, metadata !98, metadata !"i", metadata !6, i32 49, metadata !12, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [i] [line 49]
!98 = metadata !{i32 786443, metadata !93, i32 49, i32 0, metadata !6, i32 5} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/cudatree/new-func.cpp]
!99 = metadata !{i32 49, i32 0, metadata !98, null}
!100 = metadata !{i32 50, i32 0, metadata !98, null}
!101 = metadata !{i32 52, i32 0, metadata !93, null}
!102 = metadata !{i32 53, i32 0, metadata !93, null}
!103 = metadata !{i32 786688, metadata !93, metadata !"reg_si_idx", metadata !6, i32 55, metadata !12, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [reg_si_idx] [line 55]
!104 = metadata !{i32 55, i32 0, metadata !93, null}
!105 = metadata !{i32 58, i32 0, metadata !93, null}
!106 = metadata !{i32 786688, metadata !107, metadata !"i", metadata !6, i32 61, metadata !12, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [i] [line 61]
!107 = metadata !{i32 786443, metadata !93, i32 61, i32 0, metadata !6, i32 6} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/cudatree/new-func.cpp]
!108 = metadata !{i32 61, i32 0, metadata !107, null}
!109 = metadata !{i32 62, i32 0, metadata !107, null}
!110 = metadata !{i32 63, i32 0, metadata !93, null}
!111 = metadata !{i32 786689, metadata !16, metadata !"impurity_2d", metadata !6, i32 16777283, metadata !9, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [impurity_2d] [line 67]
!112 = metadata !{i32 67, i32 0, metadata !16, null}
!113 = metadata !{i32 786689, metadata !16, metadata !"impurity_left", metadata !6, i32 33554500, metadata !9, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [impurity_left] [line 68]
!114 = metadata !{i32 68, i32 0, metadata !16, null}
!115 = metadata !{i32 786689, metadata !16, metadata !"impurity_right", metadata !6, i32 50331717, metadata !9, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [impurity_right] [line 69]
!116 = metadata !{i32 69, i32 0, metadata !16, null}
!117 = metadata !{i32 786689, metadata !16, metadata !"split_2d", metadata !6, i32 67108934, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [split_2d] [line 70]
!118 = metadata !{i32 70, i32 0, metadata !16, null}
!119 = metadata !{i32 786689, metadata !16, metadata !"split_1d", metadata !6, i32 83886151, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [split_1d] [line 71]
!120 = metadata !{i32 71, i32 0, metadata !16, null}
!121 = metadata !{i32 786689, metadata !16, metadata !"n_block", metadata !6, i32 100663368, metadata !12, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [n_block] [line 72]
!122 = metadata !{i32 72, i32 0, metadata !16, null}
!123 = metadata !{i32 786688, metadata !124, metadata !"imp_offset", metadata !6, i32 77, metadata !125, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [imp_offset] [line 77]
!124 = metadata !{i32 786443, metadata !16, i32 73, i32 0, metadata !6, i32 7} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/cudatree/new-func.cpp]
!125 = metadata !{i32 786454, null, metadata !"int32_t", metadata !6, i32 38, i64 0, i64 0, i64 0, i32 0, metadata !12} ; [ DW_TAG_typedef ] [int32_t] [line 38, size 0, align 0, offset 0] [from int]
!126 = metadata !{i32 77, i32 0, metadata !124, null}
!127 = metadata !{i32 786688, metadata !124, metadata !"split_offset", metadata !6, i32 78, metadata !125, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [split_offset] [line 78]
!128 = metadata !{i32 78, i32 0, metadata !124, null}
!129 = metadata !{i32 786688, metadata !130, metadata !"t", metadata !6, i32 80, metadata !125, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [t] [line 80]
!130 = metadata !{i32 786443, metadata !124, i32 80, i32 0, metadata !6, i32 8} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/cudatree/new-func.cpp]
!131 = metadata !{i32 80, i32 0, metadata !130, null}
!132 = metadata !{i32 81, i32 0, metadata !130, null}
!133 = metadata !{i32 83, i32 0, metadata !124, null}
!134 = metadata !{i32 85, i32 0, metadata !124, null}
!135 = metadata !{i32 786688, metadata !136, metadata !"min_left", metadata !6, i32 86, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [min_left] [line 86]
!136 = metadata !{i32 786443, metadata !124, i32 85, i32 0, metadata !6, i32 9} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/cudatree/new-func.cpp]
!137 = metadata !{i32 86, i32 0, metadata !136, null}
!138 = metadata !{i32 786688, metadata !136, metadata !"min_right", metadata !6, i32 87, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [min_right] [line 87]
!139 = metadata !{i32 87, i32 0, metadata !136, null}
!140 = metadata !{i32 786688, metadata !136, metadata !"min_idx", metadata !6, i32 88, metadata !125, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [min_idx] [line 88]
!141 = metadata !{i32 88, i32 0, metadata !136, null}
!142 = metadata !{i32 786688, metadata !143, metadata !"i", metadata !6, i32 89, metadata !125, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [i] [line 89]
!143 = metadata !{i32 786443, metadata !136, i32 89, i32 0, metadata !6, i32 10} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/cudatree/new-func.cpp]
!144 = metadata !{i32 89, i32 0, metadata !143, null}
!145 = metadata !{i32 90, i32 0, metadata !143, null}
!146 = metadata !{i32 91, i32 0, metadata !147, null}
!147 = metadata !{i32 786443, metadata !143, i32 90, i32 0, metadata !6, i32 11} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/cudatree/new-func.cpp]
!148 = metadata !{i32 92, i32 0, metadata !147, null}
!149 = metadata !{i32 93, i32 0, metadata !147, null}
!150 = metadata !{i32 94, i32 0, metadata !147, null}
!151 = metadata !{i32 95, i32 0, metadata !136, null}
!152 = metadata !{i32 96, i32 0, metadata !136, null}
!153 = metadata !{i32 97, i32 0, metadata !136, null}
!154 = metadata !{i32 98, i32 0, metadata !136, null}
!155 = metadata !{i32 99, i32 0, metadata !124, null}
!156 = metadata !{i32 786689, metadata !19, metadata !"left_child_arr", metadata !6, i32 16777318, metadata !22, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [left_child_arr] [line 102]
!157 = metadata !{i32 102, i32 0, metadata !19, null}
!158 = metadata !{i32 786689, metadata !19, metadata !"right_child_arr", metadata !6, i32 33554535, metadata !22, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [right_child_arr] [line 103]
!159 = metadata !{i32 103, i32 0, metadata !19, null}
!160 = metadata !{i32 786689, metadata !19, metadata !"feature_array", metadata !6, i32 50331752, metadata !25, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [feature_array] [line 104]
!161 = metadata !{i32 104, i32 0, metadata !19, null}
!162 = metadata !{i32 786689, metadata !19, metadata !"threshold_array", metadata !6, i32 67108969, metadata !9, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [threshold_array] [line 105]
!163 = metadata !{i32 105, i32 0, metadata !19, null}
!164 = metadata !{i32 786689, metadata !19, metadata !"value_array", metadata !6, i32 83886186, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [value_array] [line 106]
!165 = metadata !{i32 106, i32 0, metadata !19, null}
!166 = metadata !{i32 786689, metadata !19, metadata !"predict_array", metadata !6, i32 100663403, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [predict_array] [line 107]
!167 = metadata !{i32 107, i32 0, metadata !19, null}
!168 = metadata !{i32 786689, metadata !19, metadata !"predict_res", metadata !6, i32 117440620, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [predict_res] [line 108]
!169 = metadata !{i32 108, i32 0, metadata !19, null}
!170 = metadata !{i32 786689, metadata !19, metadata !"n_features", metadata !6, i32 134217837, metadata !12, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [n_features] [line 109]
!171 = metadata !{i32 109, i32 0, metadata !19, null}
!172 = metadata !{i32 786689, metadata !19, metadata !"n_predict", metadata !6, i32 150995054, metadata !12, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [n_predict] [line 110]
!173 = metadata !{i32 110, i32 0, metadata !19, null}
!174 = metadata !{i32 786688, metadata !175, metadata !"lane_id", metadata !6, i32 114, metadata !12, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [lane_id] [line 114]
!175 = metadata !{i32 786443, metadata !19, i32 111, i32 0, metadata !6, i32 12} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/cudatree/new-func.cpp]
!176 = metadata !{i32 114, i32 0, metadata !175, null}
!177 = metadata !{i32 786688, metadata !175, metadata !"warp_id", metadata !6, i32 115, metadata !12, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [warp_id] [line 115]
!178 = metadata !{i32 115, i32 0, metadata !175, null}
!179 = metadata !{i32 117, i32 0, metadata !175, null}
!180 = metadata !{i32 118, i32 0, metadata !175, null}
!181 = metadata !{i32 786688, metadata !175, metadata !"predict_idx", metadata !6, i32 120, metadata !12, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [predict_idx] [line 120]
!182 = metadata !{i32 120, i32 0, metadata !175, null}
!183 = metadata !{i32 786688, metadata !175, metadata !"offset", metadata !6, i32 121, metadata !12, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [offset] [line 121]
!184 = metadata !{i32 121, i32 0, metadata !175, null}
!185 = metadata !{i32 786688, metadata !175, metadata !"idx", metadata !6, i32 122, metadata !12, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [idx] [line 122]
!186 = metadata !{i32 122, i32 0, metadata !175, null}
!187 = metadata !{i32 124, i32 0, metadata !175, null}
!188 = metadata !{i32 125, i32 0, metadata !175, null}
!189 = metadata !{i32 127, i32 0, metadata !175, null}
!190 = metadata !{i32 786688, metadata !191, metadata !"left_idx", metadata !6, i32 128, metadata !23, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [left_idx] [line 128]
!191 = metadata !{i32 786443, metadata !175, i32 127, i32 0, metadata !6, i32 13} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/cudatree/new-func.cpp]
!192 = metadata !{i32 128, i32 0, metadata !191, null}
!193 = metadata !{i32 786688, metadata !191, metadata !"right_idx", metadata !6, i32 129, metadata !23, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [right_idx] [line 129]
!194 = metadata !{i32 129, i32 0, metadata !191, null}
!195 = metadata !{i32 131, i32 0, metadata !191, null}
!196 = metadata !{i32 133, i32 0, metadata !197, null}
!197 = metadata !{i32 786443, metadata !191, i32 131, i32 0, metadata !6, i32 14} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/cudatree/new-func.cpp]
!198 = metadata !{i32 134, i32 0, metadata !197, null}
!199 = metadata !{i32 786688, metadata !191, metadata !"threshold", metadata !6, i32 137, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [threshold] [line 137]
!200 = metadata !{i32 137, i32 0, metadata !191, null}
!201 = metadata !{i32 786688, metadata !191, metadata !"feature_idx", metadata !6, i32 138, metadata !26, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [feature_idx] [line 138]
!202 = metadata !{i32 138, i32 0, metadata !191, null}
!203 = metadata !{i32 140, i32 0, metadata !191, null}
!204 = metadata !{i32 141, i32 0, metadata !191, null}
!205 = metadata !{i32 143, i32 0, metadata !191, null}
!206 = metadata !{i32 144, i32 0, metadata !191, null}
!207 = metadata !{i32 146, i32 0, metadata !175, null}
