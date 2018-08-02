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
  call void @llvm.dbg.declare(metadata !{float** %1}, metadata !18), !dbg !19
  store i32 %rows, i32* %2, align 4
  call void @llvm.dbg.declare(metadata !{i32* %2}, metadata !20), !dbg !19
  store i32 %stride, i32* %3, align 4
  call void @llvm.dbg.declare(metadata !{i32* %3}, metadata !21), !dbg !19
  call void @llvm.dbg.declare(metadata !{i32* %i}, metadata !22), !dbg !24
  %4 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 0), align 4, !dbg !24
  %5 = load i32* getelementptr inbounds (%struct.dim3* @blockDim, i32 0, i32 0), align 4, !dbg !24
  %6 = mul i32 %4, %5, !dbg !24
  %7 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !24
  %8 = add i32 %6, %7, !dbg !24
  store i32 %8, i32* %i, align 4, !dbg !24
  call void @llvm.dbg.declare(metadata !{i32* %j}, metadata !25), !dbg !26
  %9 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 1), align 4, !dbg !26
  %10 = load i32* getelementptr inbounds (%struct.dim3* @blockDim, i32 0, i32 1), align 4, !dbg !26
  %11 = mul i32 %9, %10, !dbg !26
  %12 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 1), align 4, !dbg !26
  %13 = add i32 %11, %12, !dbg !26
  store i32 %13, i32* %j, align 4, !dbg !26
  %14 = load i32* %i, align 4, !dbg !27
  %15 = load i32* %j, align 4, !dbg !27
  %16 = icmp sle i32 %14, %15, !dbg !27
  br i1 %16, label %21, label %17, !dbg !27

; <label>:17                                      ; preds = %0
  %18 = load i32* %i, align 4, !dbg !27
  %19 = load i32* %2, align 4, !dbg !27
  %20 = icmp sge i32 %18, %19, !dbg !27
  br i1 %20, label %21, label %22, !dbg !27

; <label>:21                                      ; preds = %17, %0
  br label %42, !dbg !28

; <label>:22                                      ; preds = %17
  call void @llvm.dbg.declare(metadata !{i32* %index_1}, metadata !29), !dbg !30
  %23 = load i32* %i, align 4, !dbg !30
  %24 = load i32* %3, align 4, !dbg !30
  %25 = mul nsw i32 %23, %24, !dbg !30
  %26 = load i32* %j, align 4, !dbg !30
  %27 = add nsw i32 %25, %26, !dbg !30
  store i32 %27, i32* %index_1, align 4, !dbg !30
  call void @llvm.dbg.declare(metadata !{i32* %index_2}, metadata !31), !dbg !32
  %28 = load i32* %j, align 4, !dbg !32
  %29 = load i32* %3, align 4, !dbg !32
  %30 = mul nsw i32 %28, %29, !dbg !32
  %31 = load i32* %i, align 4, !dbg !32
  %32 = add nsw i32 %30, %31, !dbg !32
  store i32 %32, i32* %index_2, align 4, !dbg !32
  %33 = load i32* %index_1, align 4, !dbg !33
  %34 = sext i32 %33 to i64, !dbg !33
  %35 = load float** %1, align 8, !dbg !33
  %36 = getelementptr inbounds float* %35, i64 %34, !dbg !33
  %37 = load float* %36, align 4, !dbg !33
  %38 = load i32* %index_2, align 4, !dbg !33
  %39 = sext i32 %38 to i64, !dbg !33
  %40 = load float** %1, align 8, !dbg !33
  %41 = getelementptr inbounds float* %40, i64 %39, !dbg !33
  store float %37, float* %41, align 4, !dbg !33
  br label %42, !dbg !34

; <label>:42                                      ; preds = %22, %21
  ret void, !dbg !34
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
  call void @llvm.dbg.declare(metadata !{float** %1}, metadata !35), !dbg !36
  store i32 %rows, i32* %2, align 4
  call void @llvm.dbg.declare(metadata !{i32* %2}, metadata !37), !dbg !36
  store i32 %stride, i32* %3, align 4
  call void @llvm.dbg.declare(metadata !{i32* %3}, metadata !38), !dbg !36
  call void @llvm.dbg.declare(metadata !{i32* %i}, metadata !39), !dbg !41
  %4 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 0), align 4, !dbg !41
  %5 = load i32* getelementptr inbounds (%struct.dim3* @blockDim, i32 0, i32 0), align 4, !dbg !41
  %6 = mul i32 %4, %5, !dbg !41
  %7 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !41
  %8 = add i32 %6, %7, !dbg !41
  store i32 %8, i32* %i, align 4, !dbg !41
  call void @llvm.dbg.declare(metadata !{i32* %j}, metadata !42), !dbg !43
  %9 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 1), align 4, !dbg !43
  %10 = load i32* getelementptr inbounds (%struct.dim3* @blockDim, i32 0, i32 1), align 4, !dbg !43
  %11 = mul i32 %9, %10, !dbg !43
  %12 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 1), align 4, !dbg !43
  %13 = add i32 %11, %12, !dbg !43
  store i32 %13, i32* %j, align 4, !dbg !43
  %14 = load i32* %j, align 4, !dbg !44
  %15 = load i32* %i, align 4, !dbg !44
  %16 = icmp sle i32 %14, %15, !dbg !44
  br i1 %16, label %21, label %17, !dbg !44

; <label>:17                                      ; preds = %0
  %18 = load i32* %j, align 4, !dbg !44
  %19 = load i32* %2, align 4, !dbg !44
  %20 = icmp sge i32 %18, %19, !dbg !44
  br i1 %20, label %21, label %22, !dbg !44

; <label>:21                                      ; preds = %17, %0
  br label %42, !dbg !45

; <label>:22                                      ; preds = %17
  call void @llvm.dbg.declare(metadata !{i32* %index_1}, metadata !46), !dbg !47
  %23 = load i32* %i, align 4, !dbg !47
  %24 = load i32* %3, align 4, !dbg !47
  %25 = mul nsw i32 %23, %24, !dbg !47
  %26 = load i32* %j, align 4, !dbg !47
  %27 = add nsw i32 %25, %26, !dbg !47
  store i32 %27, i32* %index_1, align 4, !dbg !47
  call void @llvm.dbg.declare(metadata !{i32* %index_2}, metadata !48), !dbg !49
  %28 = load i32* %j, align 4, !dbg !49
  %29 = load i32* %3, align 4, !dbg !49
  %30 = mul nsw i32 %28, %29, !dbg !49
  %31 = load i32* %i, align 4, !dbg !49
  %32 = add nsw i32 %30, %31, !dbg !49
  store i32 %32, i32* %index_2, align 4, !dbg !49
  %33 = load i32* %index_1, align 4, !dbg !50
  %34 = sext i32 %33 to i64, !dbg !50
  %35 = load float** %1, align 8, !dbg !50
  %36 = getelementptr inbounds float* %35, i64 %34, !dbg !50
  %37 = load float* %36, align 4, !dbg !50
  %38 = load i32* %index_2, align 4, !dbg !50
  %39 = sext i32 %38 to i64, !dbg !50
  %40 = load float** %1, align 8, !dbg !50
  %41 = getelementptr inbounds float* %40, i64 %39, !dbg !50
  store float %37, float* %41, align 4, !dbg !50
  br label %42, !dbg !51

; <label>:42                                      ; preds = %22, %21
  ret void, !dbg !51
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
  call void @llvm.dbg.declare(metadata !{float* %1}, metadata !52), !dbg !53
  store float* %mat, float** %2, align 8
  call void @llvm.dbg.declare(metadata !{float** %2}, metadata !54), !dbg !53
  store i32 %stride, i32* %3, align 4
  call void @llvm.dbg.declare(metadata !{i32* %3}, metadata !55), !dbg !53
  store i32 %rows, i32* %4, align 4
  call void @llvm.dbg.declare(metadata !{i32* %4}, metadata !56), !dbg !53
  store i32 %cols, i32* %5, align 4
  call void @llvm.dbg.declare(metadata !{i32* %5}, metadata !57), !dbg !53
  store float* %vec, float** %6, align 8
  call void @llvm.dbg.declare(metadata !{float** %6}, metadata !58), !dbg !59
  store float* %mat2, float** %7, align 8
  call void @llvm.dbg.declare(metadata !{float** %7}, metadata !60), !dbg !59
  store i32 %mat2_row_stride, i32* %8, align 4
  call void @llvm.dbg.declare(metadata !{i32* %8}, metadata !61), !dbg !62
  store i32 %mat2_col_stride, i32* %9, align 4
  call void @llvm.dbg.declare(metadata !{i32* %9}, metadata !63), !dbg !62
  store float %beta, float* %10, align 4
  call void @llvm.dbg.declare(metadata !{float* %10}, metadata !64), !dbg !65
  call void @llvm.dbg.declare(metadata !{i32* %i}, metadata !66), !dbg !68
  %11 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 0), align 4, !dbg !68
  %12 = load i32* getelementptr inbounds (%struct.dim3* @blockDim, i32 0, i32 0), align 4, !dbg !68
  %13 = mul i32 %11, %12, !dbg !68
  %14 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !68
  %15 = add i32 %13, %14, !dbg !68
  store i32 %15, i32* %i, align 4, !dbg !68
  call void @llvm.dbg.declare(metadata !{i32* %j}, metadata !69), !dbg !70
  %16 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 1), align 4, !dbg !70
  %17 = load i32* getelementptr inbounds (%struct.dim3* @blockDim, i32 0, i32 1), align 4, !dbg !70
  %18 = mul i32 %16, %17, !dbg !70
  %19 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 1), align 4, !dbg !70
  %20 = add i32 %18, %19, !dbg !70
  store i32 %20, i32* %j, align 4, !dbg !70
  call void @llvm.dbg.declare(metadata !{i32* %index}, metadata !71), !dbg !72
  %21 = load i32* %j, align 4, !dbg !73
  %22 = load i32* %3, align 4, !dbg !73
  %23 = mul nsw i32 %21, %22, !dbg !73
  %24 = load i32* %i, align 4, !dbg !73
  %25 = add nsw i32 %23, %24, !dbg !73
  store i32 %25, i32* %index, align 4, !dbg !73
  call void @llvm.dbg.declare(metadata !{i32* %index2}, metadata !74), !dbg !72
  %26 = load i32* %j, align 4, !dbg !73
  %27 = load i32* %8, align 4, !dbg !73
  %28 = mul nsw i32 %26, %27, !dbg !73
  %29 = load i32* %i, align 4, !dbg !73
  %30 = load i32* %9, align 4, !dbg !73
  %31 = mul nsw i32 %29, %30, !dbg !73
  %32 = add nsw i32 %28, %31, !dbg !73
  store i32 %32, i32* %index2, align 4, !dbg !73
  %33 = load i32* %i, align 4, !dbg !75
  %34 = load i32* %5, align 4, !dbg !75
  %35 = icmp slt i32 %33, %34, !dbg !75
  br i1 %35, label %36, label %66, !dbg !75

; <label>:36                                      ; preds = %0
  %37 = load i32* %j, align 4, !dbg !75
  %38 = load i32* %4, align 4, !dbg !75
  %39 = icmp slt i32 %37, %38, !dbg !75
  br i1 %39, label %40, label %66, !dbg !75

; <label>:40                                      ; preds = %36
  %41 = load float* %1, align 4, !dbg !76
  %42 = load i32* %j, align 4, !dbg !76
  %43 = sext i32 %42 to i64, !dbg !76
  %44 = load float** %6, align 8, !dbg !76
  %45 = getelementptr inbounds float* %44, i64 %43, !dbg !76
  %46 = load float* %45, align 4, !dbg !76
  %47 = fmul float %41, %46, !dbg !76
  %48 = load i32* %index2, align 4, !dbg !76
  %49 = sext i32 %48 to i64, !dbg !76
  %50 = load float** %7, align 8, !dbg !76
  %51 = getelementptr inbounds float* %50, i64 %49, !dbg !76
  %52 = load float* %51, align 4, !dbg !76
  %53 = fmul float %47, %52, !dbg !76
  %54 = load float* %10, align 4, !dbg !76
  %55 = load i32* %index, align 4, !dbg !76
  %56 = sext i32 %55 to i64, !dbg !76
  %57 = load float** %2, align 8, !dbg !76
  %58 = getelementptr inbounds float* %57, i64 %56, !dbg !76
  %59 = load float* %58, align 4, !dbg !76
  %60 = fmul float %54, %59, !dbg !76
  %61 = fadd float %53, %60, !dbg !76
  %62 = load i32* %index, align 4, !dbg !76
  %63 = sext i32 %62 to i64, !dbg !76
  %64 = load float** %2, align 8, !dbg !76
  %65 = getelementptr inbounds float* %64, i64 %63, !dbg !76
  store float %61, float* %65, align 4, !dbg !76
  br label %66, !dbg !78

; <label>:66                                      ; preds = %40, %36, %0
  ret void, !dbg !79
}

!llvm.dbg.cu = !{!0}

!0 = metadata !{i32 786449, i32 0, i32 4, metadata !"new-func.cpp", metadata !"/home/mingyuanwu/kaldi-new-bug", metadata !"clang version 3.2 (tags/RELEASE_32/final)", i1 true, i1 false, metadata !"", i32 0, metadata !1, metadata !1, metadata !3, metadata !1} ; [ DW_TAG_compile_unit ] [/home/mingyuanwu/kaldi-new-bug/new-func.cpp] [DW_LANG_C_plus_plus]
!1 = metadata !{metadata !2}
!2 = metadata !{i32 0}
!3 = metadata !{metadata !4}
!4 = metadata !{metadata !5, metadata !12, metadata !13}
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
!18 = metadata !{i32 786689, metadata !5, metadata !"A", metadata !6, i32 16777218, metadata !9, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [A] [line 2]
!19 = metadata !{i32 2, i32 0, metadata !5, null}
!20 = metadata !{i32 786689, metadata !5, metadata !"rows", metadata !6, i32 33554434, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [rows] [line 2]
!21 = metadata !{i32 786689, metadata !5, metadata !"stride", metadata !6, i32 50331650, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [stride] [line 2]
!22 = metadata !{i32 786688, metadata !23, metadata !"i", metadata !6, i32 3, metadata !11, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [i] [line 3]
!23 = metadata !{i32 786443, metadata !5, i32 2, i32 0, metadata !6, i32 0} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/kaldi-new-bug/new-func.cpp]
!24 = metadata !{i32 3, i32 0, metadata !23, null}
!25 = metadata !{i32 786688, metadata !23, metadata !"j", metadata !6, i32 4, metadata !11, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [j] [line 4]
!26 = metadata !{i32 4, i32 0, metadata !23, null}
!27 = metadata !{i32 5, i32 0, metadata !23, null}
!28 = metadata !{i32 6, i32 0, metadata !23, null}
!29 = metadata !{i32 786688, metadata !23, metadata !"index_1", metadata !6, i32 7, metadata !11, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [index_1] [line 7]
!30 = metadata !{i32 7, i32 0, metadata !23, null}
!31 = metadata !{i32 786688, metadata !23, metadata !"index_2", metadata !6, i32 8, metadata !11, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [index_2] [line 8]
!32 = metadata !{i32 8, i32 0, metadata !23, null}
!33 = metadata !{i32 9, i32 0, metadata !23, null}
!34 = metadata !{i32 10, i32 0, metadata !23, null}
!35 = metadata !{i32 786689, metadata !12, metadata !"A", metadata !6, i32 16777235, metadata !9, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [A] [line 19]
!36 = metadata !{i32 19, i32 0, metadata !12, null}
!37 = metadata !{i32 786689, metadata !12, metadata !"rows", metadata !6, i32 33554451, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [rows] [line 19]
!38 = metadata !{i32 786689, metadata !12, metadata !"stride", metadata !6, i32 50331667, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [stride] [line 19]
!39 = metadata !{i32 786688, metadata !40, metadata !"i", metadata !6, i32 20, metadata !11, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [i] [line 20]
!40 = metadata !{i32 786443, metadata !12, i32 19, i32 0, metadata !6, i32 1} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/kaldi-new-bug/new-func.cpp]
!41 = metadata !{i32 20, i32 0, metadata !40, null}
!42 = metadata !{i32 786688, metadata !40, metadata !"j", metadata !6, i32 21, metadata !11, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [j] [line 21]
!43 = metadata !{i32 21, i32 0, metadata !40, null}
!44 = metadata !{i32 22, i32 0, metadata !40, null}
!45 = metadata !{i32 23, i32 0, metadata !40, null}
!46 = metadata !{i32 786688, metadata !40, metadata !"index_1", metadata !6, i32 24, metadata !11, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [index_1] [line 24]
!47 = metadata !{i32 24, i32 0, metadata !40, null}
!48 = metadata !{i32 786688, metadata !40, metadata !"index_2", metadata !6, i32 25, metadata !11, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [index_2] [line 25]
!49 = metadata !{i32 25, i32 0, metadata !40, null}
!50 = metadata !{i32 26, i32 0, metadata !40, null}
!51 = metadata !{i32 27, i32 0, metadata !40, null}
!52 = metadata !{i32 786689, metadata !13, metadata !"alpha", metadata !6, i32 16777247, metadata !10, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [alpha] [line 31]
!53 = metadata !{i32 31, i32 0, metadata !13, null}
!54 = metadata !{i32 786689, metadata !13, metadata !"mat", metadata !6, i32 33554463, metadata !9, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [mat] [line 31]
!55 = metadata !{i32 786689, metadata !13, metadata !"stride", metadata !6, i32 50331679, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [stride] [line 31]
!56 = metadata !{i32 786689, metadata !13, metadata !"rows", metadata !6, i32 67108895, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [rows] [line 31]
!57 = metadata !{i32 786689, metadata !13, metadata !"cols", metadata !6, i32 83886111, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [cols] [line 31]
!58 = metadata !{i32 786689, metadata !13, metadata !"vec", metadata !6, i32 100663328, metadata !16, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [vec] [line 32]
!59 = metadata !{i32 32, i32 0, metadata !13, null}
!60 = metadata !{i32 786689, metadata !13, metadata !"mat2", metadata !6, i32 117440544, metadata !16, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [mat2] [line 32]
!61 = metadata !{i32 786689, metadata !13, metadata !"mat2_row_stride", metadata !6, i32 134217761, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [mat2_row_stride] [line 33]
!62 = metadata !{i32 33, i32 0, metadata !13, null}
!63 = metadata !{i32 786689, metadata !13, metadata !"mat2_col_stride", metadata !6, i32 150994977, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [mat2_col_stride] [line 33]
!64 = metadata !{i32 786689, metadata !13, metadata !"beta", metadata !6, i32 167772194, metadata !10, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [beta] [line 34]
!65 = metadata !{i32 34, i32 0, metadata !13, null}
!66 = metadata !{i32 786688, metadata !67, metadata !"i", metadata !6, i32 35, metadata !11, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [i] [line 35]
!67 = metadata !{i32 786443, metadata !13, i32 34, i32 0, metadata !6, i32 2} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/kaldi-new-bug/new-func.cpp]
!68 = metadata !{i32 35, i32 0, metadata !67, null}
!69 = metadata !{i32 786688, metadata !67, metadata !"j", metadata !6, i32 36, metadata !11, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [j] [line 36]
!70 = metadata !{i32 36, i32 0, metadata !67, null}
!71 = metadata !{i32 786688, metadata !67, metadata !"index", metadata !6, i32 38, metadata !11, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [index] [line 38]
!72 = metadata !{i32 38, i32 0, metadata !67, null}
!73 = metadata !{i32 39, i32 0, metadata !67, null}
!74 = metadata !{i32 786688, metadata !67, metadata !"index2", metadata !6, i32 38, metadata !11, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [index2] [line 38]
!75 = metadata !{i32 41, i32 0, metadata !67, null}
!76 = metadata !{i32 42, i32 0, metadata !77, null}
!77 = metadata !{i32 786443, metadata !67, i32 41, i32 0, metadata !6, i32 3} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/kaldi-new-bug/new-func.cpp]
!78 = metadata !{i32 43, i32 0, metadata !77, null}
!79 = metadata !{i32 44, i32 0, metadata !67, null}
