; ModuleID = 'barrier3'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.dim3 = type { i32, i32, i32 }

@threadIdx = external global %struct.dim3
@blockIdx = external global %struct.dim3
@blockDim = external global %struct.dim3

define void @_Z2dlPi(i32* %in) uwtable noinline {
  %1 = alloca i32*, align 8
  %tid = alloca i32, align 4
  store i32* %in, i32** %1, align 8
  call void @llvm.dbg.declare(metadata !{i32** %1}, metadata !11), !dbg !12
  call void @llvm.dbg.declare(metadata !{i32* %tid}, metadata !13), !dbg !15
  %2 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !15
  %3 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 0), align 4, !dbg !15
  %4 = load i32* getelementptr inbounds (%struct.dim3* @blockDim, i32 0, i32 0), align 4, !dbg !15
  %5 = mul i32 %3, %4, !dbg !15
  %6 = add i32 %2, %5, !dbg !15
  store i32 %6, i32* %tid, align 4, !dbg !15
  %7 = load i32* %tid, align 4, !dbg !16
  %8 = icmp sgt i32 %7, 31, !dbg !16
  br i1 %8, label %9, label %21, !dbg !16

; <label>:9                                       ; preds = %0
  %10 = load i32* %tid, align 4, !dbg !17
  %11 = srem i32 %10, 2, !dbg !17
  %12 = icmp eq i32 %11, 0, !dbg !17
  br i1 %12, label %13, label %20, !dbg !17

; <label>:13                                      ; preds = %9
  %14 = load i32* %tid, align 4, !dbg !19
  %15 = sext i32 %14 to i64, !dbg !19
  %16 = load i32** %1, align 8, !dbg !19
  %17 = getelementptr inbounds i32* %16, i64 %15, !dbg !19
  %18 = load i32* %17, align 4, !dbg !19
  %19 = add nsw i32 %18, 1, !dbg !19
  store i32 %19, i32* %17, align 4, !dbg !19
  br label %20, !dbg !19

; <label>:20                                      ; preds = %13, %9

  br label %33, !dbg !21

; <label>:21                                      ; preds = %0
  %22 = load i32* %tid, align 4, !dbg !22
  %23 = srem i32 %22, 2, !dbg !22
  %24 = icmp eq i32 %23, 1, !dbg !22
  br i1 %24, label %25, label %32, !dbg !22

; <label>:25                                      ; preds = %21
  %26 = load i32* %tid, align 4, !dbg !24
  %27 = sext i32 %26 to i64, !dbg !24
  %28 = load i32** %1, align 8, !dbg !24
  %29 = getelementptr inbounds i32* %28, i64 %27, !dbg !24
  %30 = load i32* %29, align 4, !dbg !24
  %31 = add nsw i32 %30, -1, !dbg !24
  store i32 %31, i32* %29, align 4, !dbg !24
  br label %32, !dbg !24

; <label>:32                                      ; preds = %25, %21

  br label %33

; <label>:33                                      ; preds = %32, %20
  ret void, !dbg !26
}

declare void @llvm.dbg.declare(metadata, metadata) nounwind readnone

declare void @__syncthreads() section "__device__"

!llvm.dbg.cu = !{!0}

!0 = metadata !{i32 786449, i32 0, i32 4, metadata !"barrier3.cpp", metadata !"/home/mingyuanwu/gkleeTest-repair", metadata !"clang version 3.2 (tags/RELEASE_32/final)", i1 true, i1 false, metadata !"", i32 0, metadata !1, metadata !1, metadata !3, metadata !1} ; [ DW_TAG_compile_unit ] [/home/mingyuanwu/gkleeTest-repair/barrier3.cpp] [DW_LANG_C_plus_plus]
!1 = metadata !{metadata !2}
!2 = metadata !{i32 0}
!3 = metadata !{metadata !4}
!4 = metadata !{metadata !5}
!5 = metadata !{i32 786478, i32 0, metadata !6, metadata !"dl", metadata !"dl", metadata !"_Z2dlPi", metadata !6, i32 5, metadata !7, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, void (i32*)* @_Z2dlPi, null, null, metadata !1, i32 6} ; [ DW_TAG_subprogram ] [line 5] [def] [scope 6] [dl]
!6 = metadata !{i32 786473, metadata !"barrier3.cpp", metadata !"/home/mingyuanwu/gkleeTest-repair", null} ; [ DW_TAG_file_type ]
!7 = metadata !{i32 786453, i32 0, metadata !"", i32 0, i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !8, i32 0, i32 0} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!8 = metadata !{null, metadata !9}
!9 = metadata !{i32 786447, null, metadata !"", null, i32 0, i64 64, i64 64, i64 0, i32 0, metadata !10} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from int]
!10 = metadata !{i32 786468, null, metadata !"int", null, i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!11 = metadata !{i32 786689, metadata !5, metadata !"in", metadata !6, i32 16777221, metadata !9, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [in] [line 5]
!12 = metadata !{i32 5, i32 0, metadata !5, null}
!13 = metadata !{i32 786688, metadata !14, metadata !"tid", metadata !6, i32 8, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [tid] [line 8]
!14 = metadata !{i32 786443, metadata !5, i32 6, i32 0, metadata !6, i32 0} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/gkleeTest-repair/barrier3.cpp]
!15 = metadata !{i32 8, i32 0, metadata !14, null}
!16 = metadata !{i32 11, i32 0, metadata !14, null}
!17 = metadata !{i32 13, i32 0, metadata !18, null}
!18 = metadata !{i32 786443, metadata !14, i32 12, i32 0, metadata !6, i32 1} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/gkleeTest-repair/barrier3.cpp]
!19 = metadata !{i32 14, i32 0, metadata !18, null}
!20 = metadata !{i32 16, i32 0, metadata !18, null}
!21 = metadata !{i32 18, i32 0, metadata !18, null}
!22 = metadata !{i32 20, i32 0, metadata !23, null}
!23 = metadata !{i32 786443, metadata !14, i32 19, i32 0, metadata !6, i32 2} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/gkleeTest-repair/barrier3.cpp]
!24 = metadata !{i32 21, i32 0, metadata !23, null}
!25 = metadata !{i32 23, i32 0, metadata !23, null}
!26 = metadata !{i32 25, i32 0, metadata !14, null}
