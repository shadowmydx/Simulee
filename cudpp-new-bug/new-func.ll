; ModuleID = 'new-func'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.dim3 = type { i32, i32, i32 }

@blockIdx = external global %struct.dim3
@blockDim = external global %struct.dim3
@threadIdx = external global %struct.dim3
@gridDim = external global %struct.dim3

define void @_Z26sparseMatrixVectorSetFlagsPjPKjj(i32* %d_flags, i32* %d_rowindx, i32 %numRows) uwtable noinline {
  %1 = alloca i32*, align 8
  %2 = alloca i32*, align 8
  %3 = alloca i32, align 4
  %iGlobal = alloca i32, align 4
  %isLastBlock = alloca i8, align 1
  %i = alloca i32, align 4
  store i32* %d_flags, i32** %1, align 8
  call void @llvm.dbg.declare(metadata !{i32** %1}, metadata !13), !dbg !14
  store i32* %d_rowindx, i32** %2, align 8
  call void @llvm.dbg.declare(metadata !{i32** %2}, metadata !15), !dbg !16
  store i32 %numRows, i32* %3, align 4
  call void @llvm.dbg.declare(metadata !{i32* %3}, metadata !17), !dbg !18
  call void @llvm.dbg.declare(metadata !{i32* %iGlobal}, metadata !19), !dbg !21
  %4 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 0), align 4, !dbg !21
  %5 = load i32* getelementptr inbounds (%struct.dim3* @blockDim, i32 0, i32 0), align 4, !dbg !21
  %6 = shl i32 %5, 3, !dbg !21
  %7 = mul i32 %4, %6, !dbg !21
  %8 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !21
  %9 = add i32 %7, %8, !dbg !21
  store i32 %9, i32* %iGlobal, align 4, !dbg !21
  call void @llvm.dbg.declare(metadata !{i8* %isLastBlock}, metadata !22), !dbg !24
  %10 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 0), align 4, !dbg !24
  %11 = load i32* getelementptr inbounds (%struct.dim3* @gridDim, i32 0, i32 0), align 4, !dbg !24
  %12 = sub i32 %11, 1, !dbg !24
  %13 = icmp eq i32 %10, %12, !dbg !24
  %14 = zext i1 %13 to i8, !dbg !24
  store i8 %14, i8* %isLastBlock, align 1, !dbg !24
  call void @llvm.dbg.declare(metadata !{i32* %i}, metadata !25), !dbg !27
  store i32 0, i32* %i, align 4, !dbg !27
  br label %15, !dbg !27

; <label>:15                                      ; preds = %48, %0
  %16 = load i32* %i, align 4, !dbg !27
  %17 = icmp ult i32 %16, 8, !dbg !27
  br i1 %17, label %18, label %51, !dbg !27

; <label>:18                                      ; preds = %15
  %19 = load i8* %isLastBlock, align 1, !dbg !28
  %20 = trunc i8 %19 to i1, !dbg !28
  br i1 %20, label %21, label %35, !dbg !28

; <label>:21                                      ; preds = %18
  %22 = load i32* %iGlobal, align 4, !dbg !30
  %23 = load i32* %3, align 4, !dbg !30
  %24 = icmp ult i32 %22, %23, !dbg !30
  br i1 %24, label %25, label %34, !dbg !30

; <label>:25                                      ; preds = %21
  %26 = load i32* %iGlobal, align 4, !dbg !32
  %27 = zext i32 %26 to i64, !dbg !32
  %28 = load i32** %2, align 8, !dbg !32
  %29 = getelementptr inbounds i32* %28, i64 %27, !dbg !32
  %30 = load i32* %29, align 4, !dbg !32
  %31 = zext i32 %30 to i64, !dbg !32
  %32 = load i32** %1, align 8, !dbg !32
  %33 = getelementptr inbounds i32* %32, i64 %31, !dbg !32
  store i32 1, i32* %33, align 4, !dbg !32
  br label %34, !dbg !34

; <label>:34                                      ; preds = %25, %21
  br label %44, !dbg !35

; <label>:35                                      ; preds = %18
  %36 = load i32* %iGlobal, align 4, !dbg !36
  %37 = zext i32 %36 to i64, !dbg !36
  %38 = load i32** %2, align 8, !dbg !36
  %39 = getelementptr inbounds i32* %38, i64 %37, !dbg !36
  %40 = load i32* %39, align 4, !dbg !36
  %41 = zext i32 %40 to i64, !dbg !36
  %42 = load i32** %1, align 8, !dbg !36
  %43 = getelementptr inbounds i32* %42, i64 %41, !dbg !36
  store i32 1, i32* %43, align 4, !dbg !36
  br label %44

; <label>:44                                      ; preds = %35, %34
  %45 = load i32* getelementptr inbounds (%struct.dim3* @blockDim, i32 0, i32 0), align 4, !dbg !38
  %46 = load i32* %iGlobal, align 4, !dbg !38
  %47 = add i32 %46, %45, !dbg !38
  store i32 %47, i32* %iGlobal, align 4, !dbg !38
  br label %48, !dbg !39

; <label>:48                                      ; preds = %44
  %49 = load i32* %i, align 4, !dbg !27
  %50 = add i32 %49, 1, !dbg !27
  store i32 %50, i32* %i, align 4, !dbg !27
  br label %15, !dbg !27

; <label>:51                                      ; preds = %15
  call void @__syncthreads(), !dbg !40
  ret void, !dbg !41
}

declare void @llvm.dbg.declare(metadata, metadata) nounwind readnone

declare void @__syncthreads() section "__device__"

!llvm.dbg.cu = !{!0}

!0 = metadata !{i32 786449, i32 0, i32 4, metadata !"new-func.cpp", metadata !"/home/mingyuanwu/cudpp-new-bug", metadata !"clang version 3.2 (tags/RELEASE_32/final)", i1 true, i1 false, metadata !"", i32 0, metadata !1, metadata !1, metadata !3, metadata !1} ; [ DW_TAG_compile_unit ] [/home/mingyuanwu/cudpp-new-bug/new-func.cpp] [DW_LANG_C_plus_plus]
!1 = metadata !{metadata !2}
!2 = metadata !{i32 0}
!3 = metadata !{metadata !4}
!4 = metadata !{metadata !5}
!5 = metadata !{i32 786478, i32 0, metadata !6, metadata !"sparseMatrixVectorSetFlags", metadata !"sparseMatrixVectorSetFlags", metadata !"_Z26sparseMatrixVectorSetFlagsPjPKjj", metadata !6, i32 2, metadata !7, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, void (i32*, i32*, i32)* @_Z26sparseMatrixVectorSetFlagsPjPKjj, null, null, metadata !1, i32 7} ; [ DW_TAG_subprogram ] [line 2] [def] [scope 7] [sparseMatrixVectorSetFlags]
!6 = metadata !{i32 786473, metadata !"new-func.cpp", metadata !"/home/mingyuanwu/cudpp-new-bug", null} ; [ DW_TAG_file_type ]
!7 = metadata !{i32 786453, i32 0, metadata !"", i32 0, i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !8, i32 0, i32 0} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!8 = metadata !{null, metadata !9, metadata !11, metadata !10}
!9 = metadata !{i32 786447, null, metadata !"", null, i32 0, i64 64, i64 64, i64 0, i32 0, metadata !10} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from unsigned int]
!10 = metadata !{i32 786468, null, metadata !"unsigned int", null, i32 0, i64 32, i64 32, i64 0, i32 0, i32 7} ; [ DW_TAG_base_type ] [unsigned int] [line 0, size 32, align 32, offset 0, enc DW_ATE_unsigned]
!11 = metadata !{i32 786447, null, metadata !"", null, i32 0, i64 64, i64 64, i64 0, i32 0, metadata !12} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from ]
!12 = metadata !{i32 786470, null, metadata !"", null, i32 0, i64 0, i64 0, i64 0, i32 0, metadata !10} ; [ DW_TAG_const_type ] [line 0, size 0, align 0, offset 0] [from unsigned int]
!13 = metadata !{i32 786689, metadata !5, metadata !"d_flags", metadata !6, i32 16777219, metadata !9, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [d_flags] [line 3]
!14 = metadata !{i32 3, i32 0, metadata !5, null}
!15 = metadata !{i32 786689, metadata !5, metadata !"d_rowindx", metadata !6, i32 33554436, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [d_rowindx] [line 4]
!16 = metadata !{i32 4, i32 0, metadata !5, null}
!17 = metadata !{i32 786689, metadata !5, metadata !"numRows", metadata !6, i32 50331653, metadata !10, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [numRows] [line 5]
!18 = metadata !{i32 5, i32 0, metadata !5, null}
!19 = metadata !{i32 786688, metadata !20, metadata !"iGlobal", metadata !6, i32 8, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [iGlobal] [line 8]
!20 = metadata !{i32 786443, metadata !5, i32 7, i32 0, metadata !6, i32 0} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/cudpp-new-bug/new-func.cpp]
!21 = metadata !{i32 8, i32 0, metadata !20, null}
!22 = metadata !{i32 786688, metadata !20, metadata !"isLastBlock", metadata !6, i32 10, metadata !23, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [isLastBlock] [line 10]
!23 = metadata !{i32 786468, null, metadata !"bool", null, i32 0, i64 8, i64 8, i64 0, i32 0, i32 2} ; [ DW_TAG_base_type ] [bool] [line 0, size 8, align 8, offset 0, enc DW_ATE_boolean]
!24 = metadata !{i32 10, i32 0, metadata !20, null}
!25 = metadata !{i32 786688, metadata !26, metadata !"i", metadata !6, i32 12, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [i] [line 12]
!26 = metadata !{i32 786443, metadata !20, i32 12, i32 0, metadata !6, i32 1} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/cudpp-new-bug/new-func.cpp]
!27 = metadata !{i32 12, i32 0, metadata !26, null}
!28 = metadata !{i32 14, i32 0, metadata !29, null}
!29 = metadata !{i32 786443, metadata !26, i32 13, i32 0, metadata !6, i32 2} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/cudpp-new-bug/new-func.cpp]
!30 = metadata !{i32 16, i32 0, metadata !31, null}
!31 = metadata !{i32 786443, metadata !29, i32 15, i32 0, metadata !6, i32 3} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/cudpp-new-bug/new-func.cpp]
!32 = metadata !{i32 18, i32 0, metadata !33, null}
!33 = metadata !{i32 786443, metadata !31, i32 17, i32 0, metadata !6, i32 4} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/cudpp-new-bug/new-func.cpp]
!34 = metadata !{i32 19, i32 0, metadata !33, null}
!35 = metadata !{i32 20, i32 0, metadata !31, null}
!36 = metadata !{i32 23, i32 0, metadata !37, null}
!37 = metadata !{i32 786443, metadata !29, i32 22, i32 0, metadata !6, i32 5} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/cudpp-new-bug/new-func.cpp]
!38 = metadata !{i32 26, i32 0, metadata !29, null}
!39 = metadata !{i32 27, i32 0, metadata !29, null}
!40 = metadata !{i32 29, i32 0, metadata !20, null}
!41 = metadata !{i32 30, i32 0, metadata !20, null}
