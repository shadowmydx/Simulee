; ModuleID = '_add_diag_mat'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.dim3 = type { i32, i32, i32 }

@_ZZ17_add_diag_mat_matdPdiPKdiiiS1_iidE9temp_data = internal global [256 x double] zeroinitializer, section "__shared__", align 16
@blockIdx = external global %struct.dim3
@blockDim = external global %struct.dim3
@threadIdx = external global %struct.dim3

define void @_Z17_add_diag_mat_matdPdiPKdiiiS1_iid(double %alpha, double* %v, i32 %v_dim, double* %M, i32 %M_cols, i32 %M_row_stride, i32 %M_col_stride, double* %N, i32 %N_row_stride, i32 %N_col_stride, double %beta) uwtable noinline {
	%label103not = alloca i1, align 4
	%label81 = alloca i1, align 4
	%label81not = alloca i1, align 4
	%label103 = alloca i1, align 4
	%label29 = alloca i1, align 4
	%label0not = alloca i1, align 4
	%label0 = alloca i1, align 4
	%label29not = alloca i1, align 4
	%label74 = alloca i1, align 4
	%label71 = alloca i1, align 4
	%label71not = alloca i1, align 4
	%label74not = alloca i1, align 4
	%1 = alloca double, align 8
	%2 = alloca double*, align 8
	%3 = alloca i32, align 4
	%4 = alloca double*, align 8
	%5 = alloca i32, align 4
	%6 = alloca i32, align 4
	%7 = alloca i32, align 4
	%8 = alloca double*, align 8
	%9 = alloca i32, align 4
	%10 = alloca i32, align 4
	%11 = alloca double, align 8
	%threads_per_element = alloca i32, align 4
	%i = alloca i32, align 4
	%v_idx = alloca i32, align 4
	%sub_idx = alloca i32, align 4
	%sum = alloca double, align 8
	%j = alloca i32, align 4
	%M_index = alloca i32, align 4
	%N_index = alloca i32, align 4
	%num_total_threads = alloca i32, align 4
	%half_point = alloca i32, align 4
	%temp = alloca double, align 8
	store double %alpha, double* %1, align 8
	store double* %v, double** %2, align 8
	store i32 %v_dim, i32* %3, align 4
	store double* %M, double** %4, align 8
	store i32 %M_cols, i32* %5, align 4
	store i32 %M_row_stride, i32* %6, align 4
	store i32 %M_col_stride, i32* %7, align 4
	store double* %N, double** %8, align 8
	store i32 %N_row_stride, i32* %9, align 4
	store i32 %N_col_stride, i32* %10, align 4
	store double %beta, double* %11, align 8
	store i32 5, i32* %threads_per_element, align 4, !dbg !36
	%12 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 0), align 4, !dbg !38
	%13 = load i32* getelementptr inbounds (%struct.dim3* @blockDim, i32 0, i32 0), align 4, !dbg !38
	%14 = mul i32 %12, %13, !dbg !38
	%15 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !38
	%16 = add i32 %14, %15, !dbg !38
	store i32 %16, i32* %i, align 4, !dbg !38
	%17 = load i32* %i, align 4, !dbg !41
	%18 = load i32* %threads_per_element, align 4, !dbg !41
	%19 = sdiv i32 %17, %18, !dbg !41
	store i32 %19, i32* %v_idx, align 4, !dbg !41
	%20 = load i32* %i, align 4, !dbg !41
	%21 = load i32* %threads_per_element, align 4, !dbg !41
	%22 = srem i32 %20, %21, !dbg !41
	store i32 %22, i32* %sub_idx, align 4, !dbg !41
	%23 = load i32* %v_idx, align 4, !dbg !43
	%24 = load i32* %3, align 4, !dbg !43
	%25 = icmp sge i32 %23, %24, !dbg !43
	%label0 = load i1 %25
	%label0not = icmp slt i32 %23, %24, !dbg !43
	br label %127


	; <label>:127
	%label127 = load i1 %label0not
	br i1 %label127, label %27, label %128
	br label %27


	; <label>:27                                      ; preds = %0
	store double 0.000000e+00, double* %sum, align 8, !dbg !45
	%28 = load i32* %sub_idx, align 4, !dbg !48
	store i32 %28, i32* %j, align 4, !dbg !48
	br label %128


	; <label>:128
	%label128 = load i1 %label0not
	br i1 %label128, label %29, label %129
	br label %29


	; <label>:29                                      ; preds = %61, %27
	%30 = load i32* %j, align 4, !dbg !48
	%31 = load i32* %5, align 4, !dbg !48
	%32 = icmp slt i32 %30, %31, !dbg !48
	%label29 = load i1 %32
	%label29not = icmp sge i32 %30, %31, !dbg !48
	br label %129


	; <label>:129
	%label129 = load i1 %label29
	%label129 = and i1 %label129, %label0not
	br i1 %label129, label %33, label %130
	br label %33


	; <label>:33                                      ; preds = %29
	%34 = load i32* %v_idx, align 4, !dbg !52
	%35 = load i32* %6, align 4, !dbg !52
	%36 = mul nsw i32 %34, %35, !dbg !52
	%37 = load i32* %j, align 4, !dbg !52
	%38 = load i32* %7, align 4, !dbg !52
	%39 = mul nsw i32 %37, %38, !dbg !52
	%40 = add nsw i32 %36, %39, !dbg !52
	store i32 %40, i32* %M_index, align 4, !dbg !52
	%41 = load i32* %j, align 4, !dbg !52
	%42 = load i32* %9, align 4, !dbg !52
	%43 = mul nsw i32 %41, %42, !dbg !52
	%44 = load i32* %v_idx, align 4, !dbg !52
	%45 = load i32* %10, align 4, !dbg !52
	%46 = mul nsw i32 %44, %45, !dbg !52
	%47 = add nsw i32 %43, %46, !dbg !52
	store i32 %47, i32* %N_index, align 4, !dbg !52
	%48 = load i32* %M_index, align 4, !dbg !54
	%49 = sext i32 %48 to i64, !dbg !54
	%50 = load double** %4, align 8, !dbg !54
	%51 = getelementptr inbounds double* %50, i64 %49, !dbg !54
	%52 = load double* %51, align 8, !dbg !54
	%53 = load i32* %N_index, align 4, !dbg !54
	%54 = sext i32 %53 to i64, !dbg !54
	%55 = load double** %8, align 8, !dbg !54
	%56 = getelementptr inbounds double* %55, i64 %54, !dbg !54
	%57 = load double* %56, align 8, !dbg !54
	%58 = fmul double %52, %57, !dbg !54
	%59 = load double* %sum, align 8, !dbg !54
	%60 = fadd double %59, %58, !dbg !54
	store double %60, double* %sum, align 8, !dbg !54
	br label %130


	; <label>:130
	%label130 = load i1 %label29
	%label130 = and i1 %label130, %label0not
	br i1 %label130, label %61, label %131
	br label %61


	; <label>:61                                      ; preds = %33
	%62 = load i32* %threads_per_element, align 4, !dbg !48
	%63 = load i32* %j, align 4, !dbg !48
	%64 = add nsw i32 %63, %62, !dbg !48
	store i32 %64, i32* %j, align 4, !dbg !48
	br label %29, !dbg !48
	br label %131
	br label %131


	; <label>:131
	%label131 = load i1 %label0not
	br i1 %label131, label %65, label %132
	br label %65


	; <label>:65                                      ; preds = %29
	%66 = load double* %sum, align 8, !dbg !56
	%67 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !56
	%68 = zext i32 %67 to i64, !dbg !56
	%69 = getelementptr inbounds [256 x double]* @_ZZ17_add_diag_mat_matdPdiPKdiiiS1_iidE9temp_data, i32 0, i64 %68, !dbg !56
	store double %66, double* %69, align 8, !dbg !56
	%70 = load i32* %threads_per_element, align 4, !dbg !59
	store i32 %70, i32* %num_total_threads, align 4, !dbg !59
	br label %132


	; <label>:132
	call void @__syncthreads(), 0
	%label132 = load i1 %label0not
	br i1 %label132, label %71, label %133
	br label %71


	; <label>:71                                      ; preds = %101, %65
	%72 = load i32* %num_total_threads, align 4, !dbg !60
	%73 = icmp sgt i32 %72, 1, !dbg !60
	%label71 = load i1 %73
	%label71not = icmp sle i32 %72, 1, !dbg !60
	br label %133


	; <label>:133
	%label133 = load i1 %label71
	%label133 = and i1 %label133, %label0not
	br i1 %label133, label %74, label %134
	br label %74


	; <label>:74                                      ; preds = %71
	%75 = load i32* %num_total_threads, align 4, !dbg !63
	%76 = add nsw i32 1, %75, !dbg !63
	%77 = ashr i32 %76, 1, !dbg !63
	store i32 %77, i32* %half_point, align 4, !dbg !63
	%78 = load i32* %sub_idx, align 4, !dbg !64
	%79 = load i32* %half_point, align 4, !dbg !64
	%80 = icmp slt i32 %78, %79, !dbg !64
	%label74 = load i1 %80
	%label74not = icmp sge i32 %78, %79, !dbg !64
	br label %134


	; <label>:134
	%label134 = load i1 %label71
	%label134 = and i1 %label134, %label74
	%label134 = and i1 %label134, %label0not
	br i1 %label134, label %81, label %135
	br label %81


	; <label>:81                                      ; preds = %74
	store double 0.000000e+00, double* %temp, align 8, !dbg !67
	%82 = load i32* %sub_idx, align 4, !dbg !68
	%83 = load i32* %half_point, align 4, !dbg !68
	%84 = add nsw i32 %82, %83, !dbg !68
	%85 = load i32* %num_total_threads, align 4, !dbg !68
	%86 = icmp slt i32 %84, %85, !dbg !68
	%label81 = load i1 %86
	%label81not = icmp sge i32 %84, %85, !dbg !68
	br label %135


	; <label>:135
	%label135 = load i1 %label71
	%label135 = and i1 %label135, %label74
	%label135 = and i1 %label135, %label81
	%label135 = and i1 %label135, %label0not
	br i1 %label135, label %87, label %136
	br label %87


	; <label>:87                                      ; preds = %81
	%88 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !69
	%89 = load i32* %half_point, align 4, !dbg !69
	%90 = add i32 %88, %89, !dbg !69
	%91 = zext i32 %90 to i64, !dbg !69
	%92 = getelementptr inbounds [256 x double]* @_ZZ17_add_diag_mat_matdPdiPKdiiiS1_iidE9temp_data, i32 0, i64 %91, !dbg !69
	%93 = load double* %92, align 8, !dbg !69
	store double %93, double* %temp, align 8, !dbg !69
	br label %136


	; <label>:136
	call void @__syncthreads(), 1
	%label136 = load i1 %label71
	%label136 = and i1 %label136, %label74
	%label136 = and i1 %label136, %label0not
	br i1 %label136, label %94, label %137
	br label %94


	; <label>:94                                      ; preds = %87, %81
	%95 = load double* %temp, align 8, !dbg !72
	%96 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !72
	%97 = zext i32 %96 to i64, !dbg !72
	%98 = getelementptr inbounds [256 x double]* @_ZZ17_add_diag_mat_matdPdiPKdiiiS1_iidE9temp_data, i32 0, i64 %97, !dbg !72
	%99 = load double* %98, align 8, !dbg !72
	%100 = fadd double %99, %95, !dbg !72
	store double %100, double* %98, align 8, !dbg !72
	br label %137


	; <label>:137
	call void @__syncthreads()
	%label137 = load i1 %label71
	%label137 = and i1 %label137, %label0not
	br i1 %label137, label %101, label %138
	br label %101


	; <label>:101                                     ; preds = %94, %74
	%102 = load i32* %half_point, align 4, !dbg !75
	store i32 %102, i32* %num_total_threads, align 4, !dbg !75
	br label %71, !dbg !76
	br label %138
	br label %138


	; <label>:138
	%label138 = load i1 %label0not
	br i1 %label138, label %103, label %139
	br label %103


	; <label>:103                                     ; preds = %71
	%104 = load i32* %sub_idx, align 4, !dbg !77
	%105 = icmp eq i32 %104, 0, !dbg !77
	%label103 = load i1 %105
	%label103not = icmp ne i32 %104, 0, !dbg !77
	br label %139


	; <label>:139
	%label139 = load i1 %label0not
	%label139 = and i1 %label139, %label103
	br i1 %label139, label %106, label %140
	br label %106


	; <label>:106                                     ; preds = %103
	%107 = load double* %11, align 8, !dbg !78
	%108 = load i32* %v_idx, align 4, !dbg !78
	%109 = sext i32 %108 to i64, !dbg !78
	%110 = load double** %2, align 8, !dbg !78
	%111 = getelementptr inbounds double* %110, i64 %109, !dbg !78
	%112 = load double* %111, align 8, !dbg !78
	%113 = fmul double %107, %112, !dbg !78
	%114 = load double* %1, align 8, !dbg !78
	%115 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !78
	%116 = zext i32 %115 to i64, !dbg !78
	%117 = getelementptr inbounds [256 x double]* @_ZZ17_add_diag_mat_matdPdiPKdiiiS1_iidE9temp_data, i32 0, i64 %116, !dbg !78
	%118 = load double* %117, align 8, !dbg !78
	%119 = fmul double %114, %118, !dbg !78
	%120 = fadd double %113, %119, !dbg !78
	%121 = load i32* %v_idx, align 4, !dbg !78
	%122 = sext i32 %121 to i64, !dbg !78
	%123 = load double** %2, align 8, !dbg !78
	%124 = getelementptr inbounds double* %123, i64 %122, !dbg !78
	store double %120, double* %124, align 8, !dbg !78
	br label %140


	; <label>:140
	%label140 = load i1 %label0
	br i1 %label140, label %26, label %141
	br label %26


	; <label>:26                                      ; preds = %0
	br label %141


	; <label>:141
	br label %125
	br label %125


	; <label>:125                                     ; preds = %106, %103, %26
	ret void, !dbg !81

}

declare void @llvm.dbg.declare(metadata, metadata) nounwind readnone

declare void @__syncthreads() section "__device__"

!llvm.dbg.cu = !{!0}

!0 = metadata !{i32 786449, i32 0, i32 4, metadata !"_add_diag_mat.cpp", metadata !"/home/mingyuanwu/kaldi-repair", metadata !"clang version 3.2 (tags/RELEASE_32/final)", i1 true, i1 false, metadata !"", i32 0, metadata !1, metadata !1, metadata !3, metadata !14} ; [ DW_TAG_compile_unit ] [/home/mingyuanwu/kaldi-repair/_add_diag_mat.cpp] [DW_LANG_C_plus_plus]
!1 = metadata !{metadata !2}
!2 = metadata !{i32 0}
!3 = metadata !{metadata !4}
!4 = metadata !{metadata !5}
!5 = metadata !{i32 786478, i32 0, metadata !6, metadata !"_add_diag_mat_mat", metadata !"_add_diag_mat_mat", metadata !"_Z17_add_diag_mat_matdPdiPKdiiiS1_iid", metadata !6, i32 3, metadata !7, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, void (double, double*, i32, double*, i32, i32, i32, double*, i32, i32, double)* @_Z17_add_diag_mat_matdPdiPKdiiiS1_iid, null, null, metadata !1, i32 6} ; [ DW_TAG_subprogram ] [line 3] [def] [scope 6] [_add_diag_mat_mat]
!6 = metadata !{i32 786473, metadata !"_add_diag_mat.cpp", metadata !"/home/mingyuanwu/kaldi-repair", null} ; [ DW_TAG_file_type ]
!7 = metadata !{i32 786453, i32 0, metadata !"", i32 0, i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !8, i32 0, i32 0} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!8 = metadata !{null, metadata !9, metadata !10, metadata !11, metadata !12, metadata !11, metadata !11, metadata !11, metadata !12, metadata !11, metadata !11, metadata !9}
!9 = metadata !{i32 786468, null, metadata !"double", null, i32 0, i64 64, i64 64, i64 0, i32 0, i32 4} ; [ DW_TAG_base_type ] [double] [line 0, size 64, align 64, offset 0, enc DW_ATE_float]
!10 = metadata !{i32 786447, null, metadata !"", null, i32 0, i64 64, i64 64, i64 0, i32 0, metadata !9} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from double]
!11 = metadata !{i32 786468, null, metadata !"int", null, i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!12 = metadata !{i32 786447, null, metadata !"", null, i32 0, i64 64, i64 64, i64 0, i32 0, metadata !13} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from ]
!13 = metadata !{i32 786470, null, metadata !"", null, i32 0, i64 0, i64 0, i64 0, i32 0, metadata !9} ; [ DW_TAG_const_type ] [line 0, size 0, align 0, offset 0] [from double]
!14 = metadata !{metadata !15}
!15 = metadata !{metadata !16}
!16 = metadata !{i32 786484, i32 0, metadata !5, metadata !"temp_data", metadata !"temp_data", metadata !"", metadata !6, i32 10, metadata !17, i32 1, i32 1, [256 x double]* @_ZZ17_add_diag_mat_matdPdiPKdiiiS1_iidE9temp_data} ; [ DW_TAG_variable ] [temp_data] [line 10] [local] [def]
!17 = metadata !{i32 786433, null, metadata !"", null, i32 0, i64 16384, i64 64, i32 0, i32 0, metadata !9, metadata !18, i32 0, i32 0} ; [ DW_TAG_array_type ] [line 0, size 16384, align 64, offset 0] [from double]
!18 = metadata !{metadata !19}
!19 = metadata !{i32 786465, i64 0, i64 255}      ; [ DW_TAG_subrange_type ] [0, 255]
!20 = metadata !{i32 786689, metadata !5, metadata !"alpha", metadata !6, i32 16777220, metadata !9, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [alpha] [line 4]
!21 = metadata !{i32 4, i32 0, metadata !5, null}
!22 = metadata !{i32 786689, metadata !5, metadata !"v", metadata !6, i32 33554436, metadata !10, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [v] [line 4]
!23 = metadata !{i32 786689, metadata !5, metadata !"v_dim", metadata !6, i32 50331652, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [v_dim] [line 4]
!24 = metadata !{i32 786689, metadata !5, metadata !"M", metadata !6, i32 67108868, metadata !12, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [M] [line 4]
!25 = metadata !{i32 786689, metadata !5, metadata !"M_cols", metadata !6, i32 83886084, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [M_cols] [line 4]
!26 = metadata !{i32 786689, metadata !5, metadata !"M_row_stride", metadata !6, i32 100663300, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [M_row_stride] [line 4]
!27 = metadata !{i32 786689, metadata !5, metadata !"M_col_stride", metadata !6, i32 117440517, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [M_col_stride] [line 5]
!28 = metadata !{i32 5, i32 0, metadata !5, null}
!29 = metadata !{i32 786689, metadata !5, metadata !"N", metadata !6, i32 134217733, metadata !12, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [N] [line 5]
!30 = metadata !{i32 786689, metadata !5, metadata !"N_row_stride", metadata !6, i32 150994949, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [N_row_stride] [line 5]
!31 = metadata !{i32 786689, metadata !5, metadata !"N_col_stride", metadata !6, i32 167772165, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [N_col_stride] [line 5]
!32 = metadata !{i32 786689, metadata !5, metadata !"beta", metadata !6, i32 184549382, metadata !9, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [beta] [line 6]
!33 = metadata !{i32 6, i32 0, metadata !5, null}
!34 = metadata !{i32 786688, metadata !35, metadata !"threads_per_element", metadata !6, i32 11, metadata !11, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [threads_per_element] [line 11]
!35 = metadata !{i32 786443, metadata !5, i32 6, i32 0, metadata !6, i32 0} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/kaldi-repair/_add_diag_mat.cpp]
!36 = metadata !{i32 11, i32 0, metadata !35, null}
!37 = metadata !{i32 786688, metadata !35, metadata !"i", metadata !6, i32 13, metadata !11, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [i] [line 13]
!38 = metadata !{i32 13, i32 0, metadata !35, null}
!39 = metadata !{i32 786688, metadata !35, metadata !"v_idx", metadata !6, i32 14, metadata !11, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [v_idx] [line 14]
!40 = metadata !{i32 14, i32 0, metadata !35, null}
!41 = metadata !{i32 15, i32 0, metadata !35, null}
!42 = metadata !{i32 786688, metadata !35, metadata !"sub_idx", metadata !6, i32 15, metadata !11, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [sub_idx] [line 15]
!43 = metadata !{i32 17, i32 0, metadata !35, null}
!44 = metadata !{i32 786688, metadata !35, metadata !"sum", metadata !6, i32 19, metadata !9, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [sum] [line 19]
!45 = metadata !{i32 19, i32 0, metadata !35, null}
!46 = metadata !{i32 786688, metadata !47, metadata !"j", metadata !6, i32 20, metadata !11, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [j] [line 20]
!47 = metadata !{i32 786443, metadata !35, i32 20, i32 0, metadata !6, i32 1} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/kaldi-repair/_add_diag_mat.cpp]
!48 = metadata !{i32 20, i32 0, metadata !47, null}
!49 = metadata !{i32 786688, metadata !50, metadata !"M_index", metadata !6, i32 21, metadata !11, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [M_index] [line 21]
!50 = metadata !{i32 786443, metadata !47, i32 20, i32 0, metadata !6, i32 2} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/kaldi-repair/_add_diag_mat.cpp]
!51 = metadata !{i32 21, i32 0, metadata !50, null}
!52 = metadata !{i32 22, i32 0, metadata !50, null}
!53 = metadata !{i32 786688, metadata !50, metadata !"N_index", metadata !6, i32 22, metadata !11, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [N_index] [line 22]
!54 = metadata !{i32 23, i32 0, metadata !50, null}
!55 = metadata !{i32 24, i32 0, metadata !50, null}
!56 = metadata !{i32 25, i32 0, metadata !35, null}
!57 = metadata !{i32 31, i32 0, metadata !35, null}
!58 = metadata !{i32 786688, metadata !35, metadata !"num_total_threads", metadata !6, i32 32, metadata !11, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [num_total_threads] [line 32]
!59 = metadata !{i32 32, i32 0, metadata !35, null}
!60 = metadata !{i32 33, i32 0, metadata !35, null}
!61 = metadata !{i32 786688, metadata !62, metadata !"half_point", metadata !6, i32 34, metadata !11, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [half_point] [line 34]
!62 = metadata !{i32 786443, metadata !35, i32 33, i32 0, metadata !6, i32 3} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/kaldi-repair/_add_diag_mat.cpp]
!63 = metadata !{i32 34, i32 0, metadata !62, null}
!64 = metadata !{i32 35, i32 0, metadata !62, null}
!65 = metadata !{i32 786688, metadata !66, metadata !"temp", metadata !6, i32 36, metadata !9, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [temp] [line 36]
!66 = metadata !{i32 786443, metadata !62, i32 35, i32 0, metadata !6, i32 4} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/kaldi-repair/_add_diag_mat.cpp]
!67 = metadata !{i32 36, i32 0, metadata !66, null}
!68 = metadata !{i32 37, i32 0, metadata !66, null}
!69 = metadata !{i32 38, i32 0, metadata !70, null}
!70 = metadata !{i32 786443, metadata !66, i32 37, i32 0, metadata !6, i32 5} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/kaldi-repair/_add_diag_mat.cpp]
!71 = metadata !{i32 39, i32 0, metadata !70, null}
!72 = metadata !{i32 40, i32 0, metadata !66, null}
!73 = metadata !{i32 41, i32 0, metadata !66, null}
!74 = metadata !{i32 42, i32 0, metadata !62, null}
!75 = metadata !{i32 43, i32 0, metadata !62, null}
!76 = metadata !{i32 44, i32 0, metadata !62, null}
!77 = metadata !{i32 45, i32 0, metadata !35, null}
!78 = metadata !{i32 46, i32 0, metadata !79, null}
!79 = metadata !{i32 786443, metadata !35, i32 45, i32 0, metadata !6, i32 6} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/kaldi-repair/_add_diag_mat.cpp]
!80 = metadata !{i32 47, i32 0, metadata !79, null}
!81 = metadata !{i32 48, i32 0, metadata !35, null}
