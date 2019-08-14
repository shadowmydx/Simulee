; ModuleID = 'barrier1'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.dim3 = type { i32, i32, i32 }

@threadIdx = external global %struct.dim3
@blockIdx = external global %struct.dim3
@blockDim = external global %struct.dim3

define void @_Z2dlPi(i32* %in) uwtable noinline {
  %1 = alloca i32*, align 8
  %tid = alloca i32, align 4
  %sum = alloca i32, align 4
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
  %8 = icmp slt i32 %7, 15, !dbg !16
  br i1 %8, label %9, label %56, !dbg !16

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
  call void @__syncthreads(), !dbg !20
  call void @llvm.dbg.declare(metadata !{i32* %sum}, metadata !21), !dbg !22
  %21 = load i32* %tid, align 4, !dbg !22
  %22 = sext i32 %21 to i64, !dbg !22
  %23 = load i32** %1, align 8, !dbg !22
  %24 = getelementptr inbounds i32* %23, i64 %22, !dbg !22
  %25 = load i32* %24, align 4, !dbg !22
  store i32 %25, i32* %sum, align 4, !dbg !22
  %26 = load i32* %tid, align 4, !dbg !23
  %27 = icmp sgt i32 %26, 0, !dbg !23
  br i1 %27, label %28, label %37, !dbg !23

; <label>:28                                      ; preds = %20
  %29 = load i32* %tid, align 4, !dbg !24
  %30 = sub nsw i32 %29, 1, !dbg !24
  %31 = sext i32 %30 to i64, !dbg !24
  %32 = load i32** %1, align 8, !dbg !24
  %33 = getelementptr inbounds i32* %32, i64 %31, !dbg !24
  %34 = load i32* %33, align 4, !dbg !24
  %35 = load i32* %sum, align 4, !dbg !24
  %36 = add nsw i32 %35, %34, !dbg !24
  store i32 %36, i32* %sum, align 4, !dbg !24
  br label %37, !dbg !24

; <label>:37                                      ; preds = %28, %20
  %38 = load i32* %tid, align 4, !dbg !25
  %39 = icmp slt i32 %38, 49, !dbg !25
  br i1 %39, label %40, label %49, !dbg !25

; <label>:40                                      ; preds = %37
  %41 = load i32* %tid, align 4, !dbg !26
  %42 = add nsw i32 %41, 1, !dbg !26
  %43 = sext i32 %42 to i64, !dbg !26
  %44 = load i32** %1, align 8, !dbg !26
  %45 = getelementptr inbounds i32* %44, i64 %43, !dbg !26
  %46 = load i32* %45, align 4, !dbg !26
  %47 = load i32* %sum, align 4, !dbg !26
  %48 = add nsw i32 %47, %46, !dbg !26
  store i32 %48, i32* %sum, align 4, !dbg !26
  br label %49, !dbg !26

; <label>:49                                      ; preds = %40, %37
  %50 = load i32* %sum, align 4, !dbg !27
  %51 = sdiv i32 %50, 3, !dbg !27
  %52 = load i32* %tid, align 4, !dbg !27
  %53 = sext i32 %52 to i64, !dbg !27
  %54 = load i32** %1, align 8, !dbg !27
  %55 = getelementptr inbounds i32* %54, i64 %53, !dbg !27
  store i32 %51, i32* %55, align 4, !dbg !27
  br label %56, !dbg !28

; <label>:56                                      ; preds = %49, %0
  ret void, !dbg !29
}

declare void @llvm.dbg.declare(metadata, metadata) nounwind readnone

declare void @__syncthreads() section "__device__"

!llvm.dbg.cu = !{!0}

!0 = metadata !{i32 786449, i32 0, i32 4, metadata !"barrier1.cpp", metadata !"/home/mingyuanwu/gkleeTest-repair", metadata !"clang version 3.2 (tags/RELEASE_32/final)", i1 true, i1 false, metadata !"", i32 0, metadata !1, metadata !1, metadata !3, metadata !1} ; [ DW_TAG_compile_unit ] [/home/mingyuanwu/gkleeTest-repair/barrier1.cpp] [DW_LANG_C_plus_plus]
!1 = metadata !{metadata !2}
!2 = metadata !{i32 0}
!3 = metadata !{metadata !4}
!4 = metadata !{metadata !5}
!5 = metadata !{i32 786478, i32 0, metadata !6, metadata !"dl", metadata !"dl", metadata !"_Z2dlPi", metadata !6, i32 5, metadata !7, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, void (i32*)* @_Z2dlPi, null, null, metadata !1, i32 6} ; [ DW_TAG_subprogram ] [line 5] [def] [scope 6] [dl]
!6 = metadata !{i32 786473, metadata !"barrier1.cpp", metadata !"/home/mingyuanwu/gkleeTest-repair", null} ; [ DW_TAG_file_type ]
!7 = metadata !{i32 786453, i32 0, metadata !"", i32 0, i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !8, i32 0, i32 0} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!8 = metadata !{null, metadata !9}
!9 = metadata !{i32 786447, null, metadata !"", null, i32 0, i64 64, i64 64, i64 0, i32 0, metadata !10} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from int]
!10 = metadata !{i32 786468, null, metadata !"int", null, i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!11 = metadata !{i32 786689, metadata !5, metadata !"in", metadata !6, i32 16777221, metadata !9, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [in] [line 5]
!12 = metadata !{i32 5, i32 0, metadata !5, null}
!13 = metadata !{i32 786688, metadata !14, metadata !"tid", metadata !6, i32 8, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [tid] [line 8]
!14 = metadata !{i32 786443, metadata !5, i32 6, i32 0, metadata !6, i32 0} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/gkleeTest-repair/barrier1.cpp]
!15 = metadata !{i32 8, i32 0, metadata !14, null}
!16 = metadata !{i32 9, i32 0, metadata !14, null}
!17 = metadata !{i32 11, i32 0, metadata !18, null}
!18 = metadata !{i32 786443, metadata !14, i32 10, i32 0, metadata !6, i32 1} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/gkleeTest-repair/barrier1.cpp]
!19 = metadata !{i32 12, i32 0, metadata !18, null}
!20 = metadata !{i32 14, i32 0, metadata !18, null}
!21 = metadata !{i32 786688, metadata !18, metadata !"sum", metadata !6, i32 16, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [sum] [line 16]
!22 = metadata !{i32 16, i32 0, metadata !18, null}
!23 = metadata !{i32 17, i32 0, metadata !18, null}
!24 = metadata !{i32 18, i32 0, metadata !18, null}
!25 = metadata !{i32 19, i32 0, metadata !18, null}
!26 = metadata !{i32 20, i32 0, metadata !18, null}
!27 = metadata !{i32 21, i32 0, metadata !18, null}
!28 = metadata !{i32 22, i32 0, metadata !18, null}
!29 = metadata !{i32 23, i32 0, metadata !14, null}
