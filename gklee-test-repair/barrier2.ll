; ModuleID = 'barrier2'
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
  %7 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 0), align 4, !dbg !16
  %8 = urem i32 %7, 2, !dbg !16
  %9 = icmp eq i32 %8, 0, !dbg !16
  br i1 %9, label %10, label %22, !dbg !16

; <label>:10                                      ; preds = %0
  %11 = load i32* %tid, align 4, !dbg !17
  %12 = srem i32 %11, 2, !dbg !17
  %13 = icmp eq i32 %12, 0, !dbg !17
  br i1 %13, label %14, label %21, !dbg !17

; <label>:14                                      ; preds = %10
  %15 = load i32* %tid, align 4, !dbg !19
  %16 = sext i32 %15 to i64, !dbg !19
  %17 = load i32** %1, align 8, !dbg !19
  %18 = getelementptr inbounds i32* %17, i64 %16, !dbg !19
  %19 = load i32* %18, align 4, !dbg !19
  %20 = add nsw i32 %19, 1, !dbg !19
  store i32 %20, i32* %18, align 4, !dbg !19
  br label %21, !dbg !19

; <label>:21                                      ; preds = %14, %10
  call void @__syncthreads(), !dbg !20
  br label %34, !dbg !21

; <label>:22                                      ; preds = %0
  %23 = load i32* %tid, align 4, !dbg !22
  %24 = srem i32 %23, 2, !dbg !22
  %25 = icmp eq i32 %24, 1, !dbg !22
  br i1 %25, label %26, label %33, !dbg !22

; <label>:26                                      ; preds = %22
  %27 = load i32* %tid, align 4, !dbg !24
  %28 = sext i32 %27 to i64, !dbg !24
  %29 = load i32** %1, align 8, !dbg !24
  %30 = getelementptr inbounds i32* %29, i64 %28, !dbg !24
  %31 = load i32* %30, align 4, !dbg !24
  %32 = add nsw i32 %31, -1, !dbg !24
  store i32 %32, i32* %30, align 4, !dbg !24
  br label %33, !dbg !24

; <label>:33                                      ; preds = %26, %22
  call void @__syncthreads(), !dbg !25
  br label %34

; <label>:34                                      ; preds = %33, %21
  ret void, !dbg !26
}

declare void @llvm.dbg.declare(metadata, metadata) nounwind readnone

declare void @__syncthreads() section "__device__"

!llvm.dbg.cu = !{!0}

!0 = metadata !{i32 786449, i32 0, i32 4, metadata !"barrier2.cpp", metadata !"/home/mingyuanwu/gkleeTest-repair", metadata !"clang version 3.2 (tags/RELEASE_32/final)", i1 true, i1 false, metadata !"", i32 0, metadata !1, metadata !1, metadata !3, metadata !1} ; [ DW_TAG_compile_unit ] [/home/mingyuanwu/gkleeTest-repair/barrier2.cpp] [DW_LANG_C_plus_plus]
!1 = metadata !{metadata !2}
!2 = metadata !{i32 0}
!3 = metadata !{metadata !4}
!4 = metadata !{metadata !5}
!5 = metadata !{i32 786478, i32 0, metadata !6, metadata !"dl", metadata !"dl", metadata !"_Z2dlPi", metadata !6, i32 5, metadata !7, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, void (i32*)* @_Z2dlPi, null, null, metadata !1, i32 6} ; [ DW_TAG_subprogram ] [line 5] [def] [scope 6] [dl]
!6 = metadata !{i32 786473, metadata !"barrier2.cpp", metadata !"/home/mingyuanwu/gkleeTest-repair", null} ; [ DW_TAG_file_type ]
!7 = metadata !{i32 786453, i32 0, metadata !"", i32 0, i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !8, i32 0, i32 0} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!8 = metadata !{null, metadata !9}
!9 = metadata !{i32 786447, null, metadata !"", null, i32 0, i64 64, i64 64, i64 0, i32 0, metadata !10} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from int]
!10 = metadata !{i32 786468, null, metadata !"int", null, i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!11 = metadata !{i32 786689, metadata !5, metadata !"in", metadata !6, i32 16777221, metadata !9, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [in] [line 5]
!12 = metadata !{i32 5, i32 0, metadata !5, null}
!13 = metadata !{i32 786688, metadata !14, metadata !"tid", metadata !6, i32 8, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [tid] [line 8]
!14 = metadata !{i32 786443, metadata !5, i32 6, i32 0, metadata !6, i32 0} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/gkleeTest-repair/barrier2.cpp]
!15 = metadata !{i32 8, i32 0, metadata !14, null}
!16 = metadata !{i32 9, i32 0, metadata !14, null}
!17 = metadata !{i32 11, i32 0, metadata !18, null}
!18 = metadata !{i32 786443, metadata !14, i32 10, i32 0, metadata !6, i32 1} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/gkleeTest-repair/barrier2.cpp]
!19 = metadata !{i32 12, i32 0, metadata !18, null}
!20 = metadata !{i32 15, i32 0, metadata !18, null}
!21 = metadata !{i32 17, i32 0, metadata !18, null}
!22 = metadata !{i32 19, i32 0, metadata !23, null}
!23 = metadata !{i32 786443, metadata !14, i32 18, i32 0, metadata !6, i32 2} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/gkleeTest-repair/barrier2.cpp]
!24 = metadata !{i32 20, i32 0, metadata !23, null}
!25 = metadata !{i32 22, i32 0, metadata !23, null}
!26 = metadata !{i32 24, i32 0, metadata !14, null}
