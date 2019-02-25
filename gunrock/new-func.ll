; ModuleID = 'new-func'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.dim3 = type { i32, i32, i32 }

@gridDim = external global %struct.dim3
@blockDim = external global %struct.dim3
@blockIdx = external global %struct.dim3
@threadIdx = external global %struct.dim3

define void @_Z10Copy_PredsiPKiS0_Pi(i32 %num_elements, i32* %keys, i32* %in_preds, i32* %out_preds) nounwind uwtable noinline {
  %1 = alloca i32, align 4
  %2 = alloca i32*, align 8
  %3 = alloca i32*, align 8
  %4 = alloca i32*, align 8
  %STRIDE = alloca i32, align 4
  %x = alloca i32, align 4
  %t = alloca i32, align 4
  store i32 %num_elements, i32* %1, align 4
  call void @llvm.dbg.declare(metadata !{i32* %1}, metadata !13), !dbg !14
  store i32* %keys, i32** %2, align 8
  call void @llvm.dbg.declare(metadata !{i32** %2}, metadata !15), !dbg !16
  store i32* %in_preds, i32** %3, align 8
  call void @llvm.dbg.declare(metadata !{i32** %3}, metadata !17), !dbg !18
  store i32* %out_preds, i32** %4, align 8
  call void @llvm.dbg.declare(metadata !{i32** %4}, metadata !19), !dbg !20
  call void @llvm.dbg.declare(metadata !{i32* %STRIDE}, metadata !21), !dbg !23
  %5 = load i32* getelementptr inbounds (%struct.dim3* @gridDim, i32 0, i32 0), align 4, !dbg !23
  %6 = load i32* getelementptr inbounds (%struct.dim3* @blockDim, i32 0, i32 0), align 4, !dbg !23
  %7 = mul i32 %5, %6, !dbg !23
  store i32 %7, i32* %STRIDE, align 4, !dbg !23
  call void @llvm.dbg.declare(metadata !{i32* %x}, metadata !24), !dbg !25
  %8 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 0), align 4, !dbg !25
  %9 = load i32* getelementptr inbounds (%struct.dim3* @blockDim, i32 0, i32 0), align 4, !dbg !25
  %10 = mul i32 %8, %9, !dbg !25
  %11 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !25
  %12 = add i32 %10, %11, !dbg !25
  store i32 %12, i32* %x, align 4, !dbg !25
  call void @llvm.dbg.declare(metadata !{i32* %t}, metadata !26), !dbg !27
  br label %13, !dbg !28

; <label>:13                                      ; preds = %17, %0
  %14 = load i32* %x, align 4, !dbg !28
  %15 = load i32* %1, align 4, !dbg !28
  %16 = icmp slt i32 %14, %15, !dbg !28
  br i1 %16, label %17, label %35, !dbg !28

; <label>:17                                      ; preds = %13
  %18 = load i32* %x, align 4, !dbg !29
  %19 = sext i32 %18 to i64, !dbg !29
  %20 = load i32** %2, align 8, !dbg !29
  %21 = getelementptr inbounds i32* %20, i64 %19, !dbg !29
  %22 = load i32* %21, align 4, !dbg !29
  store i32 %22, i32* %t, align 4, !dbg !29
  %23 = load i32* %t, align 4, !dbg !31
  %24 = sext i32 %23 to i64, !dbg !31
  %25 = load i32** %3, align 8, !dbg !31
  %26 = getelementptr inbounds i32* %25, i64 %24, !dbg !31
  %27 = load i32* %26, align 4, !dbg !31
  %28 = load i32* %t, align 4, !dbg !31
  %29 = sext i32 %28 to i64, !dbg !31
  %30 = load i32** %4, align 8, !dbg !31
  %31 = getelementptr inbounds i32* %30, i64 %29, !dbg !31
  store i32 %27, i32* %31, align 4, !dbg !31
  %32 = load i32* %STRIDE, align 4, !dbg !32
  %33 = load i32* %x, align 4, !dbg !32
  %34 = add nsw i32 %33, %32, !dbg !32
  store i32 %34, i32* %x, align 4, !dbg !32
  br label %13, !dbg !33

; <label>:35                                      ; preds = %13
  ret void, !dbg !34
}

declare void @llvm.dbg.declare(metadata, metadata) nounwind readnone

!llvm.dbg.cu = !{!0}

!0 = metadata !{i32 786449, i32 0, i32 4, metadata !"new-func.cpp", metadata !"/home/mingyuanwu/gunrock", metadata !"clang version 3.2 (tags/RELEASE_32/final)", i1 true, i1 false, metadata !"", i32 0, metadata !1, metadata !1, metadata !3, metadata !1} ; [ DW_TAG_compile_unit ] [/home/mingyuanwu/gunrock/new-func.cpp] [DW_LANG_C_plus_plus]
!1 = metadata !{metadata !2}
!2 = metadata !{i32 0}
!3 = metadata !{metadata !4}
!4 = metadata !{metadata !5}
!5 = metadata !{i32 786478, i32 0, metadata !6, metadata !"Copy_Preds", metadata !"Copy_Preds", metadata !"_Z10Copy_PredsiPKiS0_Pi", metadata !6, i32 2, metadata !7, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, void (i32, i32*, i32*, i32*)* @_Z10Copy_PredsiPKiS0_Pi, null, null, metadata !1, i32 7} ; [ DW_TAG_subprogram ] [line 2] [def] [scope 7] [Copy_Preds]
!6 = metadata !{i32 786473, metadata !"new-func.cpp", metadata !"/home/mingyuanwu/gunrock", null} ; [ DW_TAG_file_type ]
!7 = metadata !{i32 786453, i32 0, metadata !"", i32 0, i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !8, i32 0, i32 0} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!8 = metadata !{null, metadata !9, metadata !11, metadata !11, metadata !12}
!9 = metadata !{i32 786470, null, metadata !"", null, i32 0, i64 0, i64 0, i64 0, i32 0, metadata !10} ; [ DW_TAG_const_type ] [line 0, size 0, align 0, offset 0] [from int]
!10 = metadata !{i32 786468, null, metadata !"int", null, i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!11 = metadata !{i32 786447, null, metadata !"", null, i32 0, i64 64, i64 64, i64 0, i32 0, metadata !9} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from ]
!12 = metadata !{i32 786447, null, metadata !"", null, i32 0, i64 64, i64 64, i64 0, i32 0, metadata !10} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from int]
!13 = metadata !{i32 786689, metadata !5, metadata !"num_elements", metadata !6, i32 16777219, metadata !9, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [num_elements] [line 3]
!14 = metadata !{i32 3, i32 0, metadata !5, null}
!15 = metadata !{i32 786689, metadata !5, metadata !"keys", metadata !6, i32 33554436, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [keys] [line 4]
!16 = metadata !{i32 4, i32 0, metadata !5, null}
!17 = metadata !{i32 786689, metadata !5, metadata !"in_preds", metadata !6, i32 50331653, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [in_preds] [line 5]
!18 = metadata !{i32 5, i32 0, metadata !5, null}
!19 = metadata !{i32 786689, metadata !5, metadata !"out_preds", metadata !6, i32 67108870, metadata !12, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [out_preds] [line 6]
!20 = metadata !{i32 6, i32 0, metadata !5, null}
!21 = metadata !{i32 786688, metadata !22, metadata !"STRIDE", metadata !6, i32 8, metadata !9, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [STRIDE] [line 8]
!22 = metadata !{i32 786443, metadata !5, i32 7, i32 0, metadata !6, i32 0} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/gunrock/new-func.cpp]
!23 = metadata !{i32 8, i32 0, metadata !22, null}
!24 = metadata !{i32 786688, metadata !22, metadata !"x", metadata !6, i32 9, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [x] [line 9]
!25 = metadata !{i32 9, i32 0, metadata !22, null}
!26 = metadata !{i32 786688, metadata !22, metadata !"t", metadata !6, i32 10, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [t] [line 10]
!27 = metadata !{i32 10, i32 0, metadata !22, null}
!28 = metadata !{i32 12, i32 0, metadata !22, null}
!29 = metadata !{i32 14, i32 0, metadata !30, null}
!30 = metadata !{i32 786443, metadata !22, i32 13, i32 0, metadata !6, i32 1} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/gunrock/new-func.cpp]
!31 = metadata !{i32 15, i32 0, metadata !30, null}
!32 = metadata !{i32 16, i32 0, metadata !30, null}
!33 = metadata !{i32 17, i32 0, metadata !30, null}
!34 = metadata !{i32 18, i32 0, metadata !22, null}
