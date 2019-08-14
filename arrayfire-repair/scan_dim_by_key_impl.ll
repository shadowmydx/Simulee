; ModuleID = 'scan_dim_by_key_impl'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.dim3 = type { i32, i32, i32 }

@threadIdx = external global %struct.dim3
@blockIdx = external global %struct.dim3
@blockDim = external global %struct.dim3
@_ZZ24scan_dim_nonfinal_kerneljjjE5s_flg = internal global [320 x i8] zeroinitializer, section "__shared__", align 16
@_ZZ24scan_dim_nonfinal_kerneljjjE5s_val = internal global [320 x i32] zeroinitializer, section "__shared__", align 16
@_ZZ24scan_dim_nonfinal_kerneljjjE6s_ftmp = internal global [32 x i8] zeroinitializer, section "__shared__", align 16
@_ZZ24scan_dim_nonfinal_kerneljjjE5s_tmp = internal global [32 x i32] zeroinitializer, section "__shared__", align 16
@_ZZ24scan_dim_nonfinal_kerneljjjE10boundaryid = internal global [32 x i32] zeroinitializer, section "__shared__", align 16

define void @_Z24scan_dim_nonfinal_kerneljjj(i32 %blocks_x, i32 %blocks_y, i32 %lim) uwtable noinline {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %tidx = alloca i32, align 4
  %tidy = alloca i32, align 4
  %tid = alloca i32, align 4
  %zid = alloca i32, align 4
  %wid = alloca i32, align 4
  %blockIdx_x = alloca i32, align 4
  %blockIdx_y = alloca i32, align 4
  %xid = alloca i32, align 4
  %yid = alloca i32, align 4
  %sptr = alloca i32*, align 8
  %sfptr = alloca i8*, align 8
  %id_dim = alloca i32, align 4
  %flag = alloca i8, align 1
  %start = alloca i32, align 4
  %val = alloca i32, align 4
  %k = alloca i32, align 4
  store i32 %blocks_x, i32* %1, align 4
  call void @llvm.dbg.declare(metadata !{i32* %1}, metadata !28), !dbg !29
  store i32 %blocks_y, i32* %2, align 4
  call void @llvm.dbg.declare(metadata !{i32* %2}, metadata !30), !dbg !31
  store i32 %lim, i32* %3, align 4
  call void @llvm.dbg.declare(metadata !{i32* %3}, metadata !32), !dbg !33
  call void @llvm.dbg.declare(metadata !{i32* %tidx}, metadata !34), !dbg !37
  %4 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !37
  store i32 %4, i32* %tidx, align 4, !dbg !37
  call void @llvm.dbg.declare(metadata !{i32* %tidy}, metadata !38), !dbg !39
  %5 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 1), align 4, !dbg !39
  store i32 %5, i32* %tidy, align 4, !dbg !39
  call void @llvm.dbg.declare(metadata !{i32* %tid}, metadata !40), !dbg !41
  %6 = load i32* %tidy, align 4, !dbg !41
  %7 = mul nsw i32 %6, 32, !dbg !41
  %8 = load i32* %tidx, align 4, !dbg !41
  %9 = add nsw i32 %7, %8, !dbg !41
  store i32 %9, i32* %tid, align 4, !dbg !41
  call void @llvm.dbg.declare(metadata !{i32* %zid}, metadata !42), !dbg !43
  %10 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 0), align 4, !dbg !43
  %11 = load i32* %1, align 4, !dbg !43
  %12 = udiv i32 %10, %11, !dbg !43
  store i32 %12, i32* %zid, align 4, !dbg !43
  call void @llvm.dbg.declare(metadata !{i32* %wid}, metadata !44), !dbg !45
  %13 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 1), align 4, !dbg !45
  %14 = load i32* %2, align 4, !dbg !45
  %15 = udiv i32 %13, %14, !dbg !45
  store i32 %15, i32* %wid, align 4, !dbg !45
  call void @llvm.dbg.declare(metadata !{i32* %blockIdx_x}, metadata !46), !dbg !47
  %16 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 0), align 4, !dbg !47
  %17 = load i32* %1, align 4, !dbg !47
  %18 = load i32* %zid, align 4, !dbg !47
  %19 = mul i32 %17, %18, !dbg !47
  %20 = sub i32 %16, %19, !dbg !47
  store i32 %20, i32* %blockIdx_x, align 4, !dbg !47
  call void @llvm.dbg.declare(metadata !{i32* %blockIdx_y}, metadata !48), !dbg !49
  %21 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 1), align 4, !dbg !49
  %22 = load i32* %2, align 4, !dbg !49
  %23 = load i32* %wid, align 4, !dbg !49
  %24 = mul i32 %22, %23, !dbg !49
  %25 = sub i32 %21, %24, !dbg !49
  store i32 %25, i32* %blockIdx_y, align 4, !dbg !49
  call void @llvm.dbg.declare(metadata !{i32* %xid}, metadata !50), !dbg !51
  %26 = load i32* %blockIdx_x, align 4, !dbg !51
  %27 = load i32* getelementptr inbounds (%struct.dim3* @blockDim, i32 0, i32 0), align 4, !dbg !51
  %28 = mul i32 %26, %27, !dbg !51
  %29 = load i32* %tidx, align 4, !dbg !51
  %30 = add i32 %28, %29, !dbg !51
  store i32 %30, i32* %xid, align 4, !dbg !51
  call void @llvm.dbg.declare(metadata !{i32* %yid}, metadata !52), !dbg !53
  %31 = load i32* %blockIdx_y, align 4, !dbg !53
  store i32 %31, i32* %yid, align 4, !dbg !53
  call void @llvm.dbg.declare(metadata !{i32** %sptr}, metadata !54), !dbg !56
  %32 = load i32* %tid, align 4, !dbg !56
  %33 = sext i32 %32 to i64, !dbg !56
  %34 = getelementptr inbounds i32* getelementptr inbounds ([320 x i32]* @_ZZ24scan_dim_nonfinal_kerneljjjE5s_val, i32 0, i32 0), i64 %33, !dbg !56
  store i32* %34, i32** %sptr, align 8, !dbg !56
  call void @llvm.dbg.declare(metadata !{i8** %sfptr}, metadata !57), !dbg !59
  %35 = load i32* %tid, align 4, !dbg !59
  %36 = sext i32 %35 to i64, !dbg !59
  %37 = getelementptr inbounds i8* getelementptr inbounds ([320 x i8]* @_ZZ24scan_dim_nonfinal_kerneljjjE5s_flg, i32 0, i32 0), i64 %36, !dbg !59
  store i8* %37, i8** %sfptr, align 8, !dbg !59
  call void @llvm.dbg.declare(metadata !{i32* %id_dim}, metadata !60), !dbg !61
  store i32 256, i32* %id_dim, align 4, !dbg !61
  %38 = load i32* %tidy, align 4, !dbg !62
  %39 = icmp eq i32 %38, 4, !dbg !62
  br i1 %39, label %40, label %50, !dbg !62

; <label>:40                                      ; preds = %0
  %41 = load i32* %tidx, align 4, !dbg !63
  %42 = sext i32 %41 to i64, !dbg !63
  %43 = getelementptr inbounds [32 x i32]* @_ZZ24scan_dim_nonfinal_kerneljjjE5s_tmp, i32 0, i64 %42, !dbg !63
  store i32 0, i32* %43, align 4, !dbg !63
  %44 = load i32* %tidx, align 4, !dbg !65
  %45 = sext i32 %44 to i64, !dbg !65
  %46 = getelementptr inbounds [32 x i8]* @_ZZ24scan_dim_nonfinal_kerneljjjE6s_ftmp, i32 0, i64 %45, !dbg !65
  store i8 0, i8* %46, align 1, !dbg !65
  %47 = load i32* %tidx, align 4, !dbg !66
  %48 = sext i32 %47 to i64, !dbg !66
  %49 = getelementptr inbounds [32 x i32]* @_ZZ24scan_dim_nonfinal_kerneljjjE10boundaryid, i32 0, i64 %48, !dbg !66
  store i32 -1, i32* %49, align 4, !dbg !66
  br label %50, !dbg !67

; <label>:50                                      ; preds = %40, %0
  call void @__syncthreads(), !dbg !68
  call void @llvm.dbg.declare(metadata !{i8* %flag}, metadata !69), !dbg !70
  store i8 0, i8* %flag, align 1, !dbg !70
  store i32 3, i32* %3, align 4, !dbg !71
  call void @llvm.dbg.declare(metadata !{i32* %start}, metadata !72), !dbg !73
  store i32 1, i32* %start, align 4, !dbg !73
  call void @llvm.dbg.declare(metadata !{i32* %val}, metadata !74), !dbg !73
  store i32 0, i32* %val, align 4, !dbg !73
  call void @llvm.dbg.declare(metadata !{i32* %k}, metadata !75), !dbg !77
  store i32 0, i32* %k, align 4, !dbg !77
  br label %51, !dbg !77

; <label>:51                                      ; preds = %121, %50
  %52 = load i32* %k, align 4, !dbg !77
  %53 = load i32* %3, align 4, !dbg !77
  %54 = icmp ult i32 %52, %53, !dbg !77
  br i1 %54, label %55, label %124, !dbg !77

; <label>:55                                      ; preds = %51
  %56 = load i32* %tidy, align 4, !dbg !78
  %57 = icmp eq i32 %56, 0, !dbg !78
  br i1 %57, label %58, label %80, !dbg !78

; <label>:58                                      ; preds = %55
  %59 = load i32* %tidx, align 4, !dbg !80
  %60 = sext i32 %59 to i64, !dbg !80
  %61 = getelementptr inbounds [32 x i8]* @_ZZ24scan_dim_nonfinal_kerneljjjE6s_ftmp, i32 0, i64 %60, !dbg !80
  %62 = load i8* %61, align 1, !dbg !80
  %63 = sext i8 %62 to i32, !dbg !80
  %64 = icmp eq i32 %63, 0, !dbg !80
  br i1 %64, label %65, label %79, !dbg !80

; <label>:65                                      ; preds = %58
  %66 = load i32* %start, align 4, !dbg !80
  %67 = mul nsw i32 %66, 32, !dbg !80
  %68 = sext i32 %67 to i64, !dbg !80
  %69 = load i8** %sfptr, align 8, !dbg !80
  %70 = getelementptr inbounds i8* %69, i64 %68, !dbg !80
  %71 = load i8* %70, align 1, !dbg !80
  %72 = sext i8 %71 to i32, !dbg !80
  %73 = icmp eq i32 %72, 1, !dbg !80
  br i1 %73, label %74, label %79, !dbg !80

; <label>:74                                      ; preds = %65
  %75 = load i32* %id_dim, align 4, !dbg !82
  %76 = load i32* %tidx, align 4, !dbg !82
  %77 = sext i32 %76 to i64, !dbg !82
  %78 = getelementptr inbounds [32 x i32]* @_ZZ24scan_dim_nonfinal_kerneljjjE10boundaryid, i32 0, i64 %77, !dbg !82
  store i32 %75, i32* %78, align 4, !dbg !82
  br label %79, !dbg !84

; <label>:79                                      ; preds = %74, %65, %58
  br label %105, !dbg !85

; <label>:80                                      ; preds = %55
  %81 = load i32* %start, align 4, !dbg !86
  %82 = sub nsw i32 %81, 1, !dbg !86
  %83 = mul nsw i32 %82, 32, !dbg !86
  %84 = sext i32 %83 to i64, !dbg !86
  %85 = load i8** %sfptr, align 8, !dbg !86
  %86 = getelementptr inbounds i8* %85, i64 %84, !dbg !86
  %87 = load i8* %86, align 1, !dbg !86
  %88 = sext i8 %87 to i32, !dbg !86
  %89 = icmp eq i32 %88, 0, !dbg !86
  br i1 %89, label %90, label %104, !dbg !86

; <label>:90                                      ; preds = %80
  %91 = load i32* %start, align 4, !dbg !86
  %92 = mul nsw i32 %91, 32, !dbg !86
  %93 = sext i32 %92 to i64, !dbg !86
  %94 = load i8** %sfptr, align 8, !dbg !86
  %95 = getelementptr inbounds i8* %94, i64 %93, !dbg !86
  %96 = load i8* %95, align 1, !dbg !86
  %97 = sext i8 %96 to i32, !dbg !86
  %98 = icmp eq i32 %97, 1, !dbg !86
  br i1 %98, label %99, label %104, !dbg !86

; <label>:99                                      ; preds = %90
  %100 = load i32* %id_dim, align 4, !dbg !88
  %101 = load i32* %tidx, align 4, !dbg !88
  %102 = sext i32 %101 to i64, !dbg !88
  %103 = getelementptr inbounds [32 x i32]* @_ZZ24scan_dim_nonfinal_kerneljjjE10boundaryid, i32 0, i64 %102, !dbg !88
  store i32 %100, i32* %103, align 4, !dbg !88
  br label %104, !dbg !90

; <label>:104                                     ; preds = %99, %90, %80
  br label %105

; <label>:105                                     ; preds = %104, %79
  %106 = load i32* %tidy, align 4, !dbg !91
  %107 = icmp eq i32 %106, 4, !dbg !91
  br i1 %107, label %108, label %117, !dbg !91

; <label>:108                                     ; preds = %105
  %109 = load i32* %val, align 4, !dbg !92
  %110 = load i32* %tidx, align 4, !dbg !92
  %111 = sext i32 %110 to i64, !dbg !92
  %112 = getelementptr inbounds [32 x i32]* @_ZZ24scan_dim_nonfinal_kerneljjjE5s_tmp, i32 0, i64 %111, !dbg !92
  store i32 %109, i32* %112, align 4, !dbg !92
  %113 = load i8* %flag, align 1, !dbg !94
  %114 = load i32* %tidx, align 4, !dbg !94
  %115 = sext i32 %114 to i64, !dbg !94
  %116 = getelementptr inbounds [32 x i8]* @_ZZ24scan_dim_nonfinal_kerneljjjE6s_ftmp, i32 0, i64 %115, !dbg !94
  store i8 %113, i8* %116, align 1, !dbg !94
  br label %117, !dbg !95

; <label>:117                                     ; preds = %108, %105
  %118 = load i32* getelementptr inbounds (%struct.dim3* @blockDim, i32 0, i32 1), align 4, !dbg !96
  %119 = load i32* %id_dim, align 4, !dbg !96
  %120 = add i32 %119, %118, !dbg !96
  store i32 %120, i32* %id_dim, align 4, !dbg !96
  call void @__syncthreads(), !dbg !97
  br label %121, !dbg !98

; <label>:121                                     ; preds = %117
  %122 = load i32* %k, align 4, !dbg !77
  %123 = add nsw i32 %122, 1, !dbg !77
  store i32 %123, i32* %k, align 4, !dbg !77
  br label %51, !dbg !77

; <label>:124                                     ; preds = %51
  ret void, !dbg !99
}

declare void @llvm.dbg.declare(metadata, metadata) nounwind readnone

declare void @__syncthreads() section "__device__"

!llvm.dbg.cu = !{!0}

!0 = metadata !{i32 786449, i32 0, i32 4, metadata !"scan_dim_by_key_impl.cpp", metadata !"/home/mingyuanwu/arrayfire-repair", metadata !"clang version 3.2 (tags/RELEASE_32/final)", i1 true, i1 false, metadata !"", i32 0, metadata !1, metadata !1, metadata !3, metadata !11} ; [ DW_TAG_compile_unit ] [/home/mingyuanwu/arrayfire-repair/scan_dim_by_key_impl.cpp] [DW_LANG_C_plus_plus]
!1 = metadata !{metadata !2}
!2 = metadata !{i32 0}
!3 = metadata !{metadata !4}
!4 = metadata !{metadata !5}
!5 = metadata !{i32 786478, i32 0, metadata !6, metadata !"scan_dim_nonfinal_kernel", metadata !"scan_dim_nonfinal_kernel", metadata !"_Z24scan_dim_nonfinal_kerneljjj", metadata !6, i32 4, metadata !7, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, void (i32, i32, i32)* @_Z24scan_dim_nonfinal_kerneljjj, null, null, metadata !1, i32 8} ; [ DW_TAG_subprogram ] [line 4] [def] [scope 8] [scan_dim_nonfinal_kernel]
!6 = metadata !{i32 786473, metadata !"scan_dim_by_key_impl.cpp", metadata !"/home/mingyuanwu/arrayfire-repair", null} ; [ DW_TAG_file_type ]
!7 = metadata !{i32 786453, i32 0, metadata !"", i32 0, i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !8, i32 0, i32 0} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!8 = metadata !{null, metadata !9, metadata !9, metadata !9}
!9 = metadata !{i32 786454, null, metadata !"uint", metadata !6, i32 152, i64 0, i64 0, i64 0, i32 0, metadata !10} ; [ DW_TAG_typedef ] [uint] [line 152, size 0, align 0, offset 0] [from unsigned int]
!10 = metadata !{i32 786468, null, metadata !"unsigned int", null, i32 0, i64 32, i64 32, i64 0, i32 0, i32 7} ; [ DW_TAG_base_type ] [unsigned int] [line 0, size 32, align 32, offset 0, enc DW_ATE_unsigned]
!11 = metadata !{metadata !12}
!12 = metadata !{metadata !13, metadata !18, metadata !21, metadata !25, metadata !27}
!13 = metadata !{i32 786484, i32 0, metadata !5, metadata !"s_flg", metadata !"s_flg", metadata !"", metadata !6, i32 23, metadata !14, i32 1, i32 1, [320 x i8]* @_ZZ24scan_dim_nonfinal_kerneljjjE5s_flg} ; [ DW_TAG_variable ] [s_flg] [line 23] [local] [def]
!14 = metadata !{i32 786433, null, metadata !"", null, i32 0, i64 2560, i64 8, i32 0, i32 0, metadata !15, metadata !16, i32 0, i32 0} ; [ DW_TAG_array_type ] [line 0, size 2560, align 8, offset 0] [from char]
!15 = metadata !{i32 786468, null, metadata !"char", null, i32 0, i64 8, i64 8, i64 0, i32 0, i32 6} ; [ DW_TAG_base_type ] [char] [line 0, size 8, align 8, offset 0, enc DW_ATE_signed_char]
!16 = metadata !{metadata !17}
!17 = metadata !{i32 786465, i64 0, i64 319}      ; [ DW_TAG_subrange_type ] [0, 319]
!18 = metadata !{i32 786484, i32 0, metadata !5, metadata !"s_val", metadata !"s_val", metadata !"", metadata !6, i32 24, metadata !19, i32 1, i32 1, [320 x i32]* @_ZZ24scan_dim_nonfinal_kerneljjjE5s_val} ; [ DW_TAG_variable ] [s_val] [line 24] [local] [def]
!19 = metadata !{i32 786433, null, metadata !"", null, i32 0, i64 10240, i64 32, i32 0, i32 0, metadata !20, metadata !16, i32 0, i32 0} ; [ DW_TAG_array_type ] [line 0, size 10240, align 32, offset 0] [from int]
!20 = metadata !{i32 786468, null, metadata !"int", null, i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!21 = metadata !{i32 786484, i32 0, metadata !5, metadata !"s_ftmp", metadata !"s_ftmp", metadata !"", metadata !6, i32 25, metadata !22, i32 1, i32 1, [32 x i8]* @_ZZ24scan_dim_nonfinal_kerneljjjE6s_ftmp} ; [ DW_TAG_variable ] [s_ftmp] [line 25] [local] [def]
!22 = metadata !{i32 786433, null, metadata !"", null, i32 0, i64 256, i64 8, i32 0, i32 0, metadata !15, metadata !23, i32 0, i32 0} ; [ DW_TAG_array_type ] [line 0, size 256, align 8, offset 0] [from char]
!23 = metadata !{metadata !24}
!24 = metadata !{i32 786465, i64 0, i64 31}       ; [ DW_TAG_subrange_type ] [0, 31]
!25 = metadata !{i32 786484, i32 0, metadata !5, metadata !"s_tmp", metadata !"s_tmp", metadata !"", metadata !6, i32 26, metadata !26, i32 1, i32 1, [32 x i32]* @_ZZ24scan_dim_nonfinal_kerneljjjE5s_tmp} ; [ DW_TAG_variable ] [s_tmp] [line 26] [local] [def]
!26 = metadata !{i32 786433, null, metadata !"", null, i32 0, i64 1024, i64 32, i32 0, i32 0, metadata !20, metadata !23, i32 0, i32 0} ; [ DW_TAG_array_type ] [line 0, size 1024, align 32, offset 0] [from int]
!27 = metadata !{i32 786484, i32 0, metadata !5, metadata !"boundaryid", metadata !"boundaryid", metadata !"", metadata !6, i32 27, metadata !26, i32 1, i32 1, [32 x i32]* @_ZZ24scan_dim_nonfinal_kerneljjjE10boundaryid} ; [ DW_TAG_variable ] [boundaryid] [line 27] [local] [def]
!28 = metadata !{i32 786689, metadata !5, metadata !"blocks_x", metadata !6, i32 16777221, metadata !9, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [blocks_x] [line 5]
!29 = metadata !{i32 5, i32 0, metadata !5, null}
!30 = metadata !{i32 786689, metadata !5, metadata !"blocks_y", metadata !6, i32 33554438, metadata !9, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [blocks_y] [line 6]
!31 = metadata !{i32 6, i32 0, metadata !5, null}
!32 = metadata !{i32 786689, metadata !5, metadata !"lim", metadata !6, i32 50331655, metadata !9, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [lim] [line 7]
!33 = metadata !{i32 7, i32 0, metadata !5, null}
!34 = metadata !{i32 786688, metadata !35, metadata !"tidx", metadata !6, i32 10, metadata !36, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [tidx] [line 10]
!35 = metadata !{i32 786443, metadata !5, i32 8, i32 0, metadata !6, i32 0} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire-repair/scan_dim_by_key_impl.cpp]
!36 = metadata !{i32 786470, null, metadata !"", null, i32 0, i64 0, i64 0, i64 0, i32 0, metadata !20} ; [ DW_TAG_const_type ] [line 0, size 0, align 0, offset 0] [from int]
!37 = metadata !{i32 10, i32 0, metadata !35, null}
!38 = metadata !{i32 786688, metadata !35, metadata !"tidy", metadata !6, i32 11, metadata !36, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [tidy] [line 11]
!39 = metadata !{i32 11, i32 0, metadata !35, null}
!40 = metadata !{i32 786688, metadata !35, metadata !"tid", metadata !6, i32 12, metadata !36, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [tid] [line 12]
!41 = metadata !{i32 12, i32 0, metadata !35, null}
!42 = metadata !{i32 786688, metadata !35, metadata !"zid", metadata !6, i32 14, metadata !36, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [zid] [line 14]
!43 = metadata !{i32 14, i32 0, metadata !35, null}
!44 = metadata !{i32 786688, metadata !35, metadata !"wid", metadata !6, i32 15, metadata !36, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [wid] [line 15]
!45 = metadata !{i32 15, i32 0, metadata !35, null}
!46 = metadata !{i32 786688, metadata !35, metadata !"blockIdx_x", metadata !6, i32 16, metadata !36, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [blockIdx_x] [line 16]
!47 = metadata !{i32 16, i32 0, metadata !35, null}
!48 = metadata !{i32 786688, metadata !35, metadata !"blockIdx_y", metadata !6, i32 17, metadata !36, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [blockIdx_y] [line 17]
!49 = metadata !{i32 17, i32 0, metadata !35, null}
!50 = metadata !{i32 786688, metadata !35, metadata !"xid", metadata !6, i32 18, metadata !36, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [xid] [line 18]
!51 = metadata !{i32 18, i32 0, metadata !35, null}
!52 = metadata !{i32 786688, metadata !35, metadata !"yid", metadata !6, i32 19, metadata !36, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [yid] [line 19]
!53 = metadata !{i32 19, i32 0, metadata !35, null}
!54 = metadata !{i32 786688, metadata !35, metadata !"sptr", metadata !6, i32 28, metadata !55, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [sptr] [line 28]
!55 = metadata !{i32 786447, null, metadata !"", null, i32 0, i64 64, i64 64, i64 0, i32 0, metadata !20} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from int]
!56 = metadata !{i32 28, i32 0, metadata !35, null}
!57 = metadata !{i32 786688, metadata !35, metadata !"sfptr", metadata !6, i32 29, metadata !58, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [sfptr] [line 29]
!58 = metadata !{i32 786447, null, metadata !"", null, i32 0, i64 64, i64 64, i64 0, i32 0, metadata !15} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from char]
!59 = metadata !{i32 29, i32 0, metadata !35, null}
!60 = metadata !{i32 786688, metadata !35, metadata !"id_dim", metadata !6, i32 30, metadata !20, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [id_dim] [line 30]
!61 = metadata !{i32 30, i32 0, metadata !35, null}
!62 = metadata !{i32 32, i32 0, metadata !35, null}
!63 = metadata !{i32 33, i32 0, metadata !64, null}
!64 = metadata !{i32 786443, metadata !35, i32 32, i32 0, metadata !6, i32 1} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire-repair/scan_dim_by_key_impl.cpp]
!65 = metadata !{i32 34, i32 0, metadata !64, null}
!66 = metadata !{i32 35, i32 0, metadata !64, null}
!67 = metadata !{i32 36, i32 0, metadata !64, null}
!68 = metadata !{i32 37, i32 0, metadata !35, null}
!69 = metadata !{i32 786688, metadata !35, metadata !"flag", metadata !6, i32 39, metadata !15, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [flag] [line 39]
!70 = metadata !{i32 39, i32 0, metadata !35, null}
!71 = metadata !{i32 40, i32 0, metadata !35, null}
!72 = metadata !{i32 786688, metadata !35, metadata !"start", metadata !6, i32 41, metadata !20, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [start] [line 41]
!73 = metadata !{i32 41, i32 0, metadata !35, null}
!74 = metadata !{i32 786688, metadata !35, metadata !"val", metadata !6, i32 41, metadata !20, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [val] [line 41]
!75 = metadata !{i32 786688, metadata !76, metadata !"k", metadata !6, i32 42, metadata !20, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [k] [line 42]
!76 = metadata !{i32 786443, metadata !35, i32 42, i32 0, metadata !6, i32 2} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire-repair/scan_dim_by_key_impl.cpp]
!77 = metadata !{i32 42, i32 0, metadata !76, null}
!78 = metadata !{i32 45, i32 0, metadata !79, null}
!79 = metadata !{i32 786443, metadata !76, i32 42, i32 0, metadata !6, i32 3} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire-repair/scan_dim_by_key_impl.cpp]
!80 = metadata !{i32 46, i32 0, metadata !81, null}
!81 = metadata !{i32 786443, metadata !79, i32 45, i32 0, metadata !6, i32 4} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire-repair/scan_dim_by_key_impl.cpp]
!82 = metadata !{i32 47, i32 0, metadata !83, null}
!83 = metadata !{i32 786443, metadata !81, i32 46, i32 0, metadata !6, i32 5} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire-repair/scan_dim_by_key_impl.cpp]
!84 = metadata !{i32 48, i32 0, metadata !83, null}
!85 = metadata !{i32 49, i32 0, metadata !81, null}
!86 = metadata !{i32 50, i32 0, metadata !87, null}
!87 = metadata !{i32 786443, metadata !79, i32 49, i32 0, metadata !6, i32 6} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire-repair/scan_dim_by_key_impl.cpp]
!88 = metadata !{i32 51, i32 0, metadata !89, null}
!89 = metadata !{i32 786443, metadata !87, i32 50, i32 0, metadata !6, i32 7} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire-repair/scan_dim_by_key_impl.cpp]
!90 = metadata !{i32 52, i32 0, metadata !89, null}
!91 = metadata !{i32 56, i32 0, metadata !79, null}
!92 = metadata !{i32 57, i32 0, metadata !93, null}
!93 = metadata !{i32 786443, metadata !79, i32 56, i32 0, metadata !6, i32 8} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire-repair/scan_dim_by_key_impl.cpp]
!94 = metadata !{i32 58, i32 0, metadata !93, null}
!95 = metadata !{i32 59, i32 0, metadata !93, null}
!96 = metadata !{i32 60, i32 0, metadata !79, null}
!97 = metadata !{i32 62, i32 0, metadata !79, null}
!98 = metadata !{i32 63, i32 0, metadata !79, null}
!99 = metadata !{i32 65, i32 0, metadata !35, null}
