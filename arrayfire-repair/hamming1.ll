; ModuleID = 'hamming1'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.dim3 = type { i32, i32, i32 }

@blockDim = external global %struct.dim3
@blockIdx = external global %struct.dim3
@threadIdx = external global %struct.dim3
@_ZZ22hamming_matcher_unrollPjS_jE6s_dist = internal global [256 x i32] zeroinitializer, section "__shared__", align 16
@_ZZ22hamming_matcher_unrollPjS_jE5s_idx = internal global [256 x i32] zeroinitializer, section "__shared__", align 16
@gridDim = external global %struct.dim3

define void @_Z22hamming_matcher_unrollPjS_j(i32* %out_idx, i32* %out_dist, i32 %max_dist) uwtable noinline {
  %1 = alloca i32*, align 8
  %2 = alloca i32*, align 8
  %3 = alloca i32, align 4
  %f = alloca i32, align 4
  %tid = alloca i32, align 4
  %feat_len = alloca i32, align 4
  %nquery = alloca i32, align 4
  %ntrain = alloca i32, align 4
  %valid_feat = alloca i8, align 1
  %j = alloca i32, align 4
  store i32* %out_idx, i32** %1, align 8
  call void @llvm.dbg.declare(metadata !{i32** %1}, metadata !19), !dbg !20
  store i32* %out_dist, i32** %2, align 8
  call void @llvm.dbg.declare(metadata !{i32** %2}, metadata !21), !dbg !22
  store i32 %max_dist, i32* %3, align 4
  call void @llvm.dbg.declare(metadata !{i32* %3}, metadata !23), !dbg !24
  call void @llvm.dbg.declare(metadata !{i32* %f}, metadata !25), !dbg !27
  %4 = load i32* getelementptr inbounds (%struct.dim3* @blockDim, i32 0, i32 0), align 4, !dbg !27
  %5 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 0), align 4, !dbg !27
  %6 = mul i32 %4, %5, !dbg !27
  %7 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !27
  %8 = add i32 %6, %7, !dbg !27
  store i32 %8, i32* %f, align 4, !dbg !27
  call void @llvm.dbg.declare(metadata !{i32* %tid}, metadata !28), !dbg !29
  %9 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !29
  store i32 %9, i32* %tid, align 4, !dbg !29
  call void @llvm.dbg.declare(metadata !{i32* %feat_len}, metadata !30), !dbg !31
  store i32 6, i32* %feat_len, align 4, !dbg !31
  call void @llvm.dbg.declare(metadata !{i32* %nquery}, metadata !32), !dbg !31
  store i32 6, i32* %nquery, align 4, !dbg !31
  %10 = load i32* %3, align 4, !dbg !33
  %11 = load i32* %tid, align 4, !dbg !33
  %12 = zext i32 %11 to i64, !dbg !33
  %13 = getelementptr inbounds [256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jE6s_dist, i32 0, i64 %12, !dbg !33
  store i32 %10, i32* %13, align 4, !dbg !33
  %14 = load i32* %tid, align 4, !dbg !34
  %15 = zext i32 %14 to i64, !dbg !34
  %16 = getelementptr inbounds [256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jE5s_idx, i32 0, i64 %15, !dbg !34
  store i32 -1, i32* %16, align 4, !dbg !34
  call void @llvm.dbg.declare(metadata !{i32* %ntrain}, metadata !35), !dbg !36
  store i32 64, i32* %ntrain, align 4, !dbg !36
  call void @llvm.dbg.declare(metadata !{i8* %valid_feat}, metadata !37), !dbg !39
  %17 = load i32* %f, align 4, !dbg !39
  %18 = load i32* %ntrain, align 4, !dbg !39
  %19 = icmp ult i32 %17, %18, !dbg !39
  %20 = zext i1 %19 to i8, !dbg !39
  store i8 %20, i8* %valid_feat, align 1, !dbg !39
  call void @llvm.dbg.declare(metadata !{i32* %j}, metadata !40), !dbg !42
  store i32 0, i32* %j, align 4, !dbg !42
  br label %21, !dbg !42

; <label>:21                                      ; preds = %167, %0
  %22 = load i32* %j, align 4, !dbg !42
  %23 = load i32* %nquery, align 4, !dbg !42
  %24 = icmp ult i32 %22, %23, !dbg !42
  br i1 %24, label %25, label %170, !dbg !42

; <label>:25                                      ; preds = %21
  %26 = load i32* %3, align 4, !dbg !43
  %27 = load i32* %tid, align 4, !dbg !43
  %28 = zext i32 %27 to i64, !dbg !43
  %29 = getelementptr inbounds [256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jE6s_dist, i32 0, i64 %28, !dbg !43
  store i32 %26, i32* %29, align 4, !dbg !43
  %30 = load i32* %tid, align 4, !dbg !45
  %31 = load i32* %feat_len, align 4, !dbg !45
  %32 = icmp ult i32 %30, %31, !dbg !45
  br i1 %32, label %33, label %47, !dbg !45

; <label>:33                                      ; preds = %25
  %34 = load i32* %f, align 4, !dbg !45
  %35 = load i32* %ntrain, align 4, !dbg !45
  %36 = icmp ult i32 %34, %35, !dbg !45
  br i1 %36, label %37, label %47, !dbg !45

; <label>:37                                      ; preds = %33
  %38 = load i32* %tid, align 4, !dbg !46
  %39 = load i32* %nquery, align 4, !dbg !46
  %40 = mul i32 %38, %39, !dbg !46
  %41 = load i32* %j, align 4, !dbg !46
  %42 = add i32 %40, %41, !dbg !46
  %43 = load i32* %tid, align 4, !dbg !46
  %44 = zext i32 %43 to i64, !dbg !46
  %45 = load i32** %1, align 8, !dbg !46
  %46 = getelementptr inbounds i32* %45, i64 %44, !dbg !46
  store i32 %42, i32* %46, align 4, !dbg !46
  br label %47, !dbg !48

; <label>:47                                      ; preds = %37, %33, %25
  call void @__syncthreads(), !dbg !49
  %48 = load i32* %tid, align 4, !dbg !50
  %49 = icmp ult i32 %48, 32, !dbg !50
  br i1 %49, label %50, label %79, !dbg !50

; <label>:50                                      ; preds = %47
  %51 = load i32* %tid, align 4, !dbg !51
  %52 = add i32 %51, 128, !dbg !51
  %53 = zext i32 %52 to i64, !dbg !51
  %54 = getelementptr inbounds [256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jE6s_dist, i32 0, i64 %53, !dbg !51
  %55 = load i32* %54, align 4, !dbg !51
  %56 = load i32* %tid, align 4, !dbg !51
  %57 = zext i32 %56 to i64, !dbg !51
  %58 = getelementptr inbounds [256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jE6s_dist, i32 0, i64 %57, !dbg !51
  %59 = load i32* %58, align 4, !dbg !51
  %60 = icmp ult i32 %55, %59, !dbg !51
  br i1 %60, label %61, label %78, !dbg !51

; <label>:61                                      ; preds = %50
  %62 = load i32* %tid, align 4, !dbg !53
  %63 = add i32 %62, 128, !dbg !53
  %64 = zext i32 %63 to i64, !dbg !53
  %65 = getelementptr inbounds [256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jE6s_dist, i32 0, i64 %64, !dbg !53
  %66 = load i32* %65, align 4, !dbg !53
  %67 = load i32* %tid, align 4, !dbg !53
  %68 = zext i32 %67 to i64, !dbg !53
  %69 = getelementptr inbounds [256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jE6s_dist, i32 0, i64 %68, !dbg !53
  store i32 %66, i32* %69, align 4, !dbg !53
  %70 = load i32* %tid, align 4, !dbg !55
  %71 = add i32 %70, 128, !dbg !55
  %72 = zext i32 %71 to i64, !dbg !55
  %73 = getelementptr inbounds [256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jE5s_idx, i32 0, i64 %72, !dbg !55
  %74 = load i32* %73, align 4, !dbg !55
  %75 = load i32* %tid, align 4, !dbg !55
  %76 = zext i32 %75 to i64, !dbg !55
  %77 = getelementptr inbounds [256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jE5s_idx, i32 0, i64 %76, !dbg !55
  store i32 %74, i32* %77, align 4, !dbg !55
  br label %78, !dbg !56

; <label>:78                                      ; preds = %61, %50
  br label %79, !dbg !57

; <label>:79                                      ; preds = %78, %47
  call void @__syncthreads(), !dbg !58
  %80 = load i32* %tid, align 4, !dbg !59
  %81 = icmp ult i32 %80, 16, !dbg !59
  br i1 %81, label %82, label %111, !dbg !59

; <label>:82                                      ; preds = %79
  %83 = load i32* %tid, align 4, !dbg !60
  %84 = add i32 %83, 64, !dbg !60
  %85 = zext i32 %84 to i64, !dbg !60
  %86 = getelementptr inbounds [256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jE6s_dist, i32 0, i64 %85, !dbg !60
  %87 = load i32* %86, align 4, !dbg !60
  %88 = load i32* %tid, align 4, !dbg !60
  %89 = zext i32 %88 to i64, !dbg !60
  %90 = getelementptr inbounds [256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jE6s_dist, i32 0, i64 %89, !dbg !60
  %91 = load i32* %90, align 4, !dbg !60
  %92 = icmp ult i32 %87, %91, !dbg !60
  br i1 %92, label %93, label %110, !dbg !60

; <label>:93                                      ; preds = %82
  %94 = load i32* %tid, align 4, !dbg !62
  %95 = add i32 %94, 64, !dbg !62
  %96 = zext i32 %95 to i64, !dbg !62
  %97 = getelementptr inbounds [256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jE6s_dist, i32 0, i64 %96, !dbg !62
  %98 = load i32* %97, align 4, !dbg !62
  %99 = load i32* %tid, align 4, !dbg !62
  %100 = zext i32 %99 to i64, !dbg !62
  %101 = getelementptr inbounds [256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jE6s_dist, i32 0, i64 %100, !dbg !62
  store i32 %98, i32* %101, align 4, !dbg !62
  %102 = load i32* %tid, align 4, !dbg !64
  %103 = add i32 %102, 64, !dbg !64
  %104 = zext i32 %103 to i64, !dbg !64
  %105 = getelementptr inbounds [256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jE5s_idx, i32 0, i64 %104, !dbg !64
  %106 = load i32* %105, align 4, !dbg !64
  %107 = load i32* %tid, align 4, !dbg !64
  %108 = zext i32 %107 to i64, !dbg !64
  %109 = getelementptr inbounds [256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jE5s_idx, i32 0, i64 %108, !dbg !64
  store i32 %106, i32* %109, align 4, !dbg !64
  br label %110, !dbg !65

; <label>:110                                     ; preds = %93, %82
  br label %111, !dbg !66

; <label>:111                                     ; preds = %110, %79
  call void @__syncthreads(), !dbg !67
  %112 = load i32* %tid, align 4, !dbg !68
  %113 = icmp ult i32 %112, 8, !dbg !68
  br i1 %113, label %114, label %143, !dbg !68

; <label>:114                                     ; preds = %111
  %115 = load i32* %tid, align 4, !dbg !69
  %116 = add i32 %115, 32, !dbg !69
  %117 = zext i32 %116 to i64, !dbg !69
  %118 = getelementptr inbounds [256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jE6s_dist, i32 0, i64 %117, !dbg !69
  %119 = load i32* %118, align 4, !dbg !69
  %120 = load i32* %tid, align 4, !dbg !69
  %121 = zext i32 %120 to i64, !dbg !69
  %122 = getelementptr inbounds [256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jE6s_dist, i32 0, i64 %121, !dbg !69
  %123 = load i32* %122, align 4, !dbg !69
  %124 = icmp ult i32 %119, %123, !dbg !69
  br i1 %124, label %125, label %142, !dbg !69

; <label>:125                                     ; preds = %114
  %126 = load i32* %tid, align 4, !dbg !71
  %127 = add i32 %126, 32, !dbg !71
  %128 = zext i32 %127 to i64, !dbg !71
  %129 = getelementptr inbounds [256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jE6s_dist, i32 0, i64 %128, !dbg !71
  %130 = load i32* %129, align 4, !dbg !71
  %131 = load i32* %tid, align 4, !dbg !71
  %132 = zext i32 %131 to i64, !dbg !71
  %133 = getelementptr inbounds [256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jE6s_dist, i32 0, i64 %132, !dbg !71
  store i32 %130, i32* %133, align 4, !dbg !71
  %134 = load i32* %tid, align 4, !dbg !73
  %135 = add i32 %134, 32, !dbg !73
  %136 = zext i32 %135 to i64, !dbg !73
  %137 = getelementptr inbounds [256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jE5s_idx, i32 0, i64 %136, !dbg !73
  %138 = load i32* %137, align 4, !dbg !73
  %139 = load i32* %tid, align 4, !dbg !73
  %140 = zext i32 %139 to i64, !dbg !73
  %141 = getelementptr inbounds [256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jE5s_idx, i32 0, i64 %140, !dbg !73
  store i32 %138, i32* %141, align 4, !dbg !73
  br label %142, !dbg !74

; <label>:142                                     ; preds = %125, %114
  br label %143, !dbg !75

; <label>:143                                     ; preds = %142, %111
  call void @__syncthreads(), !dbg !76
  %144 = load i32* %f, align 4, !dbg !77
  %145 = load i32* %ntrain, align 4, !dbg !77
  %146 = icmp ult i32 %144, %145, !dbg !77
  br i1 %146, label %147, label %166, !dbg !77

; <label>:147                                     ; preds = %143
  %148 = load i32* getelementptr inbounds ([256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jE6s_dist, i32 0, i64 0), align 4, !dbg !78
  %149 = load i32* %j, align 4, !dbg !78
  %150 = load i32* getelementptr inbounds (%struct.dim3* @gridDim, i32 0, i32 0), align 4, !dbg !78
  %151 = mul i32 %149, %150, !dbg !78
  %152 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 0), align 4, !dbg !78
  %153 = add i32 %151, %152, !dbg !78
  %154 = zext i32 %153 to i64, !dbg !78
  %155 = load i32** %1, align 8, !dbg !78
  %156 = getelementptr inbounds i32* %155, i64 %154, !dbg !78
  store i32 %148, i32* %156, align 4, !dbg !78
  %157 = load i32* getelementptr inbounds ([256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jE5s_idx, i32 0, i64 0), align 4, !dbg !80
  %158 = load i32* %j, align 4, !dbg !80
  %159 = load i32* getelementptr inbounds (%struct.dim3* @gridDim, i32 0, i32 0), align 4, !dbg !80
  %160 = mul i32 %158, %159, !dbg !80
  %161 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 0), align 4, !dbg !80
  %162 = add i32 %160, %161, !dbg !80
  %163 = zext i32 %162 to i64, !dbg !80
  %164 = load i32** %2, align 8, !dbg !80
  %165 = getelementptr inbounds i32* %164, i64 %163, !dbg !80
  store i32 %157, i32* %165, align 4, !dbg !80
  br label %166, !dbg !81

; <label>:166                                     ; preds = %147, %143
  br label %167, !dbg !82

; <label>:167                                     ; preds = %166
  %168 = load i32* %j, align 4, !dbg !42
  %169 = add i32 %168, 1, !dbg !42
  store i32 %169, i32* %j, align 4, !dbg !42
  br label %21, !dbg !42

; <label>:170                                     ; preds = %21
  ret void, !dbg !83
}

declare void @llvm.dbg.declare(metadata, metadata) nounwind readnone

declare void @__syncthreads() section "__device__"

!llvm.dbg.cu = !{!0}

!0 = metadata !{i32 786449, i32 0, i32 4, metadata !"hamming1.cpp", metadata !"/home/mingyuanwu/arrayfire-repair", metadata !"clang version 3.2 (tags/RELEASE_32/final)", i1 true, i1 false, metadata !"", i32 0, metadata !1, metadata !1, metadata !3, metadata !12} ; [ DW_TAG_compile_unit ] [/home/mingyuanwu/arrayfire-repair/hamming1.cpp] [DW_LANG_C_plus_plus]
!1 = metadata !{metadata !2}
!2 = metadata !{i32 0}
!3 = metadata !{metadata !4}
!4 = metadata !{metadata !5}
!5 = metadata !{i32 786478, i32 0, metadata !6, metadata !"hamming_matcher_unroll", metadata !"hamming_matcher_unroll", metadata !"_Z22hamming_matcher_unrollPjS_j", metadata !6, i32 3, metadata !7, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, void (i32*, i32*, i32)* @_Z22hamming_matcher_unrollPjS_j, null, null, metadata !1, i32 7} ; [ DW_TAG_subprogram ] [line 3] [def] [scope 7] [hamming_matcher_unroll]
!6 = metadata !{i32 786473, metadata !"hamming1.cpp", metadata !"/home/mingyuanwu/arrayfire-repair", null} ; [ DW_TAG_file_type ]
!7 = metadata !{i32 786453, i32 0, metadata !"", i32 0, i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !8, i32 0, i32 0} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!8 = metadata !{null, metadata !9, metadata !9, metadata !11}
!9 = metadata !{i32 786447, null, metadata !"", null, i32 0, i64 64, i64 64, i64 0, i32 0, metadata !10} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from unsigned int]
!10 = metadata !{i32 786468, null, metadata !"unsigned int", null, i32 0, i64 32, i64 32, i64 0, i32 0, i32 7} ; [ DW_TAG_base_type ] [unsigned int] [line 0, size 32, align 32, offset 0, enc DW_ATE_unsigned]
!11 = metadata !{i32 786470, null, metadata !"", null, i32 0, i64 0, i64 0, i64 0, i32 0, metadata !10} ; [ DW_TAG_const_type ] [line 0, size 0, align 0, offset 0] [from unsigned int]
!12 = metadata !{metadata !13}
!13 = metadata !{metadata !14, metadata !18}
!14 = metadata !{i32 786484, i32 0, metadata !5, metadata !"s_dist", metadata !"s_dist", metadata !"", metadata !6, i32 14, metadata !15, i32 1, i32 1, [256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jE6s_dist} ; [ DW_TAG_variable ] [s_dist] [line 14] [local] [def]
!15 = metadata !{i32 786433, null, metadata !"", null, i32 0, i64 8192, i64 32, i32 0, i32 0, metadata !10, metadata !16, i32 0, i32 0} ; [ DW_TAG_array_type ] [line 0, size 8192, align 32, offset 0] [from unsigned int]
!16 = metadata !{metadata !17}
!17 = metadata !{i32 786465, i64 0, i64 255}      ; [ DW_TAG_subrange_type ] [0, 255]
!18 = metadata !{i32 786484, i32 0, metadata !5, metadata !"s_idx", metadata !"s_idx", metadata !"", metadata !6, i32 15, metadata !15, i32 1, i32 1, [256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jE5s_idx} ; [ DW_TAG_variable ] [s_idx] [line 15] [local] [def]
!19 = metadata !{i32 786689, metadata !5, metadata !"out_idx", metadata !6, i32 16777220, metadata !9, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [out_idx] [line 4]
!20 = metadata !{i32 4, i32 0, metadata !5, null}
!21 = metadata !{i32 786689, metadata !5, metadata !"out_dist", metadata !6, i32 33554437, metadata !9, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [out_dist] [line 5]
!22 = metadata !{i32 5, i32 0, metadata !5, null}
!23 = metadata !{i32 786689, metadata !5, metadata !"max_dist", metadata !6, i32 50331654, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [max_dist] [line 6]
!24 = metadata !{i32 6, i32 0, metadata !5, null}
!25 = metadata !{i32 786688, metadata !26, metadata !"f", metadata !6, i32 10, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [f] [line 10]
!26 = metadata !{i32 786443, metadata !5, i32 7, i32 0, metadata !6, i32 0} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire-repair/hamming1.cpp]
!27 = metadata !{i32 10, i32 0, metadata !26, null}
!28 = metadata !{i32 786688, metadata !26, metadata !"tid", metadata !6, i32 11, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [tid] [line 11]
!29 = metadata !{i32 11, i32 0, metadata !26, null}
!30 = metadata !{i32 786688, metadata !26, metadata !"feat_len", metadata !6, i32 12, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [feat_len] [line 12]
!31 = metadata !{i32 12, i32 0, metadata !26, null}
!32 = metadata !{i32 786688, metadata !26, metadata !"nquery", metadata !6, i32 12, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [nquery] [line 12]
!33 = metadata !{i32 17, i32 0, metadata !26, null}
!34 = metadata !{i32 18, i32 0, metadata !26, null}
!35 = metadata !{i32 786688, metadata !26, metadata !"ntrain", metadata !6, i32 19, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [ntrain] [line 19]
!36 = metadata !{i32 19, i32 0, metadata !26, null}
!37 = metadata !{i32 786688, metadata !26, metadata !"valid_feat", metadata !6, i32 20, metadata !38, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [valid_feat] [line 20]
!38 = metadata !{i32 786468, null, metadata !"bool", null, i32 0, i64 8, i64 8, i64 0, i32 0, i32 2} ; [ DW_TAG_base_type ] [bool] [line 0, size 8, align 8, offset 0, enc DW_ATE_boolean]
!39 = metadata !{i32 20, i32 0, metadata !26, null}
!40 = metadata !{i32 786688, metadata !41, metadata !"j", metadata !6, i32 23, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [j] [line 23]
!41 = metadata !{i32 786443, metadata !26, i32 23, i32 0, metadata !6, i32 1} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire-repair/hamming1.cpp]
!42 = metadata !{i32 23, i32 0, metadata !41, null}
!43 = metadata !{i32 24, i32 0, metadata !44, null}
!44 = metadata !{i32 786443, metadata !41, i32 23, i32 0, metadata !6, i32 2} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire-repair/hamming1.cpp]
!45 = metadata !{i32 28, i32 0, metadata !44, null}
!46 = metadata !{i32 29, i32 0, metadata !47, null}
!47 = metadata !{i32 786443, metadata !44, i32 28, i32 0, metadata !6, i32 3} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire-repair/hamming1.cpp]
!48 = metadata !{i32 30, i32 0, metadata !47, null}
!49 = metadata !{i32 31, i32 0, metadata !44, null}
!50 = metadata !{i32 36, i32 0, metadata !44, null}
!51 = metadata !{i32 37, i32 0, metadata !52, null}
!52 = metadata !{i32 786443, metadata !44, i32 36, i32 0, metadata !6, i32 4} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire-repair/hamming1.cpp]
!53 = metadata !{i32 38, i32 0, metadata !54, null}
!54 = metadata !{i32 786443, metadata !52, i32 37, i32 0, metadata !6, i32 5} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire-repair/hamming1.cpp]
!55 = metadata !{i32 39, i32 0, metadata !54, null}
!56 = metadata !{i32 40, i32 0, metadata !54, null}
!57 = metadata !{i32 41, i32 0, metadata !52, null}
!58 = metadata !{i32 42, i32 0, metadata !44, null}
!59 = metadata !{i32 43, i32 0, metadata !44, null}
!60 = metadata !{i32 44, i32 0, metadata !61, null}
!61 = metadata !{i32 786443, metadata !44, i32 43, i32 0, metadata !6, i32 6} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire-repair/hamming1.cpp]
!62 = metadata !{i32 45, i32 0, metadata !63, null}
!63 = metadata !{i32 786443, metadata !61, i32 44, i32 0, metadata !6, i32 7} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire-repair/hamming1.cpp]
!64 = metadata !{i32 46, i32 0, metadata !63, null}
!65 = metadata !{i32 47, i32 0, metadata !63, null}
!66 = metadata !{i32 48, i32 0, metadata !61, null}
!67 = metadata !{i32 49, i32 0, metadata !44, null}
!68 = metadata !{i32 50, i32 0, metadata !44, null}
!69 = metadata !{i32 51, i32 0, metadata !70, null}
!70 = metadata !{i32 786443, metadata !44, i32 50, i32 0, metadata !6, i32 8} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire-repair/hamming1.cpp]
!71 = metadata !{i32 52, i32 0, metadata !72, null}
!72 = metadata !{i32 786443, metadata !70, i32 51, i32 0, metadata !6, i32 9} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire-repair/hamming1.cpp]
!73 = metadata !{i32 53, i32 0, metadata !72, null}
!74 = metadata !{i32 54, i32 0, metadata !72, null}
!75 = metadata !{i32 55, i32 0, metadata !70, null}
!76 = metadata !{i32 56, i32 0, metadata !44, null}
!77 = metadata !{i32 60, i32 0, metadata !44, null}
!78 = metadata !{i32 61, i32 0, metadata !79, null}
!79 = metadata !{i32 786443, metadata !44, i32 60, i32 0, metadata !6, i32 10} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire-repair/hamming1.cpp]
!80 = metadata !{i32 62, i32 0, metadata !79, null}
!81 = metadata !{i32 63, i32 0, metadata !79, null}
!82 = metadata !{i32 64, i32 0, metadata !44, null}
!83 = metadata !{i32 65, i32 0, metadata !26, null}
