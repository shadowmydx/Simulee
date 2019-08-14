; ModuleID = 'reduce1'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.dim3 = type { i32, i32, i32 }

@threadIdx = external global %struct.dim3

define void @_Z11warp_reducePiPj(i32* %s_ptr, i32* %s_idx) nounwind uwtable section "__device__" {
  %1 = alloca i32*, align 8
  %2 = alloca i32*, align 8
  %tidx = alloca i32, align 4
  %n = alloca i32, align 4
  %val1 = alloca i32, align 4
  %val2 = alloca i32, align 4
  %idx1 = alloca i32, align 4
  %idx2 = alloca i32, align 4
  store i32* %s_ptr, i32** %1, align 8
  call void @llvm.dbg.declare(metadata !{i32** %1}, metadata !14), !dbg !15
  store i32* %s_idx, i32** %2, align 8
  call void @llvm.dbg.declare(metadata !{i32** %2}, metadata !16), !dbg !15
  call void @llvm.dbg.declare(metadata !{i32* %tidx}, metadata !17), !dbg !19
  %3 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !19
  store i32 %3, i32* %tidx, align 4, !dbg !19
  call void @llvm.dbg.declare(metadata !{i32* %n}, metadata !20), !dbg !22
  store i32 16, i32* %n, align 4, !dbg !22
  br label %4, !dbg !22

; <label>:4                                       ; preds = %47, %0
  %5 = load i32* %n, align 4, !dbg !22
  %6 = icmp sge i32 %5, 1, !dbg !22
  br i1 %6, label %7, label %50, !dbg !22

; <label>:7                                       ; preds = %4
  %8 = load i32* %tidx, align 4, !dbg !23
  %9 = load i32* %n, align 4, !dbg !23
  %10 = icmp slt i32 %8, %9, !dbg !23
  br i1 %10, label %11, label %46, !dbg !23

; <label>:11                                      ; preds = %7
  call void @llvm.dbg.declare(metadata !{i32* %val1}, metadata !25), !dbg !27
  call void @llvm.dbg.declare(metadata !{i32* %val2}, metadata !28), !dbg !27
  %12 = load i32* %tidx, align 4, !dbg !29
  %13 = sext i32 %12 to i64, !dbg !29
  %14 = load i32** %1, align 8, !dbg !29
  %15 = getelementptr inbounds i32* %14, i64 %13, !dbg !29
  %16 = load i32* %15, align 4, !dbg !29
  store i32 %16, i32* %val1, align 4, !dbg !29
  %17 = load i32* %tidx, align 4, !dbg !30
  %18 = load i32* %n, align 4, !dbg !30
  %19 = add nsw i32 %17, %18, !dbg !30
  %20 = sext i32 %19 to i64, !dbg !30
  %21 = load i32** %1, align 8, !dbg !30
  %22 = getelementptr inbounds i32* %21, i64 %20, !dbg !30
  %23 = load i32* %22, align 4, !dbg !30
  store i32 %23, i32* %val2, align 4, !dbg !30
  call void @llvm.dbg.declare(metadata !{i32* %idx1}, metadata !31), !dbg !32
  call void @llvm.dbg.declare(metadata !{i32* %idx2}, metadata !33), !dbg !32
  %24 = load i32* %tidx, align 4, !dbg !34
  %25 = sext i32 %24 to i64, !dbg !34
  %26 = load i32** %2, align 8, !dbg !34
  %27 = getelementptr inbounds i32* %26, i64 %25, !dbg !34
  %28 = load i32* %27, align 4, !dbg !34
  store i32 %28, i32* %idx1, align 4, !dbg !34
  %29 = load i32* %tidx, align 4, !dbg !35
  %30 = load i32* %n, align 4, !dbg !35
  %31 = add nsw i32 %29, %30, !dbg !35
  %32 = sext i32 %31 to i64, !dbg !35
  %33 = load i32** %2, align 8, !dbg !35
  %34 = getelementptr inbounds i32* %33, i64 %32, !dbg !35
  %35 = load i32* %34, align 4, !dbg !35
  store i32 %35, i32* %idx2, align 4, !dbg !35
  %36 = load i32* %idx2, align 4, !dbg !36
  %37 = load i32* %tidx, align 4, !dbg !36
  %38 = sext i32 %37 to i64, !dbg !36
  %39 = load i32** %1, align 8, !dbg !36
  %40 = getelementptr inbounds i32* %39, i64 %38, !dbg !36
  store i32 %36, i32* %40, align 4, !dbg !36
  %41 = load i32* %val2, align 4, !dbg !37
  %42 = load i32* %tidx, align 4, !dbg !37
  %43 = sext i32 %42 to i64, !dbg !37
  %44 = load i32** %2, align 8, !dbg !37
  %45 = getelementptr inbounds i32* %44, i64 %43, !dbg !37
  store i32 %41, i32* %45, align 4, !dbg !37
  br label %46, !dbg !38

; <label>:46                                      ; preds = %11, %7
  br label %47, !dbg !39

; <label>:47                                      ; preds = %46
  %48 = load i32* %n, align 4, !dbg !22
  %49 = ashr i32 %48, 1, !dbg !22
  store i32 %49, i32* %n, align 4, !dbg !22
  br label %4, !dbg !22

; <label>:50                                      ; preds = %4
  ret void, !dbg !40
}

declare void @llvm.dbg.declare(metadata, metadata) nounwind readnone

!llvm.dbg.cu = !{!0}

!0 = metadata !{i32 786449, i32 0, i32 4, metadata !"reduce1.cpp", metadata !"/home/mingyuanwu/arrayfire-repair", metadata !"clang version 3.2 (tags/RELEASE_32/final)", i1 true, i1 false, metadata !"", i32 0, metadata !1, metadata !1, metadata !3, metadata !1} ; [ DW_TAG_compile_unit ] [/home/mingyuanwu/arrayfire-repair/reduce1.cpp] [DW_LANG_C_plus_plus]
!1 = metadata !{metadata !2}
!2 = metadata !{i32 0}
!3 = metadata !{metadata !4}
!4 = metadata !{metadata !5}
!5 = metadata !{i32 786478, i32 0, metadata !6, metadata !"warp_reduce", metadata !"warp_reduce", metadata !"_Z11warp_reducePiPj", metadata !6, i32 1, metadata !7, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, void (i32*, i32*)* @_Z11warp_reducePiPj, null, null, metadata !1, i32 2} ; [ DW_TAG_subprogram ] [line 1] [def] [scope 2] [warp_reduce]
!6 = metadata !{i32 786473, metadata !"reduce1.cpp", metadata !"/home/mingyuanwu/arrayfire-repair", null} ; [ DW_TAG_file_type ]
!7 = metadata !{i32 786453, i32 0, metadata !"", i32 0, i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !8, i32 0, i32 0} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!8 = metadata !{null, metadata !9, metadata !11}
!9 = metadata !{i32 786447, null, metadata !"", null, i32 0, i64 64, i64 64, i64 0, i32 0, metadata !10} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from int]
!10 = metadata !{i32 786468, null, metadata !"int", null, i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!11 = metadata !{i32 786447, null, metadata !"", null, i32 0, i64 64, i64 64, i64 0, i32 0, metadata !12} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from uint]
!12 = metadata !{i32 786454, null, metadata !"uint", metadata !6, i32 152, i64 0, i64 0, i64 0, i32 0, metadata !13} ; [ DW_TAG_typedef ] [uint] [line 152, size 0, align 0, offset 0] [from unsigned int]
!13 = metadata !{i32 786468, null, metadata !"unsigned int", null, i32 0, i64 32, i64 32, i64 0, i32 0, i32 7} ; [ DW_TAG_base_type ] [unsigned int] [line 0, size 32, align 32, offset 0, enc DW_ATE_unsigned]
!14 = metadata !{i32 786689, metadata !5, metadata !"s_ptr", metadata !6, i32 16777217, metadata !9, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [s_ptr] [line 1]
!15 = metadata !{i32 1, i32 0, metadata !5, null}
!16 = metadata !{i32 786689, metadata !5, metadata !"s_idx", metadata !6, i32 33554433, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [s_idx] [line 1]
!17 = metadata !{i32 786688, metadata !18, metadata !"tidx", metadata !6, i32 3, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [tidx] [line 3]
!18 = metadata !{i32 786443, metadata !5, i32 2, i32 0, metadata !6, i32 0} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire-repair/reduce1.cpp]
!19 = metadata !{i32 3, i32 0, metadata !18, null}
!20 = metadata !{i32 786688, metadata !21, metadata !"n", metadata !6, i32 5, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [n] [line 5]
!21 = metadata !{i32 786443, metadata !18, i32 5, i32 0, metadata !6, i32 1} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire-repair/reduce1.cpp]
!22 = metadata !{i32 5, i32 0, metadata !21, null}
!23 = metadata !{i32 6, i32 0, metadata !24, null}
!24 = metadata !{i32 786443, metadata !21, i32 5, i32 0, metadata !6, i32 2} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire-repair/reduce1.cpp]
!25 = metadata !{i32 786688, metadata !26, metadata !"val1", metadata !6, i32 7, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [val1] [line 7]
!26 = metadata !{i32 786443, metadata !24, i32 6, i32 0, metadata !6, i32 3} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire-repair/reduce1.cpp]
!27 = metadata !{i32 7, i32 0, metadata !26, null}
!28 = metadata !{i32 786688, metadata !26, metadata !"val2", metadata !6, i32 7, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [val2] [line 7]
!29 = metadata !{i32 8, i32 0, metadata !26, null}
!30 = metadata !{i32 9, i32 0, metadata !26, null}
!31 = metadata !{i32 786688, metadata !26, metadata !"idx1", metadata !6, i32 11, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [idx1] [line 11]
!32 = metadata !{i32 11, i32 0, metadata !26, null}
!33 = metadata !{i32 786688, metadata !26, metadata !"idx2", metadata !6, i32 11, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [idx2] [line 11]
!34 = metadata !{i32 12, i32 0, metadata !26, null}
!35 = metadata !{i32 13, i32 0, metadata !26, null}
!36 = metadata !{i32 15, i32 0, metadata !26, null}
!37 = metadata !{i32 16, i32 0, metadata !26, null}
!38 = metadata !{i32 17, i32 0, metadata !26, null}
!39 = metadata !{i32 18, i32 0, metadata !24, null}
!40 = metadata !{i32 19, i32 0, metadata !18, null}
