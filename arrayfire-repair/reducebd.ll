; ModuleID = 'reducebd'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.dim3 = type { i32, i32, i32 }

@threadIdx = external global %struct.dim3

define void @_Z11warp_reducePd(double* %s_ptr) uwtable noinline {
  %1 = alloca double*, align 8
  %tidx = alloca i32, align 4
  %s_ptr_vol = alloca double*, align 8
  %tmp = alloca double, align 8
  %n = alloca i32, align 4
  %val1 = alloca double, align 8
  %val2 = alloca double, align 8
  store double* %s_ptr, double** %1, align 8
  call void @llvm.dbg.declare(metadata !{double** %1}, metadata !11), !dbg !12
  call void @llvm.dbg.declare(metadata !{i32* %tidx}, metadata !13), !dbg !16
  %2 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !16
  store i32 %2, i32* %tidx, align 4, !dbg !16
  call void @llvm.dbg.declare(metadata !{double** %s_ptr_vol}, metadata !17), !dbg !18
  %3 = load double** %1, align 8, !dbg !18
  %4 = load i32* %tidx, align 4, !dbg !18
  %5 = sext i32 %4 to i64, !dbg !18
  %6 = getelementptr inbounds double* %3, i64 %5, !dbg !18
  store double* %6, double** %s_ptr_vol, align 8, !dbg !18
  call void @llvm.dbg.declare(metadata !{double* %tmp}, metadata !19), !dbg !20
  %7 = load double** %1, align 8, !dbg !20
  %8 = load double* %7, align 8, !dbg !20
  store double %8, double* %tmp, align 8, !dbg !20
  call void @llvm.dbg.declare(metadata !{i32* %n}, metadata !21), !dbg !23
  store i32 16, i32* %n, align 4, !dbg !23
  br label %9, !dbg !23

; <label>:9                                       ; preds = %32, %0
  %10 = load i32* %n, align 4, !dbg !23
  %11 = icmp sge i32 %10, 1, !dbg !23
  br i1 %11, label %12, label %35, !dbg !23

; <label>:12                                      ; preds = %9
  %13 = load i32* %tidx, align 4, !dbg !24
  %14 = load i32* %n, align 4, !dbg !24
  %15 = icmp slt i32 %13, %14, !dbg !24
  br i1 %15, label %16, label %31, !dbg !24

; <label>:16                                      ; preds = %12
  call void @llvm.dbg.declare(metadata !{double* %val1}, metadata !26), !dbg !28
  call void @llvm.dbg.declare(metadata !{double* %val2}, metadata !29), !dbg !28
  %17 = load double** %s_ptr_vol, align 8, !dbg !30
  %18 = getelementptr inbounds double* %17, i64 0, !dbg !30
  %19 = load double* %18, align 8, !dbg !30
  store double %19, double* %val1, align 8, !dbg !30
  %20 = load i32* %n, align 4, !dbg !31
  %21 = sext i32 %20 to i64, !dbg !31
  %22 = load double** %s_ptr_vol, align 8, !dbg !31
  %23 = getelementptr inbounds double* %22, i64 %21, !dbg !31
  %24 = load double* %23, align 8, !dbg !31
  store double %24, double* %val2, align 8, !dbg !31
  call void @__syncthreads(), !dbg !32
  %25 = load double* %val1, align 8, !dbg !33
  %26 = load double* %val2, align 8, !dbg !33
  %27 = fadd double %25, %26, !dbg !33
  store double %27, double* %tmp, align 8, !dbg !33
  %28 = load double* %tmp, align 8, !dbg !34
  %29 = load double** %s_ptr_vol, align 8, !dbg !34
  %30 = getelementptr inbounds double* %29, i64 0, !dbg !34
  store double %28, double* %30, align 8, !dbg !34
  br label %31, !dbg !35

; <label>:31                                      ; preds = %16, %12
  br label %32, !dbg !36

; <label>:32                                      ; preds = %31
  %33 = load i32* %n, align 4, !dbg !23
  %34 = ashr i32 %33, 1, !dbg !23
  store i32 %34, i32* %n, align 4, !dbg !23
  br label %9, !dbg !23

; <label>:35                                      ; preds = %9
  ret void, !dbg !37
}

declare void @llvm.dbg.declare(metadata, metadata) nounwind readnone

declare void @__syncthreads() section "__device__"

!llvm.dbg.cu = !{!0}

!0 = metadata !{i32 786449, i32 0, i32 4, metadata !"reducebd.cpp", metadata !"/home/mingyuanwu/arrayfire-repair", metadata !"clang version 3.2 (tags/RELEASE_32/final)", i1 true, i1 false, metadata !"", i32 0, metadata !1, metadata !1, metadata !3, metadata !1} ; [ DW_TAG_compile_unit ] [/home/mingyuanwu/arrayfire-repair/reducebd.cpp] [DW_LANG_C_plus_plus]
!1 = metadata !{metadata !2}
!2 = metadata !{i32 0}
!3 = metadata !{metadata !4}
!4 = metadata !{metadata !5}
!5 = metadata !{i32 786478, i32 0, metadata !6, metadata !"warp_reduce", metadata !"warp_reduce", metadata !"_Z11warp_reducePd", metadata !6, i32 2, metadata !7, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, void (double*)* @_Z11warp_reducePd, null, null, metadata !1, i32 3} ; [ DW_TAG_subprogram ] [line 2] [def] [scope 3] [warp_reduce]
!6 = metadata !{i32 786473, metadata !"reducebd.cpp", metadata !"/home/mingyuanwu/arrayfire-repair", null} ; [ DW_TAG_file_type ]
!7 = metadata !{i32 786453, i32 0, metadata !"", i32 0, i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !8, i32 0, i32 0} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!8 = metadata !{null, metadata !9}
!9 = metadata !{i32 786447, null, metadata !"", null, i32 0, i64 64, i64 64, i64 0, i32 0, metadata !10} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from double]
!10 = metadata !{i32 786468, null, metadata !"double", null, i32 0, i64 64, i64 64, i64 0, i32 0, i32 4} ; [ DW_TAG_base_type ] [double] [line 0, size 64, align 64, offset 0, enc DW_ATE_float]
!11 = metadata !{i32 786689, metadata !5, metadata !"s_ptr", metadata !6, i32 16777218, metadata !9, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [s_ptr] [line 2]
!12 = metadata !{i32 2, i32 0, metadata !5, null}
!13 = metadata !{i32 786688, metadata !14, metadata !"tidx", metadata !6, i32 4, metadata !15, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [tidx] [line 4]
!14 = metadata !{i32 786443, metadata !5, i32 3, i32 0, metadata !6, i32 0} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire-repair/reducebd.cpp]
!15 = metadata !{i32 786468, null, metadata !"int", null, i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!16 = metadata !{i32 4, i32 0, metadata !14, null}
!17 = metadata !{i32 786688, metadata !14, metadata !"s_ptr_vol", metadata !6, i32 5, metadata !9, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [s_ptr_vol] [line 5]
!18 = metadata !{i32 5, i32 0, metadata !14, null}
!19 = metadata !{i32 786688, metadata !14, metadata !"tmp", metadata !6, i32 6, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [tmp] [line 6]
!20 = metadata !{i32 6, i32 0, metadata !14, null}
!21 = metadata !{i32 786688, metadata !22, metadata !"n", metadata !6, i32 8, metadata !15, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [n] [line 8]
!22 = metadata !{i32 786443, metadata !14, i32 8, i32 0, metadata !6, i32 1} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire-repair/reducebd.cpp]
!23 = metadata !{i32 8, i32 0, metadata !22, null}
!24 = metadata !{i32 9, i32 0, metadata !25, null}
!25 = metadata !{i32 786443, metadata !22, i32 8, i32 0, metadata !6, i32 2} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire-repair/reducebd.cpp]
!26 = metadata !{i32 786688, metadata !27, metadata !"val1", metadata !6, i32 10, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [val1] [line 10]
!27 = metadata !{i32 786443, metadata !25, i32 9, i32 0, metadata !6, i32 3} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire-repair/reducebd.cpp]
!28 = metadata !{i32 10, i32 0, metadata !27, null}
!29 = metadata !{i32 786688, metadata !27, metadata !"val2", metadata !6, i32 10, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [val2] [line 10]
!30 = metadata !{i32 11, i32 0, metadata !27, null}
!31 = metadata !{i32 12, i32 0, metadata !27, null}
!32 = metadata !{i32 13, i32 0, metadata !27, null}
!33 = metadata !{i32 14, i32 0, metadata !27, null}
!34 = metadata !{i32 15, i32 0, metadata !27, null}
!35 = metadata !{i32 16, i32 0, metadata !27, null}
!36 = metadata !{i32 17, i32 0, metadata !25, null}
!37 = metadata !{i32 18, i32 0, metadata !14, null}
