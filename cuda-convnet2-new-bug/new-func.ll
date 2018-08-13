; ModuleID = 'new-func'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.dim3 = type { i32, i32, i32 }

@blockIdx = external global %struct.dim3
@threadIdx = external global %struct.dim3
@blockDim = external global %struct.dim3
@gridDim = external global %struct.dim3
@_ZZ13kDotProduct_rPfS_S_jE5shmem = internal global [512 x float] zeroinitializer, section "__shared__", align 16

define void @_Z9kReflectHPfS_iiiib(float* %imgs, float* %targets, i32 %imgSize, i32 %numCases, i32 %numColors, i32 %imgsPerThread, i1 zeroext %checkCaseBounds) nounwind uwtable noinline {
  %1 = alloca float*, align 8
  %2 = alloca float*, align 8
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i8, align 1
  %pxIdx = alloca i32, align 4
  %imgPixels = alloca i32, align 4
  %caseIdx = alloca i32, align 4
  %pxIdxY = alloca i32, align 4
  %pxIdxX = alloca i32, align 4
  %pxIdxXR = alloca i32, align 4
  %pxIdxR = alloca i32, align 4
  %i = alloca i32, align 4
  %c = alloca i32, align 4
  store float* %imgs, float** %1, align 8
  call void @llvm.dbg.declare(metadata !{float** %1}, metadata !31), !dbg !32
  store float* %targets, float** %2, align 8
  call void @llvm.dbg.declare(metadata !{float** %2}, metadata !33), !dbg !32
  store i32 %imgSize, i32* %3, align 4
  call void @llvm.dbg.declare(metadata !{i32* %3}, metadata !34), !dbg !35
  store i32 %numCases, i32* %4, align 4
  call void @llvm.dbg.declare(metadata !{i32* %4}, metadata !36), !dbg !35
  store i32 %numColors, i32* %5, align 4
  call void @llvm.dbg.declare(metadata !{i32* %5}, metadata !37), !dbg !35
  store i32 %imgsPerThread, i32* %6, align 4
  call void @llvm.dbg.declare(metadata !{i32* %6}, metadata !38), !dbg !35
  %8 = zext i1 %checkCaseBounds to i8
  store i8 %8, i8* %7, align 1
  call void @llvm.dbg.declare(metadata !{i8* %7}, metadata !39), !dbg !35
  call void @llvm.dbg.declare(metadata !{i32* %pxIdx}, metadata !40), !dbg !42
  %9 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 1), align 4, !dbg !42
  %10 = mul i32 %9, 4, !dbg !42
  %11 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 1), align 4, !dbg !42
  %12 = add i32 %10, %11, !dbg !42
  store i32 %12, i32* %pxIdx, align 4, !dbg !42
  call void @llvm.dbg.declare(metadata !{i32* %imgPixels}, metadata !43), !dbg !44
  %13 = load i32* %3, align 4, !dbg !44
  %14 = load i32* %3, align 4, !dbg !44
  %15 = mul nsw i32 %13, %14, !dbg !44
  store i32 %15, i32* %imgPixels, align 4, !dbg !44
  %16 = load i32* %pxIdx, align 4, !dbg !45
  %17 = load i32* %imgPixels, align 4, !dbg !45
  %18 = icmp slt i32 %16, %17, !dbg !45
  br i1 %18, label %19, label %109, !dbg !45

; <label>:19                                      ; preds = %0
  call void @llvm.dbg.declare(metadata !{i32* %caseIdx}, metadata !46), !dbg !48
  %20 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 0), align 4, !dbg !48
  %21 = mul i32 %20, 32, !dbg !48
  %22 = load i32* %6, align 4, !dbg !48
  %23 = mul i32 %21, %22, !dbg !48
  %24 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !48
  %25 = add i32 %23, %24, !dbg !48
  store i32 %25, i32* %caseIdx, align 4, !dbg !48
  call void @llvm.dbg.declare(metadata !{i32* %pxIdxY}, metadata !49), !dbg !50
  %26 = load i32* %pxIdx, align 4, !dbg !50
  %27 = load i32* %3, align 4, !dbg !50
  %28 = sdiv i32 %26, %27, !dbg !50
  store i32 %28, i32* %pxIdxY, align 4, !dbg !50
  call void @llvm.dbg.declare(metadata !{i32* %pxIdxX}, metadata !51), !dbg !52
  %29 = load i32* %pxIdx, align 4, !dbg !52
  %30 = load i32* %3, align 4, !dbg !52
  %31 = srem i32 %29, %30, !dbg !52
  store i32 %31, i32* %pxIdxX, align 4, !dbg !52
  call void @llvm.dbg.declare(metadata !{i32* %pxIdxXR}, metadata !53), !dbg !54
  %32 = load i32* %3, align 4, !dbg !54
  %33 = sub nsw i32 %32, 1, !dbg !54
  %34 = load i32* %pxIdxX, align 4, !dbg !54
  %35 = sub nsw i32 %33, %34, !dbg !54
  store i32 %35, i32* %pxIdxXR, align 4, !dbg !54
  call void @llvm.dbg.declare(metadata !{i32* %pxIdxR}, metadata !55), !dbg !56
  %36 = load i32* %pxIdxY, align 4, !dbg !56
  %37 = load i32* %3, align 4, !dbg !56
  %38 = mul nsw i32 %36, %37, !dbg !56
  %39 = load i32* %pxIdxXR, align 4, !dbg !56
  %40 = add nsw i32 %38, %39, !dbg !56
  store i32 %40, i32* %pxIdxR, align 4, !dbg !56
  %41 = load i32* %pxIdx, align 4, !dbg !57
  %42 = load i32* %4, align 4, !dbg !57
  %43 = mul nsw i32 %41, %42, !dbg !57
  %44 = load i32* %caseIdx, align 4, !dbg !57
  %45 = add nsw i32 %43, %44, !dbg !57
  %46 = load float** %1, align 8, !dbg !57
  %47 = sext i32 %45 to i64, !dbg !57
  %48 = getelementptr inbounds float* %46, i64 %47, !dbg !57
  store float* %48, float** %1, align 8, !dbg !57
  %49 = load i32* %pxIdxR, align 4, !dbg !58
  %50 = load i32* %4, align 4, !dbg !58
  %51 = mul nsw i32 %49, %50, !dbg !58
  %52 = load i32* %caseIdx, align 4, !dbg !58
  %53 = add nsw i32 %51, %52, !dbg !58
  %54 = load float** %2, align 8, !dbg !58
  %55 = sext i32 %53 to i64, !dbg !58
  %56 = getelementptr inbounds float* %54, i64 %55, !dbg !58
  store float* %56, float** %2, align 8, !dbg !58
  call void @llvm.dbg.declare(metadata !{i32* %i}, metadata !59), !dbg !61
  store i32 0, i32* %i, align 4, !dbg !61
  br label %57, !dbg !61

; <label>:57                                      ; preds = %105, %19
  %58 = load i32* %i, align 4, !dbg !61
  %59 = load i32* %6, align 4, !dbg !61
  %60 = icmp slt i32 %58, %59, !dbg !61
  br i1 %60, label %61, label %108, !dbg !61

; <label>:61                                      ; preds = %57
  %62 = load i8* %7, align 1, !dbg !62
  %63 = trunc i8 %62 to i1, !dbg !62
  br i1 %63, label %64, label %71, !dbg !62

; <label>:64                                      ; preds = %61
  %65 = load i32* %caseIdx, align 4, !dbg !62
  %66 = load i32* %i, align 4, !dbg !62
  %67 = mul nsw i32 %66, 32, !dbg !62
  %68 = add nsw i32 %65, %67, !dbg !62
  %69 = load i32* %4, align 4, !dbg !62
  %70 = icmp slt i32 %68, %69, !dbg !62
  br i1 %70, label %71, label %104, !dbg !62

; <label>:71                                      ; preds = %64, %61
  call void @llvm.dbg.declare(metadata !{i32* %c}, metadata !64), !dbg !67
  store i32 0, i32* %c, align 4, !dbg !67
  br label %72, !dbg !67

; <label>:72                                      ; preds = %100, %71
  %73 = load i32* %c, align 4, !dbg !67
  %74 = load i32* %5, align 4, !dbg !67
  %75 = icmp slt i32 %73, %74, !dbg !67
  br i1 %75, label %76, label %103, !dbg !67

; <label>:76                                      ; preds = %72
  %77 = load i32* %c, align 4, !dbg !68
  %78 = load i32* %imgPixels, align 4, !dbg !68
  %79 = mul nsw i32 %77, %78, !dbg !68
  %80 = load i32* %4, align 4, !dbg !68
  %81 = mul nsw i32 %79, %80, !dbg !68
  %82 = load i32* %i, align 4, !dbg !68
  %83 = mul nsw i32 %82, 32, !dbg !68
  %84 = add nsw i32 %81, %83, !dbg !68
  %85 = sext i32 %84 to i64, !dbg !68
  %86 = load float** %1, align 8, !dbg !68
  %87 = getelementptr inbounds float* %86, i64 %85, !dbg !68
  %88 = load float* %87, align 4, !dbg !68
  %89 = load i32* %c, align 4, !dbg !68
  %90 = load i32* %imgPixels, align 4, !dbg !68
  %91 = mul nsw i32 %89, %90, !dbg !68
  %92 = load i32* %4, align 4, !dbg !68
  %93 = mul nsw i32 %91, %92, !dbg !68
  %94 = load i32* %i, align 4, !dbg !68
  %95 = mul nsw i32 %94, 32, !dbg !68
  %96 = add nsw i32 %93, %95, !dbg !68
  %97 = sext i32 %96 to i64, !dbg !68
  %98 = load float** %2, align 8, !dbg !68
  %99 = getelementptr inbounds float* %98, i64 %97, !dbg !68
  store float %88, float* %99, align 4, !dbg !68
  br label %100, !dbg !70

; <label>:100                                     ; preds = %76
  %101 = load i32* %c, align 4, !dbg !67
  %102 = add nsw i32 %101, 1, !dbg !67
  store i32 %102, i32* %c, align 4, !dbg !67
  br label %72, !dbg !67

; <label>:103                                     ; preds = %72
  br label %104, !dbg !71

; <label>:104                                     ; preds = %103, %64
  br label %105, !dbg !72

; <label>:105                                     ; preds = %104
  %106 = load i32* %i, align 4, !dbg !61
  %107 = add nsw i32 %106, 1, !dbg !61
  store i32 %107, i32* %i, align 4, !dbg !61
  br label %57, !dbg !61

; <label>:108                                     ; preds = %57
  br label %109, !dbg !73

; <label>:109                                     ; preds = %108, %0
  ret void, !dbg !74
}

declare void @llvm.dbg.declare(metadata, metadata) nounwind readnone

define void @_Z5kTilePKfPfjjjj(float* %src, float* %tgt, i32 %srcWidth, i32 %srcHeight, i32 %tgtWidth, i32 %tgtHeight) nounwind uwtable noinline {
  %1 = alloca float*, align 8
  %2 = alloca float*, align 8
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %idx = alloca i32, align 4
  %numThreads = alloca i32, align 4
  %i = alloca i32, align 4
  %y = alloca i32, align 4
  %x = alloca i32, align 4
  %srcY = alloca i32, align 4
  %srcX = alloca i32, align 4
  store float* %src, float** %1, align 8
  call void @llvm.dbg.declare(metadata !{float** %1}, metadata !75), !dbg !76
  store float* %tgt, float** %2, align 8
  call void @llvm.dbg.declare(metadata !{float** %2}, metadata !77), !dbg !76
  store i32 %srcWidth, i32* %3, align 4
  call void @llvm.dbg.declare(metadata !{i32* %3}, metadata !78), !dbg !76
  store i32 %srcHeight, i32* %4, align 4
  call void @llvm.dbg.declare(metadata !{i32* %4}, metadata !79), !dbg !76
  store i32 %tgtWidth, i32* %5, align 4
  call void @llvm.dbg.declare(metadata !{i32* %5}, metadata !80), !dbg !76
  store i32 %tgtHeight, i32* %6, align 4
  call void @llvm.dbg.declare(metadata !{i32* %6}, metadata !81), !dbg !76
  call void @llvm.dbg.declare(metadata !{i32* %idx}, metadata !82), !dbg !84
  %7 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 0), align 4, !dbg !84
  %8 = load i32* getelementptr inbounds (%struct.dim3* @blockDim, i32 0, i32 0), align 4, !dbg !84
  %9 = mul i32 %7, %8, !dbg !84
  %10 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !84
  %11 = add i32 %9, %10, !dbg !84
  store i32 %11, i32* %idx, align 4, !dbg !84
  call void @llvm.dbg.declare(metadata !{i32* %numThreads}, metadata !85), !dbg !86
  %12 = load i32* getelementptr inbounds (%struct.dim3* @blockDim, i32 0, i32 0), align 4, !dbg !86
  %13 = load i32* getelementptr inbounds (%struct.dim3* @gridDim, i32 0, i32 0), align 4, !dbg !86
  %14 = mul i32 %12, %13, !dbg !86
  store i32 %14, i32* %numThreads, align 4, !dbg !86
  call void @llvm.dbg.declare(metadata !{i32* %i}, metadata !87), !dbg !89
  %15 = load i32* %idx, align 4, !dbg !89
  store i32 %15, i32* %i, align 4, !dbg !89
  br label %16, !dbg !89

; <label>:16                                      ; preds = %48, %0
  %17 = load i32* %i, align 4, !dbg !89
  %18 = load i32* %5, align 4, !dbg !89
  %19 = load i32* %6, align 4, !dbg !89
  %20 = mul i32 %18, %19, !dbg !89
  %21 = icmp ult i32 %17, %20, !dbg !89
  br i1 %21, label %22, label %52, !dbg !89

; <label>:22                                      ; preds = %16
  call void @llvm.dbg.declare(metadata !{i32* %y}, metadata !90), !dbg !92
  %23 = load i32* %i, align 4, !dbg !92
  %24 = load i32* %5, align 4, !dbg !92
  %25 = udiv i32 %23, %24, !dbg !92
  store i32 %25, i32* %y, align 4, !dbg !92
  call void @llvm.dbg.declare(metadata !{i32* %x}, metadata !93), !dbg !94
  %26 = load i32* %i, align 4, !dbg !94
  %27 = load i32* %5, align 4, !dbg !94
  %28 = urem i32 %26, %27, !dbg !94
  store i32 %28, i32* %x, align 4, !dbg !94
  call void @llvm.dbg.declare(metadata !{i32* %srcY}, metadata !95), !dbg !96
  %29 = load i32* %y, align 4, !dbg !96
  %30 = load i32* %4, align 4, !dbg !96
  %31 = urem i32 %29, %30, !dbg !96
  store i32 %31, i32* %srcY, align 4, !dbg !96
  call void @llvm.dbg.declare(metadata !{i32* %srcX}, metadata !97), !dbg !98
  %32 = load i32* %x, align 4, !dbg !98
  %33 = load i32* %3, align 4, !dbg !98
  %34 = urem i32 %32, %33, !dbg !98
  store i32 %34, i32* %srcX, align 4, !dbg !98
  %35 = load i32* %srcY, align 4, !dbg !99
  %36 = load i32* %3, align 4, !dbg !99
  %37 = mul i32 %35, %36, !dbg !99
  %38 = load i32* %srcX, align 4, !dbg !99
  %39 = add i32 %37, %38, !dbg !99
  %40 = zext i32 %39 to i64, !dbg !99
  %41 = load float** %1, align 8, !dbg !99
  %42 = getelementptr inbounds float* %41, i64 %40, !dbg !99
  %43 = load float* %42, align 4, !dbg !99
  %44 = load i32* %i, align 4, !dbg !99
  %45 = zext i32 %44 to i64, !dbg !99
  %46 = load float** %2, align 8, !dbg !99
  %47 = getelementptr inbounds float* %46, i64 %45, !dbg !99
  store float %43, float* %47, align 4, !dbg !99
  br label %48, !dbg !100

; <label>:48                                      ; preds = %22
  %49 = load i32* %numThreads, align 4, !dbg !89
  %50 = load i32* %i, align 4, !dbg !89
  %51 = add i32 %50, %49, !dbg !89
  store i32 %51, i32* %i, align 4, !dbg !89
  br label %16, !dbg !89

; <label>:52                                      ; preds = %16
  ret void, !dbg !101
}

define void @_Z13kDotProduct_rPfS_S_j(float* %a, float* %b, float* %target, i32 %numElements) uwtable noinline {
  %1 = alloca float*, align 8
  %2 = alloca float*, align 8
  %3 = alloca float*, align 8
  %4 = alloca i32, align 4
  %eidx = alloca i32, align 4
  %mysh = alloca float*, align 8
  store float* %a, float** %1, align 8
  call void @llvm.dbg.declare(metadata !{float** %1}, metadata !102), !dbg !103
  store float* %b, float** %2, align 8
  call void @llvm.dbg.declare(metadata !{float** %2}, metadata !104), !dbg !103
  store float* %target, float** %3, align 8
  call void @llvm.dbg.declare(metadata !{float** %3}, metadata !105), !dbg !103
  store i32 %numElements, i32* %4, align 4
  call void @llvm.dbg.declare(metadata !{i32* %4}, metadata !106), !dbg !103
  call void @llvm.dbg.declare(metadata !{i32* %eidx}, metadata !107), !dbg !109
  %5 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 0), align 4, !dbg !109
  %6 = mul i32 512, %5, !dbg !109
  %7 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !109
  %8 = add i32 %6, %7, !dbg !109
  store i32 %8, i32* %eidx, align 4, !dbg !109
  %9 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !110
  %10 = zext i32 %9 to i64, !dbg !110
  %11 = getelementptr inbounds [512 x float]* @_ZZ13kDotProduct_rPfS_S_jE5shmem, i32 0, i64 %10, !dbg !110
  store float 0.000000e+00, float* %11, align 4, !dbg !110
  %12 = load i32* %eidx, align 4, !dbg !111
  %13 = load i32* getelementptr inbounds (%struct.dim3* @gridDim, i32 0, i32 0), align 4, !dbg !111
  %14 = mul i32 %13, 512, !dbg !111
  %15 = icmp ult i32 %12, %14, !dbg !111
  br i1 %15, label %16, label %44, !dbg !111

; <label>:16                                      ; preds = %0
  br label %17, !dbg !112

; <label>:17                                      ; preds = %38, %16
  %18 = load i32* %eidx, align 4, !dbg !112
  %19 = load i32* %4, align 4, !dbg !112
  %20 = icmp ult i32 %18, %19, !dbg !112
  br i1 %20, label %21, label %43, !dbg !112

; <label>:21                                      ; preds = %17
  %22 = load i32* %eidx, align 4, !dbg !115
  %23 = zext i32 %22 to i64, !dbg !115
  %24 = load float** %1, align 8, !dbg !115
  %25 = getelementptr inbounds float* %24, i64 %23, !dbg !115
  %26 = load float* %25, align 4, !dbg !115
  %27 = load i32* %eidx, align 4, !dbg !115
  %28 = zext i32 %27 to i64, !dbg !115
  %29 = load float** %2, align 8, !dbg !115
  %30 = getelementptr inbounds float* %29, i64 %28, !dbg !115
  %31 = load float* %30, align 4, !dbg !115
  %32 = fmul float %26, %31, !dbg !115
  %33 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !115
  %34 = zext i32 %33 to i64, !dbg !115
  %35 = getelementptr inbounds [512 x float]* @_ZZ13kDotProduct_rPfS_S_jE5shmem, i32 0, i64 %34, !dbg !115
  %36 = load float* %35, align 4, !dbg !115
  %37 = fadd float %36, %32, !dbg !115
  store float %37, float* %35, align 4, !dbg !115
  br label %38, !dbg !117

; <label>:38                                      ; preds = %21
  %39 = load i32* getelementptr inbounds (%struct.dim3* @gridDim, i32 0, i32 0), align 4, !dbg !112
  %40 = mul i32 %39, 512, !dbg !112
  %41 = load i32* %eidx, align 4, !dbg !112
  %42 = add i32 %41, %40, !dbg !112
  store i32 %42, i32* %eidx, align 4, !dbg !112
  br label %17, !dbg !112

; <label>:43                                      ; preds = %17
  br label %44, !dbg !118

; <label>:44                                      ; preds = %43, %0
  call void @__syncthreads(), !dbg !119
  %45 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !120
  %46 = icmp ult i32 %45, 256, !dbg !120
  br i1 %46, label %47, label %58, !dbg !120

; <label>:47                                      ; preds = %44
  %48 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !121
  %49 = add i32 %48, 256, !dbg !121
  %50 = zext i32 %49 to i64, !dbg !121
  %51 = getelementptr inbounds [512 x float]* @_ZZ13kDotProduct_rPfS_S_jE5shmem, i32 0, i64 %50, !dbg !121
  %52 = load float* %51, align 4, !dbg !121
  %53 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !121
  %54 = zext i32 %53 to i64, !dbg !121
  %55 = getelementptr inbounds [512 x float]* @_ZZ13kDotProduct_rPfS_S_jE5shmem, i32 0, i64 %54, !dbg !121
  %56 = load float* %55, align 4, !dbg !121
  %57 = fadd float %56, %52, !dbg !121
  store float %57, float* %55, align 4, !dbg !121
  br label %58, !dbg !123

; <label>:58                                      ; preds = %47, %44
  call void @__syncthreads(), !dbg !124
  %59 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !125
  %60 = icmp ult i32 %59, 128, !dbg !125
  br i1 %60, label %61, label %72, !dbg !125

; <label>:61                                      ; preds = %58
  %62 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !126
  %63 = add i32 %62, 128, !dbg !126
  %64 = zext i32 %63 to i64, !dbg !126
  %65 = getelementptr inbounds [512 x float]* @_ZZ13kDotProduct_rPfS_S_jE5shmem, i32 0, i64 %64, !dbg !126
  %66 = load float* %65, align 4, !dbg !126
  %67 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !126
  %68 = zext i32 %67 to i64, !dbg !126
  %69 = getelementptr inbounds [512 x float]* @_ZZ13kDotProduct_rPfS_S_jE5shmem, i32 0, i64 %68, !dbg !126
  %70 = load float* %69, align 4, !dbg !126
  %71 = fadd float %70, %66, !dbg !126
  store float %71, float* %69, align 4, !dbg !126
  br label %72, !dbg !128

; <label>:72                                      ; preds = %61, %58
  call void @__syncthreads(), !dbg !129
  %73 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !130
  %74 = icmp ult i32 %73, 64, !dbg !130
  br i1 %74, label %75, label %86, !dbg !130

; <label>:75                                      ; preds = %72
  %76 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !131
  %77 = add i32 %76, 64, !dbg !131
  %78 = zext i32 %77 to i64, !dbg !131
  %79 = getelementptr inbounds [512 x float]* @_ZZ13kDotProduct_rPfS_S_jE5shmem, i32 0, i64 %78, !dbg !131
  %80 = load float* %79, align 4, !dbg !131
  %81 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !131
  %82 = zext i32 %81 to i64, !dbg !131
  %83 = getelementptr inbounds [512 x float]* @_ZZ13kDotProduct_rPfS_S_jE5shmem, i32 0, i64 %82, !dbg !131
  %84 = load float* %83, align 4, !dbg !131
  %85 = fadd float %84, %80, !dbg !131
  store float %85, float* %83, align 4, !dbg !131
  br label %86, !dbg !133

; <label>:86                                      ; preds = %75, %72
  call void @__syncthreads(), !dbg !134
  %87 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !135
  %88 = icmp ult i32 %87, 32, !dbg !135
  br i1 %88, label %89, label %139, !dbg !135

; <label>:89                                      ; preds = %86
  call void @llvm.dbg.declare(metadata !{float** %mysh}, metadata !136), !dbg !140
  %90 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !140
  %91 = zext i32 %90 to i64, !dbg !140
  %92 = getelementptr inbounds [512 x float]* @_ZZ13kDotProduct_rPfS_S_jE5shmem, i32 0, i64 %91, !dbg !140
  store float* %92, float** %mysh, align 8, !dbg !140
  %93 = load float** %mysh, align 8, !dbg !141
  %94 = getelementptr inbounds float* %93, i64 32, !dbg !141
  %95 = load volatile float* %94, align 4, !dbg !141
  %96 = load float** %mysh, align 8, !dbg !141
  %97 = load volatile float* %96, align 4, !dbg !141
  %98 = fadd float %97, %95, !dbg !141
  store volatile float %98, float* %96, align 4, !dbg !141
  %99 = load float** %mysh, align 8, !dbg !142
  %100 = getelementptr inbounds float* %99, i64 16, !dbg !142
  %101 = load volatile float* %100, align 4, !dbg !142
  %102 = load float** %mysh, align 8, !dbg !142
  %103 = load volatile float* %102, align 4, !dbg !142
  %104 = fadd float %103, %101, !dbg !142
  store volatile float %104, float* %102, align 4, !dbg !142
  %105 = load float** %mysh, align 8, !dbg !143
  %106 = getelementptr inbounds float* %105, i64 8, !dbg !143
  %107 = load volatile float* %106, align 4, !dbg !143
  %108 = load float** %mysh, align 8, !dbg !143
  %109 = load volatile float* %108, align 4, !dbg !143
  %110 = fadd float %109, %107, !dbg !143
  store volatile float %110, float* %108, align 4, !dbg !143
  %111 = load float** %mysh, align 8, !dbg !144
  %112 = getelementptr inbounds float* %111, i64 4, !dbg !144
  %113 = load volatile float* %112, align 4, !dbg !144
  %114 = load float** %mysh, align 8, !dbg !144
  %115 = load volatile float* %114, align 4, !dbg !144
  %116 = fadd float %115, %113, !dbg !144
  store volatile float %116, float* %114, align 4, !dbg !144
  %117 = load float** %mysh, align 8, !dbg !145
  %118 = getelementptr inbounds float* %117, i64 2, !dbg !145
  %119 = load volatile float* %118, align 4, !dbg !145
  %120 = load float** %mysh, align 8, !dbg !145
  %121 = load volatile float* %120, align 4, !dbg !145
  %122 = fadd float %121, %119, !dbg !145
  store volatile float %122, float* %120, align 4, !dbg !145
  %123 = load float** %mysh, align 8, !dbg !146
  %124 = getelementptr inbounds float* %123, i64 1, !dbg !146
  %125 = load volatile float* %124, align 4, !dbg !146
  %126 = load float** %mysh, align 8, !dbg !146
  %127 = load volatile float* %126, align 4, !dbg !146
  %128 = fadd float %127, %125, !dbg !146
  store volatile float %128, float* %126, align 4, !dbg !146
  %129 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !147
  %130 = icmp eq i32 %129, 0, !dbg !147
  br i1 %130, label %131, label %138, !dbg !147

; <label>:131                                     ; preds = %89
  %132 = load float** %mysh, align 8, !dbg !148
  %133 = load volatile float* %132, align 4, !dbg !148
  %134 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 0), align 4, !dbg !148
  %135 = zext i32 %134 to i64, !dbg !148
  %136 = load float** %3, align 8, !dbg !148
  %137 = getelementptr inbounds float* %136, i64 %135, !dbg !148
  store float %133, float* %137, align 4, !dbg !148
  br label %138, !dbg !150

; <label>:138                                     ; preds = %131, %89
  br label %139, !dbg !151

; <label>:139                                     ; preds = %138, %86
  ret void, !dbg !152
}

declare void @__syncthreads() section "__device__"

!llvm.dbg.cu = !{!0}

!0 = metadata !{i32 786449, i32 0, i32 4, metadata !"new-func.cpp", metadata !"/home/mingyuanwu/cuda-convnet2-new-bug", metadata !"clang version 3.2 (tags/RELEASE_32/final)", i1 true, i1 false, metadata !"", i32 0, metadata !1, metadata !1, metadata !3, metadata !25} ; [ DW_TAG_compile_unit ] [/home/mingyuanwu/cuda-convnet2-new-bug/new-func.cpp] [DW_LANG_C_plus_plus]
!1 = metadata !{metadata !2}
!2 = metadata !{i32 0}
!3 = metadata !{metadata !4}
!4 = metadata !{metadata !5, metadata !14, metadata !22}
!5 = metadata !{i32 786478, i32 0, metadata !6, metadata !"kReflectH", metadata !"kReflectH", metadata !"_Z9kReflectHPfS_iiiib", metadata !6, i32 4, metadata !7, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, void (float*, float*, i32, i32, i32, i32, i1)* @_Z9kReflectHPfS_iiiib, null, null, metadata !1, i32 5} ; [ DW_TAG_subprogram ] [line 4] [def] [scope 5] [kReflectH]
!6 = metadata !{i32 786473, metadata !"new-func.cpp", metadata !"/home/mingyuanwu/cuda-convnet2-new-bug", null} ; [ DW_TAG_file_type ]
!7 = metadata !{i32 786453, i32 0, metadata !"", i32 0, i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !8, i32 0, i32 0} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!8 = metadata !{null, metadata !9, metadata !9, metadata !11, metadata !11, metadata !12, metadata !12, metadata !13}
!9 = metadata !{i32 786447, null, metadata !"", null, i32 0, i64 64, i64 64, i64 0, i32 0, metadata !10} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from float]
!10 = metadata !{i32 786468, null, metadata !"float", null, i32 0, i64 32, i64 32, i64 0, i32 0, i32 4} ; [ DW_TAG_base_type ] [float] [line 0, size 32, align 32, offset 0, enc DW_ATE_float]
!11 = metadata !{i32 786470, null, metadata !"", null, i32 0, i64 0, i64 0, i64 0, i32 0, metadata !12} ; [ DW_TAG_const_type ] [line 0, size 0, align 0, offset 0] [from int]
!12 = metadata !{i32 786468, null, metadata !"int", null, i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!13 = metadata !{i32 786468, null, metadata !"bool", null, i32 0, i64 8, i64 8, i64 0, i32 0, i32 2} ; [ DW_TAG_base_type ] [bool] [line 0, size 8, align 8, offset 0, enc DW_ATE_boolean]
!14 = metadata !{i32 786478, i32 0, metadata !6, metadata !"kTile", metadata !"kTile", metadata !"_Z5kTilePKfPfjjjj", metadata !6, i32 33, metadata !15, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, void (float*, float*, i32, i32, i32, i32)* @_Z5kTilePKfPfjjjj, null, null, metadata !1, i32 33} ; [ DW_TAG_subprogram ] [line 33] [def] [kTile]
!15 = metadata !{i32 786453, i32 0, metadata !"", i32 0, i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !16, i32 0, i32 0} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!16 = metadata !{null, metadata !17, metadata !9, metadata !19, metadata !19, metadata !19, metadata !19}
!17 = metadata !{i32 786447, null, metadata !"", null, i32 0, i64 64, i64 64, i64 0, i32 0, metadata !18} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from ]
!18 = metadata !{i32 786470, null, metadata !"", null, i32 0, i64 0, i64 0, i64 0, i32 0, metadata !10} ; [ DW_TAG_const_type ] [line 0, size 0, align 0, offset 0] [from float]
!19 = metadata !{i32 786470, null, metadata !"", null, i32 0, i64 0, i64 0, i64 0, i32 0, metadata !20} ; [ DW_TAG_const_type ] [line 0, size 0, align 0, offset 0] [from uint]
!20 = metadata !{i32 786454, null, metadata !"uint", metadata !6, i32 152, i64 0, i64 0, i64 0, i32 0, metadata !21} ; [ DW_TAG_typedef ] [uint] [line 152, size 0, align 0, offset 0] [from unsigned int]
!21 = metadata !{i32 786468, null, metadata !"unsigned int", null, i32 0, i64 32, i64 32, i64 0, i32 0, i32 7} ; [ DW_TAG_base_type ] [unsigned int] [line 0, size 32, align 32, offset 0, enc DW_ATE_unsigned]
!22 = metadata !{i32 786478, i32 0, metadata !6, metadata !"kDotProduct_r", metadata !"kDotProduct_r", metadata !"_Z13kDotProduct_rPfS_S_j", metadata !6, i32 46, metadata !23, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, void (float*, float*, float*, i32)* @_Z13kDotProduct_rPfS_S_j, null, null, metadata !1, i32 46} ; [ DW_TAG_subprogram ] [line 46] [def] [kDotProduct_r]
!23 = metadata !{i32 786453, i32 0, metadata !"", i32 0, i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !24, i32 0, i32 0} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!24 = metadata !{null, metadata !9, metadata !9, metadata !9, metadata !19}
!25 = metadata !{metadata !26}
!26 = metadata !{metadata !27}
!27 = metadata !{i32 786484, i32 0, metadata !22, metadata !"shmem", metadata !"shmem", metadata !"", metadata !6, i32 47, metadata !28, i32 1, i32 1, [512 x float]* @_ZZ13kDotProduct_rPfS_S_jE5shmem} ; [ DW_TAG_variable ] [shmem] [line 47] [local] [def]
!28 = metadata !{i32 786433, null, metadata !"", null, i32 0, i64 16384, i64 32, i32 0, i32 0, metadata !10, metadata !29, i32 0, i32 0} ; [ DW_TAG_array_type ] [line 0, size 16384, align 32, offset 0] [from float]
!29 = metadata !{metadata !30}
!30 = metadata !{i32 786465, i64 0, i64 511}      ; [ DW_TAG_subrange_type ] [0, 511]
!31 = metadata !{i32 786689, metadata !5, metadata !"imgs", metadata !6, i32 16777220, metadata !9, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [imgs] [line 4]
!32 = metadata !{i32 4, i32 0, metadata !5, null}
!33 = metadata !{i32 786689, metadata !5, metadata !"targets", metadata !6, i32 33554436, metadata !9, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [targets] [line 4]
!34 = metadata !{i32 786689, metadata !5, metadata !"imgSize", metadata !6, i32 50331653, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [imgSize] [line 5]
!35 = metadata !{i32 5, i32 0, metadata !5, null}
!36 = metadata !{i32 786689, metadata !5, metadata !"numCases", metadata !6, i32 67108869, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [numCases] [line 5]
!37 = metadata !{i32 786689, metadata !5, metadata !"numColors", metadata !6, i32 83886085, metadata !12, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [numColors] [line 5]
!38 = metadata !{i32 786689, metadata !5, metadata !"imgsPerThread", metadata !6, i32 100663301, metadata !12, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [imgsPerThread] [line 5]
!39 = metadata !{i32 786689, metadata !5, metadata !"checkCaseBounds", metadata !6, i32 117440517, metadata !13, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [checkCaseBounds] [line 5]
!40 = metadata !{i32 786688, metadata !41, metadata !"pxIdx", metadata !6, i32 6, metadata !11, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [pxIdx] [line 6]
!41 = metadata !{i32 786443, metadata !5, i32 5, i32 0, metadata !6, i32 0} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/cuda-convnet2-new-bug/new-func.cpp]
!42 = metadata !{i32 6, i32 0, metadata !41, null}
!43 = metadata !{i32 786688, metadata !41, metadata !"imgPixels", metadata !6, i32 7, metadata !11, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [imgPixels] [line 7]
!44 = metadata !{i32 7, i32 0, metadata !41, null}
!45 = metadata !{i32 9, i32 0, metadata !41, null}
!46 = metadata !{i32 786688, metadata !47, metadata !"caseIdx", metadata !6, i32 10, metadata !11, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [caseIdx] [line 10]
!47 = metadata !{i32 786443, metadata !41, i32 9, i32 0, metadata !6, i32 1} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/cuda-convnet2-new-bug/new-func.cpp]
!48 = metadata !{i32 10, i32 0, metadata !47, null}
!49 = metadata !{i32 786688, metadata !47, metadata !"pxIdxY", metadata !6, i32 11, metadata !11, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [pxIdxY] [line 11]
!50 = metadata !{i32 11, i32 0, metadata !47, null}
!51 = metadata !{i32 786688, metadata !47, metadata !"pxIdxX", metadata !6, i32 12, metadata !11, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [pxIdxX] [line 12]
!52 = metadata !{i32 12, i32 0, metadata !47, null}
!53 = metadata !{i32 786688, metadata !47, metadata !"pxIdxXR", metadata !6, i32 14, metadata !11, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [pxIdxXR] [line 14]
!54 = metadata !{i32 14, i32 0, metadata !47, null}
!55 = metadata !{i32 786688, metadata !47, metadata !"pxIdxR", metadata !6, i32 15, metadata !11, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [pxIdxR] [line 15]
!56 = metadata !{i32 15, i32 0, metadata !47, null}
!57 = metadata !{i32 17, i32 0, metadata !47, null}
!58 = metadata !{i32 18, i32 0, metadata !47, null}
!59 = metadata !{i32 786688, metadata !60, metadata !"i", metadata !6, i32 21, metadata !12, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [i] [line 21]
!60 = metadata !{i32 786443, metadata !47, i32 21, i32 0, metadata !6, i32 2} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/cuda-convnet2-new-bug/new-func.cpp]
!61 = metadata !{i32 21, i32 0, metadata !60, null}
!62 = metadata !{i32 22, i32 0, metadata !63, null}
!63 = metadata !{i32 786443, metadata !60, i32 21, i32 0, metadata !6, i32 3} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/cuda-convnet2-new-bug/new-func.cpp]
!64 = metadata !{i32 786688, metadata !65, metadata !"c", metadata !6, i32 24, metadata !12, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [c] [line 24]
!65 = metadata !{i32 786443, metadata !66, i32 24, i32 0, metadata !6, i32 5} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/cuda-convnet2-new-bug/new-func.cpp]
!66 = metadata !{i32 786443, metadata !63, i32 22, i32 0, metadata !6, i32 4} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/cuda-convnet2-new-bug/new-func.cpp]
!67 = metadata !{i32 24, i32 0, metadata !65, null}
!68 = metadata !{i32 25, i32 0, metadata !69, null}
!69 = metadata !{i32 786443, metadata !65, i32 24, i32 0, metadata !6, i32 6} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/cuda-convnet2-new-bug/new-func.cpp]
!70 = metadata !{i32 26, i32 0, metadata !69, null}
!71 = metadata !{i32 27, i32 0, metadata !66, null}
!72 = metadata !{i32 28, i32 0, metadata !63, null}
!73 = metadata !{i32 29, i32 0, metadata !47, null}
!74 = metadata !{i32 30, i32 0, metadata !41, null}
!75 = metadata !{i32 786689, metadata !14, metadata !"src", metadata !6, i32 16777249, metadata !17, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [src] [line 33]
!76 = metadata !{i32 33, i32 0, metadata !14, null}
!77 = metadata !{i32 786689, metadata !14, metadata !"tgt", metadata !6, i32 33554465, metadata !9, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [tgt] [line 33]
!78 = metadata !{i32 786689, metadata !14, metadata !"srcWidth", metadata !6, i32 50331681, metadata !19, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [srcWidth] [line 33]
!79 = metadata !{i32 786689, metadata !14, metadata !"srcHeight", metadata !6, i32 67108897, metadata !19, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [srcHeight] [line 33]
!80 = metadata !{i32 786689, metadata !14, metadata !"tgtWidth", metadata !6, i32 83886113, metadata !19, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [tgtWidth] [line 33]
!81 = metadata !{i32 786689, metadata !14, metadata !"tgtHeight", metadata !6, i32 100663329, metadata !19, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [tgtHeight] [line 33]
!82 = metadata !{i32 786688, metadata !83, metadata !"idx", metadata !6, i32 34, metadata !11, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [idx] [line 34]
!83 = metadata !{i32 786443, metadata !14, i32 33, i32 0, metadata !6, i32 7} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/cuda-convnet2-new-bug/new-func.cpp]
!84 = metadata !{i32 34, i32 0, metadata !83, null}
!85 = metadata !{i32 786688, metadata !83, metadata !"numThreads", metadata !6, i32 35, metadata !11, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [numThreads] [line 35]
!86 = metadata !{i32 35, i32 0, metadata !83, null}
!87 = metadata !{i32 786688, metadata !88, metadata !"i", metadata !6, i32 37, metadata !20, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [i] [line 37]
!88 = metadata !{i32 786443, metadata !83, i32 37, i32 0, metadata !6, i32 8} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/cuda-convnet2-new-bug/new-func.cpp]
!89 = metadata !{i32 37, i32 0, metadata !88, null}
!90 = metadata !{i32 786688, metadata !91, metadata !"y", metadata !6, i32 38, metadata !19, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [y] [line 38]
!91 = metadata !{i32 786443, metadata !88, i32 37, i32 0, metadata !6, i32 9} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/cuda-convnet2-new-bug/new-func.cpp]
!92 = metadata !{i32 38, i32 0, metadata !91, null}
!93 = metadata !{i32 786688, metadata !91, metadata !"x", metadata !6, i32 39, metadata !19, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [x] [line 39]
!94 = metadata !{i32 39, i32 0, metadata !91, null}
!95 = metadata !{i32 786688, metadata !91, metadata !"srcY", metadata !6, i32 40, metadata !19, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [srcY] [line 40]
!96 = metadata !{i32 40, i32 0, metadata !91, null}
!97 = metadata !{i32 786688, metadata !91, metadata !"srcX", metadata !6, i32 41, metadata !19, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [srcX] [line 41]
!98 = metadata !{i32 41, i32 0, metadata !91, null}
!99 = metadata !{i32 42, i32 0, metadata !91, null}
!100 = metadata !{i32 43, i32 0, metadata !91, null}
!101 = metadata !{i32 44, i32 0, metadata !83, null}
!102 = metadata !{i32 786689, metadata !22, metadata !"a", metadata !6, i32 16777262, metadata !9, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [a] [line 46]
!103 = metadata !{i32 46, i32 0, metadata !22, null}
!104 = metadata !{i32 786689, metadata !22, metadata !"b", metadata !6, i32 33554478, metadata !9, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [b] [line 46]
!105 = metadata !{i32 786689, metadata !22, metadata !"target", metadata !6, i32 50331694, metadata !9, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [target] [line 46]
!106 = metadata !{i32 786689, metadata !22, metadata !"numElements", metadata !6, i32 67108910, metadata !19, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [numElements] [line 46]
!107 = metadata !{i32 786688, metadata !108, metadata !"eidx", metadata !6, i32 49, metadata !20, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [eidx] [line 49]
!108 = metadata !{i32 786443, metadata !22, i32 46, i32 0, metadata !6, i32 10} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/cuda-convnet2-new-bug/new-func.cpp]
!109 = metadata !{i32 49, i32 0, metadata !108, null}
!110 = metadata !{i32 50, i32 0, metadata !108, null}
!111 = metadata !{i32 51, i32 0, metadata !108, null}
!112 = metadata !{i32 52, i32 0, metadata !113, null}
!113 = metadata !{i32 786443, metadata !114, i32 52, i32 0, metadata !6, i32 12} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/cuda-convnet2-new-bug/new-func.cpp]
!114 = metadata !{i32 786443, metadata !108, i32 51, i32 0, metadata !6, i32 11} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/cuda-convnet2-new-bug/new-func.cpp]
!115 = metadata !{i32 53, i32 0, metadata !116, null}
!116 = metadata !{i32 786443, metadata !113, i32 52, i32 0, metadata !6, i32 13} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/cuda-convnet2-new-bug/new-func.cpp]
!117 = metadata !{i32 54, i32 0, metadata !116, null}
!118 = metadata !{i32 55, i32 0, metadata !114, null}
!119 = metadata !{i32 56, i32 0, metadata !108, null}
!120 = metadata !{i32 57, i32 0, metadata !108, null}
!121 = metadata !{i32 58, i32 0, metadata !122, null}
!122 = metadata !{i32 786443, metadata !108, i32 57, i32 0, metadata !6, i32 14} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/cuda-convnet2-new-bug/new-func.cpp]
!123 = metadata !{i32 59, i32 0, metadata !122, null}
!124 = metadata !{i32 60, i32 0, metadata !108, null}
!125 = metadata !{i32 61, i32 0, metadata !108, null}
!126 = metadata !{i32 62, i32 0, metadata !127, null}
!127 = metadata !{i32 786443, metadata !108, i32 61, i32 0, metadata !6, i32 15} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/cuda-convnet2-new-bug/new-func.cpp]
!128 = metadata !{i32 63, i32 0, metadata !127, null}
!129 = metadata !{i32 64, i32 0, metadata !108, null}
!130 = metadata !{i32 65, i32 0, metadata !108, null}
!131 = metadata !{i32 66, i32 0, metadata !132, null}
!132 = metadata !{i32 786443, metadata !108, i32 65, i32 0, metadata !6, i32 16} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/cuda-convnet2-new-bug/new-func.cpp]
!133 = metadata !{i32 67, i32 0, metadata !132, null}
!134 = metadata !{i32 68, i32 0, metadata !108, null}
!135 = metadata !{i32 69, i32 0, metadata !108, null}
!136 = metadata !{i32 786688, metadata !137, metadata !"mysh", metadata !6, i32 70, metadata !138, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [mysh] [line 70]
!137 = metadata !{i32 786443, metadata !108, i32 69, i32 0, metadata !6, i32 17} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/cuda-convnet2-new-bug/new-func.cpp]
!138 = metadata !{i32 786447, null, metadata !"", null, i32 0, i64 64, i64 64, i64 0, i32 0, metadata !139} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from ]
!139 = metadata !{i32 786485, null, metadata !"", null, i32 0, i64 0, i64 0, i64 0, i32 0, metadata !10} ; [ DW_TAG_volatile_type ] [line 0, size 0, align 0, offset 0] [from float]
!140 = metadata !{i32 70, i32 0, metadata !137, null}
!141 = metadata !{i32 71, i32 0, metadata !137, null}
!142 = metadata !{i32 72, i32 0, metadata !137, null}
!143 = metadata !{i32 73, i32 0, metadata !137, null}
!144 = metadata !{i32 74, i32 0, metadata !137, null}
!145 = metadata !{i32 75, i32 0, metadata !137, null}
!146 = metadata !{i32 76, i32 0, metadata !137, null}
!147 = metadata !{i32 77, i32 0, metadata !137, null}
!148 = metadata !{i32 78, i32 0, metadata !149, null}
!149 = metadata !{i32 786443, metadata !137, i32 77, i32 0, metadata !6, i32 18} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/cuda-convnet2-new-bug/new-func.cpp]
!150 = metadata !{i32 79, i32 0, metadata !149, null}
!151 = metadata !{i32 80, i32 0, metadata !137, null}
!152 = metadata !{i32 81, i32 0, metadata !108, null}
