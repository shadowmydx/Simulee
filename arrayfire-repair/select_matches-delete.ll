; ModuleID = 'select_matches'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.dim3 = type { i32, i32, i32 }

@blockIdx = external global %struct.dim3
@blockDim = external global %struct.dim3
@threadIdx = external global %struct.dim3
@_ZZ14select_matchesPKjPKijjiE6s_dist = internal global [256 x i32] zeroinitializer, section "__shared__", align 16
@_ZZ14select_matchesPKjPKijjiE5s_idx = internal global [256 x i32] zeroinitializer, section "__shared__", align 16

define void @_Z14select_matchesPKjPKijji(i32* %in_idx, i32* %in_dist, i32 %nfeat, i32 %nelem, i32 %max_dist) uwtable noinline {
  %1 = alloca i32*, align 8
  %2 = alloca i32*, align 8
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %f = alloca i32, align 4
  %sid = alloca i32, align 4
  %i = alloca i32, align 4
  %dist = alloca i32, align 4
  store i32* %in_idx, i32** %1, align 8
  call void @llvm.dbg.declare(metadata !{i32** %1}, metadata !23), !dbg !24
  store i32* %in_dist, i32** %2, align 8
  call void @llvm.dbg.declare(metadata !{i32** %2}, metadata !25), !dbg !26
  store i32 %nfeat, i32* %3, align 4
  call void @llvm.dbg.declare(metadata !{i32* %3}, metadata !27), !dbg !28
  store i32 %nelem, i32* %4, align 4
  call void @llvm.dbg.declare(metadata !{i32* %4}, metadata !29), !dbg !30
  store i32 %max_dist, i32* %5, align 4
  call void @llvm.dbg.declare(metadata !{i32* %5}, metadata !31), !dbg !32
  call void @llvm.dbg.declare(metadata !{i32* %f}, metadata !33), !dbg !35
  %6 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 0), align 4, !dbg !35
  %7 = load i32* getelementptr inbounds (%struct.dim3* @blockDim, i32 0, i32 0), align 4, !dbg !35
  %8 = mul i32 %6, %7, !dbg !35
  %9 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !35
  %10 = add i32 %8, %9, !dbg !35
  store i32 %10, i32* %f, align 4, !dbg !35
  call void @llvm.dbg.declare(metadata !{i32* %sid}, metadata !36), !dbg !37
  %11 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !37
  %12 = load i32* getelementptr inbounds (%struct.dim3* @blockDim, i32 0, i32 1), align 4, !dbg !37
  %13 = mul i32 %11, %12, !dbg !37
  %14 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 1), align 4, !dbg !37
  %15 = add i32 %13, %14, !dbg !37
  store i32 %15, i32* %sid, align 4, !dbg !37
  call void @llvm.dbg.declare(metadata !{i32* %i}, metadata !38), !dbg !40
  %16 = load i32* getelementptr inbounds (%struct.dim3* @blockDim, i32 0, i32 1), align 4, !dbg !40
  %17 = udiv i32 %16, 2, !dbg !40
  store i32 %17, i32* %i, align 4, !dbg !40
  br label %18, !dbg !40

; <label>:18                                      ; preds = %54, %0
  %19 = load i32* %i, align 4, !dbg !40
  %20 = icmp ugt i32 %19, 0, !dbg !40
  br i1 %20, label %21, label %57, !dbg !40

; <label>:21                                      ; preds = %18
  %22 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 1), align 4, !dbg !41
  %23 = load i32* %i, align 4, !dbg !41
  %24 = icmp ult i32 %22, %23, !dbg !41
  br i1 %24, label %25, label %53, !dbg !41

; <label>:25                                      ; preds = %21
  call void @llvm.dbg.declare(metadata !{i32* %dist}, metadata !43), !dbg !45
  %26 = load i32* %sid, align 4, !dbg !45
  %27 = load i32* %i, align 4, !dbg !45
  %28 = add i32 %26, %27, !dbg !45
  %29 = zext i32 %28 to i64, !dbg !45
  %30 = getelementptr inbounds [256 x i32]* @_ZZ14select_matchesPKjPKijjiE6s_dist, i32 0, i64 %29, !dbg !45
  %31 = load i32* %30, align 4, !dbg !45
  store i32 %31, i32* %dist, align 4, !dbg !45
  %32 = load i32* %dist, align 4, !dbg !46
  %33 = load i32* %sid, align 4, !dbg !46
  %34 = zext i32 %33 to i64, !dbg !46
  %35 = getelementptr inbounds [256 x i32]* @_ZZ14select_matchesPKjPKijjiE6s_dist, i32 0, i64 %34, !dbg !46
  %36 = load i32* %35, align 4, !dbg !46
  %37 = icmp slt i32 %32, %36, !dbg !46
  br i1 %37, label %38, label %52, !dbg !46

; <label>:38                                      ; preds = %25
  %39 = load i32* %dist, align 4, !dbg !47
  %40 = load i32* %sid, align 4, !dbg !47
  %41 = zext i32 %40 to i64, !dbg !47
  %42 = getelementptr inbounds [256 x i32]* @_ZZ14select_matchesPKjPKijjiE6s_dist, i32 0, i64 %41, !dbg !47
  store i32 %39, i32* %42, align 4, !dbg !47
  %43 = load i32* %sid, align 4, !dbg !49
  %44 = load i32* %i, align 4, !dbg !49
  %45 = add i32 %43, %44, !dbg !49
  %46 = zext i32 %45 to i64, !dbg !49
  %47 = getelementptr inbounds [256 x i32]* @_ZZ14select_matchesPKjPKijjiE5s_idx, i32 0, i64 %46, !dbg !49
  %48 = load i32* %47, align 4, !dbg !49
  %49 = load i32* %sid, align 4, !dbg !49
  %50 = zext i32 %49 to i64, !dbg !49
  %51 = getelementptr inbounds [256 x i32]* @_ZZ14select_matchesPKjPKijjiE5s_idx, i32 0, i64 %50, !dbg !49
  store i32 %48, i32* %51, align 4, !dbg !49
  br label %52, !dbg !50

; <label>:52                                      ; preds = %38, %25

  br label %53, !dbg !52

; <label>:53                                      ; preds = %52, %21
  br label %54, !dbg !53

; <label>:54                                      ; preds = %53
  %55 = load i32* %i, align 4, !dbg !40
  %56 = lshr i32 %55, 1, !dbg !40
  store i32 %56, i32* %i, align 4, !dbg !40
  br label %18, !dbg !40

; <label>:57                                      ; preds = %18
  ret void, !dbg !54
}

declare void @llvm.dbg.declare(metadata, metadata) nounwind readnone

declare void @__syncthreads() section "__device__"

!llvm.dbg.cu = !{!0}

!0 = metadata !{i32 786449, i32 0, i32 4, metadata !"select_matches.cpp", metadata !"/home/mingyuanwu/arrayfire-repair", metadata !"clang version 3.2 (tags/RELEASE_32/final)", i1 true, i1 false, metadata !"", i32 0, metadata !1, metadata !1, metadata !3, metadata !15} ; [ DW_TAG_compile_unit ] [/home/mingyuanwu/arrayfire-repair/select_matches.cpp] [DW_LANG_C_plus_plus]
!1 = metadata !{metadata !2}
!2 = metadata !{i32 0}
!3 = metadata !{metadata !4}
!4 = metadata !{metadata !5}
!5 = metadata !{i32 786478, i32 0, metadata !6, metadata !"select_matches", metadata !"select_matches", metadata !"_Z14select_matchesPKjPKijji", metadata !6, i32 3, metadata !7, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, void (i32*, i32*, i32, i32, i32)* @_Z14select_matchesPKjPKijji, null, null, metadata !1, i32 9} ; [ DW_TAG_subprogram ] [line 3] [def] [scope 9] [select_matches]
!6 = metadata !{i32 786473, metadata !"select_matches.cpp", metadata !"/home/mingyuanwu/arrayfire-repair", null} ; [ DW_TAG_file_type ]
!7 = metadata !{i32 786453, i32 0, metadata !"", i32 0, i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !8, i32 0, i32 0} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!8 = metadata !{null, metadata !9, metadata !12, metadata !10, metadata !10, metadata !13}
!9 = metadata !{i32 786447, null, metadata !"", null, i32 0, i64 64, i64 64, i64 0, i32 0, metadata !10} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from ]
!10 = metadata !{i32 786470, null, metadata !"", null, i32 0, i64 0, i64 0, i64 0, i32 0, metadata !11} ; [ DW_TAG_const_type ] [line 0, size 0, align 0, offset 0] [from unsigned int]
!11 = metadata !{i32 786468, null, metadata !"unsigned int", null, i32 0, i64 32, i64 32, i64 0, i32 0, i32 7} ; [ DW_TAG_base_type ] [unsigned int] [line 0, size 32, align 32, offset 0, enc DW_ATE_unsigned]
!12 = metadata !{i32 786447, null, metadata !"", null, i32 0, i64 64, i64 64, i64 0, i32 0, metadata !13} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from ]
!13 = metadata !{i32 786470, null, metadata !"", null, i32 0, i64 0, i64 0, i64 0, i32 0, metadata !14} ; [ DW_TAG_const_type ] [line 0, size 0, align 0, offset 0] [from int]
!14 = metadata !{i32 786468, null, metadata !"int", null, i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!15 = metadata !{metadata !16}
!16 = metadata !{metadata !17, metadata !21}
!17 = metadata !{i32 786484, i32 0, metadata !5, metadata !"s_dist", metadata !"s_dist", metadata !"", metadata !6, i32 13, metadata !18, i32 1, i32 1, [256 x i32]* @_ZZ14select_matchesPKjPKijjiE6s_dist} ; [ DW_TAG_variable ] [s_dist] [line 13] [local] [def]
!18 = metadata !{i32 786433, null, metadata !"", null, i32 0, i64 8192, i64 32, i32 0, i32 0, metadata !14, metadata !19, i32 0, i32 0} ; [ DW_TAG_array_type ] [line 0, size 8192, align 32, offset 0] [from int]
!19 = metadata !{metadata !20}
!20 = metadata !{i32 786465, i64 0, i64 255}      ; [ DW_TAG_subrange_type ] [0, 255]
!21 = metadata !{i32 786484, i32 0, metadata !5, metadata !"s_idx", metadata !"s_idx", metadata !"", metadata !6, i32 14, metadata !22, i32 1, i32 1, [256 x i32]* @_ZZ14select_matchesPKjPKijjiE5s_idx} ; [ DW_TAG_variable ] [s_idx] [line 14] [local] [def]
!22 = metadata !{i32 786433, null, metadata !"", null, i32 0, i64 8192, i64 32, i32 0, i32 0, metadata !11, metadata !19, i32 0, i32 0} ; [ DW_TAG_array_type ] [line 0, size 8192, align 32, offset 0] [from unsigned int]
!23 = metadata !{i32 786689, metadata !5, metadata !"in_idx", metadata !6, i32 16777220, metadata !9, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [in_idx] [line 4]
!24 = metadata !{i32 4, i32 0, metadata !5, null}
!25 = metadata !{i32 786689, metadata !5, metadata !"in_dist", metadata !6, i32 33554437, metadata !12, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [in_dist] [line 5]
!26 = metadata !{i32 5, i32 0, metadata !5, null}
!27 = metadata !{i32 786689, metadata !5, metadata !"nfeat", metadata !6, i32 50331654, metadata !10, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [nfeat] [line 6]
!28 = metadata !{i32 6, i32 0, metadata !5, null}
!29 = metadata !{i32 786689, metadata !5, metadata !"nelem", metadata !6, i32 67108871, metadata !10, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [nelem] [line 7]
!30 = metadata !{i32 7, i32 0, metadata !5, null}
!31 = metadata !{i32 786689, metadata !5, metadata !"max_dist", metadata !6, i32 83886088, metadata !13, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [max_dist] [line 8]
!32 = metadata !{i32 8, i32 0, metadata !5, null}
!33 = metadata !{i32 786688, metadata !34, metadata !"f", metadata !6, i32 10, metadata !11, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [f] [line 10]
!34 = metadata !{i32 786443, metadata !5, i32 9, i32 0, metadata !6, i32 0} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire-repair/select_matches.cpp]
!35 = metadata !{i32 10, i32 0, metadata !34, null}
!36 = metadata !{i32 786688, metadata !34, metadata !"sid", metadata !6, i32 11, metadata !11, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [sid] [line 11]
!37 = metadata !{i32 11, i32 0, metadata !34, null}
!38 = metadata !{i32 786688, metadata !39, metadata !"i", metadata !6, i32 18, metadata !11, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [i] [line 18]
!39 = metadata !{i32 786443, metadata !34, i32 18, i32 0, metadata !6, i32 1} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire-repair/select_matches.cpp]
!40 = metadata !{i32 18, i32 0, metadata !39, null}
!41 = metadata !{i32 19, i32 0, metadata !42, null}
!42 = metadata !{i32 786443, metadata !39, i32 18, i32 0, metadata !6, i32 2} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire-repair/select_matches.cpp]
!43 = metadata !{i32 786688, metadata !44, metadata !"dist", metadata !6, i32 20, metadata !14, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [dist] [line 20]
!44 = metadata !{i32 786443, metadata !42, i32 19, i32 0, metadata !6, i32 3} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire-repair/select_matches.cpp]
!45 = metadata !{i32 20, i32 0, metadata !44, null}
!46 = metadata !{i32 21, i32 0, metadata !44, null}
!47 = metadata !{i32 22, i32 0, metadata !48, null}
!48 = metadata !{i32 786443, metadata !44, i32 21, i32 0, metadata !6, i32 4} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire-repair/select_matches.cpp]
!49 = metadata !{i32 23, i32 0, metadata !48, null}
!50 = metadata !{i32 24, i32 0, metadata !48, null}
!51 = metadata !{i32 25, i32 0, metadata !44, null}
!52 = metadata !{i32 26, i32 0, metadata !44, null}
!53 = metadata !{i32 27, i32 0, metadata !42, null}
!54 = metadata !{i32 29, i32 0, metadata !34, null}
