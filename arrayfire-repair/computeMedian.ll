; ModuleID = 'computeMedian'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.dim3 = type { i32, i32, i32 }

@threadIdx = external global %struct.dim3
@blockIdx = external global %struct.dim3
@blockDim = external global %struct.dim3
@_ZZ13computeMedianjE8s_median = internal global [256 x float] zeroinitializer, section "__shared__", align 16
@_ZZ13computeMedianjE5s_idx = internal global [256 x i32] zeroinitializer, section "__shared__", align 16

define void @_Z13computeMedianj(i32 %iterations) uwtable noinline {
  %1 = alloca i32, align 4
  %tid = alloca i32, align 4
  %bid = alloca i32, align 4
  %i = alloca i32, align 4
  store i32 %iterations, i32* %1, align 4
  call void @llvm.dbg.declare(metadata !{i32* %1}, metadata !20), !dbg !21
  call void @llvm.dbg.declare(metadata !{i32* %tid}, metadata !22), !dbg !24
  %2 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !24
  store i32 %2, i32* %tid, align 4, !dbg !24
  call void @llvm.dbg.declare(metadata !{i32* %bid}, metadata !25), !dbg !26
  %3 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 0), align 4, !dbg !26
  store i32 %3, i32* %bid, align 4, !dbg !26
  call void @llvm.dbg.declare(metadata !{i32* %i}, metadata !27), !dbg !28
  %4 = load i32* %bid, align 4, !dbg !28
  %5 = load i32* getelementptr inbounds (%struct.dim3* @blockDim, i32 0, i32 0), align 4, !dbg !28
  %6 = mul i32 %4, %5, !dbg !28
  %7 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !28
  %8 = add i32 %6, %7, !dbg !28
  store i32 %8, i32* %i, align 4, !dbg !28
  %9 = load i32* %tid, align 4, !dbg !29
  %10 = zext i32 %9 to i64, !dbg !29
  %11 = getelementptr inbounds [256 x float]* @_ZZ13computeMedianjE8s_median, i32 0, i64 %10, !dbg !29
  store float 2.560000e+02, float* %11, align 4, !dbg !29
  %12 = load i32* %tid, align 4, !dbg !30
  %13 = zext i32 %12 to i64, !dbg !30
  %14 = getelementptr inbounds [256 x i32]* @_ZZ13computeMedianjE5s_idx, i32 0, i64 %13, !dbg !30
  store i32 0, i32* %14, align 4, !dbg !30
  call void @__syncthreads(), !dbg !31
  %15 = load i32* %i, align 4, !dbg !32
  %16 = load i32* %1, align 4, !dbg !32
  %17 = icmp ult i32 %15, %16, !dbg !32
  br i1 %17, label %18, label %26, !dbg !32

; <label>:18                                      ; preds = %0
  %19 = load i32* %i, align 4, !dbg !33
  %20 = load i32* %tid, align 4, !dbg !33
  %21 = zext i32 %20 to i64, !dbg !33
  %22 = getelementptr inbounds [256 x i32]* @_ZZ13computeMedianjE5s_idx, i32 0, i64 %21, !dbg !33
  store i32 %19, i32* %22, align 4, !dbg !33
  %23 = load i32* %tid, align 4, !dbg !35
  %24 = zext i32 %23 to i64, !dbg !35
  %25 = getelementptr inbounds [256 x float]* @_ZZ13computeMedianjE8s_median, i32 0, i64 %24, !dbg !35
  store float 2.000000e+00, float* %25, align 4, !dbg !35
  br label %26, !dbg !36

; <label>:26                                      ; preds = %18, %0
  ret void, !dbg !37
}

declare void @llvm.dbg.declare(metadata, metadata) nounwind readnone

declare void @__syncthreads() section "__device__"

!llvm.dbg.cu = !{!0}

!0 = metadata !{i32 786449, i32 0, i32 4, metadata !"computeMedian.cpp", metadata !"/home/mingyuanwu/arrayfire-repair", metadata !"clang version 3.2 (tags/RELEASE_32/final)", i1 true, i1 false, metadata !"", i32 0, metadata !1, metadata !1, metadata !3, metadata !11} ; [ DW_TAG_compile_unit ] [/home/mingyuanwu/arrayfire-repair/computeMedian.cpp] [DW_LANG_C_plus_plus]
!1 = metadata !{metadata !2}
!2 = metadata !{i32 0}
!3 = metadata !{metadata !4}
!4 = metadata !{metadata !5}
!5 = metadata !{i32 786478, i32 0, metadata !6, metadata !"computeMedian", metadata !"computeMedian", metadata !"_Z13computeMedianj", metadata !6, i32 1, metadata !7, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, void (i32)* @_Z13computeMedianj, null, null, metadata !1, i32 3} ; [ DW_TAG_subprogram ] [line 1] [def] [scope 3] [computeMedian]
!6 = metadata !{i32 786473, metadata !"computeMedian.cpp", metadata !"/home/mingyuanwu/arrayfire-repair", null} ; [ DW_TAG_file_type ]
!7 = metadata !{i32 786453, i32 0, metadata !"", i32 0, i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !8, i32 0, i32 0} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!8 = metadata !{null, metadata !9}
!9 = metadata !{i32 786470, null, metadata !"", null, i32 0, i64 0, i64 0, i64 0, i32 0, metadata !10} ; [ DW_TAG_const_type ] [line 0, size 0, align 0, offset 0] [from unsigned int]
!10 = metadata !{i32 786468, null, metadata !"unsigned int", null, i32 0, i64 32, i64 32, i64 0, i32 0, i32 7} ; [ DW_TAG_base_type ] [unsigned int] [line 0, size 32, align 32, offset 0, enc DW_ATE_unsigned]
!11 = metadata !{metadata !12}
!12 = metadata !{metadata !13, metadata !18}
!13 = metadata !{i32 786484, i32 0, metadata !5, metadata !"s_median", metadata !"s_median", metadata !"", metadata !6, i32 8, metadata !14, i32 1, i32 1, [256 x float]* @_ZZ13computeMedianjE8s_median} ; [ DW_TAG_variable ] [s_median] [line 8] [local] [def]
!14 = metadata !{i32 786433, null, metadata !"", null, i32 0, i64 8192, i64 32, i32 0, i32 0, metadata !15, metadata !16, i32 0, i32 0} ; [ DW_TAG_array_type ] [line 0, size 8192, align 32, offset 0] [from float]
!15 = metadata !{i32 786468, null, metadata !"float", null, i32 0, i64 32, i64 32, i64 0, i32 0, i32 4} ; [ DW_TAG_base_type ] [float] [line 0, size 32, align 32, offset 0, enc DW_ATE_float]
!16 = metadata !{metadata !17}
!17 = metadata !{i32 786465, i64 0, i64 255}      ; [ DW_TAG_subrange_type ] [0, 255]
!18 = metadata !{i32 786484, i32 0, metadata !5, metadata !"s_idx", metadata !"s_idx", metadata !"", metadata !6, i32 9, metadata !19, i32 1, i32 1, [256 x i32]* @_ZZ13computeMedianjE5s_idx} ; [ DW_TAG_variable ] [s_idx] [line 9] [local] [def]
!19 = metadata !{i32 786433, null, metadata !"", null, i32 0, i64 8192, i64 32, i32 0, i32 0, metadata !10, metadata !16, i32 0, i32 0} ; [ DW_TAG_array_type ] [line 0, size 8192, align 32, offset 0] [from unsigned int]
!20 = metadata !{i32 786689, metadata !5, metadata !"iterations", metadata !6, i32 16777218, metadata !9, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [iterations] [line 2]
!21 = metadata !{i32 2, i32 0, metadata !5, null}
!22 = metadata !{i32 786688, metadata !23, metadata !"tid", metadata !6, i32 4, metadata !9, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [tid] [line 4]
!23 = metadata !{i32 786443, metadata !5, i32 3, i32 0, metadata !6, i32 0} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire-repair/computeMedian.cpp]
!24 = metadata !{i32 4, i32 0, metadata !23, null}
!25 = metadata !{i32 786688, metadata !23, metadata !"bid", metadata !6, i32 5, metadata !9, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [bid] [line 5]
!26 = metadata !{i32 5, i32 0, metadata !23, null}
!27 = metadata !{i32 786688, metadata !23, metadata !"i", metadata !6, i32 6, metadata !9, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [i] [line 6]
!28 = metadata !{i32 6, i32 0, metadata !23, null}
!29 = metadata !{i32 11, i32 0, metadata !23, null}
!30 = metadata !{i32 12, i32 0, metadata !23, null}
!31 = metadata !{i32 13, i32 0, metadata !23, null}
!32 = metadata !{i32 15, i32 0, metadata !23, null}
!33 = metadata !{i32 17, i32 0, metadata !34, null}
!34 = metadata !{i32 786443, metadata !23, i32 15, i32 0, metadata !6, i32 1} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire-repair/computeMedian.cpp]
!35 = metadata !{i32 18, i32 0, metadata !34, null}
!36 = metadata !{i32 19, i32 0, metadata !34, null}
!37 = metadata !{i32 20, i32 0, metadata !23, null}
