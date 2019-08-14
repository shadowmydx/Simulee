; ModuleID = 'scan_first_by_key_impl'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.dim3 = type { i32, i32, i32 }

@_ZZ20scan_nonfinal_kerneljjjE5s_flg = internal global [55 x i8] zeroinitializer, section "__shared__", align 16
@_ZZ20scan_nonfinal_kerneljjjE5s_val = internal global [55 x i32] zeroinitializer, section "__shared__", align 16
@_ZZ20scan_nonfinal_kerneljjjE6s_ftmp = internal global [5 x i8] zeroinitializer, section "__shared__", align 1
@_ZZ20scan_nonfinal_kerneljjjE5s_tmp = internal global [5 x i32] zeroinitializer, section "__shared__", align 16
@_ZZ20scan_nonfinal_kerneljjjE10boundaryid = internal global [5 x i32] zeroinitializer, section "__shared__", align 16
@threadIdx = external global %struct.dim3
@blockIdx = external global %struct.dim3
@blockDim = external global %struct.dim3

define void @_Z20scan_nonfinal_kerneljjj(i32 %blocks_x, i32 %blocks_y, i32 %lim) uwtable noinline {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %DIMY = alloca i32, align 4
  %SHARED_MEM_SIZE = alloca i32, align 4
  %tidx = alloca i32, align 4
  %tidy = alloca i32, align 4
  %zid = alloca i32, align 4
  %wid = alloca i32, align 4
  %blockIdx_x = alloca i32, align 4
  %blockIdx_y = alloca i32, align 4
  %xid = alloca i32, align 4
  %yid = alloca i32, align 4
  %sptr = alloca i32*, align 8
  %sfptr = alloca i8*, align 8
  %id = alloca i32, align 4
  %isLast = alloca i8, align 1
  %flag = alloca i8, align 1
  %val = alloca i32, align 4
  %k = alloca i32, align 4
  %start = alloca i32, align 4
  store i32 %blocks_x, i32* %1, align 4
  call void @llvm.dbg.declare(metadata !{i32* %1}, metadata !30), !dbg !31
  store i32 %blocks_y, i32* %2, align 4
  call void @llvm.dbg.declare(metadata !{i32* %2}, metadata !32), !dbg !33
  store i32 %lim, i32* %3, align 4
  call void @llvm.dbg.declare(metadata !{i32* %3}, metadata !34), !dbg !35
  call void @llvm.dbg.declare(metadata !{i32* %DIMY}, metadata !36), !dbg !38
  store i32 5, i32* %DIMY, align 4, !dbg !38
  call void @llvm.dbg.declare(metadata !{i32* %SHARED_MEM_SIZE}, metadata !39), !dbg !40
  store i32 55, i32* %SHARED_MEM_SIZE, align 4, !dbg !40
  call void @llvm.dbg.declare(metadata !{i32* %tidx}, metadata !41), !dbg !42
  %4 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !42
  store i32 %4, i32* %tidx, align 4, !dbg !42
  call void @llvm.dbg.declare(metadata !{i32* %tidy}, metadata !43), !dbg !44
  %5 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 1), align 4, !dbg !44
  store i32 %5, i32* %tidy, align 4, !dbg !44
  call void @llvm.dbg.declare(metadata !{i32* %zid}, metadata !45), !dbg !46
  %6 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 0), align 4, !dbg !46
  %7 = load i32* %1, align 4, !dbg !46
  %8 = udiv i32 %6, %7, !dbg !46
  store i32 %8, i32* %zid, align 4, !dbg !46
  call void @llvm.dbg.declare(metadata !{i32* %wid}, metadata !47), !dbg !48
  %9 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 1), align 4, !dbg !48
  %10 = load i32* %2, align 4, !dbg !48
  %11 = udiv i32 %9, %10, !dbg !48
  store i32 %11, i32* %wid, align 4, !dbg !48
  call void @llvm.dbg.declare(metadata !{i32* %blockIdx_x}, metadata !49), !dbg !50
  %12 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 0), align 4, !dbg !50
  %13 = load i32* %1, align 4, !dbg !50
  %14 = load i32* %zid, align 4, !dbg !50
  %15 = mul i32 %13, %14, !dbg !50
  %16 = sub i32 %12, %15, !dbg !50
  store i32 %16, i32* %blockIdx_x, align 4, !dbg !50
  call void @llvm.dbg.declare(metadata !{i32* %blockIdx_y}, metadata !51), !dbg !52
  %17 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 1), align 4, !dbg !52
  %18 = load i32* %2, align 4, !dbg !52
  %19 = load i32* %wid, align 4, !dbg !52
  %20 = mul i32 %18, %19, !dbg !52
  %21 = sub i32 %17, %20, !dbg !52
  store i32 %21, i32* %blockIdx_y, align 4, !dbg !52
  call void @llvm.dbg.declare(metadata !{i32* %xid}, metadata !53), !dbg !54
  %22 = load i32* %blockIdx_x, align 4, !dbg !54
  %23 = load i32* getelementptr inbounds (%struct.dim3* @blockDim, i32 0, i32 0), align 4, !dbg !54
  %24 = mul i32 %22, %23, !dbg !54
  %25 = load i32* %3, align 4, !dbg !54
  %26 = mul i32 %24, %25, !dbg !54
  %27 = load i32* %tidx, align 4, !dbg !54
  %28 = add i32 %26, %27, !dbg !54
  store i32 %28, i32* %xid, align 4, !dbg !54
  call void @llvm.dbg.declare(metadata !{i32* %yid}, metadata !55), !dbg !56
  %29 = load i32* %blockIdx_y, align 4, !dbg !56
  %30 = load i32* getelementptr inbounds (%struct.dim3* @blockDim, i32 0, i32 1), align 4, !dbg !56
  %31 = mul i32 %29, %30, !dbg !56
  %32 = load i32* %tidy, align 4, !dbg !56
  %33 = add i32 %31, %32, !dbg !56
  store i32 %33, i32* %yid, align 4, !dbg !56
  call void @llvm.dbg.declare(metadata !{i32** %sptr}, metadata !57), !dbg !59
  %34 = load i32* %tidy, align 4, !dbg !59
  %35 = mul nsw i32 %34, 11, !dbg !59
  %36 = sext i32 %35 to i64, !dbg !59
  %37 = getelementptr inbounds i32* getelementptr inbounds ([55 x i32]* @_ZZ20scan_nonfinal_kerneljjjE5s_val, i32 0, i32 0), i64 %36, !dbg !59
  store i32* %37, i32** %sptr, align 8, !dbg !59
  call void @llvm.dbg.declare(metadata !{i8** %sfptr}, metadata !60), !dbg !62
  %38 = load i32* %tidy, align 4, !dbg !62
  %39 = mul nsw i32 %38, 11, !dbg !62
  %40 = sext i32 %39 to i64, !dbg !62
  %41 = getelementptr inbounds i8* getelementptr inbounds ([55 x i8]* @_ZZ20scan_nonfinal_kerneljjjE5s_flg, i32 0, i32 0), i64 %40, !dbg !62
  store i8* %41, i8** %sfptr, align 8, !dbg !62
  call void @llvm.dbg.declare(metadata !{i32* %id}, metadata !63), !dbg !64
  %42 = load i32* %xid, align 4, !dbg !64
  store i32 %42, i32* %id, align 4, !dbg !64
  call void @llvm.dbg.declare(metadata !{i8* %isLast}, metadata !65), !dbg !68
  %43 = load i32* %tidx, align 4, !dbg !68
  %44 = icmp eq i32 %43, 4, !dbg !68
  %45 = zext i1 %44 to i8, !dbg !68
  store i8 %45, i8* %isLast, align 1, !dbg !68
  %46 = load i32* %tidx, align 4, !dbg !69
  %47 = icmp eq i32 %46, 4, !dbg !69
  br i1 %47, label %48, label %58, !dbg !69

; <label>:48                                      ; preds = %0
  %49 = load i32* %tidy, align 4, !dbg !70
  %50 = sext i32 %49 to i64, !dbg !70
  %51 = getelementptr inbounds [5 x i32]* @_ZZ20scan_nonfinal_kerneljjjE5s_tmp, i32 0, i64 %50, !dbg !70
  store i32 0, i32* %51, align 4, !dbg !70
  %52 = load i32* %tidy, align 4, !dbg !72
  %53 = sext i32 %52 to i64, !dbg !72
  %54 = getelementptr inbounds [5 x i8]* @_ZZ20scan_nonfinal_kerneljjjE6s_ftmp, i32 0, i64 %53, !dbg !72
  store i8 0, i8* %54, align 1, !dbg !72
  %55 = load i32* %tidy, align 4, !dbg !73
  %56 = sext i32 %55 to i64, !dbg !73
  %57 = getelementptr inbounds [5 x i32]* @_ZZ20scan_nonfinal_kerneljjjE10boundaryid, i32 0, i64 %56, !dbg !73
  store i32 -1, i32* %57, align 4, !dbg !73
  br label %58, !dbg !74

; <label>:58                                      ; preds = %48, %0
  call void @__syncthreads(), !dbg !75
  call void @llvm.dbg.declare(metadata !{i8* %flag}, metadata !76), !dbg !77
  store i8 0, i8* %flag, align 1, !dbg !77
  call void @llvm.dbg.declare(metadata !{i32* %val}, metadata !78), !dbg !79
  store i32 0, i32* %val, align 4, !dbg !79
  store i32 6, i32* %3, align 4, !dbg !80
  call void @llvm.dbg.declare(metadata !{i32* %k}, metadata !81), !dbg !83
  store i32 0, i32* %k, align 4, !dbg !83
  br label %59, !dbg !83

; <label>:59                                      ; preds = %136, %58
  %60 = load i32* %k, align 4, !dbg !83
  %61 = load i32* %3, align 4, !dbg !83
  %62 = icmp ult i32 %60, %61, !dbg !83
  br i1 %62, label %63, label %139, !dbg !83

; <label>:63                                      ; preds = %59
  %64 = load i32* %val, align 4, !dbg !84
  %65 = load i32* %tidx, align 4, !dbg !84
  %66 = sext i32 %65 to i64, !dbg !84
  %67 = load i32** %sptr, align 8, !dbg !84
  %68 = getelementptr inbounds i32* %67, i64 %66, !dbg !84
  store i32 %64, i32* %68, align 4, !dbg !84
  %69 = load i8* %flag, align 1, !dbg !86
  %70 = load i32* %tidx, align 4, !dbg !86
  %71 = sext i32 %70 to i64, !dbg !86
  %72 = load i8** %sfptr, align 8, !dbg !86
  %73 = getelementptr inbounds i8* %72, i64 %71, !dbg !86
  store i8 %69, i8* %73, align 1, !dbg !86
  call void @__syncthreads(), !dbg !87
  call void @llvm.dbg.declare(metadata !{i32* %start}, metadata !88), !dbg !89
  store i32 0, i32* %start, align 4, !dbg !89
  %74 = load i32* %tidx, align 4, !dbg !90
  %75 = icmp eq i32 %74, 0, !dbg !90
  br i1 %75, label %76, label %97, !dbg !90

; <label>:76                                      ; preds = %63
  %77 = load i32* %tidy, align 4, !dbg !91
  %78 = sext i32 %77 to i64, !dbg !91
  %79 = getelementptr inbounds [5 x i8]* @_ZZ20scan_nonfinal_kerneljjjE6s_ftmp, i32 0, i64 %78, !dbg !91
  %80 = load i8* %79, align 1, !dbg !91
  %81 = sext i8 %80 to i32, !dbg !91
  %82 = icmp eq i32 %81, 0, !dbg !91
  br i1 %82, label %83, label %96, !dbg !91

; <label>:83                                      ; preds = %76
  %84 = load i32* %tidx, align 4, !dbg !91
  %85 = sext i32 %84 to i64, !dbg !91
  %86 = load i8** %sfptr, align 8, !dbg !91
  %87 = getelementptr inbounds i8* %86, i64 %85, !dbg !91
  %88 = load i8* %87, align 1, !dbg !91
  %89 = sext i8 %88 to i32, !dbg !91
  %90 = icmp eq i32 %89, 1, !dbg !91
  br i1 %90, label %91, label %96, !dbg !91

; <label>:91                                      ; preds = %83
  %92 = load i32* %id, align 4, !dbg !93
  %93 = load i32* %tidy, align 4, !dbg !93
  %94 = sext i32 %93 to i64, !dbg !93
  %95 = getelementptr inbounds [5 x i32]* @_ZZ20scan_nonfinal_kerneljjjE10boundaryid, i32 0, i64 %94, !dbg !93
  store i32 %92, i32* %95, align 4, !dbg !93
  br label %96, !dbg !95

; <label>:96                                      ; preds = %91, %83, %76
  br label %120, !dbg !96

; <label>:97                                      ; preds = %63
  %98 = load i32* %tidx, align 4, !dbg !97
  %99 = sub nsw i32 %98, 1, !dbg !97
  %100 = sext i32 %99 to i64, !dbg !97
  %101 = load i8** %sfptr, align 8, !dbg !97
  %102 = getelementptr inbounds i8* %101, i64 %100, !dbg !97
  %103 = load i8* %102, align 1, !dbg !97
  %104 = sext i8 %103 to i32, !dbg !97
  %105 = icmp eq i32 %104, 0, !dbg !97
  br i1 %105, label %106, label %119, !dbg !97

; <label>:106                                     ; preds = %97
  %107 = load i32* %tidx, align 4, !dbg !97
  %108 = sext i32 %107 to i64, !dbg !97
  %109 = load i8** %sfptr, align 8, !dbg !97
  %110 = getelementptr inbounds i8* %109, i64 %108, !dbg !97
  %111 = load i8* %110, align 1, !dbg !97
  %112 = sext i8 %111 to i32, !dbg !97
  %113 = icmp eq i32 %112, 1, !dbg !97
  br i1 %113, label %114, label %119, !dbg !97

; <label>:114                                     ; preds = %106
  %115 = load i32* %id, align 4, !dbg !99
  %116 = load i32* %tidy, align 4, !dbg !99
  %117 = sext i32 %116 to i64, !dbg !99
  %118 = getelementptr inbounds [5 x i32]* @_ZZ20scan_nonfinal_kerneljjjE10boundaryid, i32 0, i64 %117, !dbg !99
  store i32 %115, i32* %118, align 4, !dbg !99
  br label %119, !dbg !101

; <label>:119                                     ; preds = %114, %106, %97
  br label %120

; <label>:120                                     ; preds = %119, %96
  %121 = load i32* %tidx, align 4, !dbg !102
  %122 = icmp eq i32 %121, 4, !dbg !102
  br i1 %122, label %123, label %132, !dbg !102

; <label>:123                                     ; preds = %120
  %124 = load i32* %val, align 4, !dbg !103
  %125 = load i32* %tidy, align 4, !dbg !103
  %126 = sext i32 %125 to i64, !dbg !103
  %127 = getelementptr inbounds [5 x i32]* @_ZZ20scan_nonfinal_kerneljjjE5s_tmp, i32 0, i64 %126, !dbg !103
  store i32 %124, i32* %127, align 4, !dbg !103
  %128 = load i8* %flag, align 1, !dbg !105
  %129 = load i32* %tidy, align 4, !dbg !105
  %130 = sext i32 %129 to i64, !dbg !105
  %131 = getelementptr inbounds [5 x i8]* @_ZZ20scan_nonfinal_kerneljjjE6s_ftmp, i32 0, i64 %130, !dbg !105
  store i8 %128, i8* %131, align 1, !dbg !105
  br label %132, !dbg !106

; <label>:132                                     ; preds = %123, %120
  %133 = load i32* getelementptr inbounds (%struct.dim3* @blockDim, i32 0, i32 0), align 4, !dbg !107
  %134 = load i32* %id, align 4, !dbg !107
  %135 = add i32 %134, %133, !dbg !107
  store i32 %135, i32* %id, align 4, !dbg !107
  call void @__syncthreads(), !dbg !108
  br label %136, !dbg !109

; <label>:136                                     ; preds = %132
  %137 = load i32* %k, align 4, !dbg !83
  %138 = add nsw i32 %137, 1, !dbg !83
  store i32 %138, i32* %k, align 4, !dbg !83
  br label %59, !dbg !83

; <label>:139                                     ; preds = %59
  ret void, !dbg !110
}

declare void @llvm.dbg.declare(metadata, metadata) nounwind readnone

declare void @__syncthreads() section "__device__"

!llvm.dbg.cu = !{!0}

!0 = metadata !{i32 786449, i32 0, i32 4, metadata !"scan_first_by_key_impl.cpp", metadata !"/home/mingyuanwu/arrayfire-repair", metadata !"clang version 3.2 (tags/RELEASE_32/final)", i1 true, i1 false, metadata !"", i32 0, metadata !1, metadata !1, metadata !3, metadata !11} ; [ DW_TAG_compile_unit ] [/home/mingyuanwu/arrayfire-repair/scan_first_by_key_impl.cpp] [DW_LANG_C_plus_plus]
!1 = metadata !{metadata !2}
!2 = metadata !{i32 0}
!3 = metadata !{metadata !4}
!4 = metadata !{metadata !5}
!5 = metadata !{i32 786478, i32 0, metadata !6, metadata !"scan_nonfinal_kernel", metadata !"scan_nonfinal_kernel", metadata !"_Z20scan_nonfinal_kerneljjj", metadata !6, i32 5, metadata !7, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, void (i32, i32, i32)* @_Z20scan_nonfinal_kerneljjj, null, null, metadata !1, i32 9} ; [ DW_TAG_subprogram ] [line 5] [def] [scope 9] [scan_nonfinal_kernel]
!6 = metadata !{i32 786473, metadata !"scan_first_by_key_impl.cpp", metadata !"/home/mingyuanwu/arrayfire-repair", null} ; [ DW_TAG_file_type ]
!7 = metadata !{i32 786453, i32 0, metadata !"", i32 0, i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !8, i32 0, i32 0} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!8 = metadata !{null, metadata !9, metadata !9, metadata !9}
!9 = metadata !{i32 786454, null, metadata !"uint", metadata !6, i32 152, i64 0, i64 0, i64 0, i32 0, metadata !10} ; [ DW_TAG_typedef ] [uint] [line 152, size 0, align 0, offset 0] [from unsigned int]
!10 = metadata !{i32 786468, null, metadata !"unsigned int", null, i32 0, i64 32, i64 32, i64 0, i32 0, i32 7} ; [ DW_TAG_base_type ] [unsigned int] [line 0, size 32, align 32, offset 0, enc DW_ATE_unsigned]
!11 = metadata !{metadata !12}
!12 = metadata !{metadata !13, metadata !16, metadata !21, metadata !23, metadata !27, metadata !29}
!13 = metadata !{i32 786484, i32 0, metadata !6, metadata !"DIMY", metadata !"DIMY", metadata !"DIMY", metadata !6, i32 10, metadata !14, i32 1, i32 1, i32 5} ; [ DW_TAG_variable ] [DIMY] [line 10] [local] [def]
!14 = metadata !{i32 786470, null, metadata !"", null, i32 0, i64 0, i64 0, i64 0, i32 0, metadata !15} ; [ DW_TAG_const_type ] [line 0, size 0, align 0, offset 0] [from int]
!15 = metadata !{i32 786468, null, metadata !"int", null, i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!16 = metadata !{i32 786484, i32 0, metadata !5, metadata !"s_flg", metadata !"s_flg", metadata !"", metadata !6, i32 12, metadata !17, i32 1, i32 1, [55 x i8]* @_ZZ20scan_nonfinal_kerneljjjE5s_flg} ; [ DW_TAG_variable ] [s_flg] [line 12] [local] [def]
!17 = metadata !{i32 786433, null, metadata !"", null, i32 0, i64 440, i64 8, i32 0, i32 0, metadata !18, metadata !19, i32 0, i32 0} ; [ DW_TAG_array_type ] [line 0, size 440, align 8, offset 0] [from char]
!18 = metadata !{i32 786468, null, metadata !"char", null, i32 0, i64 8, i64 8, i64 0, i32 0, i32 6} ; [ DW_TAG_base_type ] [char] [line 0, size 8, align 8, offset 0, enc DW_ATE_signed_char]
!19 = metadata !{metadata !20}
!20 = metadata !{i32 786465, i64 0, i64 54}       ; [ DW_TAG_subrange_type ] [0, 54]
!21 = metadata !{i32 786484, i32 0, metadata !5, metadata !"s_val", metadata !"s_val", metadata !"", metadata !6, i32 13, metadata !22, i32 1, i32 1, [55 x i32]* @_ZZ20scan_nonfinal_kerneljjjE5s_val} ; [ DW_TAG_variable ] [s_val] [line 13] [local] [def]
!22 = metadata !{i32 786433, null, metadata !"", null, i32 0, i64 1760, i64 32, i32 0, i32 0, metadata !15, metadata !19, i32 0, i32 0} ; [ DW_TAG_array_type ] [line 0, size 1760, align 32, offset 0] [from int]
!23 = metadata !{i32 786484, i32 0, metadata !5, metadata !"s_ftmp", metadata !"s_ftmp", metadata !"", metadata !6, i32 14, metadata !24, i32 1, i32 1, [5 x i8]* @_ZZ20scan_nonfinal_kerneljjjE6s_ftmp} ; [ DW_TAG_variable ] [s_ftmp] [line 14] [local] [def]
!24 = metadata !{i32 786433, null, metadata !"", null, i32 0, i64 40, i64 8, i32 0, i32 0, metadata !18, metadata !25, i32 0, i32 0} ; [ DW_TAG_array_type ] [line 0, size 40, align 8, offset 0] [from char]
!25 = metadata !{metadata !26}
!26 = metadata !{i32 786465, i64 0, i64 4}        ; [ DW_TAG_subrange_type ] [0, 4]
!27 = metadata !{i32 786484, i32 0, metadata !5, metadata !"s_tmp", metadata !"s_tmp", metadata !"", metadata !6, i32 15, metadata !28, i32 1, i32 1, [5 x i32]* @_ZZ20scan_nonfinal_kerneljjjE5s_tmp} ; [ DW_TAG_variable ] [s_tmp] [line 15] [local] [def]
!28 = metadata !{i32 786433, null, metadata !"", null, i32 0, i64 160, i64 32, i32 0, i32 0, metadata !15, metadata !25, i32 0, i32 0} ; [ DW_TAG_array_type ] [line 0, size 160, align 32, offset 0] [from int]
!29 = metadata !{i32 786484, i32 0, metadata !5, metadata !"boundaryid", metadata !"boundaryid", metadata !"", metadata !6, i32 16, metadata !28, i32 1, i32 1, [5 x i32]* @_ZZ20scan_nonfinal_kerneljjjE10boundaryid} ; [ DW_TAG_variable ] [boundaryid] [line 16] [local] [def]
!30 = metadata !{i32 786689, metadata !5, metadata !"blocks_x", metadata !6, i32 16777222, metadata !9, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [blocks_x] [line 6]
!31 = metadata !{i32 6, i32 0, metadata !5, null}
!32 = metadata !{i32 786689, metadata !5, metadata !"blocks_y", metadata !6, i32 33554439, metadata !9, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [blocks_y] [line 7]
!33 = metadata !{i32 7, i32 0, metadata !5, null}
!34 = metadata !{i32 786689, metadata !5, metadata !"lim", metadata !6, i32 50331656, metadata !9, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [lim] [line 8]
!35 = metadata !{i32 8, i32 0, metadata !5, null}
!36 = metadata !{i32 786688, metadata !37, metadata !"DIMY", metadata !6, i32 10, metadata !14, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [DIMY] [line 10]
!37 = metadata !{i32 786443, metadata !5, i32 9, i32 0, metadata !6, i32 0} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire-repair/scan_first_by_key_impl.cpp]
!38 = metadata !{i32 10, i32 0, metadata !37, null}
!39 = metadata !{i32 786688, metadata !37, metadata !"SHARED_MEM_SIZE", metadata !6, i32 11, metadata !14, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [SHARED_MEM_SIZE] [line 11]
!40 = metadata !{i32 11, i32 0, metadata !37, null}
!41 = metadata !{i32 786688, metadata !37, metadata !"tidx", metadata !6, i32 18, metadata !14, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [tidx] [line 18]
!42 = metadata !{i32 18, i32 0, metadata !37, null}
!43 = metadata !{i32 786688, metadata !37, metadata !"tidy", metadata !6, i32 19, metadata !14, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [tidy] [line 19]
!44 = metadata !{i32 19, i32 0, metadata !37, null}
!45 = metadata !{i32 786688, metadata !37, metadata !"zid", metadata !6, i32 20, metadata !14, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [zid] [line 20]
!46 = metadata !{i32 20, i32 0, metadata !37, null}
!47 = metadata !{i32 786688, metadata !37, metadata !"wid", metadata !6, i32 21, metadata !14, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [wid] [line 21]
!48 = metadata !{i32 21, i32 0, metadata !37, null}
!49 = metadata !{i32 786688, metadata !37, metadata !"blockIdx_x", metadata !6, i32 22, metadata !14, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [blockIdx_x] [line 22]
!50 = metadata !{i32 22, i32 0, metadata !37, null}
!51 = metadata !{i32 786688, metadata !37, metadata !"blockIdx_y", metadata !6, i32 23, metadata !14, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [blockIdx_y] [line 23]
!52 = metadata !{i32 23, i32 0, metadata !37, null}
!53 = metadata !{i32 786688, metadata !37, metadata !"xid", metadata !6, i32 24, metadata !14, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [xid] [line 24]
!54 = metadata !{i32 24, i32 0, metadata !37, null}
!55 = metadata !{i32 786688, metadata !37, metadata !"yid", metadata !6, i32 25, metadata !14, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [yid] [line 25]
!56 = metadata !{i32 25, i32 0, metadata !37, null}
!57 = metadata !{i32 786688, metadata !37, metadata !"sptr", metadata !6, i32 28, metadata !58, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [sptr] [line 28]
!58 = metadata !{i32 786447, null, metadata !"", null, i32 0, i64 64, i64 64, i64 0, i32 0, metadata !15} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from int]
!59 = metadata !{i32 28, i32 0, metadata !37, null}
!60 = metadata !{i32 786688, metadata !37, metadata !"sfptr", metadata !6, i32 29, metadata !61, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [sfptr] [line 29]
!61 = metadata !{i32 786447, null, metadata !"", null, i32 0, i64 64, i64 64, i64 0, i32 0, metadata !18} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from char]
!62 = metadata !{i32 29, i32 0, metadata !37, null}
!63 = metadata !{i32 786688, metadata !37, metadata !"id", metadata !6, i32 30, metadata !15, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [id] [line 30]
!64 = metadata !{i32 30, i32 0, metadata !37, null}
!65 = metadata !{i32 786688, metadata !37, metadata !"isLast", metadata !6, i32 32, metadata !66, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [isLast] [line 32]
!66 = metadata !{i32 786470, null, metadata !"", null, i32 0, i64 0, i64 0, i64 0, i32 0, metadata !67} ; [ DW_TAG_const_type ] [line 0, size 0, align 0, offset 0] [from bool]
!67 = metadata !{i32 786468, null, metadata !"bool", null, i32 0, i64 8, i64 8, i64 0, i32 0, i32 2} ; [ DW_TAG_base_type ] [bool] [line 0, size 8, align 8, offset 0, enc DW_ATE_boolean]
!68 = metadata !{i32 32, i32 0, metadata !37, null}
!69 = metadata !{i32 33, i32 0, metadata !37, null}
!70 = metadata !{i32 34, i32 0, metadata !71, null}
!71 = metadata !{i32 786443, metadata !37, i32 33, i32 0, metadata !6, i32 1} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire-repair/scan_first_by_key_impl.cpp]
!72 = metadata !{i32 35, i32 0, metadata !71, null}
!73 = metadata !{i32 36, i32 0, metadata !71, null}
!74 = metadata !{i32 37, i32 0, metadata !71, null}
!75 = metadata !{i32 38, i32 0, metadata !37, null}
!76 = metadata !{i32 786688, metadata !37, metadata !"flag", metadata !6, i32 42, metadata !18, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [flag] [line 42]
!77 = metadata !{i32 42, i32 0, metadata !37, null}
!78 = metadata !{i32 786688, metadata !37, metadata !"val", metadata !6, i32 43, metadata !15, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [val] [line 43]
!79 = metadata !{i32 43, i32 0, metadata !37, null}
!80 = metadata !{i32 44, i32 0, metadata !37, null}
!81 = metadata !{i32 786688, metadata !82, metadata !"k", metadata !6, i32 45, metadata !15, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [k] [line 45]
!82 = metadata !{i32 786443, metadata !37, i32 45, i32 0, metadata !6, i32 2} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire-repair/scan_first_by_key_impl.cpp]
!83 = metadata !{i32 45, i32 0, metadata !82, null}
!84 = metadata !{i32 48, i32 0, metadata !85, null}
!85 = metadata !{i32 786443, metadata !82, i32 45, i32 0, metadata !6, i32 3} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire-repair/scan_first_by_key_impl.cpp]
!86 = metadata !{i32 49, i32 0, metadata !85, null}
!87 = metadata !{i32 50, i32 0, metadata !85, null}
!88 = metadata !{i32 786688, metadata !85, metadata !"start", metadata !6, i32 53, metadata !15, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [start] [line 53]
!89 = metadata !{i32 53, i32 0, metadata !85, null}
!90 = metadata !{i32 56, i32 0, metadata !85, null}
!91 = metadata !{i32 57, i32 0, metadata !92, null}
!92 = metadata !{i32 786443, metadata !85, i32 56, i32 0, metadata !6, i32 4} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire-repair/scan_first_by_key_impl.cpp]
!93 = metadata !{i32 58, i32 0, metadata !94, null}
!94 = metadata !{i32 786443, metadata !92, i32 57, i32 0, metadata !6, i32 5} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire-repair/scan_first_by_key_impl.cpp]
!95 = metadata !{i32 59, i32 0, metadata !94, null}
!96 = metadata !{i32 60, i32 0, metadata !92, null}
!97 = metadata !{i32 61, i32 0, metadata !98, null}
!98 = metadata !{i32 786443, metadata !85, i32 60, i32 0, metadata !6, i32 6} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire-repair/scan_first_by_key_impl.cpp]
!99 = metadata !{i32 62, i32 0, metadata !100, null}
!100 = metadata !{i32 786443, metadata !98, i32 61, i32 0, metadata !6, i32 7} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire-repair/scan_first_by_key_impl.cpp]
!101 = metadata !{i32 63, i32 0, metadata !100, null}
!102 = metadata !{i32 66, i32 0, metadata !85, null}
!103 = metadata !{i32 67, i32 0, metadata !104, null}
!104 = metadata !{i32 786443, metadata !85, i32 66, i32 0, metadata !6, i32 8} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire-repair/scan_first_by_key_impl.cpp]
!105 = metadata !{i32 68, i32 0, metadata !104, null}
!106 = metadata !{i32 69, i32 0, metadata !104, null}
!107 = metadata !{i32 70, i32 0, metadata !85, null}
!108 = metadata !{i32 71, i32 0, metadata !85, null}
!109 = metadata !{i32 72, i32 0, metadata !85, null}
!110 = metadata !{i32 74, i32 0, metadata !37, null}
