; ModuleID = 'new-func'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.dim3 = type { i32, i32, i32 }

@blockIdx = external global %struct.dim3
@blockDim = external global %struct.dim3
@threadIdx = external global %struct.dim3
@_ZZ14kMinColumnwisePfS_jjE8min_vals = internal global [32 x float] zeroinitializer, section "__shared__", align 16

define void @_Z15kRandomGaussianPjPyPfj(i32* %rndMults, i64* %rndWords, float* %gData, i32 %numElements) nounwind uwtable noinline {
  %1 = alloca i32*, align 8
  %2 = alloca i64*, align 8
  %3 = alloca float*, align 8
  %4 = alloca i32, align 4
  %idx = alloca i32, align 4
  %rndWord = alloca i64, align 8
  %rndMult = alloca i32, align 4
  %rnd1 = alloca float, align 4
  %rnd2 = alloca float, align 4
  %R = alloca float, align 4
  %T = alloca float, align 4
  %i = alloca i32, align 4
  store i32* %rndMults, i32** %1, align 8
  call void @llvm.dbg.declare(metadata !{i32** %1}, metadata !24), !dbg !25
  store i64* %rndWords, i64** %2, align 8
  call void @llvm.dbg.declare(metadata !{i64** %2}, metadata !26), !dbg !25
  store float* %gData, float** %3, align 8
  call void @llvm.dbg.declare(metadata !{float** %3}, metadata !27), !dbg !25
  store i32 %numElements, i32* %4, align 4
  call void @llvm.dbg.declare(metadata !{i32* %4}, metadata !28), !dbg !25
  call void @llvm.dbg.declare(metadata !{i32* %idx}, metadata !29), !dbg !32
  %5 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 0), align 4, !dbg !32
  %6 = load i32* getelementptr inbounds (%struct.dim3* @blockDim, i32 0, i32 0), align 4, !dbg !32
  %7 = mul i32 %5, %6, !dbg !32
  %8 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !32
  %9 = add i32 %7, %8, !dbg !32
  store i32 %9, i32* %idx, align 4, !dbg !32
  call void @llvm.dbg.declare(metadata !{i64* %rndWord}, metadata !33), !dbg !34
  %10 = load i32* %idx, align 4, !dbg !34
  %11 = zext i32 %10 to i64, !dbg !34
  %12 = load i64** %2, align 8, !dbg !34
  %13 = getelementptr inbounds i64* %12, i64 %11, !dbg !34
  %14 = load i64* %13, align 8, !dbg !34
  store i64 %14, i64* %rndWord, align 8, !dbg !34
  call void @llvm.dbg.declare(metadata !{i32* %rndMult}, metadata !35), !dbg !36
  %15 = load i32* %idx, align 4, !dbg !36
  %16 = zext i32 %15 to i64, !dbg !36
  %17 = load i32** %1, align 8, !dbg !36
  %18 = getelementptr inbounds i32* %17, i64 %16, !dbg !36
  %19 = load i32* %18, align 4, !dbg !36
  store i32 %19, i32* %rndMult, align 4, !dbg !36
  call void @llvm.dbg.declare(metadata !{float* %rnd1}, metadata !37), !dbg !38
  call void @llvm.dbg.declare(metadata !{float* %rnd2}, metadata !39), !dbg !38
  call void @llvm.dbg.declare(metadata !{float* %R}, metadata !40), !dbg !38
  call void @llvm.dbg.declare(metadata !{float* %T}, metadata !41), !dbg !38
  call void @llvm.dbg.declare(metadata !{i32* %i}, metadata !42), !dbg !44
  %20 = load i32* %idx, align 4, !dbg !44
  store i32 %20, i32* %i, align 4, !dbg !44
  br label %21, !dbg !44

; <label>:21                                      ; preds = %78, %0
  %22 = load i32* %i, align 4, !dbg !44
  %23 = load i32* %4, align 4, !dbg !44
  %24 = icmp ult i32 %22, %23, !dbg !44
  br i1 %24, label %25, label %81, !dbg !44

; <label>:25                                      ; preds = %21
  %26 = load i32* %rndMult, align 4, !dbg !45
  %27 = zext i32 %26 to i64, !dbg !45
  %28 = load i64* %rndWord, align 8, !dbg !45
  %29 = and i64 %28, 4294967295, !dbg !45
  %30 = mul i64 %27, %29, !dbg !45
  %31 = load i64* %rndWord, align 8, !dbg !45
  %32 = lshr i64 %31, 32, !dbg !45
  %33 = add i64 %30, %32, !dbg !45
  store i64 %33, i64* %rndWord, align 8, !dbg !45
  %34 = load i64* %rndWord, align 8, !dbg !47
  %35 = and i64 %34, 4294967295, !dbg !47
  %36 = uitofp i64 %35 to float, !dbg !47
  %37 = fadd float %36, 1.000000e+00, !dbg !47
  %38 = fdiv float %37, 0x41F0000000000000, !dbg !47
  store float %38, float* %rnd1, align 4, !dbg !47
  %39 = load i32* %rndMult, align 4, !dbg !48
  %40 = zext i32 %39 to i64, !dbg !48
  %41 = load i64* %rndWord, align 8, !dbg !48
  %42 = and i64 %41, 4294967295, !dbg !48
  %43 = mul i64 %40, %42, !dbg !48
  %44 = load i64* %rndWord, align 8, !dbg !48
  %45 = lshr i64 %44, 32, !dbg !48
  %46 = add i64 %43, %45, !dbg !48
  store i64 %46, i64* %rndWord, align 8, !dbg !48
  %47 = load i64* %rndWord, align 8, !dbg !49
  %48 = and i64 %47, 4294967295, !dbg !49
  %49 = uitofp i64 %48 to float, !dbg !49
  %50 = fadd float %49, 1.000000e+00, !dbg !49
  %51 = fdiv float %50, 0x41F0000000000000, !dbg !49
  store float %51, float* %rnd2, align 4, !dbg !49
  %52 = load float* %rnd2, align 4, !dbg !50
  %53 = fmul float 0x401921FB60000000, %52, !dbg !50
  store float %53, float* %T, align 4, !dbg !50
  %54 = load float* %rnd1, align 4, !dbg !51
  %55 = fmul float -2.000000e+00, %54, !dbg !51
  store float %55, float* %R, align 4, !dbg !51
  %56 = load float* %R, align 4, !dbg !52
  %57 = load float* %T, align 4, !dbg !52
  %58 = fmul float %56, %57, !dbg !52
  %59 = load i32* %i, align 4, !dbg !52
  %60 = zext i32 %59 to i64, !dbg !52
  %61 = load float** %3, align 8, !dbg !52
  %62 = getelementptr inbounds float* %61, i64 %60, !dbg !52
  store float %58, float* %62, align 4, !dbg !52
  %63 = load i32* %i, align 4, !dbg !53
  %64 = add i32 %63, 12288, !dbg !53
  %65 = load i32* %4, align 4, !dbg !53
  %66 = icmp ult i32 %64, %65, !dbg !53
  br i1 %66, label %67, label %77, !dbg !53

; <label>:67                                      ; preds = %25
  %68 = load float* %R, align 4, !dbg !54
  %69 = load float* %T, align 4, !dbg !54
  %70 = call float @__sinf(float %69) nounwind, !dbg !54
  %71 = fmul float %68, %70, !dbg !54
  %72 = load i32* %i, align 4, !dbg !54
  %73 = add i32 %72, 12288, !dbg !54
  %74 = zext i32 %73 to i64, !dbg !54
  %75 = load float** %3, align 8, !dbg !54
  %76 = getelementptr inbounds float* %75, i64 %74, !dbg !54
  store float %71, float* %76, align 4, !dbg !54
  br label %77, !dbg !54

; <label>:77                                      ; preds = %67, %25
  br label %78, !dbg !55

; <label>:78                                      ; preds = %77
  %79 = load i32* %i, align 4, !dbg !44
  %80 = add i32 %79, 24576, !dbg !44
  store i32 %80, i32* %i, align 4, !dbg !44
  br label %21, !dbg !44

; <label>:81                                      ; preds = %21
  %82 = load i64* %rndWord, align 8, !dbg !56
  %83 = load i32* %idx, align 4, !dbg !56
  %84 = zext i32 %83 to i64, !dbg !56
  %85 = load i64** %2, align 8, !dbg !56
  %86 = getelementptr inbounds i64* %85, i64 %84, !dbg !56
  store i64 %82, i64* %86, align 8, !dbg !56
  ret void, !dbg !57
}

declare void @llvm.dbg.declare(metadata, metadata) nounwind readnone

declare float @__sinf(float) nounwind section "__device__"

define void @_Z14kMinColumnwisePfS_jj(float* %mat, float* %target, i32 %width, i32 %height) uwtable noinline {
  %1 = alloca float*, align 8
  %2 = alloca float*, align 8
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %cur_min = alloca float, align 4
  %val = alloca float, align 4
  %i = alloca i32, align 4
  %i1 = alloca i32, align 4
  store float* %mat, float** %1, align 8
  call void @llvm.dbg.declare(metadata !{float** %1}, metadata !58), !dbg !59
  store float* %target, float** %2, align 8
  call void @llvm.dbg.declare(metadata !{float** %2}, metadata !60), !dbg !59
  store i32 %width, i32* %3, align 4
  call void @llvm.dbg.declare(metadata !{i32* %3}, metadata !61), !dbg !59
  store i32 %height, i32* %4, align 4
  call void @llvm.dbg.declare(metadata !{i32* %4}, metadata !62), !dbg !59
  call void @llvm.dbg.declare(metadata !{float* %cur_min}, metadata !63), !dbg !65
  store float 1.000000e+00, float* %cur_min, align 4, !dbg !65
  call void @llvm.dbg.declare(metadata !{float* %val}, metadata !66), !dbg !67
  store float 0.000000e+00, float* %val, align 4, !dbg !67
  call void @llvm.dbg.declare(metadata !{i32* %i}, metadata !68), !dbg !70
  %5 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !70
  store i32 %5, i32* %i, align 4, !dbg !70
  br label %6, !dbg !70

; <label>:6                                       ; preds = %26, %0
  %7 = load i32* %i, align 4, !dbg !70
  %8 = load i32* %4, align 4, !dbg !70
  %9 = icmp ult i32 %7, %8, !dbg !70
  br i1 %9, label %10, label %29, !dbg !70

; <label>:10                                      ; preds = %6
  %11 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 0), align 4, !dbg !71
  %12 = load i32* %4, align 4, !dbg !71
  %13 = mul i32 %11, %12, !dbg !71
  %14 = load i32* %i, align 4, !dbg !71
  %15 = add i32 %13, %14, !dbg !71
  %16 = zext i32 %15 to i64, !dbg !71
  %17 = load float** %1, align 8, !dbg !71
  %18 = getelementptr inbounds float* %17, i64 %16, !dbg !71
  %19 = load float* %18, align 4, !dbg !71
  store float %19, float* %val, align 4, !dbg !71
  %20 = load float* %val, align 4, !dbg !73
  %21 = load float* %cur_min, align 4, !dbg !73
  %22 = fcmp olt float %20, %21, !dbg !73
  br i1 %22, label %23, label %25, !dbg !73

; <label>:23                                      ; preds = %10
  %24 = load float* %val, align 4, !dbg !74
  store float %24, float* %cur_min, align 4, !dbg !74
  br label %25, !dbg !74

; <label>:25                                      ; preds = %23, %10
  br label %26, !dbg !75

; <label>:26                                      ; preds = %25
  %27 = load i32* %i, align 4, !dbg !70
  %28 = add i32 %27, 32, !dbg !70
  store i32 %28, i32* %i, align 4, !dbg !70
  br label %6, !dbg !70

; <label>:29                                      ; preds = %6
  %30 = load float* %cur_min, align 4, !dbg !76
  %31 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !76
  %32 = zext i32 %31 to i64, !dbg !76
  %33 = getelementptr inbounds [32 x float]* @_ZZ14kMinColumnwisePfS_jjE8min_vals, i32 0, i64 %32, !dbg !76
  store float %30, float* %33, align 4, !dbg !76

  %34 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !78
  %35 = icmp eq i32 %34, 0, !dbg !78
  br i1 %35, label %36, label %62, !dbg !78

; <label>:36                                      ; preds = %29
  store float 1.000000e+00, float* %cur_min, align 4, !dbg !79
  call void @llvm.dbg.declare(metadata !{i32* %i1}, metadata !81), !dbg !83
  store i32 0, i32* %i1, align 4, !dbg !83
  br label %37, !dbg !83

; <label>:37                                      ; preds = %53, %36
  %38 = load i32* %i1, align 4, !dbg !83
  %39 = icmp ult i32 %38, 32, !dbg !83
  br i1 %39, label %40, label %56, !dbg !83

; <label>:40                                      ; preds = %37
  %41 = load i32* %i1, align 4, !dbg !84
  %42 = zext i32 %41 to i64, !dbg !84
  %43 = getelementptr inbounds [32 x float]* @_ZZ14kMinColumnwisePfS_jjE8min_vals, i32 0, i64 %42, !dbg !84
  %44 = load float* %43, align 4, !dbg !84
  %45 = load float* %cur_min, align 4, !dbg !84
  %46 = fcmp olt float %44, %45, !dbg !84
  br i1 %46, label %47, label %52, !dbg !84

; <label>:47                                      ; preds = %40
  %48 = load i32* %i1, align 4, !dbg !85
  %49 = zext i32 %48 to i64, !dbg !85
  %50 = getelementptr inbounds [32 x float]* @_ZZ14kMinColumnwisePfS_jjE8min_vals, i32 0, i64 %49, !dbg !85
  %51 = load float* %50, align 4, !dbg !85
  store float %51, float* %cur_min, align 4, !dbg !85
  br label %52, !dbg !85

; <label>:52                                      ; preds = %47, %40
  br label %53, !dbg !85

; <label>:53                                      ; preds = %52
  %54 = load i32* %i1, align 4, !dbg !83
  %55 = add i32 %54, 1, !dbg !83
  store i32 %55, i32* %i1, align 4, !dbg !83
  br label %37, !dbg !83

; <label>:56                                      ; preds = %37
  %57 = load float* %cur_min, align 4, !dbg !86
  %58 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 0), align 4, !dbg !86
  %59 = zext i32 %58 to i64, !dbg !86
  %60 = load float** %2, align 8, !dbg !86
  %61 = getelementptr inbounds float* %60, i64 %59, !dbg !86
  store float %57, float* %61, align 4, !dbg !86
  br label %62, !dbg !87

; <label>:62                                      ; preds = %56, %29
  ret void, !dbg !88
}

declare void @__syncthreads() section "__device__"

!llvm.dbg.cu = !{!0}

!0 = metadata !{i32 786449, i32 0, i32 4, metadata !"new-func.cpp", metadata !"/home/mingyuanwu/cuda-cudamat-new-bug", metadata !"clang version 3.2 (tags/RELEASE_32/final)", i1 true, i1 false, metadata !"", i32 0, metadata !1, metadata !1, metadata !3, metadata !18} ; [ DW_TAG_compile_unit ] [/home/mingyuanwu/cuda-cudamat-new-bug/new-func.cpp] [DW_LANG_C_plus_plus]
!1 = metadata !{metadata !2}
!2 = metadata !{i32 0}
!3 = metadata !{metadata !4}
!4 = metadata !{metadata !5, metadata !15}
!5 = metadata !{i32 786478, i32 0, metadata !6, metadata !"kRandomGaussian", metadata !"kRandomGaussian", metadata !"_Z15kRandomGaussianPjPyPfj", metadata !6, i32 23, metadata !7, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, void (i32*, i64*, float*, i32)* @_Z15kRandomGaussianPjPyPfj, null, null, metadata !1, i32 23} ; [ DW_TAG_subprogram ] [line 23] [def] [kRandomGaussian]
!6 = metadata !{i32 786473, metadata !"new-func.cpp", metadata !"/home/mingyuanwu/cuda-cudamat-new-bug", null} ; [ DW_TAG_file_type ]
!7 = metadata !{i32 786453, i32 0, metadata !"", i32 0, i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !8, i32 0, i32 0} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!8 = metadata !{null, metadata !9, metadata !11, metadata !13, metadata !10}
!9 = metadata !{i32 786447, null, metadata !"", null, i32 0, i64 64, i64 64, i64 0, i32 0, metadata !10} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from unsigned int]
!10 = metadata !{i32 786468, null, metadata !"unsigned int", null, i32 0, i64 32, i64 32, i64 0, i32 0, i32 7} ; [ DW_TAG_base_type ] [unsigned int] [line 0, size 32, align 32, offset 0, enc DW_ATE_unsigned]
!11 = metadata !{i32 786447, null, metadata !"", null, i32 0, i64 64, i64 64, i64 0, i32 0, metadata !12} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from long long unsigned int]
!12 = metadata !{i32 786468, null, metadata !"long long unsigned int", null, i32 0, i64 64, i64 64, i64 0, i32 0, i32 7} ; [ DW_TAG_base_type ] [long long unsigned int] [line 0, size 64, align 64, offset 0, enc DW_ATE_unsigned]
!13 = metadata !{i32 786447, null, metadata !"", null, i32 0, i64 64, i64 64, i64 0, i32 0, metadata !14} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from float]
!14 = metadata !{i32 786468, null, metadata !"float", null, i32 0, i64 32, i64 32, i64 0, i32 0, i32 4} ; [ DW_TAG_base_type ] [float] [line 0, size 32, align 32, offset 0, enc DW_ATE_float]
!15 = metadata !{i32 786478, i32 0, metadata !6, metadata !"kMinColumnwise", metadata !"kMinColumnwise", metadata !"_Z14kMinColumnwisePfS_jj", metadata !6, i32 43, metadata !16, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, void (float*, float*, i32, i32)* @_Z14kMinColumnwisePfS_jj, null, null, metadata !1, i32 43} ; [ DW_TAG_subprogram ] [line 43] [def] [kMinColumnwise]
!16 = metadata !{i32 786453, i32 0, metadata !"", i32 0, i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !17, i32 0, i32 0} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!17 = metadata !{null, metadata !13, metadata !13, metadata !10, metadata !10}
!18 = metadata !{metadata !19}
!19 = metadata !{metadata !20}
!20 = metadata !{i32 786484, i32 0, metadata !15, metadata !"min_vals", metadata !"min_vals", metadata !"", metadata !6, i32 44, metadata !21, i32 1, i32 1, [32 x float]* @_ZZ14kMinColumnwisePfS_jjE8min_vals} ; [ DW_TAG_variable ] [min_vals] [line 44] [local] [def]
!21 = metadata !{i32 786433, null, metadata !"", null, i32 0, i64 1024, i64 32, i32 0, i32 0, metadata !14, metadata !22, i32 0, i32 0} ; [ DW_TAG_array_type ] [line 0, size 1024, align 32, offset 0] [from float]
!22 = metadata !{metadata !23}
!23 = metadata !{i32 786465, i64 0, i64 31}       ; [ DW_TAG_subrange_type ] [0, 31]
!24 = metadata !{i32 786689, metadata !5, metadata !"rndMults", metadata !6, i32 16777239, metadata !9, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [rndMults] [line 23]
!25 = metadata !{i32 23, i32 0, metadata !5, null}
!26 = metadata !{i32 786689, metadata !5, metadata !"rndWords", metadata !6, i32 33554455, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [rndWords] [line 23]
!27 = metadata !{i32 786689, metadata !5, metadata !"gData", metadata !6, i32 50331671, metadata !13, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [gData] [line 23]
!28 = metadata !{i32 786689, metadata !5, metadata !"numElements", metadata !6, i32 67108887, metadata !10, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [numElements] [line 23]
!29 = metadata !{i32 786688, metadata !30, metadata !"idx", metadata !6, i32 24, metadata !31, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [idx] [line 24]
!30 = metadata !{i32 786443, metadata !5, i32 23, i32 0, metadata !6, i32 0} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/cuda-cudamat-new-bug/new-func.cpp]
!31 = metadata !{i32 786470, null, metadata !"", null, i32 0, i64 0, i64 0, i64 0, i32 0, metadata !10} ; [ DW_TAG_const_type ] [line 0, size 0, align 0, offset 0] [from unsigned int]
!32 = metadata !{i32 24, i32 0, metadata !30, null}
!33 = metadata !{i32 786688, metadata !30, metadata !"rndWord", metadata !6, i32 25, metadata !12, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [rndWord] [line 25]
!34 = metadata !{i32 25, i32 0, metadata !30, null}
!35 = metadata !{i32 786688, metadata !30, metadata !"rndMult", metadata !6, i32 26, metadata !31, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [rndMult] [line 26]
!36 = metadata !{i32 26, i32 0, metadata !30, null}
!37 = metadata !{i32 786688, metadata !30, metadata !"rnd1", metadata !6, i32 28, metadata !14, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [rnd1] [line 28]
!38 = metadata !{i32 28, i32 0, metadata !30, null}
!39 = metadata !{i32 786688, metadata !30, metadata !"rnd2", metadata !6, i32 28, metadata !14, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [rnd2] [line 28]
!40 = metadata !{i32 786688, metadata !30, metadata !"R", metadata !6, i32 28, metadata !14, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [R] [line 28]
!41 = metadata !{i32 786688, metadata !30, metadata !"T", metadata !6, i32 28, metadata !14, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [T] [line 28]
!42 = metadata !{i32 786688, metadata !43, metadata !"i", metadata !6, i32 29, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [i] [line 29]
!43 = metadata !{i32 786443, metadata !30, i32 29, i32 0, metadata !6, i32 1} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/cuda-cudamat-new-bug/new-func.cpp]
!44 = metadata !{i32 29, i32 0, metadata !43, null}
!45 = metadata !{i32 30, i32 0, metadata !46, null}
!46 = metadata !{i32 786443, metadata !43, i32 29, i32 0, metadata !6, i32 2} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/cuda-cudamat-new-bug/new-func.cpp]
!47 = metadata !{i32 31, i32 0, metadata !46, null}
!48 = metadata !{i32 32, i32 0, metadata !46, null}
!49 = metadata !{i32 33, i32 0, metadata !46, null}
!50 = metadata !{i32 34, i32 0, metadata !46, null}
!51 = metadata !{i32 35, i32 0, metadata !46, null}
!52 = metadata !{i32 36, i32 0, metadata !46, null}
!53 = metadata !{i32 37, i32 0, metadata !46, null}
!54 = metadata !{i32 38, i32 0, metadata !46, null}
!55 = metadata !{i32 39, i32 0, metadata !46, null}
!56 = metadata !{i32 40, i32 0, metadata !30, null}
!57 = metadata !{i32 41, i32 0, metadata !30, null}
!58 = metadata !{i32 786689, metadata !15, metadata !"mat", metadata !6, i32 16777259, metadata !13, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [mat] [line 43]
!59 = metadata !{i32 43, i32 0, metadata !15, null}
!60 = metadata !{i32 786689, metadata !15, metadata !"target", metadata !6, i32 33554475, metadata !13, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [target] [line 43]
!61 = metadata !{i32 786689, metadata !15, metadata !"width", metadata !6, i32 50331691, metadata !10, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [width] [line 43]
!62 = metadata !{i32 786689, metadata !15, metadata !"height", metadata !6, i32 67108907, metadata !10, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [height] [line 43]
!63 = metadata !{i32 786688, metadata !64, metadata !"cur_min", metadata !6, i32 45, metadata !14, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [cur_min] [line 45]
!64 = metadata !{i32 786443, metadata !15, i32 43, i32 0, metadata !6, i32 3} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/cuda-cudamat-new-bug/new-func.cpp]
!65 = metadata !{i32 45, i32 0, metadata !64, null}
!66 = metadata !{i32 786688, metadata !64, metadata !"val", metadata !6, i32 46, metadata !14, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [val] [line 46]
!67 = metadata !{i32 46, i32 0, metadata !64, null}
!68 = metadata !{i32 786688, metadata !69, metadata !"i", metadata !6, i32 48, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [i] [line 48]
!69 = metadata !{i32 786443, metadata !64, i32 48, i32 0, metadata !6, i32 4} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/cuda-cudamat-new-bug/new-func.cpp]
!70 = metadata !{i32 48, i32 0, metadata !69, null}
!71 = metadata !{i32 49, i32 0, metadata !72, null}
!72 = metadata !{i32 786443, metadata !69, i32 48, i32 0, metadata !6, i32 5} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/cuda-cudamat-new-bug/new-func.cpp]
!73 = metadata !{i32 51, i32 0, metadata !72, null}
!74 = metadata !{i32 52, i32 0, metadata !72, null}
!75 = metadata !{i32 53, i32 0, metadata !72, null}
!76 = metadata !{i32 55, i32 0, metadata !64, null}
!77 = metadata !{i32 57, i32 0, metadata !64, null}
!78 = metadata !{i32 59, i32 0, metadata !64, null}
!79 = metadata !{i32 60, i32 0, metadata !80, null}
!80 = metadata !{i32 786443, metadata !64, i32 59, i32 0, metadata !6, i32 6} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/cuda-cudamat-new-bug/new-func.cpp]
!81 = metadata !{i32 786688, metadata !82, metadata !"i", metadata !6, i32 62, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [i] [line 62]
!82 = metadata !{i32 786443, metadata !80, i32 62, i32 0, metadata !6, i32 7} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/cuda-cudamat-new-bug/new-func.cpp]
!83 = metadata !{i32 62, i32 0, metadata !82, null}
!84 = metadata !{i32 63, i32 0, metadata !82, null}
!85 = metadata !{i32 64, i32 0, metadata !82, null}
!86 = metadata !{i32 66, i32 0, metadata !80, null}
!87 = metadata !{i32 67, i32 0, metadata !80, null}
!88 = metadata !{i32 68, i32 0, metadata !64, null}
