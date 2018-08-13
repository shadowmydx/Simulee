; ModuleID = 'new-fun'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.dim3 = type { i32, i32, i32 }

@threadIdx = external global %struct.dim3
@blockDim = external global %struct.dim3
@_ZZ18c_smo_solve_kernelPKiPfS1_S1_S0_iffPKfS3_ifS1_iE10shared_mem = internal global [256 x i32] zeroinitializer, section "__shared__", align 16

define i32 @_Z15get_block_min_tPKfPi(float* %values, i32* %index) uwtable section "__device__" {
  %1 = alloca float*, align 8
  %2 = alloca i32*, align 8
  %tid = alloca i32, align 4
  %offset = alloca i32, align 4
  store float* %values, float** %1, align 8
  call void @llvm.dbg.declare(metadata !{float** %1}, metadata !35), !dbg !36
  store i32* %index, i32** %2, align 8
  call void @llvm.dbg.declare(metadata !{i32** %2}, metadata !37), !dbg !36
  call void @llvm.dbg.declare(metadata !{i32* %tid}, metadata !38), !dbg !40
  %3 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !40
  store i32 %3, i32* %tid, align 4, !dbg !40
  %4 = load i32* %tid, align 4, !dbg !41
  %5 = load i32* %tid, align 4, !dbg !41
  %6 = sext i32 %5 to i64, !dbg !41
  %7 = load i32** %2, align 8, !dbg !41
  %8 = getelementptr inbounds i32* %7, i64 %6, !dbg !41
  store i32 %4, i32* %8, align 4, !dbg !41
  call void @__syncthreads(), !dbg !42
  call void @llvm.dbg.declare(metadata !{i32* %offset}, metadata !43), !dbg !45
  %9 = load i32* getelementptr inbounds (%struct.dim3* @blockDim, i32 0, i32 0), align 4, !dbg !45
  %10 = udiv i32 %9, 2, !dbg !45
  store i32 %10, i32* %offset, align 4, !dbg !45
  br label %11, !dbg !45

; <label>:11                                      ; preds = %54, %0
  %12 = load i32* %offset, align 4, !dbg !45
  %13 = icmp sgt i32 %12, 0, !dbg !45
  br i1 %13, label %14, label %57, !dbg !45

; <label>:14                                      ; preds = %11
  %15 = load i32* %tid, align 4, !dbg !46
  %16 = load i32* %offset, align 4, !dbg !46
  %17 = icmp slt i32 %15, %16, !dbg !46
  br i1 %17, label %18, label %53, !dbg !46

; <label>:18                                      ; preds = %14
  %19 = load i32* %tid, align 4, !dbg !48
  %20 = load i32* %offset, align 4, !dbg !48
  %21 = add nsw i32 %19, %20, !dbg !48
  %22 = sext i32 %21 to i64, !dbg !48
  %23 = load i32** %2, align 8, !dbg !48
  %24 = getelementptr inbounds i32* %23, i64 %22, !dbg !48
  %25 = load i32* %24, align 4, !dbg !48
  %26 = sext i32 %25 to i64, !dbg !48
  %27 = load float** %1, align 8, !dbg !48
  %28 = getelementptr inbounds float* %27, i64 %26, !dbg !48
  %29 = load float* %28, align 4, !dbg !48
  %30 = load i32* %tid, align 4, !dbg !48
  %31 = sext i32 %30 to i64, !dbg !48
  %32 = load i32** %2, align 8, !dbg !48
  %33 = getelementptr inbounds i32* %32, i64 %31, !dbg !48
  %34 = load i32* %33, align 4, !dbg !48
  %35 = sext i32 %34 to i64, !dbg !48
  %36 = load float** %1, align 8, !dbg !48
  %37 = getelementptr inbounds float* %36, i64 %35, !dbg !48
  %38 = load float* %37, align 4, !dbg !48
  %39 = fcmp olt float %29, %38, !dbg !48
  br i1 %39, label %40, label %52, !dbg !48

; <label>:40                                      ; preds = %18
  %41 = load i32* %tid, align 4, !dbg !50
  %42 = load i32* %offset, align 4, !dbg !50
  %43 = add nsw i32 %41, %42, !dbg !50
  %44 = sext i32 %43 to i64, !dbg !50
  %45 = load i32** %2, align 8, !dbg !50
  %46 = getelementptr inbounds i32* %45, i64 %44, !dbg !50
  %47 = load i32* %46, align 4, !dbg !50
  %48 = load i32* %tid, align 4, !dbg !50
  %49 = sext i32 %48 to i64, !dbg !50
  %50 = load i32** %2, align 8, !dbg !50
  %51 = getelementptr inbounds i32* %50, i64 %49, !dbg !50
  store i32 %47, i32* %51, align 4, !dbg !50
  br label %52, !dbg !52

; <label>:52                                      ; preds = %40, %18
  br label %53, !dbg !53

; <label>:53                                      ; preds = %52, %14
  call void @__syncthreads(), !dbg !54
  br label %54, !dbg !55

; <label>:54                                      ; preds = %53
  %55 = load i32* %offset, align 4, !dbg !45
  %56 = ashr i32 %55, 1, !dbg !45
  store i32 %56, i32* %offset, align 4, !dbg !45
  br label %11, !dbg !45

; <label>:57                                      ; preds = %11
  %58 = load i32** %2, align 8, !dbg !56
  %59 = getelementptr inbounds i32* %58, i64 0, !dbg !56
  %60 = load i32* %59, align 4, !dbg !56
  ret i32 %60, !dbg !56
}

declare void @llvm.dbg.declare(metadata, metadata) nounwind readnone

declare void @__syncthreads() section "__device__"

define void @_Z18c_smo_solve_kernelPKiPfS1_S1_S0_iffPKfS3_ifS1_i(i32* %label, float* %f_val, float* %alpha, float* %alpha_diff, i32* %working_set, i32 %ws_size, float %Cp, float %Cn, float* %k_mat_rows, float* %k_mat_diag, i32 %row_len, float %eps, float* %diff, i32 %max_t_iter) uwtable noinline {
  %1 = alloca i32*, align 8
  %2 = alloca float*, align 8
  %3 = alloca float*, align 8
  %4 = alloca float*, align 8
  %5 = alloca i32*, align 8
  %6 = alloca i32, align 4
  %7 = alloca float, align 4
  %8 = alloca float, align 4
  %9 = alloca float*, align 8
  %10 = alloca float*, align 8
  %11 = alloca i32, align 4
  %12 = alloca float, align 4
  %13 = alloca float*, align 8
  %14 = alloca i32, align 4
  %f_idx2reduce = alloca i32*, align 8
  %f_val2reduce = alloca float*, align 8
  %alpha_i_diff = alloca float*, align 8
  %alpha_j_diff = alloca float*, align 8
  %kd = alloca float*, align 8
  %tid = alloca i32, align 4
  %wsi = alloca i32, align 4
  %y = alloca float, align 4
  %f = alloca float, align 4
  %a = alloca float, align 4
  %aold = alloca float, align 4
  %local_eps = alloca float, align 4
  %numOfIter = alloca i32, align 4
  %i = alloca i32, align 4
  %up_value = alloca float, align 4
  %kIwsI = alloca float, align 4
  %j1 = alloca i32, align 4
  %low_value = alloca float, align 4
  %local_diff = alloca float, align 4
  %aIJ = alloca float, align 4
  %bIJ = alloca float, align 4
  %j2 = alloca i32, align 4
  %l = alloca float, align 4
  %kJ2wsI = alloca float, align 4
  store i32* %label, i32** %1, align 8
  call void @llvm.dbg.declare(metadata !{i32** %1}, metadata !57), !dbg !58
  store float* %f_val, float** %2, align 8
  call void @llvm.dbg.declare(metadata !{float** %2}, metadata !59), !dbg !58
  store float* %alpha, float** %3, align 8
  call void @llvm.dbg.declare(metadata !{float** %3}, metadata !60), !dbg !58
  store float* %alpha_diff, float** %4, align 8
  call void @llvm.dbg.declare(metadata !{float** %4}, metadata !61), !dbg !58
  store i32* %working_set, i32** %5, align 8
  call void @llvm.dbg.declare(metadata !{i32** %5}, metadata !62), !dbg !63
  store i32 %ws_size, i32* %6, align 4
  call void @llvm.dbg.declare(metadata !{i32* %6}, metadata !64), !dbg !63
  store float %Cp, float* %7, align 4
  call void @llvm.dbg.declare(metadata !{float* %7}, metadata !65), !dbg !66
  store float %Cn, float* %8, align 4
  call void @llvm.dbg.declare(metadata !{float* %8}, metadata !67), !dbg !66
  store float* %k_mat_rows, float** %9, align 8
  call void @llvm.dbg.declare(metadata !{float** %9}, metadata !68), !dbg !66
  store float* %k_mat_diag, float** %10, align 8
  call void @llvm.dbg.declare(metadata !{float** %10}, metadata !69), !dbg !66
  store i32 %row_len, i32* %11, align 4
  call void @llvm.dbg.declare(metadata !{i32* %11}, metadata !70), !dbg !66
  store float %eps, float* %12, align 4
  call void @llvm.dbg.declare(metadata !{float* %12}, metadata !71), !dbg !72
  store float* %diff, float** %13, align 8
  call void @llvm.dbg.declare(metadata !{float** %13}, metadata !73), !dbg !74
  store i32 %max_t_iter, i32* %14, align 4
  call void @llvm.dbg.declare(metadata !{i32* %14}, metadata !75), !dbg !74
  call void @llvm.dbg.declare(metadata !{i32** %f_idx2reduce}, metadata !76), !dbg !78
  store i32* getelementptr inbounds ([256 x i32]* @_ZZ18c_smo_solve_kernelPKiPfS1_S1_S0_iffPKfS3_ifS1_iE10shared_mem, i32 0, i32 0), i32** %f_idx2reduce, align 8, !dbg !78
  call void @llvm.dbg.declare(metadata !{float** %f_val2reduce}, metadata !79), !dbg !80
  %15 = load i32* %6, align 4, !dbg !80
  %16 = sext i32 %15 to i64, !dbg !80
  %17 = getelementptr inbounds [256 x i32]* @_ZZ18c_smo_solve_kernelPKiPfS1_S1_S0_iffPKfS3_ifS1_iE10shared_mem, i32 0, i64 %16, !dbg !80
  %18 = bitcast i32* %17 to float*, !dbg !80
  store float* %18, float** %f_val2reduce, align 8, !dbg !80
  call void @llvm.dbg.declare(metadata !{float** %alpha_i_diff}, metadata !81), !dbg !82
  %19 = load i32* %6, align 4, !dbg !82
  %20 = sext i32 %19 to i64, !dbg !82
  %21 = load i32* %6, align 4, !dbg !82
  %22 = sext i32 %21 to i64, !dbg !82
  %23 = mul i64 %22, 4, !dbg !82
  %24 = udiv i64 %23, 4, !dbg !82
  %25 = add i64 %20, %24, !dbg !82
  %26 = getelementptr inbounds [256 x i32]* @_ZZ18c_smo_solve_kernelPKiPfS1_S1_S0_iffPKfS3_ifS1_iE10shared_mem, i32 0, i64 %25, !dbg !82
  %27 = bitcast i32* %26 to float*, !dbg !82
  store float* %27, float** %alpha_i_diff, align 8, !dbg !82
  call void @llvm.dbg.declare(metadata !{float** %alpha_j_diff}, metadata !83), !dbg !84
  %28 = load float** %alpha_i_diff, align 8, !dbg !84
  %29 = getelementptr inbounds float* %28, i64 1, !dbg !84
  store float* %29, float** %alpha_j_diff, align 8, !dbg !84
  call void @llvm.dbg.declare(metadata !{float** %kd}, metadata !85), !dbg !86
  %30 = load float** %alpha_j_diff, align 8, !dbg !86
  %31 = getelementptr inbounds float* %30, i64 1, !dbg !86
  store float* %31, float** %kd, align 8, !dbg !86
  call void @llvm.dbg.declare(metadata !{i32* %tid}, metadata !87), !dbg !88
  %32 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !88
  store i32 %32, i32* %tid, align 4, !dbg !88
  call void @llvm.dbg.declare(metadata !{i32* %wsi}, metadata !89), !dbg !90
  %33 = load i32* %tid, align 4, !dbg !90
  %34 = sext i32 %33 to i64, !dbg !90
  %35 = load i32** %5, align 8, !dbg !90
  %36 = getelementptr inbounds i32* %35, i64 %34, !dbg !90
  %37 = load i32* %36, align 4, !dbg !90
  store i32 %37, i32* %wsi, align 4, !dbg !90
  %38 = load i32* %wsi, align 4, !dbg !91
  %39 = sext i32 %38 to i64, !dbg !91
  %40 = load float** %10, align 8, !dbg !91
  %41 = getelementptr inbounds float* %40, i64 %39, !dbg !91
  %42 = load float* %41, align 4, !dbg !91
  %43 = load i32* %tid, align 4, !dbg !91
  %44 = sext i32 %43 to i64, !dbg !91
  %45 = load float** %kd, align 8, !dbg !91
  %46 = getelementptr inbounds float* %45, i64 %44, !dbg !91
  store float %42, float* %46, align 4, !dbg !91
  call void @llvm.dbg.declare(metadata !{float* %y}, metadata !92), !dbg !93
  %47 = load i32* %wsi, align 4, !dbg !93
  %48 = sext i32 %47 to i64, !dbg !93
  %49 = load i32** %1, align 8, !dbg !93
  %50 = getelementptr inbounds i32* %49, i64 %48, !dbg !93
  %51 = load i32* %50, align 4, !dbg !93
  %52 = sitofp i32 %51 to float, !dbg !93
  store float %52, float* %y, align 4, !dbg !93
  call void @llvm.dbg.declare(metadata !{float* %f}, metadata !94), !dbg !95
  %53 = load i32* %wsi, align 4, !dbg !95
  %54 = sext i32 %53 to i64, !dbg !95
  %55 = load float** %2, align 8, !dbg !95
  %56 = getelementptr inbounds float* %55, i64 %54, !dbg !95
  %57 = load float* %56, align 4, !dbg !95
  store float %57, float* %f, align 4, !dbg !95
  call void @llvm.dbg.declare(metadata !{float* %a}, metadata !96), !dbg !97
  %58 = load i32* %wsi, align 4, !dbg !97
  %59 = sext i32 %58 to i64, !dbg !97
  %60 = load float** %3, align 8, !dbg !97
  %61 = getelementptr inbounds float* %60, i64 %59, !dbg !97
  %62 = load float* %61, align 4, !dbg !97
  store float %62, float* %a, align 4, !dbg !97
  call void @llvm.dbg.declare(metadata !{float* %aold}, metadata !98), !dbg !99
  %63 = load float* %a, align 4, !dbg !99
  store float %63, float* %aold, align 4, !dbg !99
  call void @__syncthreads(), !dbg !100
  call void @llvm.dbg.declare(metadata !{float* %local_eps}, metadata !101), !dbg !102
  call void @llvm.dbg.declare(metadata !{i32* %numOfIter}, metadata !103), !dbg !104
  store i32 0, i32* %numOfIter, align 4, !dbg !104
  br label %64, !dbg !105

; <label>:64                                      ; preds = %300, %0
  %65 = load float* %a, align 4, !dbg !106
  %66 = load float* %y, align 4, !dbg !106
  %67 = load float* %7, align 4, !dbg !106
  %68 = load float* %8, align 4, !dbg !106
  %69 = call zeroext i1 @_Z7is_I_upffff(float %65, float %66, float %67, float %68), !dbg !106
  br i1 %69, label %70, label %76, !dbg !106

; <label>:70                                      ; preds = %64
  %71 = load float* %f, align 4, !dbg !108
  %72 = load i32* %tid, align 4, !dbg !108
  %73 = sext i32 %72 to i64, !dbg !108
  %74 = load float** %f_val2reduce, align 8, !dbg !108
  %75 = getelementptr inbounds float* %74, i64 %73, !dbg !108
  store float %71, float* %75, align 4, !dbg !108
  br label %81, !dbg !108

; <label>:76                                      ; preds = %64
  %77 = load i32* %tid, align 4, !dbg !109
  %78 = sext i32 %77 to i64, !dbg !109
  %79 = load float** %f_val2reduce, align 8, !dbg !109
  %80 = getelementptr inbounds float* %79, i64 %78, !dbg !109
  store float 0x7FF0000000000000, float* %80, align 4, !dbg !109
  br label %81

; <label>:81                                      ; preds = %76, %70
  call void @llvm.dbg.declare(metadata !{i32* %i}, metadata !110), !dbg !111
  %82 = load float** %f_val2reduce, align 8, !dbg !111
  %83 = load i32** %f_idx2reduce, align 8, !dbg !111
  %84 = call i32 @_Z15get_block_min_tPKfPi(float* %82, i32* %83), !dbg !111
  store i32 %84, i32* %i, align 4, !dbg !111
  call void @llvm.dbg.declare(metadata !{float* %up_value}, metadata !112), !dbg !113
  %85 = load i32* %i, align 4, !dbg !113
  %86 = sext i32 %85 to i64, !dbg !113
  %87 = load float** %f_val2reduce, align 8, !dbg !113
  %88 = getelementptr inbounds float* %87, i64 %86, !dbg !113
  %89 = load float* %88, align 4, !dbg !113
  store float %89, float* %up_value, align 4, !dbg !113
  call void @llvm.dbg.declare(metadata !{float* %kIwsI}, metadata !114), !dbg !115
  %90 = load i32* %11, align 4, !dbg !115
  %91 = load i32* %i, align 4, !dbg !115
  %92 = mul nsw i32 %90, %91, !dbg !115
  %93 = load i32* %wsi, align 4, !dbg !115
  %94 = add nsw i32 %92, %93, !dbg !115
  %95 = sext i32 %94 to i64, !dbg !115
  %96 = load float** %9, align 8, !dbg !115
  %97 = getelementptr inbounds float* %96, i64 %95, !dbg !115
  %98 = load float* %97, align 4, !dbg !115
  store float %98, float* %kIwsI, align 4, !dbg !115
  call void @__syncthreads(), !dbg !116
  %99 = load float* %a, align 4, !dbg !117
  %100 = load float* %y, align 4, !dbg !117
  %101 = load float* %7, align 4, !dbg !117
  %102 = load float* %8, align 4, !dbg !117
  %103 = call zeroext i1 @_Z8is_I_lowffff(float %99, float %100, float %101, float %102), !dbg !117
  br i1 %103, label %104, label %111, !dbg !117

; <label>:104                                     ; preds = %81
  %105 = load float* %f, align 4, !dbg !118
  %106 = fsub float -0.000000e+00, %105, !dbg !118
  %107 = load i32* %tid, align 4, !dbg !118
  %108 = sext i32 %107 to i64, !dbg !118
  %109 = load float** %f_val2reduce, align 8, !dbg !118
  %110 = getelementptr inbounds float* %109, i64 %108, !dbg !118
  store float %106, float* %110, align 4, !dbg !118
  br label %116, !dbg !118

; <label>:111                                     ; preds = %81
  %112 = load i32* %tid, align 4, !dbg !119
  %113 = sext i32 %112 to i64, !dbg !119
  %114 = load float** %f_val2reduce, align 8, !dbg !119
  %115 = getelementptr inbounds float* %114, i64 %113, !dbg !119
  store float 0x7FF0000000000000, float* %115, align 4, !dbg !119
  br label %116

; <label>:116                                     ; preds = %111, %104
  call void @llvm.dbg.declare(metadata !{i32* %j1}, metadata !120), !dbg !121
  %117 = load float** %f_val2reduce, align 8, !dbg !121
  %118 = load i32** %f_idx2reduce, align 8, !dbg !121
  %119 = call i32 @_Z15get_block_min_tPKfPi(float* %117, i32* %118), !dbg !121
  store i32 %119, i32* %j1, align 4, !dbg !121
  call void @llvm.dbg.declare(metadata !{float* %low_value}, metadata !122), !dbg !123
  %120 = load i32* %j1, align 4, !dbg !123
  %121 = sext i32 %120 to i64, !dbg !123
  %122 = load float** %f_val2reduce, align 8, !dbg !123
  %123 = getelementptr inbounds float* %122, i64 %121, !dbg !123
  %124 = load float* %123, align 4, !dbg !123
  %125 = fsub float -0.000000e+00, %124, !dbg !123
  store float %125, float* %low_value, align 4, !dbg !123
  call void @llvm.dbg.declare(metadata !{float* %local_diff}, metadata !124), !dbg !125
  %126 = load float* %low_value, align 4, !dbg !125
  %127 = load float* %up_value, align 4, !dbg !125
  %128 = fsub float %126, %127, !dbg !125
  store float %128, float* %local_diff, align 4, !dbg !125
  %129 = load i32* %numOfIter, align 4, !dbg !126
  %130 = icmp eq i32 %129, 0, !dbg !126
  br i1 %130, label %131, label %144, !dbg !126

; <label>:131                                     ; preds = %116
  %132 = load float* %12, align 4, !dbg !127
  %133 = load float* %local_diff, align 4, !dbg !127
  %134 = fmul float 0x3FB99999A0000000, %133, !dbg !127
  %135 = call zeroext i1 @_Z5max_tff(float %132, float %134), !dbg !127
  %136 = uitofp i1 %135 to float, !dbg !127
  store float %136, float* %local_eps, align 4, !dbg !127
  %137 = load i32* %tid, align 4, !dbg !129
  %138 = icmp eq i32 %137, 0, !dbg !129
  br i1 %138, label %139, label %143, !dbg !129

; <label>:139                                     ; preds = %131
  %140 = load float* %local_diff, align 4, !dbg !130
  %141 = load float** %13, align 8, !dbg !130
  %142 = getelementptr inbounds float* %141, i64 0, !dbg !130
  store float %140, float* %142, align 4, !dbg !130
  br label %143, !dbg !132

; <label>:143                                     ; preds = %139, %131
  br label %144, !dbg !133

; <label>:144                                     ; preds = %143, %116
  %145 = load i32* %numOfIter, align 4, !dbg !134
  %146 = load i32* %14, align 4, !dbg !134
  %147 = icmp sgt i32 %145, %146, !dbg !134
  br i1 %147, label %152, label %148, !dbg !134

; <label>:148                                     ; preds = %144
  %149 = load float* %local_diff, align 4, !dbg !134
  %150 = load float* %local_eps, align 4, !dbg !134
  %151 = fcmp olt float %149, %150, !dbg !134
  br i1 %151, label %152, label %172, !dbg !134

; <label>:152                                     ; preds = %148, %144
  %153 = load float* %a, align 4, !dbg !135
  %154 = load i32* %wsi, align 4, !dbg !135
  %155 = sext i32 %154 to i64, !dbg !135
  %156 = load float** %3, align 8, !dbg !135
  %157 = getelementptr inbounds float* %156, i64 %155, !dbg !135
  store float %153, float* %157, align 4, !dbg !135
  %158 = load float* %a, align 4, !dbg !137
  %159 = load float* %aold, align 4, !dbg !137
  %160 = fsub float %158, %159, !dbg !137
  %161 = fsub float -0.000000e+00, %160, !dbg !137
  %162 = load float* %y, align 4, !dbg !137
  %163 = fmul float %161, %162, !dbg !137
  %164 = load i32* %tid, align 4, !dbg !137
  %165 = sext i32 %164 to i64, !dbg !137
  %166 = load float** %4, align 8, !dbg !137
  %167 = getelementptr inbounds float* %166, i64 %165, !dbg !137
  store float %163, float* %167, align 4, !dbg !137
  %168 = load i32* %numOfIter, align 4, !dbg !138
  %169 = sitofp i32 %168 to float, !dbg !138
  %170 = load float** %13, align 8, !dbg !138
  %171 = getelementptr inbounds float* %170, i64 1, !dbg !138
  store float %169, float* %171, align 4, !dbg !138
  br label %319, !dbg !139

; <label>:172                                     ; preds = %148
  call void @__syncthreads(), !dbg !140
  %173 = load float* %up_value, align 4, !dbg !141
  %174 = fsub float -0.000000e+00, %173, !dbg !141
  %175 = load float* %f, align 4, !dbg !141
  %176 = fsub float -0.000000e+00, %175, !dbg !141
  %177 = fcmp ogt float %174, %176, !dbg !141
  br i1 %177, label %178, label %213, !dbg !141

; <label>:178                                     ; preds = %172
  %179 = load float* %a, align 4, !dbg !141
  %180 = load float* %y, align 4, !dbg !141
  %181 = load float* %7, align 4, !dbg !141
  %182 = load float* %8, align 4, !dbg !141
  %183 = call zeroext i1 @_Z8is_I_lowffff(float %179, float %180, float %181, float %182), !dbg !141
  br i1 %183, label %184, label %213, !dbg !141

; <label>:184                                     ; preds = %178
  call void @llvm.dbg.declare(metadata !{float* %aIJ}, metadata !142), !dbg !144
  %185 = load i32* %i, align 4, !dbg !144
  %186 = sext i32 %185 to i64, !dbg !144
  %187 = load float** %kd, align 8, !dbg !144
  %188 = getelementptr inbounds float* %187, i64 %186, !dbg !144
  %189 = load float* %188, align 4, !dbg !144
  %190 = load i32* %tid, align 4, !dbg !144
  %191 = sext i32 %190 to i64, !dbg !144
  %192 = load float** %kd, align 8, !dbg !144
  %193 = getelementptr inbounds float* %192, i64 %191, !dbg !144
  %194 = load float* %193, align 4, !dbg !144
  %195 = fadd float %189, %194, !dbg !144
  %196 = load float* %kIwsI, align 4, !dbg !144
  %197 = fmul float 2.000000e+00, %196, !dbg !144
  %198 = fsub float %195, %197, !dbg !144
  store float %198, float* %aIJ, align 4, !dbg !144
  call void @llvm.dbg.declare(metadata !{float* %bIJ}, metadata !145), !dbg !146
  %199 = load float* %up_value, align 4, !dbg !146
  %200 = fsub float -0.000000e+00, %199, !dbg !146
  %201 = load float* %f, align 4, !dbg !146
  %202 = fadd float %200, %201, !dbg !146
  store float %202, float* %bIJ, align 4, !dbg !146
  %203 = load float* %bIJ, align 4, !dbg !147
  %204 = fsub float -0.000000e+00, %203, !dbg !147
  %205 = load float* %bIJ, align 4, !dbg !147
  %206 = fmul float %204, %205, !dbg !147
  %207 = load float* %aIJ, align 4, !dbg !147
  %208 = fdiv float %206, %207, !dbg !147
  %209 = load i32* %tid, align 4, !dbg !147
  %210 = sext i32 %209 to i64, !dbg !147
  %211 = load float** %f_val2reduce, align 8, !dbg !147
  %212 = getelementptr inbounds float* %211, i64 %210, !dbg !147
  store float %208, float* %212, align 4, !dbg !147
  br label %218, !dbg !148

; <label>:213                                     ; preds = %178, %172
  %214 = load i32* %tid, align 4, !dbg !149
  %215 = sext i32 %214 to i64, !dbg !149
  %216 = load float** %f_val2reduce, align 8, !dbg !149
  %217 = getelementptr inbounds float* %216, i64 %215, !dbg !149
  store float 0x7FF0000000000000, float* %217, align 4, !dbg !149
  br label %218

; <label>:218                                     ; preds = %213, %184
  call void @llvm.dbg.declare(metadata !{i32* %j2}, metadata !150), !dbg !151
  %219 = load float** %f_val2reduce, align 8, !dbg !151
  %220 = load i32** %f_idx2reduce, align 8, !dbg !151
  %221 = call i32 @_Z15get_block_min_tPKfPi(float* %219, i32* %220), !dbg !151
  store i32 %221, i32* %j2, align 4, !dbg !151
  %222 = load i32* %tid, align 4, !dbg !152
  %223 = load i32* %i, align 4, !dbg !152
  %224 = icmp eq i32 %222, %223, !dbg !152
  br i1 %224, label %225, label %237, !dbg !152

; <label>:225                                     ; preds = %218
  %226 = load float* %y, align 4, !dbg !153
  %227 = fcmp ogt float %226, 0.000000e+00, !dbg !153
  br i1 %227, label %228, label %232, !dbg !153

; <label>:228                                     ; preds = %225
  %229 = load float* %7, align 4, !dbg !153
  %230 = load float* %a, align 4, !dbg !153
  %231 = fsub float %229, %230, !dbg !153
  br label %234, !dbg !153

; <label>:232                                     ; preds = %225
  %233 = load float* %a, align 4, !dbg !153
  br label %234, !dbg !153

; <label>:234                                     ; preds = %232, %228
  %235 = phi float [ %231, %228 ], [ %233, %232 ], !dbg !153
  %236 = load float** %alpha_i_diff, align 8, !dbg !153
  store float %235, float* %236, align 4, !dbg !153
  br label %237, !dbg !153

; <label>:237                                     ; preds = %234, %218
  %238 = load i32* %tid, align 4, !dbg !154
  %239 = load i32* %j2, align 4, !dbg !154
  %240 = icmp eq i32 %238, %239, !dbg !154
  br i1 %240, label %241, label %274, !dbg !154

; <label>:241                                     ; preds = %237
  %242 = load float* %y, align 4, !dbg !155
  %243 = fcmp ogt float %242, 0.000000e+00, !dbg !155
  br i1 %243, label %244, label %246, !dbg !155

; <label>:244                                     ; preds = %241
  %245 = load float* %a, align 4, !dbg !155
  br label %250, !dbg !155

; <label>:246                                     ; preds = %241
  %247 = load float* %8, align 4, !dbg !155
  %248 = load float* %a, align 4, !dbg !155
  %249 = fsub float %247, %248, !dbg !155
  br label %250, !dbg !155

; <label>:250                                     ; preds = %246, %244
  %251 = phi float [ %245, %244 ], [ %249, %246 ], !dbg !155
  %252 = load float* %up_value, align 4, !dbg !155
  %253 = fsub float -0.000000e+00, %252, !dbg !155
  %254 = load float* %f, align 4, !dbg !155
  %255 = fadd float %253, %254, !dbg !155
  %256 = load i32* %i, align 4, !dbg !155
  %257 = sext i32 %256 to i64, !dbg !155
  %258 = load float** %kd, align 8, !dbg !155
  %259 = getelementptr inbounds float* %258, i64 %257, !dbg !155
  %260 = load float* %259, align 4, !dbg !155
  %261 = load i32* %j2, align 4, !dbg !155
  %262 = sext i32 %261 to i64, !dbg !155
  %263 = load float** %kd, align 8, !dbg !155
  %264 = getelementptr inbounds float* %263, i64 %262, !dbg !155
  %265 = load float* %264, align 4, !dbg !155
  %266 = fadd float %260, %265, !dbg !155
  %267 = load float* %kIwsI, align 4, !dbg !155
  %268 = fmul float 2.000000e+00, %267, !dbg !155
  %269 = fsub float %266, %268, !dbg !155
  %270 = fdiv float %255, %269, !dbg !155
  %271 = call zeroext i1 @_Z5min_tff(float %251, float %270), !dbg !155
  %272 = uitofp i1 %271 to float, !dbg !155
  %273 = load float** %alpha_j_diff, align 8, !dbg !155
  store float %272, float* %273, align 4, !dbg !155
  br label %274, !dbg !155

; <label>:274                                     ; preds = %250, %237
  call void @__syncthreads(), !dbg !156
  call void @llvm.dbg.declare(metadata !{float* %l}, metadata !157), !dbg !158
  %275 = load float** %alpha_i_diff, align 8, !dbg !158
  %276 = load float* %275, align 4, !dbg !158
  %277 = load float** %alpha_j_diff, align 8, !dbg !158
  %278 = load float* %277, align 4, !dbg !158
  %279 = call zeroext i1 @_Z5min_tff(float %276, float %278), !dbg !158
  %280 = uitofp i1 %279 to float, !dbg !158
  store float %280, float* %l, align 4, !dbg !158
  %281 = load i32* %tid, align 4, !dbg !159
  %282 = load i32* %i, align 4, !dbg !159
  %283 = icmp eq i32 %281, %282, !dbg !159
  br i1 %283, label %284, label %290, !dbg !159

; <label>:284                                     ; preds = %274
  %285 = load float* %l, align 4, !dbg !160
  %286 = load float* %y, align 4, !dbg !160
  %287 = fmul float %285, %286, !dbg !160
  %288 = load float* %a, align 4, !dbg !160
  %289 = fadd float %288, %287, !dbg !160
  store float %289, float* %a, align 4, !dbg !160
  br label %290, !dbg !160

; <label>:290                                     ; preds = %284, %274
  %291 = load i32* %tid, align 4, !dbg !161
  %292 = load i32* %j2, align 4, !dbg !161
  %293 = icmp eq i32 %291, %292, !dbg !161
  br i1 %293, label %294, label %300, !dbg !161

; <label>:294                                     ; preds = %290
  %295 = load float* %l, align 4, !dbg !162
  %296 = load float* %y, align 4, !dbg !162
  %297 = fmul float %295, %296, !dbg !162
  %298 = load float* %a, align 4, !dbg !162
  %299 = fsub float %298, %297, !dbg !162
  store float %299, float* %a, align 4, !dbg !162
  br label %300, !dbg !162

; <label>:300                                     ; preds = %294, %290
  call void @llvm.dbg.declare(metadata !{float* %kJ2wsI}, metadata !163), !dbg !164
  %301 = load i32* %11, align 4, !dbg !164
  %302 = load i32* %j2, align 4, !dbg !164
  %303 = mul nsw i32 %301, %302, !dbg !164
  %304 = load i32* %wsi, align 4, !dbg !164
  %305 = add nsw i32 %303, %304, !dbg !164
  %306 = sext i32 %305 to i64, !dbg !164
  %307 = load float** %9, align 8, !dbg !164
  %308 = getelementptr inbounds float* %307, i64 %306, !dbg !164
  %309 = load float* %308, align 4, !dbg !164
  store float %309, float* %kJ2wsI, align 4, !dbg !164
  %310 = load float* %l, align 4, !dbg !165
  %311 = load float* %kJ2wsI, align 4, !dbg !165
  %312 = load float* %kIwsI, align 4, !dbg !165
  %313 = fsub float %311, %312, !dbg !165
  %314 = fmul float %310, %313, !dbg !165
  %315 = load float* %f, align 4, !dbg !165
  %316 = fsub float %315, %314, !dbg !165
  store float %316, float* %f, align 4, !dbg !165
  %317 = load i32* %numOfIter, align 4, !dbg !166
  %318 = add nsw i32 %317, 1, !dbg !166
  store i32 %318, i32* %numOfIter, align 4, !dbg !166
  br label %64, !dbg !167

; <label>:319                                     ; preds = %152
  ret void, !dbg !168
}

define linkonce_odr zeroext i1 @_Z7is_I_upffff(float %a, float %y, float %Cp, float %Cn) nounwind uwtable inlinehint section "__device__" {
  %1 = alloca float, align 4
  %2 = alloca float, align 4
  %3 = alloca float, align 4
  %4 = alloca float, align 4
  store float %a, float* %1, align 4
  call void @llvm.dbg.declare(metadata !{float* %1}, metadata !169), !dbg !170
  store float %y, float* %2, align 4
  call void @llvm.dbg.declare(metadata !{float* %2}, metadata !171), !dbg !170
  store float %Cp, float* %3, align 4
  call void @llvm.dbg.declare(metadata !{float* %3}, metadata !172), !dbg !170
  store float %Cn, float* %4, align 4
  call void @llvm.dbg.declare(metadata !{float* %4}, metadata !173), !dbg !170
  %5 = load float* %2, align 4, !dbg !174
  %6 = fcmp ogt float %5, 0.000000e+00, !dbg !174
  br i1 %6, label %7, label %11, !dbg !174

; <label>:7                                       ; preds = %0
  %8 = load float* %1, align 4, !dbg !174
  %9 = load float* %3, align 4, !dbg !174
  %10 = fcmp olt float %8, %9, !dbg !174
  br i1 %10, label %19, label %11, !dbg !174

; <label>:11                                      ; preds = %7, %0
  %12 = load float* %2, align 4, !dbg !174
  %13 = fcmp olt float %12, 0.000000e+00, !dbg !174
  br i1 %13, label %14, label %17, !dbg !174

; <label>:14                                      ; preds = %11
  %15 = load float* %1, align 4, !dbg !174
  %16 = fcmp ogt float %15, 0.000000e+00, !dbg !174
  br label %17

; <label>:17                                      ; preds = %14, %11
  %18 = phi i1 [ false, %11 ], [ %16, %14 ]
  br label %19

; <label>:19                                      ; preds = %17, %7
  %20 = phi i1 [ true, %7 ], [ %18, %17 ]
  ret i1 %20, !dbg !176
}

define linkonce_odr zeroext i1 @_Z8is_I_lowffff(float %a, float %y, float %Cp, float %Cn) nounwind uwtable inlinehint section "__device__" {
  %1 = alloca float, align 4
  %2 = alloca float, align 4
  %3 = alloca float, align 4
  %4 = alloca float, align 4
  store float %a, float* %1, align 4
  call void @llvm.dbg.declare(metadata !{float* %1}, metadata !177), !dbg !178
  store float %y, float* %2, align 4
  call void @llvm.dbg.declare(metadata !{float* %2}, metadata !179), !dbg !178
  store float %Cp, float* %3, align 4
  call void @llvm.dbg.declare(metadata !{float* %3}, metadata !180), !dbg !178
  store float %Cn, float* %4, align 4
  call void @llvm.dbg.declare(metadata !{float* %4}, metadata !181), !dbg !178
  %5 = load float* %2, align 4, !dbg !182
  %6 = fcmp ogt float %5, 0.000000e+00, !dbg !182
  br i1 %6, label %7, label %10, !dbg !182

; <label>:7                                       ; preds = %0
  %8 = load float* %1, align 4, !dbg !182
  %9 = fcmp ogt float %8, 0.000000e+00, !dbg !182
  br i1 %9, label %19, label %10, !dbg !182

; <label>:10                                      ; preds = %7, %0
  %11 = load float* %2, align 4, !dbg !182
  %12 = fcmp olt float %11, 0.000000e+00, !dbg !182
  br i1 %12, label %13, label %17, !dbg !182

; <label>:13                                      ; preds = %10
  %14 = load float* %1, align 4, !dbg !182
  %15 = load float* %4, align 4, !dbg !182
  %16 = fcmp olt float %14, %15, !dbg !182
  br label %17

; <label>:17                                      ; preds = %13, %10
  %18 = phi i1 [ false, %10 ], [ %16, %13 ]
  br label %19

; <label>:19                                      ; preds = %17, %7
  %20 = phi i1 [ true, %7 ], [ %18, %17 ]
  ret i1 %20, !dbg !184
}

define linkonce_odr zeroext i1 @_Z5max_tff(float %a, float %y) nounwind uwtable inlinehint section "__device__" {
  %1 = alloca float, align 4
  %2 = alloca float, align 4
  store float %a, float* %1, align 4
  call void @llvm.dbg.declare(metadata !{float* %1}, metadata !185), !dbg !186
  store float %y, float* %2, align 4
  call void @llvm.dbg.declare(metadata !{float* %2}, metadata !187), !dbg !186
  %3 = load float* %1, align 4, !dbg !188
  %4 = load float* %2, align 4, !dbg !188
  %5 = fcmp ogt float %3, %4, !dbg !188
  %6 = load float* %1, align 4, !dbg !188
  %7 = load float* %2, align 4, !dbg !188
  %8 = select i1 %5, float %6, float %7, !dbg !188
  %9 = fcmp une float %8, 0.000000e+00, !dbg !188
  ret i1 %9, !dbg !188
}

define linkonce_odr zeroext i1 @_Z5min_tff(float %a, float %y) nounwind uwtable inlinehint section "__device__" {
  %1 = alloca float, align 4
  %2 = alloca float, align 4
  store float %a, float* %1, align 4
  call void @llvm.dbg.declare(metadata !{float* %1}, metadata !190), !dbg !191
  store float %y, float* %2, align 4
  call void @llvm.dbg.declare(metadata !{float* %2}, metadata !192), !dbg !191
  %3 = load float* %1, align 4, !dbg !193
  %4 = load float* %2, align 4, !dbg !193
  %5 = fcmp ogt float %3, %4, !dbg !193
  %6 = load float* %2, align 4, !dbg !193
  %7 = load float* %1, align 4, !dbg !193
  %8 = select i1 %5, float %6, float %7, !dbg !193
  %9 = fcmp une float %8, 0.000000e+00, !dbg !193
  ret i1 %9, !dbg !193
}

!llvm.dbg.cu = !{!0}

!0 = metadata !{i32 786449, i32 0, i32 4, metadata !"new-fun.cpp", metadata !"/home/mingyuanwu/thundersvm-new-bug", metadata !"clang version 3.2 (tags/RELEASE_32/final)", i1 true, i1 false, metadata !"", i32 0, metadata !1, metadata !1, metadata !3, metadata !29} ; [ DW_TAG_compile_unit ] [/home/mingyuanwu/thundersvm-new-bug/new-fun.cpp] [DW_LANG_C_plus_plus]
!1 = metadata !{metadata !2}
!2 = metadata !{i32 0}
!3 = metadata !{metadata !4}
!4 = metadata !{metadata !5, metadata !14, metadata !20, metadata !24, metadata !25, metadata !28}
!5 = metadata !{i32 786478, i32 0, metadata !6, metadata !"get_block_min_t", metadata !"get_block_min_t", metadata !"_Z15get_block_min_tPKfPi", metadata !6, i32 21, metadata !7, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, i32 (float*, i32*)* @_Z15get_block_min_tPKfPi, null, null, metadata !1, i32 21} ; [ DW_TAG_subprogram ] [line 21] [def] [get_block_min_t]
!6 = metadata !{i32 786473, metadata !"new-fun.cpp", metadata !"/home/mingyuanwu/thundersvm-new-bug", null} ; [ DW_TAG_file_type ]
!7 = metadata !{i32 786453, i32 0, metadata !"", i32 0, i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !8, i32 0, i32 0} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!8 = metadata !{metadata !9, metadata !10, metadata !13}
!9 = metadata !{i32 786468, null, metadata !"int", null, i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!10 = metadata !{i32 786447, null, metadata !"", null, i32 0, i64 64, i64 64, i64 0, i32 0, metadata !11} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from ]
!11 = metadata !{i32 786470, null, metadata !"", null, i32 0, i64 0, i64 0, i64 0, i32 0, metadata !12} ; [ DW_TAG_const_type ] [line 0, size 0, align 0, offset 0] [from float]
!12 = metadata !{i32 786468, null, metadata !"float", null, i32 0, i64 32, i64 32, i64 0, i32 0, i32 4} ; [ DW_TAG_base_type ] [float] [line 0, size 32, align 32, offset 0, enc DW_ATE_float]
!13 = metadata !{i32 786447, null, metadata !"", null, i32 0, i64 64, i64 64, i64 0, i32 0, metadata !9} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from int]
!14 = metadata !{i32 786478, i32 0, metadata !6, metadata !"c_smo_solve_kernel", metadata !"c_smo_solve_kernel", metadata !"_Z18c_smo_solve_kernelPKiPfS1_S1_S0_iffPKfS3_ifS1_i", metadata !6, i32 39, metadata !15, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, void (i32*, float*, float*, float*, i32*, i32, float, float, float*, float*, i32, float, float*, i32)* @_Z18c_smo_solve_kernelPKiPfS1_S1_S0_iffPKfS3_ifS1_i, null, null, metadata !1, i32 43} ; [ DW_TAG_subprogram ] [line 39] [def] [scope 43] [c_smo_solve_kernel]
!15 = metadata !{i32 786453, i32 0, metadata !"", i32 0, i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !16, i32 0, i32 0} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!16 = metadata !{null, metadata !17, metadata !19, metadata !19, metadata !19, metadata !17, metadata !9, metadata !12, metadata !12, metadata !10, metadata !10, metadata !9, metadata !12, metadata !19, metadata !9}
!17 = metadata !{i32 786447, null, metadata !"", null, i32 0, i64 64, i64 64, i64 0, i32 0, metadata !18} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from ]
!18 = metadata !{i32 786470, null, metadata !"", null, i32 0, i64 0, i64 0, i64 0, i32 0, metadata !9} ; [ DW_TAG_const_type ] [line 0, size 0, align 0, offset 0] [from int]
!19 = metadata !{i32 786447, null, metadata !"", null, i32 0, i64 64, i64 64, i64 0, i32 0, metadata !12} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from float]
!20 = metadata !{i32 786478, i32 0, metadata !6, metadata !"min_t", metadata !"min_t", metadata !"_Z5min_tff", metadata !6, i32 13, metadata !21, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, i1 (float, float)* @_Z5min_tff, null, null, metadata !1, i32 13} ; [ DW_TAG_subprogram ] [line 13] [def] [min_t]
!21 = metadata !{i32 786453, i32 0, metadata !"", i32 0, i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !22, i32 0, i32 0} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!22 = metadata !{metadata !23, metadata !12, metadata !12}
!23 = metadata !{i32 786468, null, metadata !"bool", null, i32 0, i64 8, i64 8, i64 0, i32 0, i32 2} ; [ DW_TAG_base_type ] [bool] [line 0, size 8, align 8, offset 0, enc DW_ATE_boolean]
!24 = metadata !{i32 786478, i32 0, metadata !6, metadata !"max_t", metadata !"max_t", metadata !"_Z5max_tff", metadata !6, i32 17, metadata !21, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, i1 (float, float)* @_Z5max_tff, null, null, metadata !1, i32 17} ; [ DW_TAG_subprogram ] [line 17] [def] [max_t]
!25 = metadata !{i32 786478, i32 0, metadata !6, metadata !"is_I_low", metadata !"is_I_low", metadata !"_Z8is_I_lowffff", metadata !6, i32 5, metadata !26, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, i1 (float, float, float, float)* @_Z8is_I_lowffff, null, null, metadata !1, i32 5} ; [ DW_TAG_subprogram ] [line 5] [def] [is_I_low]
!26 = metadata !{i32 786453, i32 0, metadata !"", i32 0, i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !27, i32 0, i32 0} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!27 = metadata !{metadata !23, metadata !12, metadata !12, metadata !12, metadata !12}
!28 = metadata !{i32 786478, i32 0, metadata !6, metadata !"is_I_up", metadata !"is_I_up", metadata !"_Z7is_I_upffff", metadata !6, i32 1, metadata !26, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, i1 (float, float, float, float)* @_Z7is_I_upffff, null, null, metadata !1, i32 1} ; [ DW_TAG_subprogram ] [line 1] [def] [is_I_up]
!29 = metadata !{metadata !30}
!30 = metadata !{metadata !31}
!31 = metadata !{i32 786484, i32 0, metadata !14, metadata !"shared_mem", metadata !"shared_mem", metadata !"", metadata !6, i32 46, metadata !32, i32 1, i32 1, [256 x i32]* @_ZZ18c_smo_solve_kernelPKiPfS1_S1_S0_iffPKfS3_ifS1_iE10shared_mem} ; [ DW_TAG_variable ] [shared_mem] [line 46] [local] [def]
!32 = metadata !{i32 786433, null, metadata !"", null, i32 0, i64 8192, i64 32, i32 0, i32 0, metadata !9, metadata !33, i32 0, i32 0} ; [ DW_TAG_array_type ] [line 0, size 8192, align 32, offset 0] [from int]
!33 = metadata !{metadata !34}
!34 = metadata !{i32 786465, i64 0, i64 255}      ; [ DW_TAG_subrange_type ] [0, 255]
!35 = metadata !{i32 786689, metadata !5, metadata !"values", metadata !6, i32 16777237, metadata !10, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [values] [line 21]
!36 = metadata !{i32 21, i32 0, metadata !5, null}
!37 = metadata !{i32 786689, metadata !5, metadata !"index", metadata !6, i32 33554453, metadata !13, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [index] [line 21]
!38 = metadata !{i32 786688, metadata !39, metadata !"tid", metadata !6, i32 22, metadata !9, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [tid] [line 22]
!39 = metadata !{i32 786443, metadata !5, i32 21, i32 0, metadata !6, i32 0} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/thundersvm-new-bug/new-fun.cpp]
!40 = metadata !{i32 22, i32 0, metadata !39, null}
!41 = metadata !{i32 23, i32 0, metadata !39, null}
!42 = metadata !{i32 24, i32 0, metadata !39, null}
!43 = metadata !{i32 786688, metadata !44, metadata !"offset", metadata !6, i32 26, metadata !9, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [offset] [line 26]
!44 = metadata !{i32 786443, metadata !39, i32 26, i32 0, metadata !6, i32 1} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/thundersvm-new-bug/new-fun.cpp]
!45 = metadata !{i32 26, i32 0, metadata !44, null}
!46 = metadata !{i32 27, i32 0, metadata !47, null}
!47 = metadata !{i32 786443, metadata !44, i32 26, i32 0, metadata !6, i32 2} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/thundersvm-new-bug/new-fun.cpp]
!48 = metadata !{i32 28, i32 0, metadata !49, null}
!49 = metadata !{i32 786443, metadata !47, i32 27, i32 0, metadata !6, i32 3} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/thundersvm-new-bug/new-fun.cpp]
!50 = metadata !{i32 29, i32 0, metadata !51, null}
!51 = metadata !{i32 786443, metadata !49, i32 28, i32 0, metadata !6, i32 4} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/thundersvm-new-bug/new-fun.cpp]
!52 = metadata !{i32 30, i32 0, metadata !51, null}
!53 = metadata !{i32 31, i32 0, metadata !49, null}
!54 = metadata !{i32 32, i32 0, metadata !47, null}
!55 = metadata !{i32 33, i32 0, metadata !47, null}
!56 = metadata !{i32 34, i32 0, metadata !39, null}
!57 = metadata !{i32 786689, metadata !14, metadata !"label", metadata !6, i32 16777255, metadata !17, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [label] [line 39]
!58 = metadata !{i32 39, i32 0, metadata !14, null}
!59 = metadata !{i32 786689, metadata !14, metadata !"f_val", metadata !6, i32 33554471, metadata !19, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [f_val] [line 39]
!60 = metadata !{i32 786689, metadata !14, metadata !"alpha", metadata !6, i32 50331687, metadata !19, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [alpha] [line 39]
!61 = metadata !{i32 786689, metadata !14, metadata !"alpha_diff", metadata !6, i32 67108903, metadata !19, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [alpha_diff] [line 39]
!62 = metadata !{i32 786689, metadata !14, metadata !"working_set", metadata !6, i32 83886120, metadata !17, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [working_set] [line 40]
!63 = metadata !{i32 40, i32 0, metadata !14, null}
!64 = metadata !{i32 786689, metadata !14, metadata !"ws_size", metadata !6, i32 100663336, metadata !9, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [ws_size] [line 40]
!65 = metadata !{i32 786689, metadata !14, metadata !"Cp", metadata !6, i32 117440553, metadata !12, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [Cp] [line 41]
!66 = metadata !{i32 41, i32 0, metadata !14, null}
!67 = metadata !{i32 786689, metadata !14, metadata !"Cn", metadata !6, i32 134217769, metadata !12, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [Cn] [line 41]
!68 = metadata !{i32 786689, metadata !14, metadata !"k_mat_rows", metadata !6, i32 150994985, metadata !10, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [k_mat_rows] [line 41]
!69 = metadata !{i32 786689, metadata !14, metadata !"k_mat_diag", metadata !6, i32 167772201, metadata !10, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [k_mat_diag] [line 41]
!70 = metadata !{i32 786689, metadata !14, metadata !"row_len", metadata !6, i32 184549417, metadata !9, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [row_len] [line 41]
!71 = metadata !{i32 786689, metadata !14, metadata !"eps", metadata !6, i32 201326634, metadata !12, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [eps] [line 42]
!72 = metadata !{i32 42, i32 0, metadata !14, null}
!73 = metadata !{i32 786689, metadata !14, metadata !"diff", metadata !6, i32 218103851, metadata !19, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [diff] [line 43]
!74 = metadata !{i32 43, i32 0, metadata !14, null}
!75 = metadata !{i32 786689, metadata !14, metadata !"max_t_iter", metadata !6, i32 234881067, metadata !9, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [max_t_iter] [line 43]
!76 = metadata !{i32 786688, metadata !77, metadata !"f_idx2reduce", metadata !6, i32 47, metadata !13, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [f_idx2reduce] [line 47]
!77 = metadata !{i32 786443, metadata !14, i32 43, i32 0, metadata !6, i32 5} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/thundersvm-new-bug/new-fun.cpp]
!78 = metadata !{i32 47, i32 0, metadata !77, null}
!79 = metadata !{i32 786688, metadata !77, metadata !"f_val2reduce", metadata !6, i32 48, metadata !19, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [f_val2reduce] [line 48]
!80 = metadata !{i32 48, i32 0, metadata !77, null}
!81 = metadata !{i32 786688, metadata !77, metadata !"alpha_i_diff", metadata !6, i32 49, metadata !19, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [alpha_i_diff] [line 49]
!82 = metadata !{i32 49, i32 0, metadata !77, null}
!83 = metadata !{i32 786688, metadata !77, metadata !"alpha_j_diff", metadata !6, i32 50, metadata !19, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [alpha_j_diff] [line 50]
!84 = metadata !{i32 50, i32 0, metadata !77, null}
!85 = metadata !{i32 786688, metadata !77, metadata !"kd", metadata !6, i32 51, metadata !19, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [kd] [line 51]
!86 = metadata !{i32 51, i32 0, metadata !77, null}
!87 = metadata !{i32 786688, metadata !77, metadata !"tid", metadata !6, i32 54, metadata !9, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [tid] [line 54]
!88 = metadata !{i32 54, i32 0, metadata !77, null}
!89 = metadata !{i32 786688, metadata !77, metadata !"wsi", metadata !6, i32 55, metadata !9, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [wsi] [line 55]
!90 = metadata !{i32 55, i32 0, metadata !77, null}
!91 = metadata !{i32 56, i32 0, metadata !77, null}
!92 = metadata !{i32 786688, metadata !77, metadata !"y", metadata !6, i32 57, metadata !12, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [y] [line 57]
!93 = metadata !{i32 57, i32 0, metadata !77, null}
!94 = metadata !{i32 786688, metadata !77, metadata !"f", metadata !6, i32 58, metadata !12, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [f] [line 58]
!95 = metadata !{i32 58, i32 0, metadata !77, null}
!96 = metadata !{i32 786688, metadata !77, metadata !"a", metadata !6, i32 59, metadata !12, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [a] [line 59]
!97 = metadata !{i32 59, i32 0, metadata !77, null}
!98 = metadata !{i32 786688, metadata !77, metadata !"aold", metadata !6, i32 60, metadata !12, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [aold] [line 60]
!99 = metadata !{i32 60, i32 0, metadata !77, null}
!100 = metadata !{i32 61, i32 0, metadata !77, null}
!101 = metadata !{i32 786688, metadata !77, metadata !"local_eps", metadata !6, i32 62, metadata !12, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [local_eps] [line 62]
!102 = metadata !{i32 62, i32 0, metadata !77, null}
!103 = metadata !{i32 786688, metadata !77, metadata !"numOfIter", metadata !6, i32 63, metadata !9, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [numOfIter] [line 63]
!104 = metadata !{i32 63, i32 0, metadata !77, null}
!105 = metadata !{i32 64, i32 0, metadata !77, null}
!106 = metadata !{i32 66, i32 0, metadata !107, null}
!107 = metadata !{i32 786443, metadata !77, i32 64, i32 0, metadata !6, i32 6} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/thundersvm-new-bug/new-fun.cpp]
!108 = metadata !{i32 67, i32 0, metadata !107, null}
!109 = metadata !{i32 69, i32 0, metadata !107, null}
!110 = metadata !{i32 786688, metadata !107, metadata !"i", metadata !6, i32 70, metadata !9, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [i] [line 70]
!111 = metadata !{i32 70, i32 0, metadata !107, null}
!112 = metadata !{i32 786688, metadata !107, metadata !"up_value", metadata !6, i32 71, metadata !12, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [up_value] [line 71]
!113 = metadata !{i32 71, i32 0, metadata !107, null}
!114 = metadata !{i32 786688, metadata !107, metadata !"kIwsI", metadata !6, i32 72, metadata !12, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [kIwsI] [line 72]
!115 = metadata !{i32 72, i32 0, metadata !107, null}
!116 = metadata !{i32 73, i32 0, metadata !107, null}
!117 = metadata !{i32 75, i32 0, metadata !107, null}
!118 = metadata !{i32 76, i32 0, metadata !107, null}
!119 = metadata !{i32 78, i32 0, metadata !107, null}
!120 = metadata !{i32 786688, metadata !107, metadata !"j1", metadata !6, i32 79, metadata !9, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [j1] [line 79]
!121 = metadata !{i32 79, i32 0, metadata !107, null}
!122 = metadata !{i32 786688, metadata !107, metadata !"low_value", metadata !6, i32 80, metadata !12, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [low_value] [line 80]
!123 = metadata !{i32 80, i32 0, metadata !107, null}
!124 = metadata !{i32 786688, metadata !107, metadata !"local_diff", metadata !6, i32 82, metadata !12, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [local_diff] [line 82]
!125 = metadata !{i32 82, i32 0, metadata !107, null}
!126 = metadata !{i32 83, i32 0, metadata !107, null}
!127 = metadata !{i32 84, i32 0, metadata !128, null}
!128 = metadata !{i32 786443, metadata !107, i32 83, i32 0, metadata !6, i32 7} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/thundersvm-new-bug/new-fun.cpp]
!129 = metadata !{i32 85, i32 0, metadata !128, null}
!130 = metadata !{i32 86, i32 0, metadata !131, null}
!131 = metadata !{i32 786443, metadata !128, i32 85, i32 0, metadata !6, i32 8} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/thundersvm-new-bug/new-fun.cpp]
!132 = metadata !{i32 87, i32 0, metadata !131, null}
!133 = metadata !{i32 88, i32 0, metadata !128, null}
!134 = metadata !{i32 90, i32 0, metadata !107, null}
!135 = metadata !{i32 91, i32 0, metadata !136, null}
!136 = metadata !{i32 786443, metadata !107, i32 90, i32 0, metadata !6, i32 9} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/thundersvm-new-bug/new-fun.cpp]
!137 = metadata !{i32 92, i32 0, metadata !136, null}
!138 = metadata !{i32 93, i32 0, metadata !136, null}
!139 = metadata !{i32 94, i32 0, metadata !136, null}
!140 = metadata !{i32 96, i32 0, metadata !107, null}
!141 = metadata !{i32 99, i32 0, metadata !107, null}
!142 = metadata !{i32 786688, metadata !143, metadata !"aIJ", metadata !6, i32 100, metadata !12, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [aIJ] [line 100]
!143 = metadata !{i32 786443, metadata !107, i32 99, i32 0, metadata !6, i32 10} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/thundersvm-new-bug/new-fun.cpp]
!144 = metadata !{i32 100, i32 0, metadata !143, null}
!145 = metadata !{i32 786688, metadata !143, metadata !"bIJ", metadata !6, i32 101, metadata !12, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [bIJ] [line 101]
!146 = metadata !{i32 101, i32 0, metadata !143, null}
!147 = metadata !{i32 102, i32 0, metadata !143, null}
!148 = metadata !{i32 103, i32 0, metadata !143, null}
!149 = metadata !{i32 104, i32 0, metadata !107, null}
!150 = metadata !{i32 786688, metadata !107, metadata !"j2", metadata !6, i32 105, metadata !9, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [j2] [line 105]
!151 = metadata !{i32 105, i32 0, metadata !107, null}
!152 = metadata !{i32 108, i32 0, metadata !107, null}
!153 = metadata !{i32 109, i32 0, metadata !107, null}
!154 = metadata !{i32 110, i32 0, metadata !107, null}
!155 = metadata !{i32 111, i32 0, metadata !107, null}
!156 = metadata !{i32 112, i32 0, metadata !107, null}
!157 = metadata !{i32 786688, metadata !107, metadata !"l", metadata !6, i32 113, metadata !12, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [l] [line 113]
!158 = metadata !{i32 113, i32 0, metadata !107, null}
!159 = metadata !{i32 115, i32 0, metadata !107, null}
!160 = metadata !{i32 116, i32 0, metadata !107, null}
!161 = metadata !{i32 117, i32 0, metadata !107, null}
!162 = metadata !{i32 118, i32 0, metadata !107, null}
!163 = metadata !{i32 786688, metadata !107, metadata !"kJ2wsI", metadata !6, i32 121, metadata !12, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [kJ2wsI] [line 121]
!164 = metadata !{i32 121, i32 0, metadata !107, null}
!165 = metadata !{i32 122, i32 0, metadata !107, null}
!166 = metadata !{i32 123, i32 0, metadata !107, null}
!167 = metadata !{i32 124, i32 0, metadata !107, null}
!168 = metadata !{i32 125, i32 0, metadata !77, null}
!169 = metadata !{i32 786689, metadata !28, metadata !"a", metadata !6, i32 16777217, metadata !12, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [a] [line 1]
!170 = metadata !{i32 1, i32 0, metadata !28, null}
!171 = metadata !{i32 786689, metadata !28, metadata !"y", metadata !6, i32 33554433, metadata !12, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [y] [line 1]
!172 = metadata !{i32 786689, metadata !28, metadata !"Cp", metadata !6, i32 50331649, metadata !12, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [Cp] [line 1]
!173 = metadata !{i32 786689, metadata !28, metadata !"Cn", metadata !6, i32 67108865, metadata !12, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [Cn] [line 1]
!174 = metadata !{i32 2, i32 0, metadata !175, null}
!175 = metadata !{i32 786443, metadata !28, i32 1, i32 0, metadata !6, i32 14} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/thundersvm-new-bug/new-fun.cpp]
!176 = metadata !{i32 3, i32 0, metadata !28, null}
!177 = metadata !{i32 786689, metadata !25, metadata !"a", metadata !6, i32 16777221, metadata !12, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [a] [line 5]
!178 = metadata !{i32 5, i32 0, metadata !25, null}
!179 = metadata !{i32 786689, metadata !25, metadata !"y", metadata !6, i32 33554437, metadata !12, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [y] [line 5]
!180 = metadata !{i32 786689, metadata !25, metadata !"Cp", metadata !6, i32 50331653, metadata !12, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [Cp] [line 5]
!181 = metadata !{i32 786689, metadata !25, metadata !"Cn", metadata !6, i32 67108869, metadata !12, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [Cn] [line 5]
!182 = metadata !{i32 6, i32 0, metadata !183, null}
!183 = metadata !{i32 786443, metadata !25, i32 5, i32 0, metadata !6, i32 13} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/thundersvm-new-bug/new-fun.cpp]
!184 = metadata !{i32 7, i32 0, metadata !25, null}
!185 = metadata !{i32 786689, metadata !24, metadata !"a", metadata !6, i32 16777233, metadata !12, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [a] [line 17]
!186 = metadata !{i32 17, i32 0, metadata !24, null}
!187 = metadata !{i32 786689, metadata !24, metadata !"y", metadata !6, i32 33554449, metadata !12, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [y] [line 17]
!188 = metadata !{i32 18, i32 0, metadata !189, null}
!189 = metadata !{i32 786443, metadata !24, i32 17, i32 0, metadata !6, i32 12} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/thundersvm-new-bug/new-fun.cpp]
!190 = metadata !{i32 786689, metadata !20, metadata !"a", metadata !6, i32 16777229, metadata !12, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [a] [line 13]
!191 = metadata !{i32 13, i32 0, metadata !20, null}
!192 = metadata !{i32 786689, metadata !20, metadata !"y", metadata !6, i32 33554445, metadata !12, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [y] [line 13]
!193 = metadata !{i32 14, i32 0, metadata !194, null}
!194 = metadata !{i32 786443, metadata !20, i32 13, i32 0, metadata !6, i32 11} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/thundersvm-new-bug/new-fun.cpp]
