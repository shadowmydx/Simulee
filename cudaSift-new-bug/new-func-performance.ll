; ModuleID = 'new-func'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.dim3 = type { i32, i32, i32 }

@_ZZ15MatchSiftPointsPfS_S_iiE9siftPoint = internal global [128 x float] zeroinitializer, section "__shared__", align 16
@_ZZ15MatchSiftPointsPfS_S_iiE4sums = internal global [256 x float] zeroinitializer, section "__shared__", align 16
@threadIdx = external global %struct.dim3
@blockIdx = external global %struct.dim3
@gridDim = external global %struct.dim3
@_ZZ16MatchSiftPoints2PfS_S_iiE11siftPoints1 = internal global [2048 x float] zeroinitializer, section "__shared__", align 16
@_ZZ16MatchSiftPoints2PfS_S_iiE11siftPoints2 = internal global [2048 x float] zeroinitializer, section "__shared__", align 16
@_ZZ11FindMaxCorrPfS_S_iiiE8maxScore = internal global [256 x float] zeroinitializer, section "__shared__", align 16
@_ZZ11FindMaxCorrPfS_S_iiiE8maxScor2 = internal global [256 x float] zeroinitializer, section "__shared__", align 16
@_ZZ11FindMaxCorrPfS_S_iiiE8maxIndex = internal global [256 x i32] zeroinitializer, section "__shared__", align 16
@_ZZ13FindMaxCorr_2PfS_S_iiiE8maxScore = internal global [256 x float] zeroinitializer, section "__shared__", align 16
@_ZZ13FindMaxCorr_2PfS_S_iiiE8maxScor2 = internal global [256 x float] zeroinitializer, section "__shared__", align 16
@_ZZ13FindMaxCorr_2PfS_S_iiiE8maxIndex = internal global [256 x i32] zeroinitializer, section "__shared__", align 16

define void @_Z15MatchSiftPointsPfS_S_ii(float* %sift1, float* %sift2, float* %corrData, i32 %numPts1, i32 %numPts2) uwtable noinline {
  %1 = alloca float*, align 8
  %2 = alloca float*, align 8
  %3 = alloca float*, align 8
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %tx = alloca i32, align 4
  %ty = alloca i32, align 4
  %p1 = alloca i32, align 4
  %p2 = alloca i32, align 4
  %ptr1 = alloca float*, align 8
  %ptr2 = alloca float*, align 8
  %i = alloca i32, align 4
  %sum = alloca float, align 4
  %j = alloca i32, align 4
  store float* %sift1, float** %1, align 8
  call void @llvm.dbg.declare(metadata !{float** %1}, metadata !41), !dbg !42
  store float* %sift2, float** %2, align 8
  call void @llvm.dbg.declare(metadata !{float** %2}, metadata !43), !dbg !42
  store float* %corrData, float** %3, align 8
  call void @llvm.dbg.declare(metadata !{float** %3}, metadata !44), !dbg !42
  store i32 %numPts1, i32* %4, align 4
  call void @llvm.dbg.declare(metadata !{i32* %4}, metadata !45), !dbg !42
  store i32 %numPts2, i32* %5, align 4
  call void @llvm.dbg.declare(metadata !{i32* %5}, metadata !46), !dbg !42
  call void @llvm.dbg.declare(metadata !{i32* %tx}, metadata !47), !dbg !50
  %6 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !50
  store i32 %6, i32* %tx, align 4, !dbg !50
  call void @llvm.dbg.declare(metadata !{i32* %ty}, metadata !51), !dbg !52
  %7 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 1), align 4, !dbg !52
  store i32 %7, i32* %ty, align 4, !dbg !52
  call void @llvm.dbg.declare(metadata !{i32* %p1}, metadata !53), !dbg !54
  %8 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 0), align 4, !dbg !54
  store i32 %8, i32* %p1, align 4, !dbg !54
  call void @llvm.dbg.declare(metadata !{i32* %p2}, metadata !55), !dbg !56
  %9 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 1), align 4, !dbg !56
  %10 = mul i32 %9, 16, !dbg !56
  %11 = load i32* %ty, align 4, !dbg !56
  %12 = add i32 %10, %11, !dbg !56
  store i32 %12, i32* %p2, align 4, !dbg !56
  call void @llvm.dbg.declare(metadata !{float** %ptr1}, metadata !57), !dbg !60
  %13 = load float** %1, align 8, !dbg !60
  store float* %13, float** %ptr1, align 8, !dbg !60
  call void @llvm.dbg.declare(metadata !{float** %ptr2}, metadata !61), !dbg !62
  %14 = load float** %2, align 8, !dbg !62
  store float* %14, float** %ptr2, align 8, !dbg !62
  call void @llvm.dbg.declare(metadata !{i32* %i}, metadata !63), !dbg !64
  %15 = load i32* %ty, align 4, !dbg !64
  %16 = mul nsw i32 16, %15, !dbg !64
  %17 = load i32* %tx, align 4, !dbg !64
  %18 = add nsw i32 %16, %17, !dbg !64
  store i32 %18, i32* %i, align 4, !dbg !64
  %19 = load i32* %ty, align 4, !dbg !65
  %20 = icmp slt i32 %19, 8, !dbg !65
  br i1 %20, label %21, label %30, !dbg !65

; <label>:21                                      ; preds = %0
  %22 = load i32* %i, align 4, !dbg !66
  %23 = sext i32 %22 to i64, !dbg !66
  %24 = load float** %ptr1, align 8, !dbg !66
  %25 = getelementptr inbounds float* %24, i64 %23, !dbg !66
  %26 = load float* %25, align 4, !dbg !66
  %27 = load i32* %i, align 4, !dbg !66
  %28 = sext i32 %27 to i64, !dbg !66
  %29 = getelementptr inbounds [128 x float]* @_ZZ15MatchSiftPointsPfS_S_iiE9siftPoint, i32 0, i64 %28, !dbg !66
  store float %26, float* %29, align 4, !dbg !66
  br label %30, !dbg !66

; <label>:30                                      ; preds = %21, %0
  call void @__syncthreads(), !dbg !67
  call void @llvm.dbg.declare(metadata !{float* %sum}, metadata !68), !dbg !69
  store float 0.000000e+00, float* %sum, align 4, !dbg !69
  %31 = load i32* %p2, align 4, !dbg !70
  %32 = load i32* %5, align 4, !dbg !70
  %33 = icmp slt i32 %31, %32, !dbg !70
  br i1 %33, label %34, label %61, !dbg !70

; <label>:34                                      ; preds = %30
  call void @llvm.dbg.declare(metadata !{i32* %j}, metadata !71), !dbg !73
  store i32 0, i32* %j, align 4, !dbg !73
  br label %35, !dbg !73

; <label>:35                                      ; preds = %57, %34
  %36 = load i32* %j, align 4, !dbg !73
  %37 = icmp slt i32 %36, 8, !dbg !73
  br i1 %37, label %38, label %60, !dbg !73

; <label>:38                                      ; preds = %35
  %39 = load i32* %j, align 4, !dbg !74
  %40 = mul nsw i32 16, %39, !dbg !74
  %41 = load i32* %tx, align 4, !dbg !74
  %42 = add nsw i32 %40, %41, !dbg !74
  %43 = sext i32 %42 to i64, !dbg !74
  %44 = getelementptr inbounds [128 x float]* @_ZZ15MatchSiftPointsPfS_S_iiE9siftPoint, i32 0, i64 %43, !dbg !74
  %45 = load float* %44, align 4, !dbg !74
  %46 = load i32* %j, align 4, !dbg !74
  %47 = mul nsw i32 16, %46, !dbg !74
  %48 = load i32* %tx, align 4, !dbg !74
  %49 = add nsw i32 %47, %48, !dbg !74
  %50 = sext i32 %49 to i64, !dbg !74
  %51 = load float** %ptr2, align 8, !dbg !74
  %52 = getelementptr inbounds float* %51, i64 %50, !dbg !74
  %53 = load float* %52, align 4, !dbg !74
  %54 = fmul float %45, %53, !dbg !74
  %55 = load float* %sum, align 4, !dbg !74
  %56 = fadd float %55, %54, !dbg !74
  store float %56, float* %sum, align 4, !dbg !74
  br label %57, !dbg !74

; <label>:57                                      ; preds = %38
  %58 = load i32* %j, align 4, !dbg !73
  %59 = add nsw i32 %58, 1, !dbg !73
  store i32 %59, i32* %j, align 4, !dbg !73
  br label %35, !dbg !73

; <label>:60                                      ; preds = %35
  br label %61, !dbg !74

; <label>:61                                      ; preds = %60, %30
  %62 = load float* %sum, align 4, !dbg !75
  %63 = load i32* %i, align 4, !dbg !75
  %64 = sext i32 %63 to i64, !dbg !75
  %65 = getelementptr inbounds [256 x float]* @_ZZ15MatchSiftPointsPfS_S_iiE4sums, i32 0, i64 %64, !dbg !75
  store float %62, float* %65, align 4, !dbg !75
  call void @__syncthreads(), !dbg !76
  %66 = load i32* %tx, align 4, !dbg !77
  %67 = icmp slt i32 %66, 8, !dbg !77
  br i1 %67, label %68, label %79, !dbg !77

; <label>:68                                      ; preds = %61
  %69 = load i32* %i, align 4, !dbg !78
  %70 = add nsw i32 %69, 8, !dbg !78
  %71 = sext i32 %70 to i64, !dbg !78
  %72 = getelementptr inbounds [256 x float]* @_ZZ15MatchSiftPointsPfS_S_iiE4sums, i32 0, i64 %71, !dbg !78
  %73 = load float* %72, align 4, !dbg !78
  %74 = load i32* %i, align 4, !dbg !78
  %75 = sext i32 %74 to i64, !dbg !78
  %76 = getelementptr inbounds [256 x float]* @_ZZ15MatchSiftPointsPfS_S_iiE4sums, i32 0, i64 %75, !dbg !78
  %77 = load float* %76, align 4, !dbg !78
  %78 = fadd float %77, %73, !dbg !78
  store float %78, float* %76, align 4, !dbg !78
  br label %79, !dbg !78

; <label>:79                                      ; preds = %68, %61
  call void @__syncthreads(), !dbg !79
  %80 = load i32* %tx, align 4, !dbg !80
  %81 = icmp slt i32 %80, 4, !dbg !80
  br i1 %81, label %82, label %93, !dbg !80

; <label>:82                                      ; preds = %79
  %83 = load i32* %i, align 4, !dbg !81
  %84 = add nsw i32 %83, 4, !dbg !81
  %85 = sext i32 %84 to i64, !dbg !81
  %86 = getelementptr inbounds [256 x float]* @_ZZ15MatchSiftPointsPfS_S_iiE4sums, i32 0, i64 %85, !dbg !81
  %87 = load float* %86, align 4, !dbg !81
  %88 = load i32* %i, align 4, !dbg !81
  %89 = sext i32 %88 to i64, !dbg !81
  %90 = getelementptr inbounds [256 x float]* @_ZZ15MatchSiftPointsPfS_S_iiE4sums, i32 0, i64 %89, !dbg !81
  %91 = load float* %90, align 4, !dbg !81
  %92 = fadd float %91, %87, !dbg !81
  store float %92, float* %90, align 4, !dbg !81
  br label %93, !dbg !81

; <label>:93                                      ; preds = %82, %79
  call void @__syncthreads(), !dbg !82
  %94 = load i32* %ty, align 4, !dbg !83
  %95 = icmp eq i32 %94, 0, !dbg !83
  br i1 %95, label %96, label %137, !dbg !83

; <label>:96                                      ; preds = %93
  %97 = load i32* %tx, align 4, !dbg !84
  %98 = mul nsw i32 16, %97, !dbg !84
  %99 = add nsw i32 %98, 0, !dbg !84
  %100 = sext i32 %99 to i64, !dbg !84
  %101 = getelementptr inbounds [256 x float]* @_ZZ15MatchSiftPointsPfS_S_iiE4sums, i32 0, i64 %100, !dbg !84
  %102 = load float* %101, align 4, !dbg !84
  %103 = load i32* %tx, align 4, !dbg !84
  %104 = mul nsw i32 16, %103, !dbg !84
  %105 = add nsw i32 %104, 1, !dbg !84
  %106 = sext i32 %105 to i64, !dbg !84
  %107 = getelementptr inbounds [256 x float]* @_ZZ15MatchSiftPointsPfS_S_iiE4sums, i32 0, i64 %106, !dbg !84
  %108 = load float* %107, align 4, !dbg !84
  %109 = fadd float %102, %108, !dbg !84
  %110 = load i32* %tx, align 4, !dbg !84
  %111 = mul nsw i32 16, %110, !dbg !84
  %112 = add nsw i32 %111, 2, !dbg !84
  %113 = sext i32 %112 to i64, !dbg !84
  %114 = getelementptr inbounds [256 x float]* @_ZZ15MatchSiftPointsPfS_S_iiE4sums, i32 0, i64 %113, !dbg !84
  %115 = load float* %114, align 4, !dbg !84
  %116 = fadd float %109, %115, !dbg !84
  %117 = load i32* %tx, align 4, !dbg !84
  %118 = mul nsw i32 16, %117, !dbg !84
  %119 = add nsw i32 %118, 3, !dbg !84
  %120 = sext i32 %119 to i64, !dbg !84
  %121 = getelementptr inbounds [256 x float]* @_ZZ15MatchSiftPointsPfS_S_iiE4sums, i32 0, i64 %120, !dbg !84
  %122 = load float* %121, align 4, !dbg !84
  %123 = fadd float %116, %122, !dbg !84
  store float %123, float* %sum, align 4, !dbg !84
  %124 = load float* %sum, align 4, !dbg !86
  %125 = load i32* %p1, align 4, !dbg !86
  %126 = load i32* getelementptr inbounds (%struct.dim3* @gridDim, i32 0, i32 1), align 4, !dbg !86
  %127 = mul i32 %125, %126, !dbg !86
  %128 = mul i32 %127, 16, !dbg !86
  %129 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 1), align 4, !dbg !86
  %130 = mul i32 %129, 16, !dbg !86
  %131 = add i32 %128, %130, !dbg !86
  %132 = load i32* %tx, align 4, !dbg !86
  %133 = add i32 %131, %132, !dbg !86
  %134 = zext i32 %133 to i64, !dbg !86
  %135 = load float** %3, align 8, !dbg !86
  %136 = getelementptr inbounds float* %135, i64 %134, !dbg !86
  store float %124, float* %136, align 4, !dbg !86
  br label %137, !dbg !87

; <label>:137                                     ; preds = %96, %93
  call void @__syncthreads(), !dbg !88
  ret void, !dbg !89
}

declare void @llvm.dbg.declare(metadata, metadata) nounwind readnone

declare void @__syncthreads() section "__device__"

define void @_Z16MatchSiftPoints2PfS_S_ii(float* %sift1, float* %sift2, float* %corrData, i32 %numPts1, i32 %numPts2) uwtable noinline {
  %1 = alloca float*, align 8
  %2 = alloca float*, align 8
  %3 = alloca float*, align 8
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %tx = alloca i32, align 4
  %ty = alloca i32, align 4
  %ptr1 = alloca float*, align 8
  %ptr2 = alloca float*, align 8
  %i = alloca i32, align 4
  %p1 = alloca i32, align 4
  %p2 = alloca i32, align 4
  %pt1 = alloca float*, align 8
  %pt2 = alloca float*, align 8
  %sum = alloca float, align 4
  %i1 = alloca i32, align 4
  %itx = alloca i32, align 4
  store float* %sift1, float** %1, align 8
  call void @llvm.dbg.declare(metadata !{float** %1}, metadata !90), !dbg !91
  store float* %sift2, float** %2, align 8
  call void @llvm.dbg.declare(metadata !{float** %2}, metadata !92), !dbg !91
  store float* %corrData, float** %3, align 8
  call void @llvm.dbg.declare(metadata !{float** %3}, metadata !93), !dbg !91
  store i32 %numPts1, i32* %4, align 4
  call void @llvm.dbg.declare(metadata !{i32* %4}, metadata !94), !dbg !91
  store i32 %numPts2, i32* %5, align 4
  call void @llvm.dbg.declare(metadata !{i32* %5}, metadata !95), !dbg !91
  call void @llvm.dbg.declare(metadata !{i32* %tx}, metadata !96), !dbg !98
  %6 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !98
  store i32 %6, i32* %tx, align 4, !dbg !98
  call void @llvm.dbg.declare(metadata !{i32* %ty}, metadata !99), !dbg !100
  %7 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 1), align 4, !dbg !100
  store i32 %7, i32* %ty, align 4, !dbg !100
  call void @llvm.dbg.declare(metadata !{float** %ptr1}, metadata !101), !dbg !102
  %8 = load float** %1, align 8, !dbg !102
  store float* %8, float** %ptr1, align 8, !dbg !102
  call void @llvm.dbg.declare(metadata !{float** %ptr2}, metadata !103), !dbg !104
  %9 = load float** %2, align 8, !dbg !104
  store float* %9, float** %ptr2, align 8, !dbg !104
  call void @llvm.dbg.declare(metadata !{i32* %i}, metadata !105), !dbg !107
  store i32 0, i32* %i, align 4, !dbg !107
  br label %10, !dbg !107

; <label>:10                                      ; preds = %48, %0
  %11 = load i32* %i, align 4, !dbg !107
  %12 = icmp slt i32 %11, 8, !dbg !107
  br i1 %12, label %13, label %51, !dbg !107

; <label>:13                                      ; preds = %10
  %14 = load i32* %i, align 4, !dbg !108
  %15 = mul nsw i32 16, %14, !dbg !108
  %16 = load i32* %tx, align 4, !dbg !108
  %17 = add nsw i32 %15, %16, !dbg !108
  %18 = sext i32 %17 to i64, !dbg !108
  %19 = load float** %ptr1, align 8, !dbg !108
  %20 = getelementptr inbounds float* %19, i64 %18, !dbg !108
  %21 = load float* %20, align 4, !dbg !108
  %22 = load i32* %ty, align 4, !dbg !108
  %23 = mul nsw i32 128, %22, !dbg !108
  %24 = load i32* %i, align 4, !dbg !108
  %25 = mul nsw i32 16, %24, !dbg !108
  %26 = add nsw i32 %23, %25, !dbg !108
  %27 = load i32* %tx, align 4, !dbg !108
  %28 = add nsw i32 %26, %27, !dbg !108
  %29 = sext i32 %28 to i64, !dbg !108
  %30 = getelementptr inbounds [2048 x float]* @_ZZ16MatchSiftPoints2PfS_S_iiE11siftPoints1, i32 0, i64 %29, !dbg !108
  store float %21, float* %30, align 4, !dbg !108
  %31 = load i32* %i, align 4, !dbg !110
  %32 = mul nsw i32 16, %31, !dbg !110
  %33 = load i32* %tx, align 4, !dbg !110
  %34 = add nsw i32 %32, %33, !dbg !110
  %35 = sext i32 %34 to i64, !dbg !110
  %36 = load float** %ptr2, align 8, !dbg !110
  %37 = getelementptr inbounds float* %36, i64 %35, !dbg !110
  %38 = load float* %37, align 4, !dbg !110
  %39 = load i32* %ty, align 4, !dbg !110
  %40 = mul nsw i32 128, %39, !dbg !110
  %41 = load i32* %i, align 4, !dbg !110
  %42 = mul nsw i32 16, %41, !dbg !110
  %43 = add nsw i32 %40, %42, !dbg !110
  %44 = load i32* %tx, align 4, !dbg !110
  %45 = add nsw i32 %43, %44, !dbg !110
  %46 = sext i32 %45 to i64, !dbg !110
  %47 = getelementptr inbounds [2048 x float]* @_ZZ16MatchSiftPoints2PfS_S_iiE11siftPoints2, i32 0, i64 %46, !dbg !110
  store float %38, float* %47, align 4, !dbg !110
  br label %48, !dbg !111

; <label>:48                                      ; preds = %13
  %49 = load i32* %i, align 4, !dbg !107
  %50 = add nsw i32 %49, 1, !dbg !107
  store i32 %50, i32* %i, align 4, !dbg !107
  br label %10, !dbg !107

; <label>:51                                      ; preds = %10
  call void @__syncthreads(), !dbg !112
  call void @llvm.dbg.declare(metadata !{i32* %p1}, metadata !113), !dbg !114
  %52 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 0), align 4, !dbg !114
  %53 = mul i32 %52, 16, !dbg !114
  %54 = load i32* %ty, align 4, !dbg !114
  %55 = add i32 %53, %54, !dbg !114
  store i32 %55, i32* %p1, align 4, !dbg !114
  call void @llvm.dbg.declare(metadata !{i32* %p2}, metadata !115), !dbg !116
  %56 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 1), align 4, !dbg !116
  %57 = mul i32 %56, 16, !dbg !116
  %58 = load i32* %tx, align 4, !dbg !116
  %59 = add i32 %57, %58, !dbg !116
  store i32 %59, i32* %p2, align 4, !dbg !116
  call void @llvm.dbg.declare(metadata !{float** %pt1}, metadata !117), !dbg !118
  %60 = load i32* %ty, align 4, !dbg !118
  %61 = mul nsw i32 %60, 128, !dbg !118
  %62 = sext i32 %61 to i64, !dbg !118
  %63 = getelementptr inbounds [2048 x float]* @_ZZ16MatchSiftPoints2PfS_S_iiE11siftPoints1, i32 0, i64 %62, !dbg !118
  store float* %63, float** %pt1, align 8, !dbg !118
  call void @llvm.dbg.declare(metadata !{float** %pt2}, metadata !119), !dbg !120
  %64 = load i32* %tx, align 4, !dbg !120
  %65 = mul nsw i32 %64, 128, !dbg !120
  %66 = sext i32 %65 to i64, !dbg !120
  %67 = getelementptr inbounds [2048 x float]* @_ZZ16MatchSiftPoints2PfS_S_iiE11siftPoints2, i32 0, i64 %66, !dbg !120
  store float* %67, float** %pt2, align 8, !dbg !120
  call void @llvm.dbg.declare(metadata !{float* %sum}, metadata !121), !dbg !122
  store float 0.000000e+00, float* %sum, align 4, !dbg !122
  call void @llvm.dbg.declare(metadata !{i32* %i1}, metadata !123), !dbg !125
  store i32 0, i32* %i1, align 4, !dbg !125
  br label %68, !dbg !125

; <label>:68                                      ; preds = %89, %51
  %69 = load i32* %i1, align 4, !dbg !125
  %70 = icmp slt i32 %69, 128, !dbg !125
  br i1 %70, label %71, label %92, !dbg !125

; <label>:71                                      ; preds = %68
  call void @llvm.dbg.declare(metadata !{i32* %itx}, metadata !126), !dbg !128
  %72 = load i32* %i1, align 4, !dbg !128
  %73 = load i32* %tx, align 4, !dbg !128
  %74 = add nsw i32 %72, %73, !dbg !128
  %75 = and i32 %74, 127, !dbg !128
  store i32 %75, i32* %itx, align 4, !dbg !128
  %76 = load i32* %itx, align 4, !dbg !129
  %77 = sext i32 %76 to i64, !dbg !129
  %78 = load float** %pt1, align 8, !dbg !129
  %79 = getelementptr inbounds float* %78, i64 %77, !dbg !129
  %80 = load float* %79, align 4, !dbg !129
  %81 = load i32* %itx, align 4, !dbg !129
  %82 = sext i32 %81 to i64, !dbg !129
  %83 = load float** %pt2, align 8, !dbg !129
  %84 = getelementptr inbounds float* %83, i64 %82, !dbg !129
  %85 = load float* %84, align 4, !dbg !129
  %86 = fmul float %80, %85, !dbg !129
  %87 = load float* %sum, align 4, !dbg !129
  %88 = fadd float %87, %86, !dbg !129
  store float %88, float* %sum, align 4, !dbg !129
  br label %89, !dbg !130

; <label>:89                                      ; preds = %71
  %90 = load i32* %i1, align 4, !dbg !125
  %91 = add nsw i32 %90, 1, !dbg !125
  store i32 %91, i32* %i1, align 4, !dbg !125
  br label %68, !dbg !125

; <label>:92                                      ; preds = %68
  %93 = load i32* %p1, align 4, !dbg !131
  %94 = load i32* %4, align 4, !dbg !131
  %95 = icmp slt i32 %93, %94, !dbg !131
  br i1 %95, label %96, label %114, !dbg !131

; <label>:96                                      ; preds = %92
  %97 = load i32* %p2, align 4, !dbg !132
  %98 = load i32* %5, align 4, !dbg !132
  %99 = icmp slt i32 %97, %98, !dbg !132
  br i1 %99, label %100, label %102, !dbg !132

; <label>:100                                     ; preds = %96
  %101 = load float* %sum, align 4, !dbg !132
  br label %103, !dbg !132

; <label>:102                                     ; preds = %96
  br label %103, !dbg !132

; <label>:103                                     ; preds = %102, %100
  %104 = phi float [ %101, %100 ], [ -1.000000e+00, %102 ], !dbg !132
  %105 = load i32* %p1, align 4, !dbg !132
  %106 = load i32* getelementptr inbounds (%struct.dim3* @gridDim, i32 0, i32 1), align 4, !dbg !132
  %107 = mul i32 %105, %106, !dbg !132
  %108 = mul i32 %107, 16, !dbg !132
  %109 = load i32* %p2, align 4, !dbg !132
  %110 = add i32 %108, %109, !dbg !132
  %111 = zext i32 %110 to i64, !dbg !132
  %112 = load float** %3, align 8, !dbg !132
  %113 = getelementptr inbounds float* %112, i64 %111, !dbg !132
  store float %104, float* %113, align 4, !dbg !132
  br label %114, !dbg !132

; <label>:114                                     ; preds = %103, %92
  ret void, !dbg !133
}

define void @_Z16MatchSiftPoints3PfS_S_ii(float* %sift1, float* %sift2, float* %corrData, i32 %numPts1, i32 %numPts2) nounwind uwtable noinline {
  %1 = alloca float*, align 8
  %2 = alloca float*, align 8
  %3 = alloca float*, align 8
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %tx = alloca i32, align 4
  %ty = alloca i32, align 4
  %p1 = alloca i32, align 4
  %p2 = alloca i32, align 4
  %pt1 = alloca float*, align 8
  %pt2 = alloca float*, align 8
  %sum = alloca float, align 4
  %i = alloca i32, align 4
  store float* %sift1, float** %1, align 8
  call void @llvm.dbg.declare(metadata !{float** %1}, metadata !134), !dbg !135
  store float* %sift2, float** %2, align 8
  call void @llvm.dbg.declare(metadata !{float** %2}, metadata !136), !dbg !135
  store float* %corrData, float** %3, align 8
  call void @llvm.dbg.declare(metadata !{float** %3}, metadata !137), !dbg !135
  store i32 %numPts1, i32* %4, align 4
  call void @llvm.dbg.declare(metadata !{i32* %4}, metadata !138), !dbg !135
  store i32 %numPts2, i32* %5, align 4
  call void @llvm.dbg.declare(metadata !{i32* %5}, metadata !139), !dbg !135
  call void @llvm.dbg.declare(metadata !{i32* %tx}, metadata !140), !dbg !142
  %6 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !142
  store i32 %6, i32* %tx, align 4, !dbg !142
  call void @llvm.dbg.declare(metadata !{i32* %ty}, metadata !143), !dbg !144
  %7 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 1), align 4, !dbg !144
  store i32 %7, i32* %ty, align 4, !dbg !144
  call void @llvm.dbg.declare(metadata !{i32* %p1}, metadata !145), !dbg !146
  %8 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 0), align 4, !dbg !146
  %9 = mul i32 %8, 16, !dbg !146
  %10 = load i32* %ty, align 4, !dbg !146
  %11 = add i32 %9, %10, !dbg !146
  store i32 %11, i32* %p1, align 4, !dbg !146
  call void @llvm.dbg.declare(metadata !{i32* %p2}, metadata !147), !dbg !148
  %12 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 1), align 4, !dbg !148
  %13 = mul i32 %12, 16, !dbg !148
  %14 = load i32* %tx, align 4, !dbg !148
  %15 = add i32 %13, %14, !dbg !148
  store i32 %15, i32* %p2, align 4, !dbg !148
  call void @llvm.dbg.declare(metadata !{float** %pt1}, metadata !149), !dbg !150
  %16 = load float** %1, align 8, !dbg !150
  store float* %16, float** %pt1, align 8, !dbg !150
  call void @llvm.dbg.declare(metadata !{float** %pt2}, metadata !151), !dbg !152
  %17 = load float** %2, align 8, !dbg !152
  store float* %17, float** %pt2, align 8, !dbg !152
  call void @llvm.dbg.declare(metadata !{float* %sum}, metadata !153), !dbg !154
  store float 0.000000e+00, float* %sum, align 4, !dbg !154
  call void @llvm.dbg.declare(metadata !{i32* %i}, metadata !155), !dbg !157
  store i32 0, i32* %i, align 4, !dbg !157
  br label %18, !dbg !157

; <label>:18                                      ; preds = %35, %0
  %19 = load i32* %i, align 4, !dbg !157
  %20 = icmp slt i32 %19, 128, !dbg !157
  br i1 %20, label %21, label %38, !dbg !157

; <label>:21                                      ; preds = %18
  %22 = load i32* %i, align 4, !dbg !158
  %23 = sext i32 %22 to i64, !dbg !158
  %24 = load float** %pt1, align 8, !dbg !158
  %25 = getelementptr inbounds float* %24, i64 %23, !dbg !158
  %26 = load float* %25, align 4, !dbg !158
  %27 = load i32* %i, align 4, !dbg !158
  %28 = sext i32 %27 to i64, !dbg !158
  %29 = load float** %pt2, align 8, !dbg !158
  %30 = getelementptr inbounds float* %29, i64 %28, !dbg !158
  %31 = load float* %30, align 4, !dbg !158
  %32 = fmul float %26, %31, !dbg !158
  %33 = load float* %sum, align 4, !dbg !158
  %34 = fadd float %33, %32, !dbg !158
  store float %34, float* %sum, align 4, !dbg !158
  br label %35, !dbg !158

; <label>:35                                      ; preds = %21
  %36 = load i32* %i, align 4, !dbg !157
  %37 = add nsw i32 %36, 1, !dbg !157
  store i32 %37, i32* %i, align 4, !dbg !157
  br label %18, !dbg !157

; <label>:38                                      ; preds = %18
  %39 = load i32* %p1, align 4, !dbg !159
  %40 = load i32* %4, align 4, !dbg !159
  %41 = icmp slt i32 %39, %40, !dbg !159
  br i1 %41, label %42, label %60, !dbg !159

; <label>:42                                      ; preds = %38
  %43 = load i32* %p2, align 4, !dbg !160
  %44 = load i32* %5, align 4, !dbg !160
  %45 = icmp slt i32 %43, %44, !dbg !160
  br i1 %45, label %46, label %48, !dbg !160

; <label>:46                                      ; preds = %42
  %47 = load float* %sum, align 4, !dbg !160
  br label %49, !dbg !160

; <label>:48                                      ; preds = %42
  br label %49, !dbg !160

; <label>:49                                      ; preds = %48, %46
  %50 = phi float [ %47, %46 ], [ -1.000000e+00, %48 ], !dbg !160
  %51 = load i32* %p1, align 4, !dbg !160
  %52 = load i32* getelementptr inbounds (%struct.dim3* @gridDim, i32 0, i32 1), align 4, !dbg !160
  %53 = mul i32 %51, %52, !dbg !160
  %54 = mul i32 %53, 16, !dbg !160
  %55 = load i32* %p2, align 4, !dbg !160
  %56 = add i32 %54, %55, !dbg !160
  %57 = zext i32 %56 to i64, !dbg !160
  %58 = load float** %3, align 8, !dbg !160
  %59 = getelementptr inbounds float* %58, i64 %57, !dbg !160
  store float %50, float* %59, align 4, !dbg !160
  br label %60, !dbg !160

; <label>:60                                      ; preds = %49, %38
  ret void, !dbg !161
}

define void @_Z16MatchSiftPoints4PfS_S_ii(float* %sift1, float* %sift2, float* %corrData, i32 %numPts1, i32 %numPts2) nounwind uwtable noinline {
  %1 = alloca float*, align 8
  %2 = alloca float*, align 8
  %3 = alloca float*, align 8
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %tx = alloca i32, align 4
  %ty = alloca i32, align 4
  %p1 = alloca i32, align 4
  %p2 = alloca i32, align 4
  %ptr1 = alloca float*, align 8
  %ptr2 = alloca float*, align 8
  %sum = alloca float, align 4
  %j = alloca i32, align 4
  store float* %sift1, float** %1, align 8
  call void @llvm.dbg.declare(metadata !{float** %1}, metadata !162), !dbg !163
  store float* %sift2, float** %2, align 8
  call void @llvm.dbg.declare(metadata !{float** %2}, metadata !164), !dbg !163
  store float* %corrData, float** %3, align 8
  call void @llvm.dbg.declare(metadata !{float** %3}, metadata !165), !dbg !163
  store i32 %numPts1, i32* %4, align 4
  call void @llvm.dbg.declare(metadata !{i32* %4}, metadata !166), !dbg !163
  store i32 %numPts2, i32* %5, align 4
  call void @llvm.dbg.declare(metadata !{i32* %5}, metadata !167), !dbg !163
  call void @llvm.dbg.declare(metadata !{i32* %tx}, metadata !168), !dbg !170
  %6 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !170
  store i32 %6, i32* %tx, align 4, !dbg !170
  call void @llvm.dbg.declare(metadata !{i32* %ty}, metadata !171), !dbg !172
  %7 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 1), align 4, !dbg !172
  store i32 %7, i32* %ty, align 4, !dbg !172
  call void @llvm.dbg.declare(metadata !{i32* %p1}, metadata !173), !dbg !174
  %8 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 0), align 4, !dbg !174
  store i32 %8, i32* %p1, align 4, !dbg !174
  call void @llvm.dbg.declare(metadata !{i32* %p2}, metadata !175), !dbg !176
  %9 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 1), align 4, !dbg !176
  %10 = mul i32 %9, 16, !dbg !176
  %11 = load i32* %ty, align 4, !dbg !176
  %12 = add i32 %10, %11, !dbg !176
  store i32 %12, i32* %p2, align 4, !dbg !176
  call void @llvm.dbg.declare(metadata !{float** %ptr1}, metadata !177), !dbg !178
  %13 = load float** %1, align 8, !dbg !178
  store float* %13, float** %ptr1, align 8, !dbg !178
  call void @llvm.dbg.declare(metadata !{float** %ptr2}, metadata !179), !dbg !180
  %14 = load float** %2, align 8, !dbg !180
  store float* %14, float** %ptr2, align 8, !dbg !180
  call void @llvm.dbg.declare(metadata !{float* %sum}, metadata !181), !dbg !182
  store float 0.000000e+00, float* %sum, align 4, !dbg !182
  %15 = load i32* %p2, align 4, !dbg !183
  %16 = load i32* %5, align 4, !dbg !183
  %17 = icmp slt i32 %15, %16, !dbg !183
  br i1 %17, label %18, label %46, !dbg !183

; <label>:18                                      ; preds = %0
  call void @llvm.dbg.declare(metadata !{i32* %j}, metadata !184), !dbg !186
  store i32 0, i32* %j, align 4, !dbg !186
  br label %19, !dbg !186

; <label>:19                                      ; preds = %42, %18
  %20 = load i32* %j, align 4, !dbg !186
  %21 = icmp slt i32 %20, 8, !dbg !186
  br i1 %21, label %22, label %45, !dbg !186

; <label>:22                                      ; preds = %19
  %23 = load i32* %j, align 4, !dbg !187
  %24 = mul nsw i32 16, %23, !dbg !187
  %25 = load i32* %tx, align 4, !dbg !187
  %26 = add nsw i32 %24, %25, !dbg !187
  %27 = sext i32 %26 to i64, !dbg !187
  %28 = load float** %ptr1, align 8, !dbg !187
  %29 = getelementptr inbounds float* %28, i64 %27, !dbg !187
  %30 = load float* %29, align 4, !dbg !187
  %31 = load i32* %j, align 4, !dbg !187
  %32 = mul nsw i32 16, %31, !dbg !187
  %33 = load i32* %tx, align 4, !dbg !187
  %34 = add nsw i32 %32, %33, !dbg !187
  %35 = sext i32 %34 to i64, !dbg !187
  %36 = load float** %ptr2, align 8, !dbg !187
  %37 = getelementptr inbounds float* %36, i64 %35, !dbg !187
  %38 = load float* %37, align 4, !dbg !187
  %39 = fmul float %30, %38, !dbg !187
  %40 = load float* %sum, align 4, !dbg !187
  %41 = fadd float %40, %39, !dbg !187
  store float %41, float* %sum, align 4, !dbg !187
  br label %42, !dbg !187

; <label>:42                                      ; preds = %22
  %43 = load i32* %j, align 4, !dbg !186
  %44 = add nsw i32 %43, 1, !dbg !186
  store i32 %44, i32* %j, align 4, !dbg !186
  br label %19, !dbg !186

; <label>:45                                      ; preds = %19
  br label %46, !dbg !187

; <label>:46                                      ; preds = %45, %0
  %47 = load i32* %tx, align 4, !dbg !188
  %48 = icmp eq i32 %47, 0, !dbg !188
  br i1 %48, label %49, label %63, !dbg !188

; <label>:49                                      ; preds = %46
  %50 = load float* %sum, align 4, !dbg !189
  %51 = load i32* %p1, align 4, !dbg !189
  %52 = load i32* getelementptr inbounds (%struct.dim3* @gridDim, i32 0, i32 1), align 4, !dbg !189
  %53 = mul i32 %51, %52, !dbg !189
  %54 = mul i32 %53, 16, !dbg !189
  %55 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 1), align 4, !dbg !189
  %56 = mul i32 %55, 16, !dbg !189
  %57 = add i32 %54, %56, !dbg !189
  %58 = load i32* %ty, align 4, !dbg !189
  %59 = add i32 %57, %58, !dbg !189
  %60 = zext i32 %59 to i64, !dbg !189
  %61 = load float** %3, align 8, !dbg !189
  %62 = getelementptr inbounds float* %61, i64 %60, !dbg !189
  store float %50, float* %62, align 4, !dbg !189
  br label %63, !dbg !189

; <label>:63                                      ; preds = %49, %46
  ret void, !dbg !190
}

define void @_Z11FindMaxCorrPfS_S_iii(float* %corrData, float* %sift1, float* %sift2, i32 %numPts1, i32 %corrWidth, i32 %siftSize) uwtable noinline {
  %1 = alloca float*, align 8
  %2 = alloca float*, align 8
  %3 = alloca float*, align 8
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %tx = alloca i32, align 4
  %ty = alloca i32, align 4
  %idx = alloca i32, align 4
  %p1 = alloca i32, align 4
  %corrs = alloca float*, align 8
  %i = alloca i32, align 4
  %val = alloca float, align 4
  %len = alloca i32, align 4
  %val1 = alloca float, align 4
  %i2 = alloca i32, align 4
  %va2 = alloca float, align 4
  store float* %corrData, float** %1, align 8
  call void @llvm.dbg.declare(metadata !{float** %1}, metadata !191), !dbg !192
  store float* %sift1, float** %2, align 8
  call void @llvm.dbg.declare(metadata !{float** %2}, metadata !193), !dbg !192
  store float* %sift2, float** %3, align 8
  call void @llvm.dbg.declare(metadata !{float** %3}, metadata !194), !dbg !192
  store i32 %numPts1, i32* %4, align 4
  call void @llvm.dbg.declare(metadata !{i32* %4}, metadata !195), !dbg !192
  store i32 %corrWidth, i32* %5, align 4
  call void @llvm.dbg.declare(metadata !{i32* %5}, metadata !196), !dbg !192
  store i32 %siftSize, i32* %6, align 4
  call void @llvm.dbg.declare(metadata !{i32* %6}, metadata !197), !dbg !192
  call void @llvm.dbg.declare(metadata !{i32* %tx}, metadata !198), !dbg !200
  %7 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !200
  store i32 %7, i32* %tx, align 4, !dbg !200
  call void @llvm.dbg.declare(metadata !{i32* %ty}, metadata !201), !dbg !202
  %8 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 1), align 4, !dbg !202
  store i32 %8, i32* %ty, align 4, !dbg !202
  call void @llvm.dbg.declare(metadata !{i32* %idx}, metadata !203), !dbg !204
  %9 = load i32* %ty, align 4, !dbg !204
  %10 = mul nsw i32 %9, 16, !dbg !204
  %11 = load i32* %tx, align 4, !dbg !204
  %12 = add nsw i32 %10, %11, !dbg !204
  store i32 %12, i32* %idx, align 4, !dbg !204
  call void @llvm.dbg.declare(metadata !{i32* %p1}, metadata !205), !dbg !206
  %13 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 0), align 4, !dbg !206
  %14 = mul i32 %13, 16, !dbg !206
  %15 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 1), align 4, !dbg !206
  %16 = add i32 %14, %15, !dbg !206
  store i32 %16, i32* %p1, align 4, !dbg !206
  %17 = load i32* %p1, align 4, !dbg !207
  %18 = load i32* %4, align 4, !dbg !207
  %19 = icmp sge i32 %17, %18, !dbg !207
  br i1 %19, label %20, label %23, !dbg !207

; <label>:20                                      ; preds = %0
  %21 = load i32* %4, align 4, !dbg !207
  %22 = sub nsw i32 %21, 1, !dbg !207
  br label %25, !dbg !207

; <label>:23                                      ; preds = %0
  %24 = load i32* %p1, align 4, !dbg !207
  br label %25, !dbg !207

; <label>:25                                      ; preds = %23, %20
  %26 = phi i32 [ %22, %20 ], [ %24, %23 ], !dbg !207
  store i32 %26, i32* %p1, align 4, !dbg !207
  %27 = load i32* %idx, align 4, !dbg !208
  %28 = sext i32 %27 to i64, !dbg !208
  %29 = getelementptr inbounds [256 x float]* @_ZZ11FindMaxCorrPfS_S_iiiE8maxScore, i32 0, i64 %28, !dbg !208
  store float -1.000000e+00, float* %29, align 4, !dbg !208
  %30 = load i32* %idx, align 4, !dbg !209
  %31 = sext i32 %30 to i64, !dbg !209
  %32 = getelementptr inbounds [256 x float]* @_ZZ11FindMaxCorrPfS_S_iiiE8maxScor2, i32 0, i64 %31, !dbg !209
  store float -1.000000e+00, float* %32, align 4, !dbg !209
  %33 = load i32* %idx, align 4, !dbg !210
  %34 = sext i32 %33 to i64, !dbg !210
  %35 = getelementptr inbounds [256 x i32]* @_ZZ11FindMaxCorrPfS_S_iiiE8maxIndex, i32 0, i64 %34, !dbg !210
  store i32 -1, i32* %35, align 4, !dbg !210
  call void @__syncthreads(), !dbg !211
  call void @llvm.dbg.declare(metadata !{float** %corrs}, metadata !212), !dbg !213
  %36 = load i32* %p1, align 4, !dbg !213
  %37 = load i32* %5, align 4, !dbg !213
  %38 = mul nsw i32 %36, %37, !dbg !213
  %39 = sext i32 %38 to i64, !dbg !213
  %40 = load float** %1, align 8, !dbg !213
  %41 = getelementptr inbounds float* %40, i64 %39, !dbg !213
  store float* %41, float** %corrs, align 8, !dbg !213
  call void @llvm.dbg.declare(metadata !{i32* %i}, metadata !214), !dbg !216
  %42 = load i32* %tx, align 4, !dbg !216
  store i32 %42, i32* %i, align 4, !dbg !216
  br label %43, !dbg !216

; <label>:43                                      ; preds = %89, %25
  %44 = load i32* %i, align 4, !dbg !216
  %45 = load i32* %5, align 4, !dbg !216
  %46 = icmp slt i32 %44, %45, !dbg !216
  br i1 %46, label %47, label %92, !dbg !216

; <label>:47                                      ; preds = %43
  call void @llvm.dbg.declare(metadata !{float* %val}, metadata !217), !dbg !219
  %48 = load i32* %i, align 4, !dbg !219
  %49 = sext i32 %48 to i64, !dbg !219
  %50 = load float** %corrs, align 8, !dbg !219
  %51 = getelementptr inbounds float* %50, i64 %49, !dbg !219
  %52 = load float* %51, align 4, !dbg !219
  store float %52, float* %val, align 4, !dbg !219
  %53 = load float* %val, align 4, !dbg !220
  %54 = load i32* %idx, align 4, !dbg !220
  %55 = sext i32 %54 to i64, !dbg !220
  %56 = getelementptr inbounds [256 x float]* @_ZZ11FindMaxCorrPfS_S_iiiE8maxScore, i32 0, i64 %55, !dbg !220
  %57 = load float* %56, align 4, !dbg !220
  %58 = fcmp ogt float %53, %57, !dbg !220
  br i1 %58, label %59, label %75, !dbg !220

; <label>:59                                      ; preds = %47
  %60 = load i32* %idx, align 4, !dbg !221
  %61 = sext i32 %60 to i64, !dbg !221
  %62 = getelementptr inbounds [256 x float]* @_ZZ11FindMaxCorrPfS_S_iiiE8maxScore, i32 0, i64 %61, !dbg !221
  %63 = load float* %62, align 4, !dbg !221
  %64 = load i32* %idx, align 4, !dbg !221
  %65 = sext i32 %64 to i64, !dbg !221
  %66 = getelementptr inbounds [256 x float]* @_ZZ11FindMaxCorrPfS_S_iiiE8maxScor2, i32 0, i64 %65, !dbg !221
  store float %63, float* %66, align 4, !dbg !221
  %67 = load float* %val, align 4, !dbg !223
  %68 = load i32* %idx, align 4, !dbg !223
  %69 = sext i32 %68 to i64, !dbg !223
  %70 = getelementptr inbounds [256 x float]* @_ZZ11FindMaxCorrPfS_S_iiiE8maxScore, i32 0, i64 %69, !dbg !223
  store float %67, float* %70, align 4, !dbg !223
  %71 = load i32* %i, align 4, !dbg !224
  %72 = load i32* %idx, align 4, !dbg !224
  %73 = sext i32 %72 to i64, !dbg !224
  %74 = getelementptr inbounds [256 x i32]* @_ZZ11FindMaxCorrPfS_S_iiiE8maxIndex, i32 0, i64 %73, !dbg !224
  store i32 %71, i32* %74, align 4, !dbg !224
  br label %88, !dbg !225

; <label>:75                                      ; preds = %47
  %76 = load float* %val, align 4, !dbg !226
  %77 = load i32* %idx, align 4, !dbg !226
  %78 = sext i32 %77 to i64, !dbg !226
  %79 = getelementptr inbounds [256 x float]* @_ZZ11FindMaxCorrPfS_S_iiiE8maxScor2, i32 0, i64 %78, !dbg !226
  %80 = load float* %79, align 4, !dbg !226
  %81 = fcmp ogt float %76, %80, !dbg !226
  br i1 %81, label %82, label %87, !dbg !226

; <label>:82                                      ; preds = %75
  %83 = load float* %val, align 4, !dbg !227
  %84 = load i32* %idx, align 4, !dbg !227
  %85 = sext i32 %84 to i64, !dbg !227
  %86 = getelementptr inbounds [256 x float]* @_ZZ11FindMaxCorrPfS_S_iiiE8maxScor2, i32 0, i64 %85, !dbg !227
  store float %83, float* %86, align 4, !dbg !227
  br label %87, !dbg !227

; <label>:87                                      ; preds = %82, %75
  br label %88

; <label>:88                                      ; preds = %87, %59
  br label %89, !dbg !228

; <label>:89                                      ; preds = %88
  %90 = load i32* %i, align 4, !dbg !216
  %91 = add nsw i32 %90, 16, !dbg !216
  store i32 %91, i32* %i, align 4, !dbg !216
  br label %43, !dbg !216

; <label>:92                                      ; preds = %43
  call void @__syncthreads(), !dbg !229
  call void @llvm.dbg.declare(metadata !{i32* %len}, metadata !230), !dbg !232
  store i32 8, i32* %len, align 4, !dbg !232
  br label %93, !dbg !232

; <label>:93                                      ; preds = %167, %92
  %94 = load i32* %len, align 4, !dbg !232
  %95 = icmp sgt i32 %94, 0, !dbg !232
  br i1 %95, label %96, label %170, !dbg !232

; <label>:96                                      ; preds = %93
  %97 = load i32* %tx, align 4, !dbg !233
  %98 = icmp slt i32 %97, 8, !dbg !233
  br i1 %98, label %99, label %166, !dbg !233

; <label>:99                                      ; preds = %96
  call void @llvm.dbg.declare(metadata !{float* %val1}, metadata !235), !dbg !237
  %100 = load i32* %idx, align 4, !dbg !237
  %101 = load i32* %len, align 4, !dbg !237
  %102 = add nsw i32 %100, %101, !dbg !237
  %103 = sext i32 %102 to i64, !dbg !237
  %104 = getelementptr inbounds [256 x float]* @_ZZ11FindMaxCorrPfS_S_iiiE8maxScore, i32 0, i64 %103, !dbg !237
  %105 = load float* %104, align 4, !dbg !237
  store float %105, float* %val1, align 4, !dbg !237
  call void @llvm.dbg.declare(metadata !{i32* %i2}, metadata !238), !dbg !239
  %106 = load i32* %idx, align 4, !dbg !239
  %107 = load i32* %len, align 4, !dbg !239
  %108 = add nsw i32 %106, %107, !dbg !239
  %109 = sext i32 %108 to i64, !dbg !239
  %110 = getelementptr inbounds [256 x i32]* @_ZZ11FindMaxCorrPfS_S_iiiE8maxIndex, i32 0, i64 %109, !dbg !239
  %111 = load i32* %110, align 4, !dbg !239
  store i32 %111, i32* %i2, align 4, !dbg !239
  %112 = load float* %val1, align 4, !dbg !240
  %113 = load i32* %idx, align 4, !dbg !240
  %114 = sext i32 %113 to i64, !dbg !240
  %115 = getelementptr inbounds [256 x float]* @_ZZ11FindMaxCorrPfS_S_iiiE8maxScore, i32 0, i64 %114, !dbg !240
  %116 = load float* %115, align 4, !dbg !240
  %117 = fcmp ogt float %112, %116, !dbg !240
  br i1 %117, label %118, label %134, !dbg !240

; <label>:118                                     ; preds = %99
  %119 = load i32* %idx, align 4, !dbg !241
  %120 = sext i32 %119 to i64, !dbg !241
  %121 = getelementptr inbounds [256 x float]* @_ZZ11FindMaxCorrPfS_S_iiiE8maxScore, i32 0, i64 %120, !dbg !241
  %122 = load float* %121, align 4, !dbg !241
  %123 = load i32* %idx, align 4, !dbg !241
  %124 = sext i32 %123 to i64, !dbg !241
  %125 = getelementptr inbounds [256 x float]* @_ZZ11FindMaxCorrPfS_S_iiiE8maxScor2, i32 0, i64 %124, !dbg !241
  store float %122, float* %125, align 4, !dbg !241
  %126 = load float* %val1, align 4, !dbg !243
  %127 = load i32* %idx, align 4, !dbg !243
  %128 = sext i32 %127 to i64, !dbg !243
  %129 = getelementptr inbounds [256 x float]* @_ZZ11FindMaxCorrPfS_S_iiiE8maxScore, i32 0, i64 %128, !dbg !243
  store float %126, float* %129, align 4, !dbg !243
  %130 = load i32* %i2, align 4, !dbg !244
  %131 = load i32* %idx, align 4, !dbg !244
  %132 = sext i32 %131 to i64, !dbg !244
  %133 = getelementptr inbounds [256 x i32]* @_ZZ11FindMaxCorrPfS_S_iiiE8maxIndex, i32 0, i64 %132, !dbg !244
  store i32 %130, i32* %133, align 4, !dbg !244
  br label %147, !dbg !245

; <label>:134                                     ; preds = %99
  %135 = load float* %val1, align 4, !dbg !246
  %136 = load i32* %idx, align 4, !dbg !246
  %137 = sext i32 %136 to i64, !dbg !246
  %138 = getelementptr inbounds [256 x float]* @_ZZ11FindMaxCorrPfS_S_iiiE8maxScor2, i32 0, i64 %137, !dbg !246
  %139 = load float* %138, align 4, !dbg !246
  %140 = fcmp ogt float %135, %139, !dbg !246
  br i1 %140, label %141, label %146, !dbg !246

; <label>:141                                     ; preds = %134
  %142 = load float* %val1, align 4, !dbg !247
  %143 = load i32* %idx, align 4, !dbg !247
  %144 = sext i32 %143 to i64, !dbg !247
  %145 = getelementptr inbounds [256 x float]* @_ZZ11FindMaxCorrPfS_S_iiiE8maxScor2, i32 0, i64 %144, !dbg !247
  store float %142, float* %145, align 4, !dbg !247
  br label %146, !dbg !247

; <label>:146                                     ; preds = %141, %134
  br label %147

; <label>:147                                     ; preds = %146, %118
  call void @llvm.dbg.declare(metadata !{float* %va2}, metadata !248), !dbg !249
  %148 = load i32* %idx, align 4, !dbg !249
  %149 = load i32* %len, align 4, !dbg !249
  %150 = add nsw i32 %148, %149, !dbg !249
  %151 = sext i32 %150 to i64, !dbg !249
  %152 = getelementptr inbounds [256 x float]* @_ZZ11FindMaxCorrPfS_S_iiiE8maxScor2, i32 0, i64 %151, !dbg !249
  %153 = load float* %152, align 4, !dbg !249
  store float %153, float* %va2, align 4, !dbg !249
  %154 = load float* %va2, align 4, !dbg !250
  %155 = load i32* %idx, align 4, !dbg !250
  %156 = sext i32 %155 to i64, !dbg !250
  %157 = getelementptr inbounds [256 x float]* @_ZZ11FindMaxCorrPfS_S_iiiE8maxScor2, i32 0, i64 %156, !dbg !250
  %158 = load float* %157, align 4, !dbg !250
  %159 = fcmp ogt float %154, %158, !dbg !250
  br i1 %159, label %160, label %165, !dbg !250

; <label>:160                                     ; preds = %147
  %161 = load float* %va2, align 4, !dbg !251
  %162 = load i32* %idx, align 4, !dbg !251
  %163 = sext i32 %162 to i64, !dbg !251
  %164 = getelementptr inbounds [256 x float]* @_ZZ11FindMaxCorrPfS_S_iiiE8maxScor2, i32 0, i64 %163, !dbg !251
  store float %161, float* %164, align 4, !dbg !251
  br label %165, !dbg !251

; <label>:165                                     ; preds = %160, %147
  br label %166, !dbg !252

; <label>:166                                     ; preds = %165, %96
  call void @__syncthreads(), !dbg !253
  br label %167, !dbg !254

; <label>:167                                     ; preds = %166
  %168 = load i32* %len, align 4, !dbg !232
  %169 = sdiv i32 %168, 2, !dbg !232
  store i32 %169, i32* %len, align 4, !dbg !232
  br label %93, !dbg !232

; <label>:170                                     ; preds = %93
  %171 = load i32* %tx, align 4, !dbg !255
  %172 = icmp eq i32 %171, 6, !dbg !255
  br i1 %172, label %173, label %183, !dbg !255

; <label>:173                                     ; preds = %170
  %174 = load i32* %ty, align 4, !dbg !256
  %175 = mul nsw i32 %174, 16, !dbg !256
  %176 = sext i32 %175 to i64, !dbg !256
  %177 = getelementptr inbounds [256 x float]* @_ZZ11FindMaxCorrPfS_S_iiiE8maxScore, i32 0, i64 %176, !dbg !256
  %178 = load float* %177, align 4, !dbg !256
  %179 = load i32* %p1, align 4, !dbg !256
  %180 = sext i32 %179 to i64, !dbg !256
  %181 = load float** %2, align 8, !dbg !256
  %182 = getelementptr inbounds float* %181, i64 %180, !dbg !256
  store float %178, float* %182, align 4, !dbg !256
  br label %183, !dbg !256

; <label>:183                                     ; preds = %173, %170
  %184 = load i32* %tx, align 4, !dbg !257
  %185 = icmp eq i32 %184, 7, !dbg !257
  br i1 %185, label %186, label %206, !dbg !257

; <label>:186                                     ; preds = %183
  %187 = load i32* %ty, align 4, !dbg !258
  %188 = mul nsw i32 %187, 16, !dbg !258
  %189 = sext i32 %188 to i64, !dbg !258
  %190 = getelementptr inbounds [256 x float]* @_ZZ11FindMaxCorrPfS_S_iiiE8maxScor2, i32 0, i64 %189, !dbg !258
  %191 = load float* %190, align 4, !dbg !258
  %192 = fpext float %191 to double, !dbg !258
  %193 = load i32* %ty, align 4, !dbg !258
  %194 = mul nsw i32 %193, 16, !dbg !258
  %195 = sext i32 %194 to i64, !dbg !258
  %196 = getelementptr inbounds [256 x float]* @_ZZ11FindMaxCorrPfS_S_iiiE8maxScore, i32 0, i64 %195, !dbg !258
  %197 = load float* %196, align 4, !dbg !258
  %198 = fpext float %197 to double, !dbg !258
  %199 = fadd double %198, 1.000000e-06, !dbg !258
  %200 = fdiv double %192, %199, !dbg !258
  %201 = fptrunc double %200 to float, !dbg !258
  %202 = load i32* %p1, align 4, !dbg !258
  %203 = sext i32 %202 to i64, !dbg !258
  %204 = load float** %2, align 8, !dbg !258
  %205 = getelementptr inbounds float* %204, i64 %203, !dbg !258
  store float %201, float* %205, align 4, !dbg !258
  br label %206, !dbg !258

; <label>:206                                     ; preds = %186, %183
  %207 = load i32* %tx, align 4, !dbg !259
  %208 = icmp eq i32 %207, 8, !dbg !259
  br i1 %208, label %209, label %220, !dbg !259

; <label>:209                                     ; preds = %206
  %210 = load i32* %ty, align 4, !dbg !260
  %211 = mul nsw i32 %210, 16, !dbg !260
  %212 = sext i32 %211 to i64, !dbg !260
  %213 = getelementptr inbounds [256 x i32]* @_ZZ11FindMaxCorrPfS_S_iiiE8maxIndex, i32 0, i64 %212, !dbg !260
  %214 = load i32* %213, align 4, !dbg !260
  %215 = sitofp i32 %214 to float, !dbg !260
  %216 = load i32* %p1, align 4, !dbg !260
  %217 = sext i32 %216 to i64, !dbg !260
  %218 = load float** %2, align 8, !dbg !260
  %219 = getelementptr inbounds float* %218, i64 %217, !dbg !260
  store float %215, float* %219, align 4, !dbg !260
  br label %220, !dbg !260

; <label>:220                                     ; preds = %209, %206
  %221 = load i32* %tx, align 4, !dbg !261
  %222 = icmp eq i32 %221, 9, !dbg !261
  br i1 %222, label %223, label %237, !dbg !261

; <label>:223                                     ; preds = %220
  %224 = load i32* %ty, align 4, !dbg !262
  %225 = mul nsw i32 %224, 16, !dbg !262
  %226 = sext i32 %225 to i64, !dbg !262
  %227 = getelementptr inbounds [256 x i32]* @_ZZ11FindMaxCorrPfS_S_iiiE8maxIndex, i32 0, i64 %226, !dbg !262
  %228 = load i32* %227, align 4, !dbg !262
  %229 = sext i32 %228 to i64, !dbg !262
  %230 = load float** %3, align 8, !dbg !262
  %231 = getelementptr inbounds float* %230, i64 %229, !dbg !262
  %232 = load float* %231, align 4, !dbg !262
  %233 = load i32* %p1, align 4, !dbg !262
  %234 = sext i32 %233 to i64, !dbg !262
  %235 = load float** %2, align 8, !dbg !262
  %236 = getelementptr inbounds float* %235, i64 %234, !dbg !262
  store float %232, float* %236, align 4, !dbg !262
  br label %237, !dbg !262

; <label>:237                                     ; preds = %223, %220
  %238 = load i32* %tx, align 4, !dbg !263
  %239 = icmp eq i32 %238, 10, !dbg !263
  br i1 %239, label %240, label %254, !dbg !263

; <label>:240                                     ; preds = %237
  %241 = load i32* %ty, align 4, !dbg !264
  %242 = mul nsw i32 %241, 16, !dbg !264
  %243 = sext i32 %242 to i64, !dbg !264
  %244 = getelementptr inbounds [256 x i32]* @_ZZ11FindMaxCorrPfS_S_iiiE8maxIndex, i32 0, i64 %243, !dbg !264
  %245 = load i32* %244, align 4, !dbg !264
  %246 = sext i32 %245 to i64, !dbg !264
  %247 = load float** %3, align 8, !dbg !264
  %248 = getelementptr inbounds float* %247, i64 %246, !dbg !264
  %249 = load float* %248, align 4, !dbg !264
  %250 = load i32* %p1, align 4, !dbg !264
  %251 = sext i32 %250 to i64, !dbg !264
  %252 = load float** %2, align 8, !dbg !264
  %253 = getelementptr inbounds float* %252, i64 %251, !dbg !264
  store float %249, float* %253, align 4, !dbg !264
  br label %254, !dbg !264

; <label>:254                                     ; preds = %240, %237

  ret void, !dbg !266
}

define void @_Z13FindMaxCorr_2PfS_S_iii(float* %corrData, float* %sift1, float* %sift2, i32 %numPts1, i32 %corrWidth, i32 %siftSize) uwtable noinline {
  %1 = alloca float*, align 8
  %2 = alloca float*, align 8
  %3 = alloca float*, align 8
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %tx = alloca i32, align 4
  %ty = alloca i32, align 4
  %idx = alloca i32, align 4
  %p1 = alloca i32, align 4
  %corrs = alloca float*, align 8
  %i = alloca i32, align 4
  %val = alloca float, align 4
  %len = alloca i32, align 4
  %val1 = alloca float, align 4
  %i2 = alloca i32, align 4
  %va2 = alloca float, align 4
  store float* %corrData, float** %1, align 8
  call void @llvm.dbg.declare(metadata !{float** %1}, metadata !267), !dbg !268
  store float* %sift1, float** %2, align 8
  call void @llvm.dbg.declare(metadata !{float** %2}, metadata !269), !dbg !268
  store float* %sift2, float** %3, align 8
  call void @llvm.dbg.declare(metadata !{float** %3}, metadata !270), !dbg !268
  store i32 %numPts1, i32* %4, align 4
  call void @llvm.dbg.declare(metadata !{i32* %4}, metadata !271), !dbg !268
  store i32 %corrWidth, i32* %5, align 4
  call void @llvm.dbg.declare(metadata !{i32* %5}, metadata !272), !dbg !268
  store i32 %siftSize, i32* %6, align 4
  call void @llvm.dbg.declare(metadata !{i32* %6}, metadata !273), !dbg !268
  call void @llvm.dbg.declare(metadata !{i32* %tx}, metadata !274), !dbg !276
  %7 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !276
  store i32 %7, i32* %tx, align 4, !dbg !276
  call void @llvm.dbg.declare(metadata !{i32* %ty}, metadata !277), !dbg !278
  %8 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 1), align 4, !dbg !278
  store i32 %8, i32* %ty, align 4, !dbg !278
  call void @llvm.dbg.declare(metadata !{i32* %idx}, metadata !279), !dbg !280
  %9 = load i32* %ty, align 4, !dbg !280
  %10 = mul nsw i32 %9, 16, !dbg !280
  %11 = load i32* %tx, align 4, !dbg !280
  %12 = add nsw i32 %10, %11, !dbg !280
  store i32 %12, i32* %idx, align 4, !dbg !280
  call void @llvm.dbg.declare(metadata !{i32* %p1}, metadata !281), !dbg !282
  %13 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 0), align 4, !dbg !282
  %14 = mul i32 %13, 16, !dbg !282
  %15 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 1), align 4, !dbg !282
  %16 = add i32 %14, %15, !dbg !282
  store i32 %16, i32* %p1, align 4, !dbg !282
  %17 = load i32* %p1, align 4, !dbg !283
  %18 = load i32* %4, align 4, !dbg !283
  %19 = icmp sge i32 %17, %18, !dbg !283
  br i1 %19, label %20, label %23, !dbg !283

; <label>:20                                      ; preds = %0
  %21 = load i32* %4, align 4, !dbg !283
  %22 = sub nsw i32 %21, 1, !dbg !283
  br label %25, !dbg !283

; <label>:23                                      ; preds = %0
  %24 = load i32* %p1, align 4, !dbg !283
  br label %25, !dbg !283

; <label>:25                                      ; preds = %23, %20
  %26 = phi i32 [ %22, %20 ], [ %24, %23 ], !dbg !283
  store i32 %26, i32* %p1, align 4, !dbg !283
  %27 = load i32* %idx, align 4, !dbg !284
  %28 = sext i32 %27 to i64, !dbg !284
  %29 = getelementptr inbounds [256 x float]* @_ZZ13FindMaxCorr_2PfS_S_iiiE8maxScore, i32 0, i64 %28, !dbg !284
  store float -1.000000e+00, float* %29, align 4, !dbg !284
  %30 = load i32* %idx, align 4, !dbg !285
  %31 = sext i32 %30 to i64, !dbg !285
  %32 = getelementptr inbounds [256 x float]* @_ZZ13FindMaxCorr_2PfS_S_iiiE8maxScor2, i32 0, i64 %31, !dbg !285
  store float -1.000000e+00, float* %32, align 4, !dbg !285
  %33 = load i32* %idx, align 4, !dbg !286
  %34 = sext i32 %33 to i64, !dbg !286
  %35 = getelementptr inbounds [256 x i32]* @_ZZ13FindMaxCorr_2PfS_S_iiiE8maxIndex, i32 0, i64 %34, !dbg !286
  store i32 -1, i32* %35, align 4, !dbg !286
  call void @__syncthreads(), !dbg !287
  call void @llvm.dbg.declare(metadata !{float** %corrs}, metadata !288), !dbg !289
  %36 = load i32* %p1, align 4, !dbg !289
  %37 = load i32* %5, align 4, !dbg !289
  %38 = mul nsw i32 %36, %37, !dbg !289
  %39 = sext i32 %38 to i64, !dbg !289
  %40 = load float** %1, align 8, !dbg !289
  %41 = getelementptr inbounds float* %40, i64 %39, !dbg !289
  store float* %41, float** %corrs, align 8, !dbg !289
  call void @llvm.dbg.declare(metadata !{i32* %i}, metadata !290), !dbg !292
  %42 = load i32* %tx, align 4, !dbg !292
  store i32 %42, i32* %i, align 4, !dbg !292
  br label %43, !dbg !292

; <label>:43                                      ; preds = %89, %25
  %44 = load i32* %i, align 4, !dbg !292
  %45 = load i32* %5, align 4, !dbg !292
  %46 = icmp slt i32 %44, %45, !dbg !292
  br i1 %46, label %47, label %92, !dbg !292

; <label>:47                                      ; preds = %43
  call void @llvm.dbg.declare(metadata !{float* %val}, metadata !293), !dbg !295
  %48 = load i32* %i, align 4, !dbg !295
  %49 = sext i32 %48 to i64, !dbg !295
  %50 = load float** %corrs, align 8, !dbg !295
  %51 = getelementptr inbounds float* %50, i64 %49, !dbg !295
  %52 = load float* %51, align 4, !dbg !295
  store float %52, float* %val, align 4, !dbg !295
  %53 = load float* %val, align 4, !dbg !296
  %54 = load i32* %idx, align 4, !dbg !296
  %55 = sext i32 %54 to i64, !dbg !296
  %56 = getelementptr inbounds [256 x float]* @_ZZ13FindMaxCorr_2PfS_S_iiiE8maxScore, i32 0, i64 %55, !dbg !296
  %57 = load float* %56, align 4, !dbg !296
  %58 = fcmp ogt float %53, %57, !dbg !296
  br i1 %58, label %59, label %75, !dbg !296

; <label>:59                                      ; preds = %47
  %60 = load i32* %idx, align 4, !dbg !297
  %61 = sext i32 %60 to i64, !dbg !297
  %62 = getelementptr inbounds [256 x float]* @_ZZ13FindMaxCorr_2PfS_S_iiiE8maxScore, i32 0, i64 %61, !dbg !297
  %63 = load float* %62, align 4, !dbg !297
  %64 = load i32* %idx, align 4, !dbg !297
  %65 = sext i32 %64 to i64, !dbg !297
  %66 = getelementptr inbounds [256 x float]* @_ZZ13FindMaxCorr_2PfS_S_iiiE8maxScor2, i32 0, i64 %65, !dbg !297
  store float %63, float* %66, align 4, !dbg !297
  %67 = load float* %val, align 4, !dbg !299
  %68 = load i32* %idx, align 4, !dbg !299
  %69 = sext i32 %68 to i64, !dbg !299
  %70 = getelementptr inbounds [256 x float]* @_ZZ13FindMaxCorr_2PfS_S_iiiE8maxScore, i32 0, i64 %69, !dbg !299
  store float %67, float* %70, align 4, !dbg !299
  %71 = load i32* %i, align 4, !dbg !300
  %72 = load i32* %idx, align 4, !dbg !300
  %73 = sext i32 %72 to i64, !dbg !300
  %74 = getelementptr inbounds [256 x i32]* @_ZZ13FindMaxCorr_2PfS_S_iiiE8maxIndex, i32 0, i64 %73, !dbg !300
  store i32 %71, i32* %74, align 4, !dbg !300
  br label %88, !dbg !301

; <label>:75                                      ; preds = %47
  %76 = load float* %val, align 4, !dbg !302
  %77 = load i32* %idx, align 4, !dbg !302
  %78 = sext i32 %77 to i64, !dbg !302
  %79 = getelementptr inbounds [256 x float]* @_ZZ13FindMaxCorr_2PfS_S_iiiE8maxScor2, i32 0, i64 %78, !dbg !302
  %80 = load float* %79, align 4, !dbg !302
  %81 = fcmp ogt float %76, %80, !dbg !302
  br i1 %81, label %82, label %87, !dbg !302

; <label>:82                                      ; preds = %75
  %83 = load float* %val, align 4, !dbg !303
  %84 = load i32* %idx, align 4, !dbg !303
  %85 = sext i32 %84 to i64, !dbg !303
  %86 = getelementptr inbounds [256 x float]* @_ZZ13FindMaxCorr_2PfS_S_iiiE8maxScor2, i32 0, i64 %85, !dbg !303
  store float %83, float* %86, align 4, !dbg !303
  br label %87, !dbg !303

; <label>:87                                      ; preds = %82, %75
  br label %88

; <label>:88                                      ; preds = %87, %59
  br label %89, !dbg !304

; <label>:89                                      ; preds = %88
  %90 = load i32* %i, align 4, !dbg !292
  %91 = add nsw i32 %90, 16, !dbg !292
  store i32 %91, i32* %i, align 4, !dbg !292
  br label %43, !dbg !292

; <label>:92                                      ; preds = %43
  call void @__syncthreads(), !dbg !305
  call void @llvm.dbg.declare(metadata !{i32* %len}, metadata !306), !dbg !308
  store i32 8, i32* %len, align 4, !dbg !308
  br label %93, !dbg !308

; <label>:93                                      ; preds = %167, %92
  %94 = load i32* %len, align 4, !dbg !308
  %95 = icmp sgt i32 %94, 0, !dbg !308
  br i1 %95, label %96, label %170, !dbg !308

; <label>:96                                      ; preds = %93
  %97 = load i32* %tx, align 4, !dbg !309
  %98 = icmp slt i32 %97, 8, !dbg !309
  br i1 %98, label %99, label %166, !dbg !309

; <label>:99                                      ; preds = %96
  call void @llvm.dbg.declare(metadata !{float* %val1}, metadata !311), !dbg !313
  %100 = load i32* %idx, align 4, !dbg !313
  %101 = load i32* %len, align 4, !dbg !313
  %102 = add nsw i32 %100, %101, !dbg !313
  %103 = sext i32 %102 to i64, !dbg !313
  %104 = getelementptr inbounds [256 x float]* @_ZZ13FindMaxCorr_2PfS_S_iiiE8maxScore, i32 0, i64 %103, !dbg !313
  %105 = load float* %104, align 4, !dbg !313
  store float %105, float* %val1, align 4, !dbg !313
  call void @llvm.dbg.declare(metadata !{i32* %i2}, metadata !314), !dbg !315
  %106 = load i32* %idx, align 4, !dbg !315
  %107 = load i32* %len, align 4, !dbg !315
  %108 = add nsw i32 %106, %107, !dbg !315
  %109 = sext i32 %108 to i64, !dbg !315
  %110 = getelementptr inbounds [256 x i32]* @_ZZ13FindMaxCorr_2PfS_S_iiiE8maxIndex, i32 0, i64 %109, !dbg !315
  %111 = load i32* %110, align 4, !dbg !315
  store i32 %111, i32* %i2, align 4, !dbg !315
  %112 = load float* %val1, align 4, !dbg !316
  %113 = load i32* %idx, align 4, !dbg !316
  %114 = sext i32 %113 to i64, !dbg !316
  %115 = getelementptr inbounds [256 x float]* @_ZZ13FindMaxCorr_2PfS_S_iiiE8maxScore, i32 0, i64 %114, !dbg !316
  %116 = load float* %115, align 4, !dbg !316
  %117 = fcmp ogt float %112, %116, !dbg !316
  br i1 %117, label %118, label %134, !dbg !316

; <label>:118                                     ; preds = %99
  %119 = load i32* %idx, align 4, !dbg !317
  %120 = sext i32 %119 to i64, !dbg !317
  %121 = getelementptr inbounds [256 x float]* @_ZZ13FindMaxCorr_2PfS_S_iiiE8maxScore, i32 0, i64 %120, !dbg !317
  %122 = load float* %121, align 4, !dbg !317
  %123 = load i32* %idx, align 4, !dbg !317
  %124 = sext i32 %123 to i64, !dbg !317
  %125 = getelementptr inbounds [256 x float]* @_ZZ13FindMaxCorr_2PfS_S_iiiE8maxScor2, i32 0, i64 %124, !dbg !317
  store float %122, float* %125, align 4, !dbg !317
  %126 = load float* %val1, align 4, !dbg !319
  %127 = load i32* %idx, align 4, !dbg !319
  %128 = sext i32 %127 to i64, !dbg !319
  %129 = getelementptr inbounds [256 x float]* @_ZZ13FindMaxCorr_2PfS_S_iiiE8maxScore, i32 0, i64 %128, !dbg !319
  store float %126, float* %129, align 4, !dbg !319
  %130 = load i32* %i2, align 4, !dbg !320
  %131 = load i32* %idx, align 4, !dbg !320
  %132 = sext i32 %131 to i64, !dbg !320
  %133 = getelementptr inbounds [256 x i32]* @_ZZ13FindMaxCorr_2PfS_S_iiiE8maxIndex, i32 0, i64 %132, !dbg !320
  store i32 %130, i32* %133, align 4, !dbg !320
  br label %147, !dbg !321

; <label>:134                                     ; preds = %99
  %135 = load float* %val1, align 4, !dbg !322
  %136 = load i32* %idx, align 4, !dbg !322
  %137 = sext i32 %136 to i64, !dbg !322
  %138 = getelementptr inbounds [256 x float]* @_ZZ13FindMaxCorr_2PfS_S_iiiE8maxScor2, i32 0, i64 %137, !dbg !322
  %139 = load float* %138, align 4, !dbg !322
  %140 = fcmp ogt float %135, %139, !dbg !322
  br i1 %140, label %141, label %146, !dbg !322

; <label>:141                                     ; preds = %134
  %142 = load float* %val1, align 4, !dbg !323
  %143 = load i32* %idx, align 4, !dbg !323
  %144 = sext i32 %143 to i64, !dbg !323
  %145 = getelementptr inbounds [256 x float]* @_ZZ13FindMaxCorr_2PfS_S_iiiE8maxScor2, i32 0, i64 %144, !dbg !323
  store float %142, float* %145, align 4, !dbg !323
  br label %146, !dbg !323

; <label>:146                                     ; preds = %141, %134
  br label %147

; <label>:147                                     ; preds = %146, %118
  call void @llvm.dbg.declare(metadata !{float* %va2}, metadata !324), !dbg !325
  %148 = load i32* %idx, align 4, !dbg !325
  %149 = load i32* %len, align 4, !dbg !325
  %150 = add nsw i32 %148, %149, !dbg !325
  %151 = sext i32 %150 to i64, !dbg !325
  %152 = getelementptr inbounds [256 x float]* @_ZZ13FindMaxCorr_2PfS_S_iiiE8maxScor2, i32 0, i64 %151, !dbg !325
  %153 = load float* %152, align 4, !dbg !325
  store float %153, float* %va2, align 4, !dbg !325
  %154 = load float* %va2, align 4, !dbg !326
  %155 = load i32* %idx, align 4, !dbg !326
  %156 = sext i32 %155 to i64, !dbg !326
  %157 = getelementptr inbounds [256 x float]* @_ZZ13FindMaxCorr_2PfS_S_iiiE8maxScor2, i32 0, i64 %156, !dbg !326
  %158 = load float* %157, align 4, !dbg !326
  %159 = fcmp ogt float %154, %158, !dbg !326
  br i1 %159, label %160, label %165, !dbg !326

; <label>:160                                     ; preds = %147
  %161 = load float* %va2, align 4, !dbg !327
  %162 = load i32* %idx, align 4, !dbg !327
  %163 = sext i32 %162 to i64, !dbg !327
  %164 = getelementptr inbounds [256 x float]* @_ZZ13FindMaxCorr_2PfS_S_iiiE8maxScor2, i32 0, i64 %163, !dbg !327
  store float %161, float* %164, align 4, !dbg !327
  br label %165, !dbg !327

; <label>:165                                     ; preds = %160, %147
  br label %166, !dbg !328

; <label>:166                                     ; preds = %165, %96
  call void @__syncthreads(), !dbg !329
  br label %167, !dbg !330

; <label>:167                                     ; preds = %166
  %168 = load i32* %len, align 4, !dbg !308
  %169 = sdiv i32 %168, 2, !dbg !308
  store i32 %169, i32* %len, align 4, !dbg !308
  br label %93, !dbg !308

; <label>:170                                     ; preds = %93
  %171 = load i32* %tx, align 4, !dbg !331
  %172 = icmp eq i32 %171, 6, !dbg !331
  br i1 %172, label %173, label %183, !dbg !331

; <label>:173                                     ; preds = %170
  %174 = load i32* %ty, align 4, !dbg !332
  %175 = mul nsw i32 %174, 16, !dbg !332
  %176 = sext i32 %175 to i64, !dbg !332
  %177 = getelementptr inbounds [256 x float]* @_ZZ13FindMaxCorr_2PfS_S_iiiE8maxScore, i32 0, i64 %176, !dbg !332
  %178 = load float* %177, align 4, !dbg !332
  %179 = load i32* %p1, align 4, !dbg !332
  %180 = sext i32 %179 to i64, !dbg !332
  %181 = load float** %2, align 8, !dbg !332
  %182 = getelementptr inbounds float* %181, i64 %180, !dbg !332
  store float %178, float* %182, align 4, !dbg !332
  br label %183, !dbg !332

; <label>:183                                     ; preds = %173, %170
  %184 = load i32* %tx, align 4, !dbg !333
  %185 = icmp eq i32 %184, 7, !dbg !333
  br i1 %185, label %186, label %206, !dbg !333

; <label>:186                                     ; preds = %183
  %187 = load i32* %ty, align 4, !dbg !334
  %188 = mul nsw i32 %187, 16, !dbg !334
  %189 = sext i32 %188 to i64, !dbg !334
  %190 = getelementptr inbounds [256 x float]* @_ZZ13FindMaxCorr_2PfS_S_iiiE8maxScor2, i32 0, i64 %189, !dbg !334
  %191 = load float* %190, align 4, !dbg !334
  %192 = fpext float %191 to double, !dbg !334
  %193 = load i32* %ty, align 4, !dbg !334
  %194 = mul nsw i32 %193, 16, !dbg !334
  %195 = sext i32 %194 to i64, !dbg !334
  %196 = getelementptr inbounds [256 x float]* @_ZZ13FindMaxCorr_2PfS_S_iiiE8maxScore, i32 0, i64 %195, !dbg !334
  %197 = load float* %196, align 4, !dbg !334
  %198 = fpext float %197 to double, !dbg !334
  %199 = fadd double %198, 1.000000e-06, !dbg !334
  %200 = fdiv double %192, %199, !dbg !334
  %201 = fptrunc double %200 to float, !dbg !334
  %202 = load i32* %p1, align 4, !dbg !334
  %203 = sext i32 %202 to i64, !dbg !334
  %204 = load float** %2, align 8, !dbg !334
  %205 = getelementptr inbounds float* %204, i64 %203, !dbg !334
  store float %201, float* %205, align 4, !dbg !334
  br label %206, !dbg !334

; <label>:206                                     ; preds = %186, %183
  %207 = load i32* %tx, align 4, !dbg !335
  %208 = icmp eq i32 %207, 8, !dbg !335
  br i1 %208, label %209, label %220, !dbg !335

; <label>:209                                     ; preds = %206
  %210 = load i32* %ty, align 4, !dbg !336
  %211 = mul nsw i32 %210, 16, !dbg !336
  %212 = sext i32 %211 to i64, !dbg !336
  %213 = getelementptr inbounds [256 x i32]* @_ZZ13FindMaxCorr_2PfS_S_iiiE8maxIndex, i32 0, i64 %212, !dbg !336
  %214 = load i32* %213, align 4, !dbg !336
  %215 = sitofp i32 %214 to float, !dbg !336
  %216 = load i32* %p1, align 4, !dbg !336
  %217 = sext i32 %216 to i64, !dbg !336
  %218 = load float** %2, align 8, !dbg !336
  %219 = getelementptr inbounds float* %218, i64 %217, !dbg !336
  store float %215, float* %219, align 4, !dbg !336
  br label %220, !dbg !336

; <label>:220                                     ; preds = %209, %206
  %221 = load i32* %tx, align 4, !dbg !337
  %222 = icmp eq i32 %221, 9, !dbg !337
  br i1 %222, label %223, label %237, !dbg !337

; <label>:223                                     ; preds = %220
  %224 = load i32* %ty, align 4, !dbg !338
  %225 = mul nsw i32 %224, 16, !dbg !338
  %226 = sext i32 %225 to i64, !dbg !338
  %227 = getelementptr inbounds [256 x i32]* @_ZZ13FindMaxCorr_2PfS_S_iiiE8maxIndex, i32 0, i64 %226, !dbg !338
  %228 = load i32* %227, align 4, !dbg !338
  %229 = sext i32 %228 to i64, !dbg !338
  %230 = load float** %3, align 8, !dbg !338
  %231 = getelementptr inbounds float* %230, i64 %229, !dbg !338
  %232 = load float* %231, align 4, !dbg !338
  %233 = load i32* %p1, align 4, !dbg !338
  %234 = sext i32 %233 to i64, !dbg !338
  %235 = load float** %2, align 8, !dbg !338
  %236 = getelementptr inbounds float* %235, i64 %234, !dbg !338
  store float %232, float* %236, align 4, !dbg !338
  br label %237, !dbg !338

; <label>:237                                     ; preds = %223, %220
  %238 = load i32* %tx, align 4, !dbg !339
  %239 = icmp eq i32 %238, 10, !dbg !339
  br i1 %239, label %240, label %254, !dbg !339

; <label>:240                                     ; preds = %237
  %241 = load i32* %ty, align 4, !dbg !340
  %242 = mul nsw i32 %241, 16, !dbg !340
  %243 = sext i32 %242 to i64, !dbg !340
  %244 = getelementptr inbounds [256 x i32]* @_ZZ13FindMaxCorr_2PfS_S_iiiE8maxIndex, i32 0, i64 %243, !dbg !340
  %245 = load i32* %244, align 4, !dbg !340
  %246 = sext i32 %245 to i64, !dbg !340
  %247 = load float** %3, align 8, !dbg !340
  %248 = getelementptr inbounds float* %247, i64 %246, !dbg !340
  %249 = load float* %248, align 4, !dbg !340
  %250 = load i32* %p1, align 4, !dbg !340
  %251 = sext i32 %250 to i64, !dbg !340
  %252 = load float** %2, align 8, !dbg !340
  %253 = getelementptr inbounds float* %252, i64 %251, !dbg !340
  store float %249, float* %253, align 4, !dbg !340
  br label %254, !dbg !340

; <label>:254                                     ; preds = %240, %237
  ret void, !dbg !341
}

!llvm.dbg.cu = !{!0}

!0 = metadata !{i32 786449, i32 0, i32 4, metadata !"new-func.cpp", metadata !"/home/mingyuanwu/cuda-sift-new-bug", metadata !"clang version 3.2 (tags/RELEASE_32/final)", i1 true, i1 false, metadata !"", i32 0, metadata !1, metadata !1, metadata !3, metadata !19} ; [ DW_TAG_compile_unit ] [/home/mingyuanwu/cuda-sift-new-bug/new-func.cpp] [DW_LANG_C_plus_plus]
!1 = metadata !{metadata !2}
!2 = metadata !{i32 0}
!3 = metadata !{metadata !4}
!4 = metadata !{metadata !5, metadata !12, metadata !13, metadata !14, metadata !15, metadata !18}
!5 = metadata !{i32 786478, i32 0, metadata !6, metadata !"MatchSiftPoints", metadata !"MatchSiftPoints", metadata !"_Z15MatchSiftPointsPfS_S_ii", metadata !6, i32 1, metadata !7, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, void (float*, float*, float*, i32, i32)* @_Z15MatchSiftPointsPfS_S_ii, null, null, metadata !1, i32 2} ; [ DW_TAG_subprogram ] [line 1] [def] [scope 2] [MatchSiftPoints]
!6 = metadata !{i32 786473, metadata !"new-func.cpp", metadata !"/home/mingyuanwu/cuda-sift-new-bug", null} ; [ DW_TAG_file_type ]
!7 = metadata !{i32 786453, i32 0, metadata !"", i32 0, i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !8, i32 0, i32 0} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!8 = metadata !{null, metadata !9, metadata !9, metadata !9, metadata !11, metadata !11}
!9 = metadata !{i32 786447, null, metadata !"", null, i32 0, i64 64, i64 64, i64 0, i32 0, metadata !10} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from float]
!10 = metadata !{i32 786468, null, metadata !"float", null, i32 0, i64 32, i64 32, i64 0, i32 0, i32 4} ; [ DW_TAG_base_type ] [float] [line 0, size 32, align 32, offset 0, enc DW_ATE_float]
!11 = metadata !{i32 786468, null, metadata !"int", null, i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!12 = metadata !{i32 786478, i32 0, metadata !6, metadata !"MatchSiftPoints2", metadata !"MatchSiftPoints2", metadata !"_Z16MatchSiftPoints2PfS_S_ii", metadata !6, i32 34, metadata !7, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, void (float*, float*, float*, i32, i32)* @_Z16MatchSiftPoints2PfS_S_ii, null, null, metadata !1, i32 35} ; [ DW_TAG_subprogram ] [line 34] [def] [scope 35] [MatchSiftPoints2]
!13 = metadata !{i32 786478, i32 0, metadata !6, metadata !"MatchSiftPoints3", metadata !"MatchSiftPoints3", metadata !"_Z16MatchSiftPoints3PfS_S_ii", metadata !6, i32 61, metadata !7, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, void (float*, float*, float*, i32, i32)* @_Z16MatchSiftPoints3PfS_S_ii, null, null, metadata !1, i32 62} ; [ DW_TAG_subprogram ] [line 61] [def] [scope 62] [MatchSiftPoints3]
!14 = metadata !{i32 786478, i32 0, metadata !6, metadata !"MatchSiftPoints4", metadata !"MatchSiftPoints4", metadata !"_Z16MatchSiftPoints4PfS_S_ii", metadata !6, i32 76, metadata !7, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, void (float*, float*, float*, i32, i32)* @_Z16MatchSiftPoints4PfS_S_ii, null, null, metadata !1, i32 77} ; [ DW_TAG_subprogram ] [line 76] [def] [scope 77] [MatchSiftPoints4]
!15 = metadata !{i32 786478, i32 0, metadata !6, metadata !"FindMaxCorr", metadata !"FindMaxCorr", metadata !"_Z11FindMaxCorrPfS_S_iii", metadata !6, i32 92, metadata !16, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, void (float*, float*, float*, i32, i32, i32)* @_Z11FindMaxCorrPfS_S_iii, null, null, metadata !1, i32 93} ; [ DW_TAG_subprogram ] [line 92] [def] [scope 93] [FindMaxCorr]
!16 = metadata !{i32 786453, i32 0, metadata !"", i32 0, i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !17, i32 0, i32 0} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!17 = metadata !{null, metadata !9, metadata !9, metadata !9, metadata !11, metadata !11, metadata !11}
!18 = metadata !{i32 786478, i32 0, metadata !6, metadata !"FindMaxCorr_2", metadata !"FindMaxCorr_2", metadata !"_Z13FindMaxCorr_2PfS_S_iii", metadata !6, i32 147, metadata !16, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, void (float*, float*, float*, i32, i32, i32)* @_Z13FindMaxCorr_2PfS_S_iii, null, null, metadata !1, i32 148} ; [ DW_TAG_subprogram ] [line 147] [def] [scope 148] [FindMaxCorr_2]
!19 = metadata !{metadata !20}
!20 = metadata !{metadata !21, metadata !25, metadata !29, metadata !33, metadata !34, metadata !35, metadata !36, metadata !38, metadata !39, metadata !40}
!21 = metadata !{i32 786484, i32 0, metadata !5, metadata !"siftPoint", metadata !"siftPoint", metadata !"", metadata !6, i32 3, metadata !22, i32 1, i32 1, [128 x float]* @_ZZ15MatchSiftPointsPfS_S_iiE9siftPoint} ; [ DW_TAG_variable ] [siftPoint] [line 3] [local] [def]
!22 = metadata !{i32 786433, null, metadata !"", null, i32 0, i64 4096, i64 32, i32 0, i32 0, metadata !10, metadata !23, i32 0, i32 0} ; [ DW_TAG_array_type ] [line 0, size 4096, align 32, offset 0] [from float]
!23 = metadata !{metadata !24}
!24 = metadata !{i32 786465, i64 0, i64 127}      ; [ DW_TAG_subrange_type ] [0, 127]
!25 = metadata !{i32 786484, i32 0, metadata !5, metadata !"sums", metadata !"sums", metadata !"", metadata !6, i32 4, metadata !26, i32 1, i32 1, [256 x float]* @_ZZ15MatchSiftPointsPfS_S_iiE4sums} ; [ DW_TAG_variable ] [sums] [line 4] [local] [def]
!26 = metadata !{i32 786433, null, metadata !"", null, i32 0, i64 8192, i64 32, i32 0, i32 0, metadata !10, metadata !27, i32 0, i32 0} ; [ DW_TAG_array_type ] [line 0, size 8192, align 32, offset 0] [from float]
!27 = metadata !{metadata !28}
!28 = metadata !{i32 786465, i64 0, i64 255}      ; [ DW_TAG_subrange_type ] [0, 255]
!29 = metadata !{i32 786484, i32 0, metadata !12, metadata !"siftPoints1", metadata !"siftPoints1", metadata !"", metadata !6, i32 36, metadata !30, i32 1, i32 1, [2048 x float]* @_ZZ16MatchSiftPoints2PfS_S_iiE11siftPoints1} ; [ DW_TAG_variable ] [siftPoints1] [line 36] [local] [def]
!30 = metadata !{i32 786433, null, metadata !"", null, i32 0, i64 65536, i64 32, i32 0, i32 0, metadata !10, metadata !31, i32 0, i32 0} ; [ DW_TAG_array_type ] [line 0, size 65536, align 32, offset 0] [from float]
!31 = metadata !{metadata !32}
!32 = metadata !{i32 786465, i64 0, i64 2047}     ; [ DW_TAG_subrange_type ] [0, 2047]
!33 = metadata !{i32 786484, i32 0, metadata !12, metadata !"siftPoints2", metadata !"siftPoints2", metadata !"", metadata !6, i32 37, metadata !30, i32 1, i32 1, [2048 x float]* @_ZZ16MatchSiftPoints2PfS_S_iiE11siftPoints2} ; [ DW_TAG_variable ] [siftPoints2] [line 37] [local] [def]
!34 = metadata !{i32 786484, i32 0, metadata !15, metadata !"maxScore", metadata !"maxScore", metadata !"", metadata !6, i32 94, metadata !26, i32 1, i32 1, [256 x float]* @_ZZ11FindMaxCorrPfS_S_iiiE8maxScore} ; [ DW_TAG_variable ] [maxScore] [line 94] [local] [def]
!35 = metadata !{i32 786484, i32 0, metadata !15, metadata !"maxScor2", metadata !"maxScor2", metadata !"", metadata !6, i32 95, metadata !26, i32 1, i32 1, [256 x float]* @_ZZ11FindMaxCorrPfS_S_iiiE8maxScor2} ; [ DW_TAG_variable ] [maxScor2] [line 95] [local] [def]
!36 = metadata !{i32 786484, i32 0, metadata !15, metadata !"maxIndex", metadata !"maxIndex", metadata !"", metadata !6, i32 96, metadata !37, i32 1, i32 1, [256 x i32]* @_ZZ11FindMaxCorrPfS_S_iiiE8maxIndex} ; [ DW_TAG_variable ] [maxIndex] [line 96] [local] [def]
!37 = metadata !{i32 786433, null, metadata !"", null, i32 0, i64 8192, i64 32, i32 0, i32 0, metadata !11, metadata !27, i32 0, i32 0} ; [ DW_TAG_array_type ] [line 0, size 8192, align 32, offset 0] [from int]
!38 = metadata !{i32 786484, i32 0, metadata !18, metadata !"maxScore", metadata !"maxScore", metadata !"", metadata !6, i32 149, metadata !26, i32 1, i32 1, [256 x float]* @_ZZ13FindMaxCorr_2PfS_S_iiiE8maxScore} ; [ DW_TAG_variable ] [maxScore] [line 149] [local] [def]
!39 = metadata !{i32 786484, i32 0, metadata !18, metadata !"maxScor2", metadata !"maxScor2", metadata !"", metadata !6, i32 150, metadata !26, i32 1, i32 1, [256 x float]* @_ZZ13FindMaxCorr_2PfS_S_iiiE8maxScor2} ; [ DW_TAG_variable ] [maxScor2] [line 150] [local] [def]
!40 = metadata !{i32 786484, i32 0, metadata !18, metadata !"maxIndex", metadata !"maxIndex", metadata !"", metadata !6, i32 151, metadata !37, i32 1, i32 1, [256 x i32]* @_ZZ13FindMaxCorr_2PfS_S_iiiE8maxIndex} ; [ DW_TAG_variable ] [maxIndex] [line 151] [local] [def]
!41 = metadata !{i32 786689, metadata !5, metadata !"sift1", metadata !6, i32 16777217, metadata !9, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [sift1] [line 1]
!42 = metadata !{i32 1, i32 0, metadata !5, null}
!43 = metadata !{i32 786689, metadata !5, metadata !"sift2", metadata !6, i32 33554433, metadata !9, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [sift2] [line 1]
!44 = metadata !{i32 786689, metadata !5, metadata !"corrData", metadata !6, i32 50331649, metadata !9, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [corrData] [line 1]
!45 = metadata !{i32 786689, metadata !5, metadata !"numPts1", metadata !6, i32 67108865, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [numPts1] [line 1]
!46 = metadata !{i32 786689, metadata !5, metadata !"numPts2", metadata !6, i32 83886081, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [numPts2] [line 1]
!47 = metadata !{i32 786688, metadata !48, metadata !"tx", metadata !6, i32 5, metadata !49, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [tx] [line 5]
!48 = metadata !{i32 786443, metadata !5, i32 2, i32 0, metadata !6, i32 0} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/cuda-sift-new-bug/new-func.cpp]
!49 = metadata !{i32 786470, null, metadata !"", null, i32 0, i64 0, i64 0, i64 0, i32 0, metadata !11} ; [ DW_TAG_const_type ] [line 0, size 0, align 0, offset 0] [from int]
!50 = metadata !{i32 5, i32 0, metadata !48, null}
!51 = metadata !{i32 786688, metadata !48, metadata !"ty", metadata !6, i32 6, metadata !49, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [ty] [line 6]
!52 = metadata !{i32 6, i32 0, metadata !48, null}
!53 = metadata !{i32 786688, metadata !48, metadata !"p1", metadata !6, i32 7, metadata !49, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [p1] [line 7]
!54 = metadata !{i32 7, i32 0, metadata !48, null}
!55 = metadata !{i32 786688, metadata !48, metadata !"p2", metadata !6, i32 8, metadata !49, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [p2] [line 8]
!56 = metadata !{i32 8, i32 0, metadata !48, null}
!57 = metadata !{i32 786688, metadata !48, metadata !"ptr1", metadata !6, i32 9, metadata !58, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [ptr1] [line 9]
!58 = metadata !{i32 786447, null, metadata !"", null, i32 0, i64 64, i64 64, i64 0, i32 0, metadata !59} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from ]
!59 = metadata !{i32 786470, null, metadata !"", null, i32 0, i64 0, i64 0, i64 0, i32 0, metadata !10} ; [ DW_TAG_const_type ] [line 0, size 0, align 0, offset 0] [from float]
!60 = metadata !{i32 9, i32 0, metadata !48, null}
!61 = metadata !{i32 786688, metadata !48, metadata !"ptr2", metadata !6, i32 10, metadata !58, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [ptr2] [line 10]
!62 = metadata !{i32 10, i32 0, metadata !48, null}
!63 = metadata !{i32 786688, metadata !48, metadata !"i", metadata !6, i32 11, metadata !49, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [i] [line 11]
!64 = metadata !{i32 11, i32 0, metadata !48, null}
!65 = metadata !{i32 12, i32 0, metadata !48, null}
!66 = metadata !{i32 13, i32 0, metadata !48, null}
!67 = metadata !{i32 14, i32 0, metadata !48, null}
!68 = metadata !{i32 786688, metadata !48, metadata !"sum", metadata !6, i32 15, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [sum] [line 15]
!69 = metadata !{i32 15, i32 0, metadata !48, null}
!70 = metadata !{i32 16, i32 0, metadata !48, null}
!71 = metadata !{i32 786688, metadata !72, metadata !"j", metadata !6, i32 17, metadata !11, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [j] [line 17]
!72 = metadata !{i32 786443, metadata !48, i32 17, i32 0, metadata !6, i32 1} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/cuda-sift-new-bug/new-func.cpp]
!73 = metadata !{i32 17, i32 0, metadata !72, null}
!74 = metadata !{i32 18, i32 0, metadata !72, null}
!75 = metadata !{i32 19, i32 0, metadata !48, null}
!76 = metadata !{i32 20, i32 0, metadata !48, null}
!77 = metadata !{i32 21, i32 0, metadata !48, null}
!78 = metadata !{i32 22, i32 0, metadata !48, null}
!79 = metadata !{i32 23, i32 0, metadata !48, null}
!80 = metadata !{i32 24, i32 0, metadata !48, null}
!81 = metadata !{i32 25, i32 0, metadata !48, null}
!82 = metadata !{i32 26, i32 0, metadata !48, null}
!83 = metadata !{i32 27, i32 0, metadata !48, null}
!84 = metadata !{i32 28, i32 0, metadata !85, null}
!85 = metadata !{i32 786443, metadata !48, i32 27, i32 0, metadata !6, i32 2} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/cuda-sift-new-bug/new-func.cpp]
!86 = metadata !{i32 29, i32 0, metadata !85, null}
!87 = metadata !{i32 30, i32 0, metadata !85, null}
!88 = metadata !{i32 31, i32 0, metadata !48, null}
!89 = metadata !{i32 32, i32 0, metadata !48, null}
!90 = metadata !{i32 786689, metadata !12, metadata !"sift1", metadata !6, i32 16777250, metadata !9, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [sift1] [line 34]
!91 = metadata !{i32 34, i32 0, metadata !12, null}
!92 = metadata !{i32 786689, metadata !12, metadata !"sift2", metadata !6, i32 33554466, metadata !9, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [sift2] [line 34]
!93 = metadata !{i32 786689, metadata !12, metadata !"corrData", metadata !6, i32 50331682, metadata !9, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [corrData] [line 34]
!94 = metadata !{i32 786689, metadata !12, metadata !"numPts1", metadata !6, i32 67108898, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [numPts1] [line 34]
!95 = metadata !{i32 786689, metadata !12, metadata !"numPts2", metadata !6, i32 83886114, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [numPts2] [line 34]
!96 = metadata !{i32 786688, metadata !97, metadata !"tx", metadata !6, i32 38, metadata !49, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [tx] [line 38]
!97 = metadata !{i32 786443, metadata !12, i32 35, i32 0, metadata !6, i32 3} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/cuda-sift-new-bug/new-func.cpp]
!98 = metadata !{i32 38, i32 0, metadata !97, null}
!99 = metadata !{i32 786688, metadata !97, metadata !"ty", metadata !6, i32 39, metadata !49, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [ty] [line 39]
!100 = metadata !{i32 39, i32 0, metadata !97, null}
!101 = metadata !{i32 786688, metadata !97, metadata !"ptr1", metadata !6, i32 40, metadata !58, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [ptr1] [line 40]
!102 = metadata !{i32 40, i32 0, metadata !97, null}
!103 = metadata !{i32 786688, metadata !97, metadata !"ptr2", metadata !6, i32 41, metadata !58, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [ptr2] [line 41]
!104 = metadata !{i32 41, i32 0, metadata !97, null}
!105 = metadata !{i32 786688, metadata !106, metadata !"i", metadata !6, i32 42, metadata !11, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [i] [line 42]
!106 = metadata !{i32 786443, metadata !97, i32 42, i32 0, metadata !6, i32 4} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/cuda-sift-new-bug/new-func.cpp]
!107 = metadata !{i32 42, i32 0, metadata !106, null}
!108 = metadata !{i32 43, i32 0, metadata !109, null}
!109 = metadata !{i32 786443, metadata !106, i32 42, i32 0, metadata !6, i32 5} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/cuda-sift-new-bug/new-func.cpp]
!110 = metadata !{i32 44, i32 0, metadata !109, null}
!111 = metadata !{i32 45, i32 0, metadata !109, null}
!112 = metadata !{i32 46, i32 0, metadata !97, null}
!113 = metadata !{i32 786688, metadata !97, metadata !"p1", metadata !6, i32 47, metadata !49, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [p1] [line 47]
!114 = metadata !{i32 47, i32 0, metadata !97, null}
!115 = metadata !{i32 786688, metadata !97, metadata !"p2", metadata !6, i32 48, metadata !49, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [p2] [line 48]
!116 = metadata !{i32 48, i32 0, metadata !97, null}
!117 = metadata !{i32 786688, metadata !97, metadata !"pt1", metadata !6, i32 49, metadata !58, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [pt1] [line 49]
!118 = metadata !{i32 49, i32 0, metadata !97, null}
!119 = metadata !{i32 786688, metadata !97, metadata !"pt2", metadata !6, i32 50, metadata !58, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [pt2] [line 50]
!120 = metadata !{i32 50, i32 0, metadata !97, null}
!121 = metadata !{i32 786688, metadata !97, metadata !"sum", metadata !6, i32 51, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [sum] [line 51]
!122 = metadata !{i32 51, i32 0, metadata !97, null}
!123 = metadata !{i32 786688, metadata !124, metadata !"i", metadata !6, i32 52, metadata !11, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [i] [line 52]
!124 = metadata !{i32 786443, metadata !97, i32 52, i32 0, metadata !6, i32 6} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/cuda-sift-new-bug/new-func.cpp]
!125 = metadata !{i32 52, i32 0, metadata !124, null}
!126 = metadata !{i32 786688, metadata !127, metadata !"itx", metadata !6, i32 53, metadata !11, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [itx] [line 53]
!127 = metadata !{i32 786443, metadata !124, i32 52, i32 0, metadata !6, i32 7} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/cuda-sift-new-bug/new-func.cpp]
!128 = metadata !{i32 53, i32 0, metadata !127, null}
!129 = metadata !{i32 54, i32 0, metadata !127, null}
!130 = metadata !{i32 55, i32 0, metadata !127, null}
!131 = metadata !{i32 56, i32 0, metadata !97, null}
!132 = metadata !{i32 57, i32 0, metadata !97, null}
!133 = metadata !{i32 58, i32 0, metadata !97, null}
!134 = metadata !{i32 786689, metadata !13, metadata !"sift1", metadata !6, i32 16777277, metadata !9, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [sift1] [line 61]
!135 = metadata !{i32 61, i32 0, metadata !13, null}
!136 = metadata !{i32 786689, metadata !13, metadata !"sift2", metadata !6, i32 33554493, metadata !9, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [sift2] [line 61]
!137 = metadata !{i32 786689, metadata !13, metadata !"corrData", metadata !6, i32 50331709, metadata !9, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [corrData] [line 61]
!138 = metadata !{i32 786689, metadata !13, metadata !"numPts1", metadata !6, i32 67108925, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [numPts1] [line 61]
!139 = metadata !{i32 786689, metadata !13, metadata !"numPts2", metadata !6, i32 83886141, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [numPts2] [line 61]
!140 = metadata !{i32 786688, metadata !141, metadata !"tx", metadata !6, i32 63, metadata !49, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [tx] [line 63]
!141 = metadata !{i32 786443, metadata !13, i32 62, i32 0, metadata !6, i32 8} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/cuda-sift-new-bug/new-func.cpp]
!142 = metadata !{i32 63, i32 0, metadata !141, null}
!143 = metadata !{i32 786688, metadata !141, metadata !"ty", metadata !6, i32 64, metadata !49, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [ty] [line 64]
!144 = metadata !{i32 64, i32 0, metadata !141, null}
!145 = metadata !{i32 786688, metadata !141, metadata !"p1", metadata !6, i32 65, metadata !49, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [p1] [line 65]
!146 = metadata !{i32 65, i32 0, metadata !141, null}
!147 = metadata !{i32 786688, metadata !141, metadata !"p2", metadata !6, i32 66, metadata !49, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [p2] [line 66]
!148 = metadata !{i32 66, i32 0, metadata !141, null}
!149 = metadata !{i32 786688, metadata !141, metadata !"pt1", metadata !6, i32 67, metadata !58, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [pt1] [line 67]
!150 = metadata !{i32 67, i32 0, metadata !141, null}
!151 = metadata !{i32 786688, metadata !141, metadata !"pt2", metadata !6, i32 68, metadata !58, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [pt2] [line 68]
!152 = metadata !{i32 68, i32 0, metadata !141, null}
!153 = metadata !{i32 786688, metadata !141, metadata !"sum", metadata !6, i32 69, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [sum] [line 69]
!154 = metadata !{i32 69, i32 0, metadata !141, null}
!155 = metadata !{i32 786688, metadata !156, metadata !"i", metadata !6, i32 70, metadata !11, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [i] [line 70]
!156 = metadata !{i32 786443, metadata !141, i32 70, i32 0, metadata !6, i32 9} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/cuda-sift-new-bug/new-func.cpp]
!157 = metadata !{i32 70, i32 0, metadata !156, null}
!158 = metadata !{i32 71, i32 0, metadata !156, null}
!159 = metadata !{i32 72, i32 0, metadata !141, null}
!160 = metadata !{i32 73, i32 0, metadata !141, null}
!161 = metadata !{i32 74, i32 0, metadata !141, null}
!162 = metadata !{i32 786689, metadata !14, metadata !"sift1", metadata !6, i32 16777292, metadata !9, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [sift1] [line 76]
!163 = metadata !{i32 76, i32 0, metadata !14, null}
!164 = metadata !{i32 786689, metadata !14, metadata !"sift2", metadata !6, i32 33554508, metadata !9, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [sift2] [line 76]
!165 = metadata !{i32 786689, metadata !14, metadata !"corrData", metadata !6, i32 50331724, metadata !9, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [corrData] [line 76]
!166 = metadata !{i32 786689, metadata !14, metadata !"numPts1", metadata !6, i32 67108940, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [numPts1] [line 76]
!167 = metadata !{i32 786689, metadata !14, metadata !"numPts2", metadata !6, i32 83886156, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [numPts2] [line 76]
!168 = metadata !{i32 786688, metadata !169, metadata !"tx", metadata !6, i32 78, metadata !49, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [tx] [line 78]
!169 = metadata !{i32 786443, metadata !14, i32 77, i32 0, metadata !6, i32 10} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/cuda-sift-new-bug/new-func.cpp]
!170 = metadata !{i32 78, i32 0, metadata !169, null}
!171 = metadata !{i32 786688, metadata !169, metadata !"ty", metadata !6, i32 79, metadata !49, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [ty] [line 79]
!172 = metadata !{i32 79, i32 0, metadata !169, null}
!173 = metadata !{i32 786688, metadata !169, metadata !"p1", metadata !6, i32 80, metadata !49, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [p1] [line 80]
!174 = metadata !{i32 80, i32 0, metadata !169, null}
!175 = metadata !{i32 786688, metadata !169, metadata !"p2", metadata !6, i32 81, metadata !49, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [p2] [line 81]
!176 = metadata !{i32 81, i32 0, metadata !169, null}
!177 = metadata !{i32 786688, metadata !169, metadata !"ptr1", metadata !6, i32 82, metadata !58, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [ptr1] [line 82]
!178 = metadata !{i32 82, i32 0, metadata !169, null}
!179 = metadata !{i32 786688, metadata !169, metadata !"ptr2", metadata !6, i32 83, metadata !58, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [ptr2] [line 83]
!180 = metadata !{i32 83, i32 0, metadata !169, null}
!181 = metadata !{i32 786688, metadata !169, metadata !"sum", metadata !6, i32 84, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [sum] [line 84]
!182 = metadata !{i32 84, i32 0, metadata !169, null}
!183 = metadata !{i32 85, i32 0, metadata !169, null}
!184 = metadata !{i32 786688, metadata !185, metadata !"j", metadata !6, i32 86, metadata !11, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [j] [line 86]
!185 = metadata !{i32 786443, metadata !169, i32 86, i32 0, metadata !6, i32 11} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/cuda-sift-new-bug/new-func.cpp]
!186 = metadata !{i32 86, i32 0, metadata !185, null}
!187 = metadata !{i32 87, i32 0, metadata !185, null}
!188 = metadata !{i32 88, i32 0, metadata !169, null}
!189 = metadata !{i32 89, i32 0, metadata !169, null}
!190 = metadata !{i32 90, i32 0, metadata !169, null}
!191 = metadata !{i32 786689, metadata !15, metadata !"corrData", metadata !6, i32 16777308, metadata !9, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [corrData] [line 92]
!192 = metadata !{i32 92, i32 0, metadata !15, null}
!193 = metadata !{i32 786689, metadata !15, metadata !"sift1", metadata !6, i32 33554524, metadata !9, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [sift1] [line 92]
!194 = metadata !{i32 786689, metadata !15, metadata !"sift2", metadata !6, i32 50331740, metadata !9, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [sift2] [line 92]
!195 = metadata !{i32 786689, metadata !15, metadata !"numPts1", metadata !6, i32 67108956, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [numPts1] [line 92]
!196 = metadata !{i32 786689, metadata !15, metadata !"corrWidth", metadata !6, i32 83886172, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [corrWidth] [line 92]
!197 = metadata !{i32 786689, metadata !15, metadata !"siftSize", metadata !6, i32 100663388, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [siftSize] [line 92]
!198 = metadata !{i32 786688, metadata !199, metadata !"tx", metadata !6, i32 97, metadata !49, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [tx] [line 97]
!199 = metadata !{i32 786443, metadata !15, i32 93, i32 0, metadata !6, i32 12} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/cuda-sift-new-bug/new-func.cpp]
!200 = metadata !{i32 97, i32 0, metadata !199, null}
!201 = metadata !{i32 786688, metadata !199, metadata !"ty", metadata !6, i32 98, metadata !49, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [ty] [line 98]
!202 = metadata !{i32 98, i32 0, metadata !199, null}
!203 = metadata !{i32 786688, metadata !199, metadata !"idx", metadata !6, i32 99, metadata !49, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [idx] [line 99]
!204 = metadata !{i32 99, i32 0, metadata !199, null}
!205 = metadata !{i32 786688, metadata !199, metadata !"p1", metadata !6, i32 100, metadata !11, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [p1] [line 100]
!206 = metadata !{i32 100, i32 0, metadata !199, null}
!207 = metadata !{i32 101, i32 0, metadata !199, null}
!208 = metadata !{i32 102, i32 0, metadata !199, null}
!209 = metadata !{i32 103, i32 0, metadata !199, null}
!210 = metadata !{i32 104, i32 0, metadata !199, null}
!211 = metadata !{i32 105, i32 0, metadata !199, null}
!212 = metadata !{i32 786688, metadata !199, metadata !"corrs", metadata !6, i32 106, metadata !9, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [corrs] [line 106]
!213 = metadata !{i32 106, i32 0, metadata !199, null}
!214 = metadata !{i32 786688, metadata !215, metadata !"i", metadata !6, i32 107, metadata !11, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [i] [line 107]
!215 = metadata !{i32 786443, metadata !199, i32 107, i32 0, metadata !6, i32 13} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/cuda-sift-new-bug/new-func.cpp]
!216 = metadata !{i32 107, i32 0, metadata !215, null}
!217 = metadata !{i32 786688, metadata !218, metadata !"val", metadata !6, i32 108, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [val] [line 108]
!218 = metadata !{i32 786443, metadata !215, i32 107, i32 0, metadata !6, i32 14} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/cuda-sift-new-bug/new-func.cpp]
!219 = metadata !{i32 108, i32 0, metadata !218, null}
!220 = metadata !{i32 109, i32 0, metadata !218, null}
!221 = metadata !{i32 110, i32 0, metadata !222, null}
!222 = metadata !{i32 786443, metadata !218, i32 109, i32 0, metadata !6, i32 15} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/cuda-sift-new-bug/new-func.cpp]
!223 = metadata !{i32 111, i32 0, metadata !222, null}
!224 = metadata !{i32 112, i32 0, metadata !222, null}
!225 = metadata !{i32 113, i32 0, metadata !222, null}
!226 = metadata !{i32 113, i32 0, metadata !218, null}
!227 = metadata !{i32 114, i32 0, metadata !218, null}
!228 = metadata !{i32 115, i32 0, metadata !218, null}
!229 = metadata !{i32 116, i32 0, metadata !199, null}
!230 = metadata !{i32 786688, metadata !231, metadata !"len", metadata !6, i32 117, metadata !11, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [len] [line 117]
!231 = metadata !{i32 786443, metadata !199, i32 117, i32 0, metadata !6, i32 16} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/cuda-sift-new-bug/new-func.cpp]
!232 = metadata !{i32 117, i32 0, metadata !231, null}
!233 = metadata !{i32 118, i32 0, metadata !234, null}
!234 = metadata !{i32 786443, metadata !231, i32 117, i32 0, metadata !6, i32 17} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/cuda-sift-new-bug/new-func.cpp]
!235 = metadata !{i32 786688, metadata !236, metadata !"val", metadata !6, i32 119, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [val] [line 119]
!236 = metadata !{i32 786443, metadata !234, i32 118, i32 0, metadata !6, i32 18} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/cuda-sift-new-bug/new-func.cpp]
!237 = metadata !{i32 119, i32 0, metadata !236, null}
!238 = metadata !{i32 786688, metadata !236, metadata !"i", metadata !6, i32 120, metadata !11, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [i] [line 120]
!239 = metadata !{i32 120, i32 0, metadata !236, null}
!240 = metadata !{i32 121, i32 0, metadata !236, null}
!241 = metadata !{i32 122, i32 0, metadata !242, null}
!242 = metadata !{i32 786443, metadata !236, i32 121, i32 0, metadata !6, i32 19} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/cuda-sift-new-bug/new-func.cpp]
!243 = metadata !{i32 123, i32 0, metadata !242, null}
!244 = metadata !{i32 124, i32 0, metadata !242, null}
!245 = metadata !{i32 125, i32 0, metadata !242, null}
!246 = metadata !{i32 125, i32 0, metadata !236, null}
!247 = metadata !{i32 126, i32 0, metadata !236, null}
!248 = metadata !{i32 786688, metadata !236, metadata !"va2", metadata !6, i32 127, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [va2] [line 127]
!249 = metadata !{i32 127, i32 0, metadata !236, null}
!250 = metadata !{i32 128, i32 0, metadata !236, null}
!251 = metadata !{i32 129, i32 0, metadata !236, null}
!252 = metadata !{i32 130, i32 0, metadata !236, null}
!253 = metadata !{i32 131, i32 0, metadata !234, null}
!254 = metadata !{i32 132, i32 0, metadata !234, null}
!255 = metadata !{i32 133, i32 0, metadata !199, null}
!256 = metadata !{i32 134, i32 0, metadata !199, null}
!257 = metadata !{i32 135, i32 0, metadata !199, null}
!258 = metadata !{i32 136, i32 0, metadata !199, null}
!259 = metadata !{i32 137, i32 0, metadata !199, null}
!260 = metadata !{i32 138, i32 0, metadata !199, null}
!261 = metadata !{i32 139, i32 0, metadata !199, null}
!262 = metadata !{i32 140, i32 0, metadata !199, null}
!263 = metadata !{i32 141, i32 0, metadata !199, null}
!264 = metadata !{i32 142, i32 0, metadata !199, null}
!265 = metadata !{i32 143, i32 0, metadata !199, null}
!266 = metadata !{i32 144, i32 0, metadata !199, null}
!267 = metadata !{i32 786689, metadata !18, metadata !"corrData", metadata !6, i32 16777363, metadata !9, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [corrData] [line 147]
!268 = metadata !{i32 147, i32 0, metadata !18, null}
!269 = metadata !{i32 786689, metadata !18, metadata !"sift1", metadata !6, i32 33554579, metadata !9, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [sift1] [line 147]
!270 = metadata !{i32 786689, metadata !18, metadata !"sift2", metadata !6, i32 50331795, metadata !9, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [sift2] [line 147]
!271 = metadata !{i32 786689, metadata !18, metadata !"numPts1", metadata !6, i32 67109011, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [numPts1] [line 147]
!272 = metadata !{i32 786689, metadata !18, metadata !"corrWidth", metadata !6, i32 83886227, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [corrWidth] [line 147]
!273 = metadata !{i32 786689, metadata !18, metadata !"siftSize", metadata !6, i32 100663443, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [siftSize] [line 147]
!274 = metadata !{i32 786688, metadata !275, metadata !"tx", metadata !6, i32 152, metadata !49, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [tx] [line 152]
!275 = metadata !{i32 786443, metadata !18, i32 148, i32 0, metadata !6, i32 20} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/cuda-sift-new-bug/new-func.cpp]
!276 = metadata !{i32 152, i32 0, metadata !275, null}
!277 = metadata !{i32 786688, metadata !275, metadata !"ty", metadata !6, i32 153, metadata !49, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [ty] [line 153]
!278 = metadata !{i32 153, i32 0, metadata !275, null}
!279 = metadata !{i32 786688, metadata !275, metadata !"idx", metadata !6, i32 154, metadata !49, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [idx] [line 154]
!280 = metadata !{i32 154, i32 0, metadata !275, null}
!281 = metadata !{i32 786688, metadata !275, metadata !"p1", metadata !6, i32 155, metadata !11, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [p1] [line 155]
!282 = metadata !{i32 155, i32 0, metadata !275, null}
!283 = metadata !{i32 156, i32 0, metadata !275, null}
!284 = metadata !{i32 157, i32 0, metadata !275, null}
!285 = metadata !{i32 158, i32 0, metadata !275, null}
!286 = metadata !{i32 159, i32 0, metadata !275, null}
!287 = metadata !{i32 160, i32 0, metadata !275, null}
!288 = metadata !{i32 786688, metadata !275, metadata !"corrs", metadata !6, i32 161, metadata !9, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [corrs] [line 161]
!289 = metadata !{i32 161, i32 0, metadata !275, null}
!290 = metadata !{i32 786688, metadata !291, metadata !"i", metadata !6, i32 162, metadata !11, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [i] [line 162]
!291 = metadata !{i32 786443, metadata !275, i32 162, i32 0, metadata !6, i32 21} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/cuda-sift-new-bug/new-func.cpp]
!292 = metadata !{i32 162, i32 0, metadata !291, null}
!293 = metadata !{i32 786688, metadata !294, metadata !"val", metadata !6, i32 163, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [val] [line 163]
!294 = metadata !{i32 786443, metadata !291, i32 162, i32 0, metadata !6, i32 22} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/cuda-sift-new-bug/new-func.cpp]
!295 = metadata !{i32 163, i32 0, metadata !294, null}
!296 = metadata !{i32 164, i32 0, metadata !294, null}
!297 = metadata !{i32 165, i32 0, metadata !298, null}
!298 = metadata !{i32 786443, metadata !294, i32 164, i32 0, metadata !6, i32 23} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/cuda-sift-new-bug/new-func.cpp]
!299 = metadata !{i32 166, i32 0, metadata !298, null}
!300 = metadata !{i32 167, i32 0, metadata !298, null}
!301 = metadata !{i32 168, i32 0, metadata !298, null}
!302 = metadata !{i32 168, i32 0, metadata !294, null}
!303 = metadata !{i32 169, i32 0, metadata !294, null}
!304 = metadata !{i32 170, i32 0, metadata !294, null}
!305 = metadata !{i32 171, i32 0, metadata !275, null}
!306 = metadata !{i32 786688, metadata !307, metadata !"len", metadata !6, i32 172, metadata !11, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [len] [line 172]
!307 = metadata !{i32 786443, metadata !275, i32 172, i32 0, metadata !6, i32 24} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/cuda-sift-new-bug/new-func.cpp]
!308 = metadata !{i32 172, i32 0, metadata !307, null}
!309 = metadata !{i32 173, i32 0, metadata !310, null}
!310 = metadata !{i32 786443, metadata !307, i32 172, i32 0, metadata !6, i32 25} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/cuda-sift-new-bug/new-func.cpp]
!311 = metadata !{i32 786688, metadata !312, metadata !"val", metadata !6, i32 174, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [val] [line 174]
!312 = metadata !{i32 786443, metadata !310, i32 173, i32 0, metadata !6, i32 26} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/cuda-sift-new-bug/new-func.cpp]
!313 = metadata !{i32 174, i32 0, metadata !312, null}
!314 = metadata !{i32 786688, metadata !312, metadata !"i", metadata !6, i32 175, metadata !11, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [i] [line 175]
!315 = metadata !{i32 175, i32 0, metadata !312, null}
!316 = metadata !{i32 176, i32 0, metadata !312, null}
!317 = metadata !{i32 177, i32 0, metadata !318, null}
!318 = metadata !{i32 786443, metadata !312, i32 176, i32 0, metadata !6, i32 27} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/cuda-sift-new-bug/new-func.cpp]
!319 = metadata !{i32 178, i32 0, metadata !318, null}
!320 = metadata !{i32 179, i32 0, metadata !318, null}
!321 = metadata !{i32 180, i32 0, metadata !318, null}
!322 = metadata !{i32 180, i32 0, metadata !312, null}
!323 = metadata !{i32 181, i32 0, metadata !312, null}
!324 = metadata !{i32 786688, metadata !312, metadata !"va2", metadata !6, i32 182, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [va2] [line 182]
!325 = metadata !{i32 182, i32 0, metadata !312, null}
!326 = metadata !{i32 183, i32 0, metadata !312, null}
!327 = metadata !{i32 184, i32 0, metadata !312, null}
!328 = metadata !{i32 185, i32 0, metadata !312, null}
!329 = metadata !{i32 186, i32 0, metadata !310, null}
!330 = metadata !{i32 187, i32 0, metadata !310, null}
!331 = metadata !{i32 188, i32 0, metadata !275, null}
!332 = metadata !{i32 189, i32 0, metadata !275, null}
!333 = metadata !{i32 190, i32 0, metadata !275, null}
!334 = metadata !{i32 191, i32 0, metadata !275, null}
!335 = metadata !{i32 192, i32 0, metadata !275, null}
!336 = metadata !{i32 193, i32 0, metadata !275, null}
!337 = metadata !{i32 194, i32 0, metadata !275, null}
!338 = metadata !{i32 195, i32 0, metadata !275, null}
!339 = metadata !{i32 196, i32 0, metadata !275, null}
!340 = metadata !{i32 197, i32 0, metadata !275, null}
!341 = metadata !{i32 198, i32 0, metadata !275, null}
