; ModuleID = 'scan_dim'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.dim3 = type { i32, i32, i32 }

@threadIdx = external global %struct.dim3
@blockIdx = external global %struct.dim3
@blockDim = external global %struct.dim3
@_ZZ15scan_dim_kerneljjjjE5s_val = internal global [256 x double] zeroinitializer, section "__shared__", align 16
@_ZZ15scan_dim_kerneljjjjE5s_tmp = internal global [32 x double] zeroinitializer, section "__shared__", align 16

define void @_Z15scan_dim_kerneljjjj(i32 %blocks_x, i32 %blocks_y, i32 %blocks_dim, i32 %lim) uwtable noinline {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %tidx = alloca i32, align 4
  %tidy = alloca i32, align 4
  %tid = alloca i32, align 4
  %zid = alloca i32, align 4
  %wid = alloca i32, align 4
  %blockIdx_x = alloca i32, align 4
  %blockIdx_y = alloca i32, align 4
  %xid = alloca i32, align 4
  %yid = alloca i32, align 4
  %isLast = alloca i1, align 1
  %sptr = alloca double*, align 8
  %val = alloca double, align 8
  %k = alloca i32, align 4
  %start = alloca i32, align 4
  %off = alloca i32, align 4
  store i32 %blocks_x, i32* %1, align 4
  call void @llvm.dbg.declare(metadata !{i32* %1}, metadata !22), !dbg !23
  store i32 %blocks_y, i32* %2, align 4
  call void @llvm.dbg.declare(metadata !{i32* %2}, metadata !24), !dbg !25
  store i32 %blocks_dim, i32* %3, align 4
  call void @llvm.dbg.declare(metadata !{i32* %3}, metadata !26), !dbg !27
  store i32 %lim, i32* %4, align 4
  call void @llvm.dbg.declare(metadata !{i32* %4}, metadata !28), !dbg !29
  call void @llvm.dbg.declare(metadata !{i32* %tidx}, metadata !30), !dbg !33
  %5 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !33
  store i32 %5, i32* %tidx, align 4, !dbg !33
  call void @llvm.dbg.declare(metadata !{i32* %tidy}, metadata !34), !dbg !35
  %6 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 1), align 4, !dbg !35
  store i32 %6, i32* %tidy, align 4, !dbg !35
  call void @llvm.dbg.declare(metadata !{i32* %tid}, metadata !36), !dbg !37
  %7 = load i32* %tidy, align 4, !dbg !37
  %8 = mul i32 %7, 16, !dbg !37
  %9 = load i32* %tidx, align 4, !dbg !37
  %10 = add i32 %8, %9, !dbg !37
  store i32 %10, i32* %tid, align 4, !dbg !37
  call void @llvm.dbg.declare(metadata !{i32* %zid}, metadata !38), !dbg !39
  %11 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 0), align 4, !dbg !39
  %12 = load i32* %1, align 4, !dbg !39
  %13 = udiv i32 %11, %12, !dbg !39
  store i32 %13, i32* %zid, align 4, !dbg !39
  call void @llvm.dbg.declare(metadata !{i32* %wid}, metadata !40), !dbg !41
  %14 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 1), align 4, !dbg !41
  %15 = load i32* %2, align 4, !dbg !41
  %16 = udiv i32 %14, %15, !dbg !41
  store i32 %16, i32* %wid, align 4, !dbg !41
  call void @llvm.dbg.declare(metadata !{i32* %blockIdx_x}, metadata !42), !dbg !43
  %17 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 0), align 4, !dbg !43
  %18 = load i32* %1, align 4, !dbg !43
  %19 = load i32* %zid, align 4, !dbg !43
  %20 = mul i32 %18, %19, !dbg !43
  %21 = sub i32 %17, %20, !dbg !43
  store i32 %21, i32* %blockIdx_x, align 4, !dbg !43
  call void @llvm.dbg.declare(metadata !{i32* %blockIdx_y}, metadata !44), !dbg !45
  %22 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 1), align 4, !dbg !45
  %23 = load i32* %2, align 4, !dbg !45
  %24 = load i32* %wid, align 4, !dbg !45
  %25 = mul i32 %23, %24, !dbg !45
  %26 = sub i32 %22, %25, !dbg !45
  store i32 %26, i32* %blockIdx_y, align 4, !dbg !45
  call void @llvm.dbg.declare(metadata !{i32* %xid}, metadata !46), !dbg !47
  %27 = load i32* %blockIdx_x, align 4, !dbg !47
  %28 = load i32* getelementptr inbounds (%struct.dim3* @blockDim, i32 0, i32 0), align 4, !dbg !47
  %29 = mul i32 %27, %28, !dbg !47
  %30 = load i32* %tidx, align 4, !dbg !47
  %31 = add i32 %29, %30, !dbg !47
  store i32 %31, i32* %xid, align 4, !dbg !47
  call void @llvm.dbg.declare(metadata !{i32* %yid}, metadata !48), !dbg !49
  %32 = load i32* %blockIdx_y, align 4, !dbg !49
  store i32 %32, i32* %yid, align 4, !dbg !49
  call void @llvm.dbg.declare(metadata !{i1* %isLast}, metadata !50), !dbg !53
  %33 = load i32* %tidy, align 4, !dbg !53
  %34 = icmp eq i32 %33, 0, !dbg !53
  %35 = load i1 %34, !dbg !53
  store i1 %35, i1* %isLast, align 1, !dbg !53
  call void @llvm.dbg.declare(metadata !{double** %sptr}, metadata !54), !dbg !56
  %36 = load i32* %tid, align 4, !dbg !56
  %37 = zext i32 %36 to i64, !dbg !56
  %38 = getelementptr inbounds double* getelementptr inbounds ([256 x double]* @_ZZ15scan_dim_kerneljjjjE5s_val, i32 0, i32 0), i64 %37, !dbg !56
  store double* %38, double** %sptr, align 8, !dbg !56
  call void @llvm.dbg.declare(metadata !{double* %val}, metadata !57), !dbg !58
  store double 0.000000e+00, double* %val, align 8, !dbg !58
  call void @llvm.dbg.declare(metadata !{i32* %k}, metadata !59), !dbg !62
  store i32 0, i32* %k, align 4, !dbg !62
  br label %39, !dbg !62

; <label>:39                                      ; preds = %89, %0
  %40 = load i32* %k, align 4, !dbg !62
  %41 = load i32* %4, align 4, !dbg !62
  %42 = icmp ult i32 %40, %41, !dbg !62
  br i1 %42, label %43, label %92, !dbg !62

; <label>:43                                      ; preds = %39
  %45 = load i1* %isLast, align 1, !dbg !63
  br i1 %45, label %46, label %51, !dbg !63

; <label>:46                                      ; preds = %43
  %47 = load double* %val, align 8, !dbg !63
  %48 = load i32* %tidx, align 4, !dbg !63
  %49 = zext i32 %48 to i64, !dbg !63
  %50 = getelementptr inbounds [32 x double]* @_ZZ15scan_dim_kerneljjjjE5s_tmp, i32 0, i64 %49, !dbg !63
  store double %47, double* %50, align 8, !dbg !63
  br label %51, !dbg !63

; <label>:51                                      ; preds = %46, %43
  %52 = load double* %val, align 8, !dbg !65
  %53 = load double** %sptr, align 8, !dbg !65
  store double %52, double* %53, align 8, !dbg !65

  call void @llvm.dbg.declare(metadata !{i32* %start}, metadata !67), !dbg !68
  store i32 0, i32* %start, align 4, !dbg !68
  call void @llvm.dbg.declare(metadata !{i32* %off}, metadata !69), !dbg !71
  store i32 1, i32* %off, align 4, !dbg !71
  br label %54, !dbg !71

; <label>:54                                      ; preds = %79, %51
  %55 = load i32* %off, align 4, !dbg !71
  %56 = icmp slt i32 %55, 1, !dbg !71
  br i1 %56, label %57, label %82, !dbg !71

; <label>:57                                      ; preds = %54
  %58 = load i32* %tidy, align 4, !dbg !72
  %59 = load i32* %off, align 4, !dbg !72
  %60 = icmp uge i32 %58, %59, !dbg !72
  br i1 %60, label %61, label %70, !dbg !72

; <label>:61                                      ; preds = %57
  %62 = load i32* %start, align 4, !dbg !72
  %63 = load i32* %off, align 4, !dbg !72
  %64 = sub i32 %62, %63, !dbg !72
  %65 = mul i32 %64, 16, !dbg !72
  %66 = zext i32 %65 to i64, !dbg !72
  %67 = load double** %sptr, align 8, !dbg !72
  %68 = getelementptr inbounds double* %67, i64 %66, !dbg !72
  %69 = load double* %68, align 8, !dbg !72
  store double %69, double* %val, align 8, !dbg !72
  br label %70, !dbg !72

; <label>:70                                      ; preds = %61, %57
  %71 = load i32* %start, align 4, !dbg !74
  %72 = sub i32 1, %71, !dbg !74
  store i32 %72, i32* %start, align 4, !dbg !74
  %73 = load double* %val, align 8, !dbg !75
  %74 = load i32* %start, align 4, !dbg !75
  %75 = mul i32 %74, 16, !dbg !75
  %76 = zext i32 %75 to i64, !dbg !75
  %77 = load double** %sptr, align 8, !dbg !75
  %78 = getelementptr inbounds double* %77, i64 %76, !dbg !75
  store double %73, double* %78, align 8, !dbg !75

  br label %79, !dbg !77

; <label>:79                                      ; preds = %70
  %80 = load i32* %off, align 4, !dbg !71
  %81 = mul nsw i32 %80, 2, !dbg !71
  store i32 %81, i32* %off, align 4, !dbg !71
  br label %54, !dbg !71

; <label>:82                                      ; preds = %54
  %83 = load double* %val, align 8, !dbg !78
  %84 = load i32* %tidx, align 4, !dbg !78
  %85 = zext i32 %84 to i64, !dbg !78
  %86 = getelementptr inbounds [32 x double]* @_ZZ15scan_dim_kerneljjjjE5s_tmp, i32 0, i64 %85, !dbg !78
  %87 = load double* %86, align 8, !dbg !78
  %88 = fadd double %83, %87, !dbg !78
  store double %88, double* %val, align 8, !dbg !78

  br label %89, !dbg !80

; <label>:89                                      ; preds = %82
  %90 = load i32* %k, align 4, !dbg !62
  %91 = add nsw i32 %90, 1, !dbg !62
  store i32 %91, i32* %k, align 4, !dbg !62
  br label %39, !dbg !62

; <label>:92                                      ; preds = %39
  ret void, !dbg !81
}

declare void @llvm.dbg.declare(metadata, metadata) nounwind readnone

declare void @__syncthreads() section "__device__"

!llvm.dbg.cu = !{!0}

!0 = metadata !{i32 786449, i32 0, i32 4, metadata !"scan_dim.cpp", metadata !"/home/mingyuanwu/arrayfire-repair", metadata !"clang version 3.2 (tags/RELEASE_32/final)", i1 true, i1 false, metadata !"", i32 0, metadata !1, metadata !1, metadata !3, metadata !11} ; [ DW_TAG_compile_unit ] [/home/mingyuanwu/arrayfire-repair/scan_dim.cpp] [DW_LANG_C_plus_plus]
!1 = metadata !{metadata !2}
!2 = metadata !{i32 0}
!3 = metadata !{metadata !4}
!4 = metadata !{metadata !5}
!5 = metadata !{i32 786478, i32 0, metadata !6, metadata !"scan_dim_kernel", metadata !"scan_dim_kernel", metadata !"_Z15scan_dim_kerneljjjj", metadata !6, i32 5, metadata !7, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, void (i32, i32, i32, i32)* @_Z15scan_dim_kerneljjjj, null, null, metadata !1, i32 10} ; [ DW_TAG_subprogram ] [line 5] [def] [scope 10] [scan_dim_kernel]
!6 = metadata !{i32 786473, metadata !"scan_dim.cpp", metadata !"/home/mingyuanwu/arrayfire-repair", null} ; [ DW_TAG_file_type ]
!7 = metadata !{i32 786453, i32 0, metadata !"", i32 0, i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !8, i32 0, i32 0} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!8 = metadata !{null, metadata !9, metadata !9, metadata !9, metadata !9}
!9 = metadata !{i32 786454, null, metadata !"uint", metadata !6, i32 152, i64 0, i64 0, i64 0, i32 0, metadata !10} ; [ DW_TAG_typedef ] [uint] [line 152, size 0, align 0, offset 0] [from unsigned int]
!10 = metadata !{i32 786468, null, metadata !"unsigned int", null, i32 0, i64 32, i64 32, i64 0, i32 0, i32 7} ; [ DW_TAG_base_type ] [unsigned int] [line 0, size 32, align 32, offset 0, enc DW_ATE_unsigned]
!11 = metadata !{metadata !12}
!12 = metadata !{metadata !13, metadata !18}
!13 = metadata !{i32 786484, i32 0, metadata !5, metadata !"s_val", metadata !"s_val", metadata !"", metadata !6, i32 28, metadata !14, i32 1, i32 1, [256 x double]* @_ZZ15scan_dim_kerneljjjjE5s_val} ; [ DW_TAG_variable ] [s_val] [line 28] [local] [def]
!14 = metadata !{i32 786433, null, metadata !"", null, i32 0, i64 16384, i64 64, i32 0, i32 0, metadata !15, metadata !16, i32 0, i32 0} ; [ DW_TAG_array_type ] [line 0, size 16384, align 64, offset 0] [from double]
!15 = metadata !{i32 786468, null, metadata !"double", null, i32 0, i64 64, i64 64, i64 0, i32 0, i32 4} ; [ DW_TAG_base_type ] [double] [line 0, size 64, align 64, offset 0, enc DW_ATE_float]
!16 = metadata !{metadata !17}
!17 = metadata !{i32 786465, i64 0, i64 255}      ; [ DW_TAG_subrange_type ] [0, 255]
!18 = metadata !{i32 786484, i32 0, metadata !5, metadata !"s_tmp", metadata !"s_tmp", metadata !"", metadata !6, i32 29, metadata !19, i32 1, i32 1, [32 x double]* @_ZZ15scan_dim_kerneljjjjE5s_tmp} ; [ DW_TAG_variable ] [s_tmp] [line 29] [local] [def]
!19 = metadata !{i32 786433, null, metadata !"", null, i32 0, i64 2048, i64 64, i32 0, i32 0, metadata !15, metadata !20, i32 0, i32 0} ; [ DW_TAG_array_type ] [line 0, size 2048, align 64, offset 0] [from double]
!20 = metadata !{metadata !21}
!21 = metadata !{i32 786465, i64 0, i64 31}       ; [ DW_TAG_subrange_type ] [0, 31]
!22 = metadata !{i32 786689, metadata !5, metadata !"blocks_x", metadata !6, i32 16777222, metadata !9, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [blocks_x] [line 6]
!23 = metadata !{i32 6, i32 0, metadata !5, null}
!24 = metadata !{i32 786689, metadata !5, metadata !"blocks_y", metadata !6, i32 33554439, metadata !9, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [blocks_y] [line 7]
!25 = metadata !{i32 7, i32 0, metadata !5, null}
!26 = metadata !{i32 786689, metadata !5, metadata !"blocks_dim", metadata !6, i32 50331656, metadata !9, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [blocks_dim] [line 8]
!27 = metadata !{i32 8, i32 0, metadata !5, null}
!28 = metadata !{i32 786689, metadata !5, metadata !"lim", metadata !6, i32 67108873, metadata !9, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [lim] [line 9]
!29 = metadata !{i32 9, i32 0, metadata !5, null}
!30 = metadata !{i32 786688, metadata !31, metadata !"tidx", metadata !6, i32 11, metadata !32, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [tidx] [line 11]
!31 = metadata !{i32 786443, metadata !5, i32 10, i32 0, metadata !6, i32 0} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire-repair/scan_dim.cpp]
!32 = metadata !{i32 786470, null, metadata !"", null, i32 0, i64 0, i64 0, i64 0, i32 0, metadata !9} ; [ DW_TAG_const_type ] [line 0, size 0, align 0, offset 0] [from uint]
!33 = metadata !{i32 11, i32 0, metadata !31, null}
!34 = metadata !{i32 786688, metadata !31, metadata !"tidy", metadata !6, i32 12, metadata !32, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [tidy] [line 12]
!35 = metadata !{i32 12, i32 0, metadata !31, null}
!36 = metadata !{i32 786688, metadata !31, metadata !"tid", metadata !6, i32 13, metadata !32, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [tid] [line 13]
!37 = metadata !{i32 13, i32 0, metadata !31, null}
!38 = metadata !{i32 786688, metadata !31, metadata !"zid", metadata !6, i32 15, metadata !32, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [zid] [line 15]
!39 = metadata !{i32 15, i32 0, metadata !31, null}
!40 = metadata !{i32 786688, metadata !31, metadata !"wid", metadata !6, i32 16, metadata !32, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [wid] [line 16]
!41 = metadata !{i32 16, i32 0, metadata !31, null}
!42 = metadata !{i32 786688, metadata !31, metadata !"blockIdx_x", metadata !6, i32 17, metadata !32, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [blockIdx_x] [line 17]
!43 = metadata !{i32 17, i32 0, metadata !31, null}
!44 = metadata !{i32 786688, metadata !31, metadata !"blockIdx_y", metadata !6, i32 18, metadata !32, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [blockIdx_y] [line 18]
!45 = metadata !{i32 18, i32 0, metadata !31, null}
!46 = metadata !{i32 786688, metadata !31, metadata !"xid", metadata !6, i32 19, metadata !32, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [xid] [line 19]
!47 = metadata !{i32 19, i32 0, metadata !31, null}
!48 = metadata !{i32 786688, metadata !31, metadata !"yid", metadata !6, i32 20, metadata !32, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [yid] [line 20]
!49 = metadata !{i32 20, i32 0, metadata !31, null}
!50 = metadata !{i32 786688, metadata !31, metadata !"isLast", metadata !6, i32 26, metadata !51, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [isLast] [line 26]
!51 = metadata !{i32 786470, null, metadata !"", null, i32 0, i64 0, i64 0, i64 0, i32 0, metadata !52} ; [ DW_TAG_const_type ] [line 0, size 0, align 0, offset 0] [from bool]
!52 = metadata !{i32 786468, null, metadata !"bool", null, i32 0, i64 8, i64 8, i64 0, i32 0, i32 2} ; [ DW_TAG_base_type ] [bool] [line 0, size 8, align 8, offset 0, enc DW_ATE_boolean]
!53 = metadata !{i32 26, i32 0, metadata !31, null}
!54 = metadata !{i32 786688, metadata !31, metadata !"sptr", metadata !6, i32 30, metadata !55, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [sptr] [line 30]
!55 = metadata !{i32 786447, null, metadata !"", null, i32 0, i64 64, i64 64, i64 0, i32 0, metadata !15} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from double]
!56 = metadata !{i32 30, i32 0, metadata !31, null}
!57 = metadata !{i32 786688, metadata !31, metadata !"val", metadata !6, i32 32, metadata !15, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [val] [line 32]
!58 = metadata !{i32 32, i32 0, metadata !31, null}
!59 = metadata !{i32 786688, metadata !60, metadata !"k", metadata !6, i32 34, metadata !61, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [k] [line 34]
!60 = metadata !{i32 786443, metadata !31, i32 34, i32 0, metadata !6, i32 1} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire-repair/scan_dim.cpp]
!61 = metadata !{i32 786468, null, metadata !"int", null, i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!62 = metadata !{i32 34, i32 0, metadata !60, null}
!63 = metadata !{i32 36, i32 0, metadata !64, null}
!64 = metadata !{i32 786443, metadata !60, i32 34, i32 0, metadata !6, i32 2} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire-repair/scan_dim.cpp]
!65 = metadata !{i32 37, i32 0, metadata !64, null}
!66 = metadata !{i32 38, i32 0, metadata !64, null}
!67 = metadata !{i32 786688, metadata !64, metadata !"start", metadata !6, i32 40, metadata !9, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [start] [line 40]
!68 = metadata !{i32 40, i32 0, metadata !64, null}
!69 = metadata !{i32 786688, metadata !70, metadata !"off", metadata !6, i32 41, metadata !61, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [off] [line 41]
!70 = metadata !{i32 786443, metadata !64, i32 41, i32 0, metadata !6, i32 3} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire-repair/scan_dim.cpp]
!71 = metadata !{i32 41, i32 0, metadata !70, null}
!72 = metadata !{i32 43, i32 0, metadata !73, null}
!73 = metadata !{i32 786443, metadata !70, i32 41, i32 0, metadata !6, i32 4} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire-repair/scan_dim.cpp]
!74 = metadata !{i32 44, i32 0, metadata !73, null}
!75 = metadata !{i32 45, i32 0, metadata !73, null}
!76 = metadata !{i32 47, i32 0, metadata !73, null}
!77 = metadata !{i32 48, i32 0, metadata !73, null}
!78 = metadata !{i32 51, i32 0, metadata !64, null}
!79 = metadata !{i32 52, i32 0, metadata !64, null}
!80 = metadata !{i32 54, i32 0, metadata !64, null}
!81 = metadata !{i32 56, i32 0, metadata !31, null}
