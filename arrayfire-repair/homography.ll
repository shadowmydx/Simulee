; ModuleID = 'homography'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.dim3 = type { i32, i32, i32 }

@blockIdx = external global %struct.dim3
@threadIdx = external global %struct.dim3
@blockDim = external global %struct.dim3
@_ZZ21computeEvalHomographyjjjfE9s_inliers = internal global [256 x i32] zeroinitializer, section "__shared__", align 16
@_ZZ21computeEvalHomographyjjjfE5s_idx = internal global [256 x i32] zeroinitializer, section "__shared__", align 16

define void @_Z21computeEvalHomographyjjjf(i32 %inliers_count, i32 %iterations, i32 %nsamples, float %inlier_thr) uwtable noinline {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca float, align 4
  %bid_x = alloca i32, align 4
  %tid_x = alloca i32, align 4
  %i = alloca i32, align 4
  %tx = alloca i32, align 4
  store i32 %inliers_count, i32* %1, align 4
  call void @llvm.dbg.declare(metadata !{i32* %1}, metadata !20), !dbg !21
  store i32 %iterations, i32* %2, align 4
  call void @llvm.dbg.declare(metadata !{i32* %2}, metadata !22), !dbg !23
  store i32 %nsamples, i32* %3, align 4
  call void @llvm.dbg.declare(metadata !{i32* %3}, metadata !24), !dbg !25
  store float %inlier_thr, float* %4, align 4
  call void @llvm.dbg.declare(metadata !{float* %4}, metadata !26), !dbg !27
  call void @llvm.dbg.declare(metadata !{i32* %bid_x}, metadata !28), !dbg !30
  %5 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 0), align 4, !dbg !30
  store i32 %5, i32* %bid_x, align 4, !dbg !30
  call void @llvm.dbg.declare(metadata !{i32* %tid_x}, metadata !31), !dbg !32
  %6 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !32
  store i32 %6, i32* %tid_x, align 4, !dbg !32
  call void @llvm.dbg.declare(metadata !{i32* %i}, metadata !33), !dbg !34
  %7 = load i32* %bid_x, align 4, !dbg !34
  %8 = load i32* getelementptr inbounds (%struct.dim3* @blockDim, i32 0, i32 0), align 4, !dbg !34
  %9 = mul i32 %7, %8, !dbg !34
  %10 = load i32* %tid_x, align 4, !dbg !34
  %11 = add i32 %9, %10, !dbg !34
  store i32 %11, i32* %i, align 4, !dbg !34
  %12 = load i32* %tid_x, align 4, !dbg !35
  %13 = zext i32 %12 to i64, !dbg !35
  %14 = getelementptr inbounds [256 x i32]* @_ZZ21computeEvalHomographyjjjfE9s_inliers, i32 0, i64 %13, !dbg !35
  store i32 0, i32* %14, align 4, !dbg !35
  %15 = load i32* %tid_x, align 4, !dbg !36
  %16 = zext i32 %15 to i64, !dbg !36
  %17 = getelementptr inbounds [256 x i32]* @_ZZ21computeEvalHomographyjjjfE5s_idx, i32 0, i64 %16, !dbg !36
  store i32 0, i32* %17, align 4, !dbg !36
  call void @__syncthreads(), !dbg !37
  %18 = load i32* %i, align 4, !dbg !38
  %19 = icmp ult i32 %18, 110, !dbg !38
  br i1 %19, label %20, label %29, !dbg !38

; <label>:20                                      ; preds = %0
  %21 = load i32* %1, align 4, !dbg !39
  %22 = load i32* %tid_x, align 4, !dbg !39
  %23 = zext i32 %22 to i64, !dbg !39
  %24 = getelementptr inbounds [256 x i32]* @_ZZ21computeEvalHomographyjjjfE9s_inliers, i32 0, i64 %23, !dbg !39
  store i32 %21, i32* %24, align 4, !dbg !39
  %25 = load i32* %i, align 4, !dbg !41
  %26 = load i32* %tid_x, align 4, !dbg !41
  %27 = zext i32 %26 to i64, !dbg !41
  %28 = getelementptr inbounds [256 x i32]* @_ZZ21computeEvalHomographyjjjfE5s_idx, i32 0, i64 %27, !dbg !41
  store i32 %25, i32* %28, align 4, !dbg !41
  br label %29, !dbg !42

; <label>:29                                      ; preds = %20, %0
  call void @llvm.dbg.declare(metadata !{i32* %tx}, metadata !43), !dbg !45
  store i32 64, i32* %tx, align 4, !dbg !45
  br label %30, !dbg !45

; <label>:30                                      ; preds = %70, %29
  %31 = load i32* %tx, align 4, !dbg !45
  %32 = icmp ugt i32 %31, 0, !dbg !45
  br i1 %32, label %33, label %73, !dbg !45

; <label>:33                                      ; preds = %30
  %34 = load i32* %tid_x, align 4, !dbg !46
  %35 = load i32* %tx, align 4, !dbg !46
  %36 = icmp ult i32 %34, %35, !dbg !46
  br i1 %36, label %37, label %69, !dbg !46

; <label>:37                                      ; preds = %33
  %38 = load i32* %tid_x, align 4, !dbg !48
  %39 = load i32* %tx, align 4, !dbg !48
  %40 = add i32 %38, %39, !dbg !48
  %41 = zext i32 %40 to i64, !dbg !48
  %42 = getelementptr inbounds [256 x i32]* @_ZZ21computeEvalHomographyjjjfE9s_inliers, i32 0, i64 %41, !dbg !48
  %43 = load i32* %42, align 4, !dbg !48
  %44 = load i32* %tid_x, align 4, !dbg !48
  %45 = zext i32 %44 to i64, !dbg !48
  %46 = getelementptr inbounds [256 x i32]* @_ZZ21computeEvalHomographyjjjfE9s_inliers, i32 0, i64 %45, !dbg !48
  %47 = load i32* %46, align 4, !dbg !48
  %48 = icmp ugt i32 %43, %47, !dbg !48
  br i1 %48, label %49, label %68, !dbg !48

; <label>:49                                      ; preds = %37
  %50 = load i32* %tid_x, align 4, !dbg !50
  %51 = load i32* %tx, align 4, !dbg !50
  %52 = add i32 %50, %51, !dbg !50
  %53 = zext i32 %52 to i64, !dbg !50
  %54 = getelementptr inbounds [256 x i32]* @_ZZ21computeEvalHomographyjjjfE9s_inliers, i32 0, i64 %53, !dbg !50
  %55 = load i32* %54, align 4, !dbg !50
  %56 = load i32* %tid_x, align 4, !dbg !50
  %57 = zext i32 %56 to i64, !dbg !50
  %58 = getelementptr inbounds [256 x i32]* @_ZZ21computeEvalHomographyjjjfE9s_inliers, i32 0, i64 %57, !dbg !50
  store i32 %55, i32* %58, align 4, !dbg !50
  %59 = load i32* %tid_x, align 4, !dbg !52
  %60 = load i32* %tx, align 4, !dbg !52
  %61 = add i32 %59, %60, !dbg !52
  %62 = zext i32 %61 to i64, !dbg !52
  %63 = getelementptr inbounds [256 x i32]* @_ZZ21computeEvalHomographyjjjfE5s_idx, i32 0, i64 %62, !dbg !52
  %64 = load i32* %63, align 4, !dbg !52
  %65 = load i32* %tid_x, align 4, !dbg !52
  %66 = zext i32 %65 to i64, !dbg !52
  %67 = getelementptr inbounds [256 x i32]* @_ZZ21computeEvalHomographyjjjfE5s_idx, i32 0, i64 %66, !dbg !52
  store i32 %64, i32* %67, align 4, !dbg !52
  br label %68, !dbg !53

; <label>:68                                      ; preds = %49, %37
  br label %69, !dbg !54

; <label>:69                                      ; preds = %68, %33
  call void @__syncthreads(), !dbg !55
  br label %70, !dbg !56

; <label>:70                                      ; preds = %69
  %71 = load i32* %tx, align 4, !dbg !45
  %72 = lshr i32 %71, 1, !dbg !45
  store i32 %72, i32* %tx, align 4, !dbg !45
  br label %30, !dbg !45

; <label>:73                                      ; preds = %30
  ret void, !dbg !57
}

declare void @llvm.dbg.declare(metadata, metadata) nounwind readnone

declare void @__syncthreads() section "__device__"

!llvm.dbg.cu = !{!0}

!0 = metadata !{i32 786449, i32 0, i32 4, metadata !"homography.cpp", metadata !"/home/mingyuanwu/arrayfire-repair", metadata !"clang version 3.2 (tags/RELEASE_32/final)", i1 true, i1 false, metadata !"", i32 0, metadata !1, metadata !1, metadata !3, metadata !13} ; [ DW_TAG_compile_unit ] [/home/mingyuanwu/arrayfire-repair/homography.cpp] [DW_LANG_C_plus_plus]
!1 = metadata !{metadata !2}
!2 = metadata !{i32 0}
!3 = metadata !{metadata !4}
!4 = metadata !{metadata !5}
!5 = metadata !{i32 786478, i32 0, metadata !6, metadata !"computeEvalHomography", metadata !"computeEvalHomography", metadata !"_Z21computeEvalHomographyjjjf", metadata !6, i32 1, metadata !7, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, void (i32, i32, i32, float)* @_Z21computeEvalHomographyjjjf, null, null, metadata !1, i32 6} ; [ DW_TAG_subprogram ] [line 1] [def] [scope 6] [computeEvalHomography]
!6 = metadata !{i32 786473, metadata !"homography.cpp", metadata !"/home/mingyuanwu/arrayfire-repair", null} ; [ DW_TAG_file_type ]
!7 = metadata !{i32 786453, i32 0, metadata !"", i32 0, i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !8, i32 0, i32 0} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!8 = metadata !{null, metadata !9, metadata !10, metadata !10, metadata !11}
!9 = metadata !{i32 786468, null, metadata !"unsigned int", null, i32 0, i64 32, i64 32, i64 0, i32 0, i32 7} ; [ DW_TAG_base_type ] [unsigned int] [line 0, size 32, align 32, offset 0, enc DW_ATE_unsigned]
!10 = metadata !{i32 786470, null, metadata !"", null, i32 0, i64 0, i64 0, i64 0, i32 0, metadata !9} ; [ DW_TAG_const_type ] [line 0, size 0, align 0, offset 0] [from unsigned int]
!11 = metadata !{i32 786470, null, metadata !"", null, i32 0, i64 0, i64 0, i64 0, i32 0, metadata !12} ; [ DW_TAG_const_type ] [line 0, size 0, align 0, offset 0] [from float]
!12 = metadata !{i32 786468, null, metadata !"float", null, i32 0, i64 32, i64 32, i64 0, i32 0, i32 4} ; [ DW_TAG_base_type ] [float] [line 0, size 32, align 32, offset 0, enc DW_ATE_float]
!13 = metadata !{metadata !14}
!14 = metadata !{metadata !15, metadata !19}
!15 = metadata !{i32 786484, i32 0, metadata !5, metadata !"s_inliers", metadata !"s_inliers", metadata !"", metadata !6, i32 11, metadata !16, i32 1, i32 1, [256 x i32]* @_ZZ21computeEvalHomographyjjjfE9s_inliers} ; [ DW_TAG_variable ] [s_inliers] [line 11] [local] [def]
!16 = metadata !{i32 786433, null, metadata !"", null, i32 0, i64 8192, i64 32, i32 0, i32 0, metadata !9, metadata !17, i32 0, i32 0} ; [ DW_TAG_array_type ] [line 0, size 8192, align 32, offset 0] [from unsigned int]
!17 = metadata !{metadata !18}
!18 = metadata !{i32 786465, i64 0, i64 255}      ; [ DW_TAG_subrange_type ] [0, 255]
!19 = metadata !{i32 786484, i32 0, metadata !5, metadata !"s_idx", metadata !"s_idx", metadata !"", metadata !6, i32 12, metadata !16, i32 1, i32 1, [256 x i32]* @_ZZ21computeEvalHomographyjjjfE5s_idx} ; [ DW_TAG_variable ] [s_idx] [line 12] [local] [def]
!20 = metadata !{i32 786689, metadata !5, metadata !"inliers_count", metadata !6, i32 16777218, metadata !9, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [inliers_count] [line 2]
!21 = metadata !{i32 2, i32 0, metadata !5, null}
!22 = metadata !{i32 786689, metadata !5, metadata !"iterations", metadata !6, i32 33554435, metadata !10, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [iterations] [line 3]
!23 = metadata !{i32 3, i32 0, metadata !5, null}
!24 = metadata !{i32 786689, metadata !5, metadata !"nsamples", metadata !6, i32 50331652, metadata !10, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [nsamples] [line 4]
!25 = metadata !{i32 4, i32 0, metadata !5, null}
!26 = metadata !{i32 786689, metadata !5, metadata !"inlier_thr", metadata !6, i32 67108869, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [inlier_thr] [line 5]
!27 = metadata !{i32 5, i32 0, metadata !5, null}
!28 = metadata !{i32 786688, metadata !29, metadata !"bid_x", metadata !6, i32 7, metadata !9, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [bid_x] [line 7]
!29 = metadata !{i32 786443, metadata !5, i32 6, i32 0, metadata !6, i32 0} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire-repair/homography.cpp]
!30 = metadata !{i32 7, i32 0, metadata !29, null}
!31 = metadata !{i32 786688, metadata !29, metadata !"tid_x", metadata !6, i32 8, metadata !9, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [tid_x] [line 8]
!32 = metadata !{i32 8, i32 0, metadata !29, null}
!33 = metadata !{i32 786688, metadata !29, metadata !"i", metadata !6, i32 9, metadata !9, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [i] [line 9]
!34 = metadata !{i32 9, i32 0, metadata !29, null}
!35 = metadata !{i32 14, i32 0, metadata !29, null}
!36 = metadata !{i32 15, i32 0, metadata !29, null}
!37 = metadata !{i32 16, i32 0, metadata !29, null}
!38 = metadata !{i32 18, i32 0, metadata !29, null}
!39 = metadata !{i32 19, i32 0, metadata !40, null}
!40 = metadata !{i32 786443, metadata !29, i32 18, i32 0, metadata !6, i32 1} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire-repair/homography.cpp]
!41 = metadata !{i32 20, i32 0, metadata !40, null}
!42 = metadata !{i32 21, i32 0, metadata !40, null}
!43 = metadata !{i32 786688, metadata !44, metadata !"tx", metadata !6, i32 25, metadata !9, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [tx] [line 25]
!44 = metadata !{i32 786443, metadata !29, i32 25, i32 0, metadata !6, i32 2} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire-repair/homography.cpp]
!45 = metadata !{i32 25, i32 0, metadata !44, null}
!46 = metadata !{i32 26, i32 0, metadata !47, null}
!47 = metadata !{i32 786443, metadata !44, i32 25, i32 0, metadata !6, i32 3} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire-repair/homography.cpp]
!48 = metadata !{i32 27, i32 0, metadata !49, null}
!49 = metadata !{i32 786443, metadata !47, i32 26, i32 0, metadata !6, i32 4} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire-repair/homography.cpp]
!50 = metadata !{i32 28, i32 0, metadata !51, null}
!51 = metadata !{i32 786443, metadata !49, i32 27, i32 0, metadata !6, i32 5} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire-repair/homography.cpp]
!52 = metadata !{i32 29, i32 0, metadata !51, null}
!53 = metadata !{i32 30, i32 0, metadata !51, null}
!54 = metadata !{i32 31, i32 0, metadata !49, null}
!55 = metadata !{i32 32, i32 0, metadata !47, null}
!56 = metadata !{i32 33, i32 0, metadata !47, null}
!57 = metadata !{i32 34, i32 0, metadata !29, null}
