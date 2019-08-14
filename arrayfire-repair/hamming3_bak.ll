; ModuleID = 'hamming3_bak'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.dim3 = type { i32, i32, i32 }

@blockDim = external global %struct.dim3
@blockIdx = external global %struct.dim3
@threadIdx = external global %struct.dim3
@_ZZ15hamming_matcherPjS_jjE6s_dist = internal global [256 x i32] zeroinitializer, section "__shared__", align 16
@_ZZ15hamming_matcherPjS_jjE5s_idx = internal global [256 x i32] zeroinitializer, section "__shared__", align 16
@gridDim = external global %struct.dim3

define void @_Z15hamming_matcherPjS_jj(i32* %out_idx, i32* %out_dist, i32 %max_dist, i32 %feat_len) uwtable noinline {
  %1 = alloca i32*, align 8
  %2 = alloca i32*, align 8
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %nquery = alloca i32, align 4
  %ntrain = alloca i32, align 4
  %f = alloca i32, align 4
  %tid = alloca i32, align 4
  %valid_feat = alloca i8, align 1
  %j = alloca i32, align 4
  %dist = alloca i32, align 4
  store i32* %out_idx, i32** %1, align 8
  call void @llvm.dbg.declare(metadata !{i32** %1}, metadata !19), !dbg !20
  store i32* %out_dist, i32** %2, align 8
  call void @llvm.dbg.declare(metadata !{i32** %2}, metadata !21), !dbg !22
  store i32 %max_dist, i32* %3, align 4
  call void @llvm.dbg.declare(metadata !{i32* %3}, metadata !23), !dbg !24
  store i32 %feat_len, i32* %4, align 4
  call void @llvm.dbg.declare(metadata !{i32* %4}, metadata !25), !dbg !26
  call void @llvm.dbg.declare(metadata !{i32* %nquery}, metadata !27), !dbg !29
  store i32 6, i32* %nquery, align 4, !dbg !29
  call void @llvm.dbg.declare(metadata !{i32* %ntrain}, metadata !30), !dbg !31
  store i32 6, i32* %ntrain, align 4, !dbg !31
  call void @llvm.dbg.declare(metadata !{i32* %f}, metadata !32), !dbg !33
  %5 = load i32* getelementptr inbounds (%struct.dim3* @blockDim, i32 0, i32 0), align 4, !dbg !33
  %6 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 0), align 4, !dbg !33
  %7 = mul i32 %5, %6, !dbg !33
  %8 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !33
  %9 = add i32 %7, %8, !dbg !33
  store i32 %9, i32* %f, align 4, !dbg !33
  call void @llvm.dbg.declare(metadata !{i32* %tid}, metadata !34), !dbg !35
  %10 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !35
  store i32 %10, i32* %tid, align 4, !dbg !35
  %11 = load i32* %3, align 4, !dbg !36
  %12 = load i32* %tid, align 4, !dbg !36
  %13 = zext i32 %12 to i64, !dbg !36
  %14 = getelementptr inbounds [256 x i32]* @_ZZ15hamming_matcherPjS_jjE6s_dist, i32 0, i64 %13, !dbg !36
  store i32 %11, i32* %14, align 4, !dbg !36
  %15 = load i32* %tid, align 4, !dbg !37
  %16 = zext i32 %15 to i64, !dbg !37
  %17 = getelementptr inbounds [256 x i32]* @_ZZ15hamming_matcherPjS_jjE5s_idx, i32 0, i64 %16, !dbg !37
  store i32 -1, i32* %17, align 4, !dbg !37
  call void @llvm.dbg.declare(metadata !{i8* %valid_feat}, metadata !38), !dbg !40
  %18 = load i32* %f, align 4, !dbg !40
  %19 = load i32* %ntrain, align 4, !dbg !40
  %20 = icmp ult i32 %18, %19, !dbg !40
  %21 = zext i1 %20 to i8, !dbg !40
  store i8 %21, i8* %valid_feat, align 1, !dbg !40
  call void @llvm.dbg.declare(metadata !{i32* %j}, metadata !41), !dbg !43
  store i32 0, i32* %j, align 4, !dbg !43
  br label %22, !dbg !43

; <label>:22                                      ; preds = %132, %0
  %23 = load i32* %j, align 4, !dbg !43
  %24 = load i32* %nquery, align 4, !dbg !43
  %25 = icmp ult i32 %23, %24, !dbg !43
  br i1 %25, label %26, label %135, !dbg !43

; <label>:26                                      ; preds = %22
  %27 = load i32* %3, align 4, !dbg !44
  %28 = load i32* %tid, align 4, !dbg !44
  %29 = zext i32 %28 to i64, !dbg !44
  %30 = getelementptr inbounds [256 x i32]* @_ZZ15hamming_matcherPjS_jjE6s_dist, i32 0, i64 %29, !dbg !44
  store i32 %27, i32* %30, align 4, !dbg !44
  %31 = load i32* %tid, align 4, !dbg !46
  %32 = load i32* %4, align 4, !dbg !46
  %33 = icmp ult i32 %31, %32, !dbg !46
  br i1 %33, label %34, label %48, !dbg !46

; <label>:34                                      ; preds = %26
  %35 = load i32* %f, align 4, !dbg !46
  %36 = load i32* %ntrain, align 4, !dbg !46
  %37 = icmp ult i32 %35, %36, !dbg !46
  br i1 %37, label %38, label %48, !dbg !46

; <label>:38                                      ; preds = %34
  %39 = load i32* %tid, align 4, !dbg !47
  %40 = load i32* %nquery, align 4, !dbg !47
  %41 = mul i32 %39, %40, !dbg !47
  %42 = load i32* %j, align 4, !dbg !47
  %43 = add i32 %41, %42, !dbg !47
  %44 = load i32* %tid, align 4, !dbg !47
  %45 = zext i32 %44 to i64, !dbg !47
  %46 = load i32** %2, align 8, !dbg !47
  %47 = getelementptr inbounds i32* %46, i64 %45, !dbg !47
  store i32 %43, i32* %47, align 4, !dbg !47
  br label %48, !dbg !49

; <label>:48                                      ; preds = %38, %34, %26
  call void @__syncthreads(), !dbg !50
  call void @llvm.dbg.declare(metadata !{i32* %dist}, metadata !51), !dbg !52
  store i32 0, i32* %dist, align 4, !dbg !52
  %49 = load i32* %tid, align 4, !dbg !53
  %50 = icmp ult i32 %49, 8, !dbg !53
  br i1 %50, label %51, label %108, !dbg !53

; <label>:51                                      ; preds = %48
  %52 = load i32* %tid, align 4, !dbg !54
  %53 = add i32 %52, 16, !dbg !54
  %54 = zext i32 %53 to i64, !dbg !54
  %55 = getelementptr inbounds [256 x i32]* @_ZZ15hamming_matcherPjS_jjE6s_dist, i32 0, i64 %54, !dbg !54
  %56 = load i32* %55, align 4, !dbg !54
  %57 = load i32* %tid, align 4, !dbg !54
  %58 = zext i32 %57 to i64, !dbg !54
  %59 = getelementptr inbounds [256 x i32]* @_ZZ15hamming_matcherPjS_jjE6s_dist, i32 0, i64 %58, !dbg !54
  %60 = load i32* %59, align 4, !dbg !54
  %61 = icmp ult i32 %56, %60, !dbg !54
  br i1 %61, label %62, label %79, !dbg !54

; <label>:62                                      ; preds = %51
  %63 = load i32* %tid, align 4, !dbg !56
  %64 = add i32 %63, 32, !dbg !56
  %65 = zext i32 %64 to i64, !dbg !56
  %66 = getelementptr inbounds [256 x i32]* @_ZZ15hamming_matcherPjS_jjE6s_dist, i32 0, i64 %65, !dbg !56
  %67 = load i32* %66, align 4, !dbg !56
  %68 = load i32* %tid, align 4, !dbg !56
  %69 = zext i32 %68 to i64, !dbg !56
  %70 = getelementptr inbounds [256 x i32]* @_ZZ15hamming_matcherPjS_jjE6s_dist, i32 0, i64 %69, !dbg !56
  store i32 %67, i32* %70, align 4, !dbg !56
  %71 = load i32* %tid, align 4, !dbg !58
  %72 = add i32 %71, 32, !dbg !58
  %73 = zext i32 %72 to i64, !dbg !58
  %74 = getelementptr inbounds [256 x i32]* @_ZZ15hamming_matcherPjS_jjE5s_idx, i32 0, i64 %73, !dbg !58
  %75 = load i32* %74, align 4, !dbg !58
  %76 = load i32* %tid, align 4, !dbg !58
  %77 = zext i32 %76 to i64, !dbg !58
  %78 = getelementptr inbounds [256 x i32]* @_ZZ15hamming_matcherPjS_jjE5s_idx, i32 0, i64 %77, !dbg !58
  store i32 %75, i32* %78, align 4, !dbg !58
  br label %79, !dbg !59

; <label>:79                                      ; preds = %62, %51
  %80 = load i32* %tid, align 4, !dbg !60
  %81 = add i32 %80, 4, !dbg !60
  %82 = zext i32 %81 to i64, !dbg !60
  %83 = getelementptr inbounds [256 x i32]* @_ZZ15hamming_matcherPjS_jjE6s_dist, i32 0, i64 %82, !dbg !60
  %84 = load i32* %83, align 4, !dbg !60
  %85 = load i32* %tid, align 4, !dbg !60
  %86 = zext i32 %85 to i64, !dbg !60
  %87 = getelementptr inbounds [256 x i32]* @_ZZ15hamming_matcherPjS_jjE6s_dist, i32 0, i64 %86, !dbg !60
  %88 = load i32* %87, align 4, !dbg !60
  %89 = icmp ult i32 %84, %88, !dbg !60
  br i1 %89, label %90, label %107, !dbg !60

; <label>:90                                      ; preds = %79
  %91 = load i32* %tid, align 4, !dbg !61
  %92 = add i32 %91, 4, !dbg !61
  %93 = zext i32 %92 to i64, !dbg !61
  %94 = getelementptr inbounds [256 x i32]* @_ZZ15hamming_matcherPjS_jjE6s_dist, i32 0, i64 %93, !dbg !61
  %95 = load i32* %94, align 4, !dbg !61
  %96 = load i32* %tid, align 4, !dbg !61
  %97 = zext i32 %96 to i64, !dbg !61
  %98 = getelementptr inbounds [256 x i32]* @_ZZ15hamming_matcherPjS_jjE6s_dist, i32 0, i64 %97, !dbg !61
  store i32 %95, i32* %98, align 4, !dbg !61
  %99 = load i32* %tid, align 4, !dbg !63
  %100 = add i32 %99, 4, !dbg !63
  %101 = zext i32 %100 to i64, !dbg !63
  %102 = getelementptr inbounds [256 x i32]* @_ZZ15hamming_matcherPjS_jjE5s_idx, i32 0, i64 %101, !dbg !63
  %103 = load i32* %102, align 4, !dbg !63
  %104 = load i32* %tid, align 4, !dbg !63
  %105 = zext i32 %104 to i64, !dbg !63
  %106 = getelementptr inbounds [256 x i32]* @_ZZ15hamming_matcherPjS_jjE5s_idx, i32 0, i64 %105, !dbg !63
  store i32 %103, i32* %106, align 4, !dbg !63
  br label %107, !dbg !64

; <label>:107                                     ; preds = %90, %79
  br label %108, !dbg !65

; <label>:108                                     ; preds = %107, %48
  call void @__syncthreads(), !dbg !66
  %109 = load i32* %f, align 4, !dbg !67
  %110 = load i32* %ntrain, align 4, !dbg !67
  %111 = icmp ult i32 %109, %110, !dbg !67
  br i1 %111, label %112, label %131, !dbg !67

; <label>:112                                     ; preds = %108
  %113 = load i32* getelementptr inbounds ([256 x i32]* @_ZZ15hamming_matcherPjS_jjE6s_dist, i32 0, i64 0), align 4, !dbg !68
  %114 = load i32* %j, align 4, !dbg !68
  %115 = load i32* getelementptr inbounds (%struct.dim3* @gridDim, i32 0, i32 0), align 4, !dbg !68
  %116 = mul i32 %114, %115, !dbg !68
  %117 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 0), align 4, !dbg !68
  %118 = add i32 %116, %117, !dbg !68
  %119 = zext i32 %118 to i64, !dbg !68
  %120 = load i32** %2, align 8, !dbg !68
  %121 = getelementptr inbounds i32* %120, i64 %119, !dbg !68
  store i32 %113, i32* %121, align 4, !dbg !68
  %122 = load i32* getelementptr inbounds ([256 x i32]* @_ZZ15hamming_matcherPjS_jjE5s_idx, i32 0, i64 0), align 4, !dbg !70
  %123 = load i32* %j, align 4, !dbg !70
  %124 = load i32* getelementptr inbounds (%struct.dim3* @gridDim, i32 0, i32 0), align 4, !dbg !70
  %125 = mul i32 %123, %124, !dbg !70
  %126 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 0), align 4, !dbg !70
  %127 = add i32 %125, %126, !dbg !70
  %128 = zext i32 %127 to i64, !dbg !70
  %129 = load i32** %1, align 8, !dbg !70
  %130 = getelementptr inbounds i32* %129, i64 %128, !dbg !70
  store i32 %122, i32* %130, align 4, !dbg !70
  br label %131, !dbg !71

; <label>:131                                     ; preds = %112, %108
  call void @__syncthreads(), !dbg !72
  br label %132, !dbg !73

; <label>:132                                     ; preds = %131
  %133 = load i32* %j, align 4, !dbg !43
  %134 = add i32 %133, 1, !dbg !43
  store i32 %134, i32* %j, align 4, !dbg !43
  br label %22, !dbg !43

; <label>:135                                     ; preds = %22
  ret void, !dbg !74
}

declare void @llvm.dbg.declare(metadata, metadata) nounwind readnone

declare void @__syncthreads() section "__device__"

!llvm.dbg.cu = !{!0}

!0 = metadata !{i32 786449, i32 0, i32 4, metadata !"hamming3_bak.cpp", metadata !"/home/mingyuanwu/arrayfire-repair", metadata !"clang version 3.2 (tags/RELEASE_32/final)", i1 true, i1 false, metadata !"", i32 0, metadata !1, metadata !1, metadata !3, metadata !12} ; [ DW_TAG_compile_unit ] [/home/mingyuanwu/arrayfire-repair/hamming3_bak.cpp] [DW_LANG_C_plus_plus]
!1 = metadata !{metadata !2}
!2 = metadata !{i32 0}
!3 = metadata !{metadata !4}
!4 = metadata !{metadata !5}
!5 = metadata !{i32 786478, i32 0, metadata !6, metadata !"hamming_matcher", metadata !"hamming_matcher", metadata !"_Z15hamming_matcherPjS_jj", metadata !6, i32 4, metadata !7, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, void (i32*, i32*, i32, i32)* @_Z15hamming_matcherPjS_jj, null, null, metadata !1, i32 9} ; [ DW_TAG_subprogram ] [line 4] [def] [scope 9] [hamming_matcher]
!6 = metadata !{i32 786473, metadata !"hamming3_bak.cpp", metadata !"/home/mingyuanwu/arrayfire-repair", null} ; [ DW_TAG_file_type ]
!7 = metadata !{i32 786453, i32 0, metadata !"", i32 0, i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !8, i32 0, i32 0} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!8 = metadata !{null, metadata !9, metadata !9, metadata !11, metadata !11}
!9 = metadata !{i32 786447, null, metadata !"", null, i32 0, i64 64, i64 64, i64 0, i32 0, metadata !10} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from unsigned int]
!10 = metadata !{i32 786468, null, metadata !"unsigned int", null, i32 0, i64 32, i64 32, i64 0, i32 0, i32 7} ; [ DW_TAG_base_type ] [unsigned int] [line 0, size 32, align 32, offset 0, enc DW_ATE_unsigned]
!11 = metadata !{i32 786470, null, metadata !"", null, i32 0, i64 0, i64 0, i64 0, i32 0, metadata !10} ; [ DW_TAG_const_type ] [line 0, size 0, align 0, offset 0] [from unsigned int]
!12 = metadata !{metadata !13}
!13 = metadata !{metadata !14, metadata !18}
!14 = metadata !{i32 786484, i32 0, metadata !5, metadata !"s_dist", metadata !"s_dist", metadata !"", metadata !6, i32 16, metadata !15, i32 1, i32 1, [256 x i32]* @_ZZ15hamming_matcherPjS_jjE6s_dist} ; [ DW_TAG_variable ] [s_dist] [line 16] [local] [def]
!15 = metadata !{i32 786433, null, metadata !"", null, i32 0, i64 8192, i64 32, i32 0, i32 0, metadata !10, metadata !16, i32 0, i32 0} ; [ DW_TAG_array_type ] [line 0, size 8192, align 32, offset 0] [from unsigned int]
!16 = metadata !{metadata !17}
!17 = metadata !{i32 786465, i64 0, i64 255}      ; [ DW_TAG_subrange_type ] [0, 255]
!18 = metadata !{i32 786484, i32 0, metadata !5, metadata !"s_idx", metadata !"s_idx", metadata !"", metadata !6, i32 17, metadata !15, i32 1, i32 1, [256 x i32]* @_ZZ15hamming_matcherPjS_jjE5s_idx} ; [ DW_TAG_variable ] [s_idx] [line 17] [local] [def]
!19 = metadata !{i32 786689, metadata !5, metadata !"out_idx", metadata !6, i32 16777221, metadata !9, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [out_idx] [line 5]
!20 = metadata !{i32 5, i32 0, metadata !5, null}
!21 = metadata !{i32 786689, metadata !5, metadata !"out_dist", metadata !6, i32 33554438, metadata !9, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [out_dist] [line 6]
!22 = metadata !{i32 6, i32 0, metadata !5, null}
!23 = metadata !{i32 786689, metadata !5, metadata !"max_dist", metadata !6, i32 50331655, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [max_dist] [line 7]
!24 = metadata !{i32 7, i32 0, metadata !5, null}
!25 = metadata !{i32 786689, metadata !5, metadata !"feat_len", metadata !6, i32 67108872, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [feat_len] [line 8]
!26 = metadata !{i32 8, i32 0, metadata !5, null}
!27 = metadata !{i32 786688, metadata !28, metadata !"nquery", metadata !6, i32 10, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [nquery] [line 10]
!28 = metadata !{i32 786443, metadata !5, i32 9, i32 0, metadata !6, i32 0} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire-repair/hamming3_bak.cpp]
!29 = metadata !{i32 10, i32 0, metadata !28, null}
!30 = metadata !{i32 786688, metadata !28, metadata !"ntrain", metadata !6, i32 11, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [ntrain] [line 11]
!31 = metadata !{i32 11, i32 0, metadata !28, null}
!32 = metadata !{i32 786688, metadata !28, metadata !"f", metadata !6, i32 13, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [f] [line 13]
!33 = metadata !{i32 13, i32 0, metadata !28, null}
!34 = metadata !{i32 786688, metadata !28, metadata !"tid", metadata !6, i32 14, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [tid] [line 14]
!35 = metadata !{i32 14, i32 0, metadata !28, null}
!36 = metadata !{i32 20, i32 0, metadata !28, null}
!37 = metadata !{i32 21, i32 0, metadata !28, null}
!38 = metadata !{i32 786688, metadata !28, metadata !"valid_feat", metadata !6, i32 23, metadata !39, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [valid_feat] [line 23]
!39 = metadata !{i32 786468, null, metadata !"bool", null, i32 0, i64 8, i64 8, i64 0, i32 0, i32 2} ; [ DW_TAG_base_type ] [bool] [line 0, size 8, align 8, offset 0, enc DW_ATE_boolean]
!40 = metadata !{i32 23, i32 0, metadata !28, null}
!41 = metadata !{i32 786688, metadata !42, metadata !"j", metadata !6, i32 25, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [j] [line 25]
!42 = metadata !{i32 786443, metadata !28, i32 25, i32 0, metadata !6, i32 1} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire-repair/hamming3_bak.cpp]
!43 = metadata !{i32 25, i32 0, metadata !42, null}
!44 = metadata !{i32 26, i32 0, metadata !45, null}
!45 = metadata !{i32 786443, metadata !42, i32 25, i32 0, metadata !6, i32 2} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire-repair/hamming3_bak.cpp]
!46 = metadata !{i32 30, i32 0, metadata !45, null}
!47 = metadata !{i32 31, i32 0, metadata !48, null}
!48 = metadata !{i32 786443, metadata !45, i32 30, i32 0, metadata !6, i32 3} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire-repair/hamming3_bak.cpp]
!49 = metadata !{i32 32, i32 0, metadata !48, null}
!50 = metadata !{i32 33, i32 0, metadata !45, null}
!51 = metadata !{i32 786688, metadata !45, metadata !"dist", metadata !6, i32 35, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [dist] [line 35]
!52 = metadata !{i32 35, i32 0, metadata !45, null}
!53 = metadata !{i32 37, i32 0, metadata !45, null}
!54 = metadata !{i32 38, i32 0, metadata !55, null}
!55 = metadata !{i32 786443, metadata !45, i32 37, i32 0, metadata !6, i32 4} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire-repair/hamming3_bak.cpp]
!56 = metadata !{i32 39, i32 0, metadata !57, null}
!57 = metadata !{i32 786443, metadata !55, i32 38, i32 0, metadata !6, i32 5} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire-repair/hamming3_bak.cpp]
!58 = metadata !{i32 40, i32 0, metadata !57, null}
!59 = metadata !{i32 41, i32 0, metadata !57, null}
!60 = metadata !{i32 42, i32 0, metadata !55, null}
!61 = metadata !{i32 43, i32 0, metadata !62, null}
!62 = metadata !{i32 786443, metadata !55, i32 42, i32 0, metadata !6, i32 6} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire-repair/hamming3_bak.cpp]
!63 = metadata !{i32 44, i32 0, metadata !62, null}
!64 = metadata !{i32 45, i32 0, metadata !62, null}
!65 = metadata !{i32 46, i32 0, metadata !55, null}
!66 = metadata !{i32 47, i32 0, metadata !45, null}
!67 = metadata !{i32 50, i32 0, metadata !45, null}
!68 = metadata !{i32 51, i32 0, metadata !69, null}
!69 = metadata !{i32 786443, metadata !45, i32 50, i32 0, metadata !6, i32 7} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire-repair/hamming3_bak.cpp]
!70 = metadata !{i32 52, i32 0, metadata !69, null}
!71 = metadata !{i32 53, i32 0, metadata !69, null}
!72 = metadata !{i32 54, i32 0, metadata !45, null}
!73 = metadata !{i32 55, i32 0, metadata !45, null}
!74 = metadata !{i32 56, i32 0, metadata !28, null}
