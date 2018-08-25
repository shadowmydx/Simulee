; ModuleID = 'new-func'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.dim3 = type { i32, i32, i32 }

@_ZZ11g_getCost_3PfS_fiE4_sum = internal global [32 x float] zeroinitializer, section "__shared__", align 16
@threadIdx = external global %struct.dim3
@blockDim = external global %struct.dim3

define void @_Z11g_getCost_3PfS_fi(float* %cost, float* %weight, float %lambda, i32 %wlen) uwtable noinline {
  %1 = alloca float*, align 8
  %2 = alloca float*, align 8
  %3 = alloca float, align 4
  %4 = alloca i32, align 4
  %i = alloca i32, align 4
  %id = alloca i32, align 4
  %len = alloca i32, align 4
  %skip = alloca i32, align 4
  store float* %cost, float** %1, align 8
  call void @llvm.dbg.declare(metadata !{float** %1}, metadata !18), !dbg !19
  store float* %weight, float** %2, align 8
  call void @llvm.dbg.declare(metadata !{float** %2}, metadata !20), !dbg !21
  store float %lambda, float* %3, align 4
  call void @llvm.dbg.declare(metadata !{float* %3}, metadata !22), !dbg !23
  store i32 %wlen, i32* %4, align 4
  call void @llvm.dbg.declare(metadata !{i32* %4}, metadata !24), !dbg !23
  %5 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !25
  %6 = zext i32 %5 to i64, !dbg !25
  %7 = getelementptr inbounds [32 x float]* @_ZZ11g_getCost_3PfS_fiE4_sum, i32 0, i64 %6, !dbg !25
  store float 0.000000e+00, float* %7, align 4, !dbg !25
  call void @__syncthreads(), !dbg !27
  call void @llvm.dbg.declare(metadata !{i32* %i}, metadata !28), !dbg !30
  store i32 0, i32* %i, align 4, !dbg !30
  br label %8, !dbg !30

; <label>:8                                       ; preds = %37, %0
  %9 = load i32* %i, align 4, !dbg !30
  %10 = load i32* %4, align 4, !dbg !30
  %11 = icmp slt i32 %9, %10, !dbg !30
  br i1 %11, label %12, label %41, !dbg !30

; <label>:12                                      ; preds = %8
  call void @llvm.dbg.declare(metadata !{i32* %id}, metadata !31), !dbg !33
  %13 = load i32* %i, align 4, !dbg !33
  %14 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !33
  %15 = add i32 %13, %14, !dbg !33
  store i32 %15, i32* %id, align 4, !dbg !33
  %16 = load i32* %id, align 4, !dbg !34
  %17 = load i32* %4, align 4, !dbg !34
  %18 = icmp slt i32 %16, %17, !dbg !34
  br i1 %18, label %19, label %36, !dbg !34

; <label>:19                                      ; preds = %12
  %20 = load i32* %id, align 4, !dbg !35
  %21 = sext i32 %20 to i64, !dbg !35
  %22 = load float** %2, align 8, !dbg !35
  %23 = getelementptr inbounds float* %22, i64 %21, !dbg !35
  %24 = load float* %23, align 4, !dbg !35
  %25 = load i32* %id, align 4, !dbg !35
  %26 = sext i32 %25 to i64, !dbg !35
  %27 = load float** %2, align 8, !dbg !35
  %28 = getelementptr inbounds float* %27, i64 %26, !dbg !35
  %29 = load float* %28, align 4, !dbg !35
  %30 = fmul float %24, %29, !dbg !35
  %31 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !35
  %32 = zext i32 %31 to i64, !dbg !35
  %33 = getelementptr inbounds [32 x float]* @_ZZ11g_getCost_3PfS_fiE4_sum, i32 0, i64 %32, !dbg !35
  %34 = load float* %33, align 4, !dbg !35
  %35 = fadd float %34, %30, !dbg !35
  store float %35, float* %33, align 4, !dbg !35
  br label %36, !dbg !37

; <label>:36                                      ; preds = %19, %12
  br label %37, !dbg !38

; <label>:37                                      ; preds = %36
  %38 = load i32* getelementptr inbounds (%struct.dim3* @blockDim, i32 0, i32 0), align 4, !dbg !30
  %39 = load i32* %i, align 4, !dbg !30
  %40 = add i32 %39, %38, !dbg !30
  store i32 %40, i32* %i, align 4, !dbg !30
  br label %8, !dbg !30

; <label>:41                                      ; preds = %8
  call void @llvm.dbg.declare(metadata !{i32* %len}, metadata !39), !dbg !40
  %42 = load i32* getelementptr inbounds (%struct.dim3* @blockDim, i32 0, i32 0), align 4, !dbg !40
  store i32 %42, i32* %len, align 4, !dbg !40
  br label %43, !dbg !41

; <label>:43                                      ; preds = %71, %41
  %44 = load i32* %len, align 4, !dbg !41
  %45 = icmp ne i32 %44, 1, !dbg !41
  br i1 %45, label %46, label %73, !dbg !41

; <label>:46                                      ; preds = %43
  call void @__syncthreads(), !dbg !42
  call void @llvm.dbg.declare(metadata !{i32* %skip}, metadata !44), !dbg !45
  %47 = load i32* %len, align 4, !dbg !45
  %48 = add nsw i32 %47, 1, !dbg !45
  %49 = ashr i32 %48, 1, !dbg !45
  store i32 %49, i32* %skip, align 4, !dbg !45
  %50 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !46
  %51 = load i32* %skip, align 4, !dbg !46
  %52 = icmp ult i32 %50, %51, !dbg !46
  br i1 %52, label %53, label %71, !dbg !46

; <label>:53                                      ; preds = %46
  %54 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !46
  %55 = load i32* %skip, align 4, !dbg !46
  %56 = add i32 %54, %55, !dbg !46
  %57 = load i32* %len, align 4, !dbg !46
  %58 = icmp ult i32 %56, %57, !dbg !46
  br i1 %58, label %59, label %71, !dbg !46

; <label>:59                                      ; preds = %53
  %60 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !47
  %61 = load i32* %skip, align 4, !dbg !47
  %62 = add i32 %60, %61, !dbg !47
  %63 = zext i32 %62 to i64, !dbg !47
  %64 = getelementptr inbounds [32 x float]* @_ZZ11g_getCost_3PfS_fiE4_sum, i32 0, i64 %63, !dbg !47
  %65 = load float* %64, align 4, !dbg !47
  %66 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !47
  %67 = zext i32 %66 to i64, !dbg !47
  %68 = getelementptr inbounds [32 x float]* @_ZZ11g_getCost_3PfS_fiE4_sum, i32 0, i64 %67, !dbg !47
  %69 = load float* %68, align 4, !dbg !47
  %70 = fadd float %69, %65, !dbg !47
  store float %70, float* %68, align 4, !dbg !47
  br label %71, !dbg !49

; <label>:71                                      ; preds = %59, %53, %46
  %72 = load i32* %skip, align 4, !dbg !50
  store i32 %72, i32* %len, align 4, !dbg !50
  br label %43, !dbg !51

; <label>:73                                      ; preds = %43
  ret void, !dbg !52
}

declare void @llvm.dbg.declare(metadata, metadata) nounwind readnone

declare void @__syncthreads() section "__device__"

!llvm.dbg.cu = !{!0}

!0 = metadata !{i32 786449, i32 0, i32 4, metadata !"new-func.cpp", metadata !"/home/mingyuanwu/cuda-cnn-new-bug", metadata !"clang version 3.2 (tags/RELEASE_32/final)", i1 true, i1 false, metadata !"", i32 0, metadata !1, metadata !1, metadata !3, metadata !12} ; [ DW_TAG_compile_unit ] [/home/mingyuanwu/cuda-cnn-new-bug/new-func.cpp] [DW_LANG_C_plus_plus]
!1 = metadata !{metadata !2}
!2 = metadata !{i32 0}
!3 = metadata !{metadata !4}
!4 = metadata !{metadata !5}
!5 = metadata !{i32 786478, i32 0, metadata !6, metadata !"g_getCost_3", metadata !"g_getCost_3", metadata !"_Z11g_getCost_3PfS_fi", metadata !6, i32 1, metadata !7, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, void (float*, float*, float, i32)* @_Z11g_getCost_3PfS_fi, null, null, metadata !1, i32 4} ; [ DW_TAG_subprogram ] [line 1] [def] [scope 4] [g_getCost_3]
!6 = metadata !{i32 786473, metadata !"new-func.cpp", metadata !"/home/mingyuanwu/cuda-cnn-new-bug", null} ; [ DW_TAG_file_type ]
!7 = metadata !{i32 786453, i32 0, metadata !"", i32 0, i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !8, i32 0, i32 0} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!8 = metadata !{null, metadata !9, metadata !9, metadata !10, metadata !11}
!9 = metadata !{i32 786447, null, metadata !"", null, i32 0, i64 64, i64 64, i64 0, i32 0, metadata !10} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from float]
!10 = metadata !{i32 786468, null, metadata !"float", null, i32 0, i64 32, i64 32, i64 0, i32 0, i32 4} ; [ DW_TAG_base_type ] [float] [line 0, size 32, align 32, offset 0, enc DW_ATE_float]
!11 = metadata !{i32 786468, null, metadata !"int", null, i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!12 = metadata !{metadata !13}
!13 = metadata !{metadata !14}
!14 = metadata !{i32 786484, i32 0, metadata !5, metadata !"_sum", metadata !"_sum", metadata !"", metadata !6, i32 5, metadata !15, i32 1, i32 1, [32 x float]* @_ZZ11g_getCost_3PfS_fiE4_sum} ; [ DW_TAG_variable ] [_sum] [line 5] [local] [def]
!15 = metadata !{i32 786433, null, metadata !"", null, i32 0, i64 1024, i64 32, i32 0, i32 0, metadata !10, metadata !16, i32 0, i32 0} ; [ DW_TAG_array_type ] [line 0, size 1024, align 32, offset 0] [from float]
!16 = metadata !{metadata !17}
!17 = metadata !{i32 786465, i64 0, i64 31}       ; [ DW_TAG_subrange_type ] [0, 31]
!18 = metadata !{i32 786689, metadata !5, metadata !"cost", metadata !6, i32 16777217, metadata !9, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [cost] [line 1]
!19 = metadata !{i32 1, i32 0, metadata !5, null}
!20 = metadata !{i32 786689, metadata !5, metadata !"weight", metadata !6, i32 33554434, metadata !9, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [weight] [line 2]
!21 = metadata !{i32 2, i32 0, metadata !5, null}
!22 = metadata !{i32 786689, metadata !5, metadata !"lambda", metadata !6, i32 50331651, metadata !10, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [lambda] [line 3]
!23 = metadata !{i32 3, i32 0, metadata !5, null}
!24 = metadata !{i32 786689, metadata !5, metadata !"wlen", metadata !6, i32 67108867, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [wlen] [line 3]
!25 = metadata !{i32 6, i32 0, metadata !26, null}
!26 = metadata !{i32 786443, metadata !5, i32 4, i32 0, metadata !6, i32 0} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/cuda-cnn-new-bug/new-func.cpp]
!27 = metadata !{i32 7, i32 0, metadata !26, null}
!28 = metadata !{i32 786688, metadata !29, metadata !"i", metadata !6, i32 10, metadata !11, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [i] [line 10]
!29 = metadata !{i32 786443, metadata !26, i32 10, i32 0, metadata !6, i32 1} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/cuda-cnn-new-bug/new-func.cpp]
!30 = metadata !{i32 10, i32 0, metadata !29, null}
!31 = metadata !{i32 786688, metadata !32, metadata !"id", metadata !6, i32 12, metadata !11, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [id] [line 12]
!32 = metadata !{i32 786443, metadata !29, i32 11, i32 0, metadata !6, i32 2} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/cuda-cnn-new-bug/new-func.cpp]
!33 = metadata !{i32 12, i32 0, metadata !32, null}
!34 = metadata !{i32 13, i32 0, metadata !32, null}
!35 = metadata !{i32 15, i32 0, metadata !36, null}
!36 = metadata !{i32 786443, metadata !32, i32 14, i32 0, metadata !6, i32 3} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/cuda-cnn-new-bug/new-func.cpp]
!37 = metadata !{i32 16, i32 0, metadata !36, null}
!38 = metadata !{i32 17, i32 0, metadata !32, null}
!39 = metadata !{i32 786688, metadata !26, metadata !"len", metadata !6, i32 19, metadata !11, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [len] [line 19]
!40 = metadata !{i32 19, i32 0, metadata !26, null}
!41 = metadata !{i32 20, i32 0, metadata !26, null}
!42 = metadata !{i32 22, i32 0, metadata !43, null}
!43 = metadata !{i32 786443, metadata !26, i32 21, i32 0, metadata !6, i32 4} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/cuda-cnn-new-bug/new-func.cpp]
!44 = metadata !{i32 786688, metadata !43, metadata !"skip", metadata !6, i32 23, metadata !11, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [skip] [line 23]
!45 = metadata !{i32 23, i32 0, metadata !43, null}
!46 = metadata !{i32 24, i32 0, metadata !43, null}
!47 = metadata !{i32 26, i32 0, metadata !48, null}
!48 = metadata !{i32 786443, metadata !43, i32 25, i32 0, metadata !6, i32 5} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/cuda-cnn-new-bug/new-func.cpp]
!49 = metadata !{i32 27, i32 0, metadata !48, null}
!50 = metadata !{i32 28, i32 0, metadata !43, null}
!51 = metadata !{i32 29, i32 0, metadata !43, null}
!52 = metadata !{i32 30, i32 0, metadata !26, null}
