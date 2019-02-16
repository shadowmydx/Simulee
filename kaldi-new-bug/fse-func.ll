; ModuleID = 'fse-func'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.dim3 = type { i32, i32, i32 }

@blockDim = external global %struct.dim3
@threadIdx = external global %struct.dim3

define double @_Z11_sum_reducePd(double* %buffer) uwtable section "__device__" {
  %1 = alloca double*, align 8
  %nTotalThreads = alloca i32, align 4
  %halfPoint = alloca i32, align 4
  %temp = alloca double, align 8
  store double* %buffer, double** %1, align 8
  call void @llvm.dbg.declare(metadata !{double** %1}, metadata !11), !dbg !12
  call void @llvm.dbg.declare(metadata !{i32* %nTotalThreads}, metadata !13), !dbg !16
  %2 = load i32* getelementptr inbounds (%struct.dim3* @blockDim, i32 0, i32 0), align 4, !dbg !16
  store i32 %2, i32* %nTotalThreads, align 4, !dbg !16
  call void @__syncthreads(), !dbg !17
  br label %3, !dbg !18

; <label>:3                                       ; preds = %33, %0
  %4 = load i32* %nTotalThreads, align 4, !dbg !18
  %5 = icmp sgt i32 %4, 1, !dbg !18
  br i1 %5, label %6, label %37, !dbg !18

; <label>:6                                       ; preds = %3
  call void @llvm.dbg.declare(metadata !{i32* %halfPoint}, metadata !19), !dbg !21
  %7 = load i32* %nTotalThreads, align 4, !dbg !21
  %8 = add nsw i32 1, %7, !dbg !21
  %9 = ashr i32 %8, 1, !dbg !21
  store i32 %9, i32* %halfPoint, align 4, !dbg !21
  %10 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !22
  %11 = load i32* %halfPoint, align 4, !dbg !22
  %12 = icmp uge i32 %10, %11, !dbg !22
  br i1 %12, label %13, label %33, !dbg !22

; <label>:13                                      ; preds = %6
  call void @llvm.dbg.declare(metadata !{double* %temp}, metadata !23), !dbg !25
  store double 0.000000e+00, double* %temp, align 8, !dbg !25
  %14 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !26
  %15 = load i32* %nTotalThreads, align 4, !dbg !26
  %16 = icmp ult i32 %14, %15, !dbg !26
  br i1 %16, label %17, label %23, !dbg !26

; <label>:17                                      ; preds = %13
  %18 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !27
  %19 = zext i32 %18 to i64, !dbg !27
  %20 = load double** %1, align 8, !dbg !27
  %21 = getelementptr inbounds double* %20, i64 %19, !dbg !27
  %22 = load double* %21, align 8, !dbg !27
  store double %22, double* %temp, align 8, !dbg !27
  br label %23, !dbg !29

; <label>:23                                      ; preds = %17, %13
  %24 = load double* %temp, align 8, !dbg !30
  %25 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !30
  %26 = load i32* %halfPoint, align 4, !dbg !30
  %27 = sub i32 %25, %26, !dbg !30
  %28 = zext i32 %27 to i64, !dbg !30
  %29 = load double** %1, align 8, !dbg !30
  %30 = getelementptr inbounds double* %29, i64 %28, !dbg !30
  %31 = load double* %30, align 8, !dbg !30
  %32 = fadd double %31, %24, !dbg !30
  store double %32, double* %30, align 8, !dbg !30
  br label %33, !dbg !31

; <label>:33                                      ; preds = %23, %6
  call void @__syncthreads(), !dbg !32
  %34 = load i32* %nTotalThreads, align 4, !dbg !33
  %35 = add nsw i32 1, %34, !dbg !33
  %36 = ashr i32 %35, 1, !dbg !33
  store i32 %36, i32* %nTotalThreads, align 4, !dbg !33
  br label %3, !dbg !34

; <label>:37                                      ; preds = %3
  %38 = load double** %1, align 8, !dbg !35
  %39 = getelementptr inbounds double* %38, i64 0, !dbg !35
  %40 = load double* %39, align 8, !dbg !35
  ret double %40, !dbg !35
}

declare void @llvm.dbg.declare(metadata, metadata) nounwind readnone

declare void @__syncthreads() section "__device__"

!llvm.dbg.cu = !{!0}

!0 = metadata !{i32 786449, i32 0, i32 4, metadata !"fse-func.cpp", metadata !"/home/mingyuanwu/kaldi-new-bug", metadata !"clang version 3.2 (tags/RELEASE_32/final)", i1 true, i1 false, metadata !"", i32 0, metadata !1, metadata !1, metadata !3, metadata !1} ; [ DW_TAG_compile_unit ] [/home/mingyuanwu/kaldi-new-bug/fse-func.cpp] [DW_LANG_C_plus_plus]
!1 = metadata !{metadata !2}
!2 = metadata !{i32 0}
!3 = metadata !{metadata !4}
!4 = metadata !{metadata !5}
!5 = metadata !{i32 786478, i32 0, metadata !6, metadata !"_sum_reduce", metadata !"_sum_reduce", metadata !"_Z11_sum_reducePd", metadata !6, i32 2, metadata !7, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, double (double*)* @_Z11_sum_reducePd, null, null, metadata !1, i32 2} ; [ DW_TAG_subprogram ] [line 2] [def] [_sum_reduce]
!6 = metadata !{i32 786473, metadata !"fse-func.cpp", metadata !"/home/mingyuanwu/kaldi-new-bug", null} ; [ DW_TAG_file_type ]
!7 = metadata !{i32 786453, i32 0, metadata !"", i32 0, i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !8, i32 0, i32 0} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!8 = metadata !{metadata !9, metadata !10}
!9 = metadata !{i32 786468, null, metadata !"double", null, i32 0, i64 64, i64 64, i64 0, i32 0, i32 4} ; [ DW_TAG_base_type ] [double] [line 0, size 64, align 64, offset 0, enc DW_ATE_float]
!10 = metadata !{i32 786447, null, metadata !"", null, i32 0, i64 64, i64 64, i64 0, i32 0, metadata !9} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from double]
!11 = metadata !{i32 786689, metadata !5, metadata !"buffer", metadata !6, i32 16777218, metadata !10, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [buffer] [line 2]
!12 = metadata !{i32 2, i32 0, metadata !5, null}
!13 = metadata !{i32 786688, metadata !14, metadata !"nTotalThreads", metadata !6, i32 4, metadata !15, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [nTotalThreads] [line 4]
!14 = metadata !{i32 786443, metadata !5, i32 2, i32 0, metadata !6, i32 0} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/kaldi-new-bug/fse-func.cpp]
!15 = metadata !{i32 786468, null, metadata !"int", null, i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!16 = metadata !{i32 4, i32 0, metadata !14, null}
!17 = metadata !{i32 5, i32 0, metadata !14, null}
!18 = metadata !{i32 7, i32 0, metadata !14, null}
!19 = metadata !{i32 786688, metadata !20, metadata !"halfPoint", metadata !6, i32 8, metadata !15, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [halfPoint] [line 8]
!20 = metadata !{i32 786443, metadata !14, i32 7, i32 0, metadata !6, i32 1} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/kaldi-new-bug/fse-func.cpp]
!21 = metadata !{i32 8, i32 0, metadata !20, null}
!22 = metadata !{i32 10, i32 0, metadata !20, null}
!23 = metadata !{i32 786688, metadata !24, metadata !"temp", metadata !6, i32 12, metadata !9, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [temp] [line 12]
!24 = metadata !{i32 786443, metadata !20, i32 10, i32 0, metadata !6, i32 2} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/kaldi-new-bug/fse-func.cpp]
!25 = metadata !{i32 12, i32 0, metadata !24, null}
!26 = metadata !{i32 13, i32 0, metadata !24, null}
!27 = metadata !{i32 14, i32 0, metadata !28, null}
!28 = metadata !{i32 786443, metadata !24, i32 13, i32 0, metadata !6, i32 3} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/kaldi-new-bug/fse-func.cpp]
!29 = metadata !{i32 15, i32 0, metadata !28, null}
!30 = metadata !{i32 16, i32 0, metadata !24, null}
!31 = metadata !{i32 17, i32 0, metadata !24, null}
!32 = metadata !{i32 18, i32 0, metadata !20, null}
!33 = metadata !{i32 19, i32 0, metadata !20, null}
!34 = metadata !{i32 20, i32 0, metadata !20, null}
!35 = metadata !{i32 22, i32 0, metadata !14, null}
