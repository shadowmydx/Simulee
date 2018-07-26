; ModuleID = 'arrayfire-Fix-syncthreads-in-cuda-nearest-neighbour'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.dim3 = type { i32, i32, i32 }

@blockIdx = external global %struct.dim3
@blockDim = external global %struct.dim3
@threadIdx = external global %struct.dim3
@_ZZ14select_matchesPjPiPKjPKijjiE6s_dist = internal global [256 x i32] zeroinitializer, section "__shared__", align 16
@_ZZ14select_matchesPjPiPKjPKijjiE5s_idx = internal global [256 x i32] zeroinitializer, section "__shared__", align 16

define void @_Z14select_matchesPjPiPKjPKijji(i32* %idx_ptr, i32* %dist_ptr, i32* %in_idx, i32* %in_dist, i32 %nfeat, i32 %nelem, i32 %max_dist) uwtable noinline {
  %1 = alloca i32*, align 8
  %2 = alloca i32*, align 8
  %3 = alloca i32*, align 8
  %4 = alloca i32*, align 8
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %f = alloca i32, align 4
  %sid = alloca i32, align 4
  %i = alloca i32, align 4
  %dist = alloca i32, align 4
  %i1 = alloca i32, align 4
  %dist2 = alloca i32, align 4
  store i32* %idx_ptr, i32** %1, align 8
  call void @llvm.dbg.declare(metadata !{i32** %1}, metadata !25), !dbg !26
  store i32* %dist_ptr, i32** %2, align 8
  call void @llvm.dbg.declare(metadata !{i32** %2}, metadata !27), !dbg !28
  store i32* %in_idx, i32** %3, align 8
  call void @llvm.dbg.declare(metadata !{i32** %3}, metadata !29), !dbg !30
  store i32* %in_dist, i32** %4, align 8
  call void @llvm.dbg.declare(metadata !{i32** %4}, metadata !31), !dbg !32
  store i32 %nfeat, i32* %5, align 4
  call void @llvm.dbg.declare(metadata !{i32* %5}, metadata !33), !dbg !34
  store i32 %nelem, i32* %6, align 4
  call void @llvm.dbg.declare(metadata !{i32* %6}, metadata !35), !dbg !36
  store i32 %max_dist, i32* %7, align 4
  call void @llvm.dbg.declare(metadata !{i32* %7}, metadata !37), !dbg !38
  call void @llvm.dbg.declare(metadata !{i32* %f}, metadata !39), !dbg !41
  %8 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 0), align 4, !dbg !41
  %9 = load i32* getelementptr inbounds (%struct.dim3* @blockDim, i32 0, i32 0), align 4, !dbg !41
  %10 = mul i32 %8, %9, !dbg !41
  %11 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !41
  %12 = add i32 %10, %11, !dbg !41
  store i32 %12, i32* %f, align 4, !dbg !41
  call void @llvm.dbg.declare(metadata !{i32* %sid}, metadata !42), !dbg !43
  %13 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !43
  %14 = load i32* getelementptr inbounds (%struct.dim3* @blockDim, i32 0, i32 1), align 4, !dbg !43
  %15 = mul i32 %13, %14, !dbg !43
  %16 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 1), align 4, !dbg !43
  %17 = add i32 %15, %16, !dbg !43
  store i32 %17, i32* %sid, align 4, !dbg !43
  %18 = load i32* %7, align 4, !dbg !44
  %19 = load i32* %sid, align 4, !dbg !44
  %20 = zext i32 %19 to i64, !dbg !44
  %21 = getelementptr inbounds [256 x i32]* @_ZZ14select_matchesPjPiPKjPKijjiE6s_dist, i32 0, i64 %20, !dbg !44
  store i32 %18, i32* %21, align 4, !dbg !44
  %22 = load i32* %f, align 4, !dbg !45
  %23 = load i32* %5, align 4, !dbg !45
  %24 = icmp ult i32 %22, %23, !dbg !45
  br i1 %24, label %25, label %70, !dbg !45

; <label>:25                                      ; preds = %0
  call void @llvm.dbg.declare(metadata !{i32* %i}, metadata !46), !dbg !49
  %26 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 1), align 4, !dbg !49
  store i32 %26, i32* %i, align 4, !dbg !49
  br label %27, !dbg !49

; <label>:27                                      ; preds = %65, %25
  %28 = load i32* %i, align 4, !dbg !49
  %29 = load i32* %6, align 4, !dbg !49
  %30 = icmp ult i32 %28, %29, !dbg !49
  br i1 %30, label %31, label %69, !dbg !49

; <label>:31                                      ; preds = %27
  call void @llvm.dbg.declare(metadata !{i32* %dist}, metadata !50), !dbg !52
  %32 = load i32* %f, align 4, !dbg !52
  %33 = load i32* %6, align 4, !dbg !52
  %34 = mul i32 %32, %33, !dbg !52
  %35 = load i32* %i, align 4, !dbg !52
  %36 = add i32 %34, %35, !dbg !52
  %37 = zext i32 %36 to i64, !dbg !52
  %38 = load i32** %4, align 8, !dbg !52
  %39 = getelementptr inbounds i32* %38, i64 %37, !dbg !52
  %40 = load i32* %39, align 4, !dbg !52
  store i32 %40, i32* %dist, align 4, !dbg !52
  %41 = load i32* %dist, align 4, !dbg !53
  %42 = load i32* %sid, align 4, !dbg !53
  %43 = zext i32 %42 to i64, !dbg !53
  %44 = getelementptr inbounds [256 x i32]* @_ZZ14select_matchesPjPiPKjPKijjiE6s_dist, i32 0, i64 %43, !dbg !53
  %45 = load i32* %44, align 4, !dbg !53
  %46 = icmp slt i32 %41, %45, !dbg !53
  br i1 %46, label %47, label %64, !dbg !53

; <label>:47                                      ; preds = %31
  %48 = load i32* %dist, align 4, !dbg !54
  %49 = load i32* %sid, align 4, !dbg !54
  %50 = zext i32 %49 to i64, !dbg !54
  %51 = getelementptr inbounds [256 x i32]* @_ZZ14select_matchesPjPiPKjPKijjiE6s_dist, i32 0, i64 %50, !dbg !54
  store i32 %48, i32* %51, align 4, !dbg !54
  %52 = load i32* %f, align 4, !dbg !56
  %53 = load i32* %6, align 4, !dbg !56
  %54 = mul i32 %52, %53, !dbg !56
  %55 = load i32* %i, align 4, !dbg !56
  %56 = add i32 %54, %55, !dbg !56
  %57 = zext i32 %56 to i64, !dbg !56
  %58 = load i32** %3, align 8, !dbg !56
  %59 = getelementptr inbounds i32* %58, i64 %57, !dbg !56
  %60 = load i32* %59, align 4, !dbg !56
  %61 = load i32* %sid, align 4, !dbg !56
  %62 = zext i32 %61 to i64, !dbg !56
  %63 = getelementptr inbounds [256 x i32]* @_ZZ14select_matchesPjPiPKjPKijjiE5s_idx, i32 0, i64 %62, !dbg !56
  store i32 %60, i32* %63, align 4, !dbg !56
  br label %64, !dbg !57

; <label>:64                                      ; preds = %47, %31
  br label %65, !dbg !58

; <label>:65                                      ; preds = %64
  %66 = load i32* getelementptr inbounds (%struct.dim3* @blockDim, i32 0, i32 1), align 4, !dbg !49
  %67 = load i32* %i, align 4, !dbg !49
  %68 = add i32 %67, %66, !dbg !49
  store i32 %68, i32* %i, align 4, !dbg !49
  br label %27, !dbg !49

; <label>:69                                      ; preds = %27
  br label %70, !dbg !59

; <label>:70                                      ; preds = %69, %0
  call void @__syncthreads(), !dbg !60
  call void @llvm.dbg.declare(metadata !{i32* %i1}, metadata !61), !dbg !63
  %71 = load i32* getelementptr inbounds (%struct.dim3* @blockDim, i32 0, i32 1), align 4, !dbg !63
  %72 = udiv i32 %71, 2, !dbg !63
  store i32 %72, i32* %i1, align 4, !dbg !63
  br label %73, !dbg !63

; <label>:73                                      ; preds = %109, %70
  %74 = load i32* %i1, align 4, !dbg !63
  %75 = icmp ugt i32 %74, 0, !dbg !63
  br i1 %75, label %76, label %112, !dbg !63

; <label>:76                                      ; preds = %73
  %77 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 1), align 4, !dbg !64
  %78 = load i32* %i1, align 4, !dbg !64
  %79 = icmp ult i32 %77, %78, !dbg !64
  br i1 %79, label %80, label %108, !dbg !64

; <label>:80                                      ; preds = %76
  call void @llvm.dbg.declare(metadata !{i32* %dist2}, metadata !66), !dbg !68
  %81 = load i32* %sid, align 4, !dbg !68
  %82 = load i32* %i1, align 4, !dbg !68
  %83 = add i32 %81, %82, !dbg !68
  %84 = zext i32 %83 to i64, !dbg !68
  %85 = getelementptr inbounds [256 x i32]* @_ZZ14select_matchesPjPiPKjPKijjiE6s_dist, i32 0, i64 %84, !dbg !68
  %86 = load i32* %85, align 4, !dbg !68
  store i32 %86, i32* %dist2, align 4, !dbg !68
  %87 = load i32* %dist2, align 4, !dbg !69
  %88 = load i32* %sid, align 4, !dbg !69
  %89 = zext i32 %88 to i64, !dbg !69
  %90 = getelementptr inbounds [256 x i32]* @_ZZ14select_matchesPjPiPKjPKijjiE6s_dist, i32 0, i64 %89, !dbg !69
  %91 = load i32* %90, align 4, !dbg !69
  %92 = icmp slt i32 %87, %91, !dbg !69
  br i1 %92, label %93, label %107, !dbg !69

; <label>:93                                      ; preds = %80
  %94 = load i32* %dist2, align 4, !dbg !70
  %95 = load i32* %sid, align 4, !dbg !70
  %96 = zext i32 %95 to i64, !dbg !70
  %97 = getelementptr inbounds [256 x i32]* @_ZZ14select_matchesPjPiPKjPKijjiE6s_dist, i32 0, i64 %96, !dbg !70
  store i32 %94, i32* %97, align 4, !dbg !70
  %98 = load i32* %sid, align 4, !dbg !72
  %99 = load i32* %i1, align 4, !dbg !72
  %100 = add i32 %98, %99, !dbg !72
  %101 = zext i32 %100 to i64, !dbg !72
  %102 = getelementptr inbounds [256 x i32]* @_ZZ14select_matchesPjPiPKjPKijjiE5s_idx, i32 0, i64 %101, !dbg !72
  %103 = load i32* %102, align 4, !dbg !72
  %104 = load i32* %sid, align 4, !dbg !72
  %105 = zext i32 %104 to i64, !dbg !72
  %106 = getelementptr inbounds [256 x i32]* @_ZZ14select_matchesPjPiPKjPKijjiE5s_idx, i32 0, i64 %105, !dbg !72
  store i32 %103, i32* %106, align 4, !dbg !72
  br label %107, !dbg !73

; <label>:107                                     ; preds = %93, %80
  call void @__syncthreads(), !dbg !74
  br label %108, !dbg !75

; <label>:108                                     ; preds = %107, %76
  br label %109, !dbg !76

; <label>:109                                     ; preds = %108
  %110 = load i32* %i1, align 4, !dbg !63
  %111 = lshr i32 %110, 1, !dbg !63
  store i32 %111, i32* %i1, align 4, !dbg !63
  br label %73, !dbg !63

; <label>:112                                     ; preds = %73
  %113 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 1), align 4, !dbg !77
  %114 = icmp eq i32 %113, 0, !dbg !77
  br i1 %114, label %115, label %140, !dbg !77

; <label>:115                                     ; preds = %112
  %116 = load i32* %f, align 4, !dbg !77
  %117 = load i32* %5, align 4, !dbg !77
  %118 = icmp ult i32 %116, %117, !dbg !77
  br i1 %118, label %119, label %140, !dbg !77

; <label>:119                                     ; preds = %115
  %120 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !78
  %121 = load i32* getelementptr inbounds (%struct.dim3* @blockDim, i32 0, i32 1), align 4, !dbg !78
  %122 = mul i32 %120, %121, !dbg !78
  %123 = zext i32 %122 to i64, !dbg !78
  %124 = getelementptr inbounds [256 x i32]* @_ZZ14select_matchesPjPiPKjPKijjiE6s_dist, i32 0, i64 %123, !dbg !78
  %125 = load i32* %124, align 4, !dbg !78
  %126 = load i32* %f, align 4, !dbg !78
  %127 = zext i32 %126 to i64, !dbg !78
  %128 = load i32** %2, align 8, !dbg !78
  %129 = getelementptr inbounds i32* %128, i64 %127, !dbg !78
  store i32 %125, i32* %129, align 4, !dbg !78
  %130 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !80
  %131 = load i32* getelementptr inbounds (%struct.dim3* @blockDim, i32 0, i32 1), align 4, !dbg !80
  %132 = mul i32 %130, %131, !dbg !80
  %133 = zext i32 %132 to i64, !dbg !80
  %134 = getelementptr inbounds [256 x i32]* @_ZZ14select_matchesPjPiPKjPKijjiE5s_idx, i32 0, i64 %133, !dbg !80
  %135 = load i32* %134, align 4, !dbg !80
  %136 = load i32* %f, align 4, !dbg !80
  %137 = zext i32 %136 to i64, !dbg !80
  %138 = load i32** %1, align 8, !dbg !80
  %139 = getelementptr inbounds i32* %138, i64 %137, !dbg !80
  store i32 %135, i32* %139, align 4, !dbg !80
  br label %140, !dbg !81

; <label>:140                                     ; preds = %119, %115, %112
  ret void, !dbg !82
}

declare void @llvm.dbg.declare(metadata, metadata) nounwind readnone

declare void @__syncthreads() section "__device__"

!llvm.dbg.cu = !{!0}

!0 = metadata !{i32 786449, i32 0, i32 4, metadata !"arrayfire-Fix-syncthreads-in-cuda-nearest-neighbour.cpp", metadata !"/home/mingyuanwu", metadata !"clang version 3.2 (tags/RELEASE_32/final)", i1 true, i1 false, metadata !"", i32 0, metadata !1, metadata !1, metadata !3, metadata !17} ; [ DW_TAG_compile_unit ] [/home/mingyuanwu/arrayfire-Fix-syncthreads-in-cuda-nearest-neighbour.cpp] [DW_LANG_C_plus_plus]
!1 = metadata !{metadata !2}
!2 = metadata !{i32 0}
!3 = metadata !{metadata !4}
!4 = metadata !{metadata !5}
!5 = metadata !{i32 786478, i32 0, metadata !6, metadata !"select_matches", metadata !"select_matches", metadata !"_Z14select_matchesPjPiPKjPKijji", metadata !6, i32 3, metadata !7, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, void (i32*, i32*, i32*, i32*, i32, i32, i32)* @_Z14select_matchesPjPiPKjPKijji, null, null, metadata !1, i32 11} ; [ DW_TAG_subprogram ] [line 3] [def] [scope 11] [select_matches]
!6 = metadata !{i32 786473, metadata !"arrayfire-Fix-syncthreads-in-cuda-nearest-neighbour.cpp", metadata !"/home/mingyuanwu", null} ; [ DW_TAG_file_type ]
!7 = metadata !{i32 786453, i32 0, metadata !"", i32 0, i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !8, i32 0, i32 0} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!8 = metadata !{null, metadata !9, metadata !11, metadata !13, metadata !15, metadata !14, metadata !14, metadata !16}
!9 = metadata !{i32 786447, null, metadata !"", null, i32 0, i64 64, i64 64, i64 0, i32 0, metadata !10} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from unsigned int]
!10 = metadata !{i32 786468, null, metadata !"unsigned int", null, i32 0, i64 32, i64 32, i64 0, i32 0, i32 7} ; [ DW_TAG_base_type ] [unsigned int] [line 0, size 32, align 32, offset 0, enc DW_ATE_unsigned]
!11 = metadata !{i32 786447, null, metadata !"", null, i32 0, i64 64, i64 64, i64 0, i32 0, metadata !12} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from int]
!12 = metadata !{i32 786468, null, metadata !"int", null, i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!13 = metadata !{i32 786447, null, metadata !"", null, i32 0, i64 64, i64 64, i64 0, i32 0, metadata !14} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from ]
!14 = metadata !{i32 786470, null, metadata !"", null, i32 0, i64 0, i64 0, i64 0, i32 0, metadata !10} ; [ DW_TAG_const_type ] [line 0, size 0, align 0, offset 0] [from unsigned int]
!15 = metadata !{i32 786447, null, metadata !"", null, i32 0, i64 64, i64 64, i64 0, i32 0, metadata !16} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from ]
!16 = metadata !{i32 786470, null, metadata !"", null, i32 0, i64 0, i64 0, i64 0, i32 0, metadata !12} ; [ DW_TAG_const_type ] [line 0, size 0, align 0, offset 0] [from int]
!17 = metadata !{metadata !18}
!18 = metadata !{metadata !19, metadata !23}
!19 = metadata !{i32 786484, i32 0, metadata !5, metadata !"s_dist", metadata !"s_dist", metadata !"", metadata !6, i32 15, metadata !20, i32 1, i32 1, [256 x i32]* @_ZZ14select_matchesPjPiPKjPKijjiE6s_dist} ; [ DW_TAG_variable ] [s_dist] [line 15] [local] [def]
!20 = metadata !{i32 786433, null, metadata !"", null, i32 0, i64 8192, i64 32, i32 0, i32 0, metadata !12, metadata !21, i32 0, i32 0} ; [ DW_TAG_array_type ] [line 0, size 8192, align 32, offset 0] [from int]
!21 = metadata !{metadata !22}
!22 = metadata !{i32 786465, i64 0, i64 255}      ; [ DW_TAG_subrange_type ] [0, 255]
!23 = metadata !{i32 786484, i32 0, metadata !5, metadata !"s_idx", metadata !"s_idx", metadata !"", metadata !6, i32 16, metadata !24, i32 1, i32 1, [256 x i32]* @_ZZ14select_matchesPjPiPKjPKijjiE5s_idx} ; [ DW_TAG_variable ] [s_idx] [line 16] [local] [def]
!24 = metadata !{i32 786433, null, metadata !"", null, i32 0, i64 8192, i64 32, i32 0, i32 0, metadata !10, metadata !21, i32 0, i32 0} ; [ DW_TAG_array_type ] [line 0, size 8192, align 32, offset 0] [from unsigned int]
!25 = metadata !{i32 786689, metadata !5, metadata !"idx_ptr", metadata !6, i32 16777220, metadata !9, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [idx_ptr] [line 4]
!26 = metadata !{i32 4, i32 0, metadata !5, null}
!27 = metadata !{i32 786689, metadata !5, metadata !"dist_ptr", metadata !6, i32 33554437, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [dist_ptr] [line 5]
!28 = metadata !{i32 5, i32 0, metadata !5, null}
!29 = metadata !{i32 786689, metadata !5, metadata !"in_idx", metadata !6, i32 50331654, metadata !13, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [in_idx] [line 6]
!30 = metadata !{i32 6, i32 0, metadata !5, null}
!31 = metadata !{i32 786689, metadata !5, metadata !"in_dist", metadata !6, i32 67108871, metadata !15, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [in_dist] [line 7]
!32 = metadata !{i32 7, i32 0, metadata !5, null}
!33 = metadata !{i32 786689, metadata !5, metadata !"nfeat", metadata !6, i32 83886088, metadata !14, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [nfeat] [line 8]
!34 = metadata !{i32 8, i32 0, metadata !5, null}
!35 = metadata !{i32 786689, metadata !5, metadata !"nelem", metadata !6, i32 100663305, metadata !14, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [nelem] [line 9]
!36 = metadata !{i32 9, i32 0, metadata !5, null}
!37 = metadata !{i32 786689, metadata !5, metadata !"max_dist", metadata !6, i32 117440522, metadata !16, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [max_dist] [line 10]
!38 = metadata !{i32 10, i32 0, metadata !5, null}
!39 = metadata !{i32 786688, metadata !40, metadata !"f", metadata !6, i32 12, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [f] [line 12]
!40 = metadata !{i32 786443, metadata !5, i32 11, i32 0, metadata !6, i32 0} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire-Fix-syncthreads-in-cuda-nearest-neighbour.cpp]
!41 = metadata !{i32 12, i32 0, metadata !40, null}
!42 = metadata !{i32 786688, metadata !40, metadata !"sid", metadata !6, i32 13, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [sid] [line 13]
!43 = metadata !{i32 13, i32 0, metadata !40, null}
!44 = metadata !{i32 18, i32 0, metadata !40, null}
!45 = metadata !{i32 19, i32 0, metadata !40, null}
!46 = metadata !{i32 786688, metadata !47, metadata !"i", metadata !6, i32 20, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [i] [line 20]
!47 = metadata !{i32 786443, metadata !48, i32 20, i32 0, metadata !6, i32 2} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire-Fix-syncthreads-in-cuda-nearest-neighbour.cpp]
!48 = metadata !{i32 786443, metadata !40, i32 19, i32 0, metadata !6, i32 1} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire-Fix-syncthreads-in-cuda-nearest-neighbour.cpp]
!49 = metadata !{i32 20, i32 0, metadata !47, null}
!50 = metadata !{i32 786688, metadata !51, metadata !"dist", metadata !6, i32 21, metadata !12, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [dist] [line 21]
!51 = metadata !{i32 786443, metadata !47, i32 20, i32 0, metadata !6, i32 3} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire-Fix-syncthreads-in-cuda-nearest-neighbour.cpp]
!52 = metadata !{i32 21, i32 0, metadata !51, null}
!53 = metadata !{i32 25, i32 0, metadata !51, null}
!54 = metadata !{i32 26, i32 0, metadata !55, null}
!55 = metadata !{i32 786443, metadata !51, i32 25, i32 0, metadata !6, i32 4} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire-Fix-syncthreads-in-cuda-nearest-neighbour.cpp]
!56 = metadata !{i32 27, i32 0, metadata !55, null}
!57 = metadata !{i32 28, i32 0, metadata !55, null}
!58 = metadata !{i32 29, i32 0, metadata !51, null}
!59 = metadata !{i32 30, i32 0, metadata !48, null}
!60 = metadata !{i32 31, i32 0, metadata !40, null}
!61 = metadata !{i32 786688, metadata !62, metadata !"i", metadata !6, i32 34, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [i] [line 34]
!62 = metadata !{i32 786443, metadata !40, i32 34, i32 0, metadata !6, i32 5} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire-Fix-syncthreads-in-cuda-nearest-neighbour.cpp]
!63 = metadata !{i32 34, i32 0, metadata !62, null}
!64 = metadata !{i32 35, i32 0, metadata !65, null}
!65 = metadata !{i32 786443, metadata !62, i32 34, i32 0, metadata !6, i32 6} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire-Fix-syncthreads-in-cuda-nearest-neighbour.cpp]
!66 = metadata !{i32 786688, metadata !67, metadata !"dist", metadata !6, i32 36, metadata !12, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [dist] [line 36]
!67 = metadata !{i32 786443, metadata !65, i32 35, i32 0, metadata !6, i32 7} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire-Fix-syncthreads-in-cuda-nearest-neighbour.cpp]
!68 = metadata !{i32 36, i32 0, metadata !67, null}
!69 = metadata !{i32 37, i32 0, metadata !67, null}
!70 = metadata !{i32 38, i32 0, metadata !71, null}
!71 = metadata !{i32 786443, metadata !67, i32 37, i32 0, metadata !6, i32 8} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire-Fix-syncthreads-in-cuda-nearest-neighbour.cpp]
!72 = metadata !{i32 39, i32 0, metadata !71, null}
!73 = metadata !{i32 40, i32 0, metadata !71, null}
!74 = metadata !{i32 41, i32 0, metadata !67, null}
!75 = metadata !{i32 42, i32 0, metadata !67, null}
!76 = metadata !{i32 43, i32 0, metadata !65, null}
!77 = metadata !{i32 46, i32 0, metadata !40, null}
!78 = metadata !{i32 47, i32 0, metadata !79, null}
!79 = metadata !{i32 786443, metadata !40, i32 46, i32 0, metadata !6, i32 9} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire-Fix-syncthreads-in-cuda-nearest-neighbour.cpp]
!80 = metadata !{i32 48, i32 0, metadata !79, null}
!81 = metadata !{i32 49, i32 0, metadata !79, null}
!82 = metadata !{i32 50, i32 0, metadata !40, null}
