; ModuleID = 'smo_kernel'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.dim3 = type { i32, i32, i32 }

@threadIdx = external global %struct.dim3
@blockDim = external global %struct.dim3
@_ZZ19nu_smo_solve_kernelPKiPfS1_S1_S0_ifPKfS3_ifS1_E10shared_mem = internal global [256 x i32] zeroinitializer, section "__shared__", align 16

define i32 @_Z13get_block_minPKfPi(float* %values, i32* %index) uwtable section "__device__" {
  %1 = alloca float*, align 8
  %2 = alloca i32*, align 8
  %tid = alloca i32, align 4
  %offset = alloca i32, align 4
  store float* %values, float** %1, align 8
  call void @llvm.dbg.declare(metadata !{float** %1}, metadata !31), !dbg !32
  store i32* %index, i32** %2, align 8
  call void @llvm.dbg.declare(metadata !{i32** %2}, metadata !33), !dbg !32
  call void @llvm.dbg.declare(metadata !{i32* %tid}, metadata !34), !dbg !36
  %3 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !36
  store i32 %3, i32* %tid, align 4, !dbg !36
  %4 = load i32* %tid, align 4, !dbg !37
  %5 = load i32* %tid, align 4, !dbg !37
  %6 = sext i32 %5 to i64, !dbg !37
  %7 = load i32** %2, align 8, !dbg !37
  %8 = getelementptr inbounds i32* %7, i64 %6, !dbg !37
  store i32 %4, i32* %8, align 4, !dbg !37
  call void @__syncthreads(), !dbg !38
  call void @llvm.dbg.declare(metadata !{i32* %offset}, metadata !39), !dbg !41
  %9 = load i32* getelementptr inbounds (%struct.dim3* @blockDim, i32 0, i32 0), align 4, !dbg !41
  %10 = udiv i32 %9, 2, !dbg !41
  store i32 %10, i32* %offset, align 4, !dbg !41
  br label %11, !dbg !41

; <label>:11                                      ; preds = %54, %0
  %12 = load i32* %offset, align 4, !dbg !41
  %13 = icmp sgt i32 %12, 0, !dbg !41
  br i1 %13, label %14, label %57, !dbg !41

; <label>:14                                      ; preds = %11
  %15 = load i32* %tid, align 4, !dbg !42
  %16 = load i32* %offset, align 4, !dbg !42
  %17 = icmp slt i32 %15, %16, !dbg !42
  br i1 %17, label %18, label %53, !dbg !42

; <label>:18                                      ; preds = %14
  %19 = load i32* %tid, align 4, !dbg !44
  %20 = load i32* %offset, align 4, !dbg !44
  %21 = add nsw i32 %19, %20, !dbg !44
  %22 = sext i32 %21 to i64, !dbg !44
  %23 = load i32** %2, align 8, !dbg !44
  %24 = getelementptr inbounds i32* %23, i64 %22, !dbg !44
  %25 = load i32* %24, align 4, !dbg !44
  %26 = sext i32 %25 to i64, !dbg !44
  %27 = load float** %1, align 8, !dbg !44
  %28 = getelementptr inbounds float* %27, i64 %26, !dbg !44
  %29 = load float* %28, align 4, !dbg !44
  %30 = load i32* %tid, align 4, !dbg !44
  %31 = sext i32 %30 to i64, !dbg !44
  %32 = load i32** %2, align 8, !dbg !44
  %33 = getelementptr inbounds i32* %32, i64 %31, !dbg !44
  %34 = load i32* %33, align 4, !dbg !44
  %35 = sext i32 %34 to i64, !dbg !44
  %36 = load float** %1, align 8, !dbg !44
  %37 = getelementptr inbounds float* %36, i64 %35, !dbg !44
  %38 = load float* %37, align 4, !dbg !44
  %39 = fcmp ole float %29, %38, !dbg !44
  br i1 %39, label %40, label %52, !dbg !44

; <label>:40                                      ; preds = %18
  %41 = load i32* %tid, align 4, !dbg !46
  %42 = load i32* %offset, align 4, !dbg !46
  %43 = add nsw i32 %41, %42, !dbg !46
  %44 = sext i32 %43 to i64, !dbg !46
  %45 = load i32** %2, align 8, !dbg !46
  %46 = getelementptr inbounds i32* %45, i64 %44, !dbg !46
  %47 = load i32* %46, align 4, !dbg !46
  %48 = load i32* %tid, align 4, !dbg !46
  %49 = sext i32 %48 to i64, !dbg !46
  %50 = load i32** %2, align 8, !dbg !46
  %51 = getelementptr inbounds i32* %50, i64 %49, !dbg !46
  store i32 %47, i32* %51, align 4, !dbg !46
  br label %52, !dbg !48

; <label>:52                                      ; preds = %40, %18
  br label %53, !dbg !49

; <label>:53                                      ; preds = %52, %14
  call void @__syncthreads(), !dbg !50
  br label %54, !dbg !51

; <label>:54                                      ; preds = %53
  %55 = load i32* %offset, align 4, !dbg !41
  %56 = ashr i32 %55, 1, !dbg !41
  store i32 %56, i32* %offset, align 4, !dbg !41
  br label %11, !dbg !41

; <label>:57                                      ; preds = %11
  %58 = load i32** %2, align 8, !dbg !52
  %59 = getelementptr inbounds i32* %58, i64 0, !dbg !52
  %60 = load i32* %59, align 4, !dbg !52
  ret i32 %60, !dbg !52
}

declare void @llvm.dbg.declare(metadata, metadata) nounwind readnone

declare void @__syncthreads() section "__device__"

define zeroext i1 @_Z7is_I_upfff(float %a, float %y, float %C) nounwind uwtable section "__device__" {
  %1 = alloca float, align 4
  %2 = alloca float, align 4
  %3 = alloca float, align 4
  store float %a, float* %1, align 4
  call void @llvm.dbg.declare(metadata !{float* %1}, metadata !53), !dbg !54
  store float %y, float* %2, align 4
  call void @llvm.dbg.declare(metadata !{float* %2}, metadata !55), !dbg !54
  store float %C, float* %3, align 4
  call void @llvm.dbg.declare(metadata !{float* %3}, metadata !56), !dbg !54
  %4 = load float* %2, align 4, !dbg !57
  %5 = fcmp ogt float %4, 0.000000e+00, !dbg !57
  br i1 %5, label %6, label %10, !dbg !57

; <label>:6                                       ; preds = %0
  %7 = load float* %1, align 4, !dbg !57
  %8 = load float* %3, align 4, !dbg !57
  %9 = fcmp olt float %7, %8, !dbg !57
  br i1 %9, label %18, label %10, !dbg !57

; <label>:10                                      ; preds = %6, %0
  %11 = load float* %2, align 4, !dbg !57
  %12 = fcmp olt float %11, 0.000000e+00, !dbg !57
  br i1 %12, label %13, label %16, !dbg !57

; <label>:13                                      ; preds = %10
  %14 = load float* %1, align 4, !dbg !57
  %15 = fcmp ogt float %14, 0.000000e+00, !dbg !57
  br label %16

; <label>:16                                      ; preds = %13, %10
  %17 = phi i1 [ false, %10 ], [ %15, %13 ]
  br label %18

; <label>:18                                      ; preds = %16, %6
  %19 = phi i1 [ true, %6 ], [ %17, %16 ]
  ret i1 %19, !dbg !59
}

define zeroext i1 @_Z8is_I_lowfff(float %a, float %y, float %C) nounwind uwtable section "__device__" {
  %1 = alloca float, align 4
  %2 = alloca float, align 4
  %3 = alloca float, align 4
  store float %a, float* %1, align 4
  call void @llvm.dbg.declare(metadata !{float* %1}, metadata !60), !dbg !61
  store float %y, float* %2, align 4
  call void @llvm.dbg.declare(metadata !{float* %2}, metadata !62), !dbg !61
  store float %C, float* %3, align 4
  call void @llvm.dbg.declare(metadata !{float* %3}, metadata !63), !dbg !61
  %4 = load float* %2, align 4, !dbg !64
  %5 = fcmp ogt float %4, 0.000000e+00, !dbg !64
  br i1 %5, label %6, label %9, !dbg !64

; <label>:6                                       ; preds = %0
  %7 = load float* %1, align 4, !dbg !64
  %8 = fcmp ogt float %7, 0.000000e+00, !dbg !64
  br i1 %8, label %18, label %9, !dbg !64

; <label>:9                                       ; preds = %6, %0
  %10 = load float* %2, align 4, !dbg !64
  %11 = fcmp olt float %10, 0.000000e+00, !dbg !64
  br i1 %11, label %12, label %16, !dbg !64

; <label>:12                                      ; preds = %9
  %13 = load float* %1, align 4, !dbg !64
  %14 = load float* %3, align 4, !dbg !64
  %15 = fcmp olt float %13, %14, !dbg !64
  br label %16

; <label>:16                                      ; preds = %12, %9
  %17 = phi i1 [ false, %9 ], [ %15, %12 ]
  br label %18

; <label>:18                                      ; preds = %16, %6
  %19 = phi i1 [ true, %6 ], [ %17, %16 ]
  ret i1 %19, !dbg !66
}

define void @_Z19nu_smo_solve_kernelPKiPfS1_S1_S0_ifPKfS3_ifS1_(i32* %label, float* %f_values, float* %alpha, float* %alpha_diff, i32* %working_set, i32 %ws_size, float %C, float* %k_mat_rows, float* %k_mat_diag, i32 %row_len, float %eps, float* %diff_and_bias) uwtable noinline {
  %1 = alloca i32*, align 8
  %2 = alloca float*, align 8
  %3 = alloca float*, align 8
  %4 = alloca float*, align 8
  %5 = alloca i32*, align 8
  %6 = alloca i32, align 4
  %7 = alloca float, align 4
  %8 = alloca float*, align 8
  %9 = alloca float*, align 8
  %10 = alloca i32, align 4
  %11 = alloca float, align 4
  %12 = alloca float*, align 8
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
  %ip = alloca i32, align 4
  %up_value_p = alloca float, align 4
  %kIpwsI = alloca float, align 4
  %local_diff = alloca float, align 4
  store i32* %label, i32** %1, align 8
  call void @llvm.dbg.declare(metadata !{i32** %1}, metadata !67), !dbg !68
  store float* %f_values, float** %2, align 8
  call void @llvm.dbg.declare(metadata !{float** %2}, metadata !69), !dbg !68
  store float* %alpha, float** %3, align 8
  call void @llvm.dbg.declare(metadata !{float** %3}, metadata !70), !dbg !68
  store float* %alpha_diff, float** %4, align 8
  call void @llvm.dbg.declare(metadata !{float** %4}, metadata !71), !dbg !68
  store i32* %working_set, i32** %5, align 8
  call void @llvm.dbg.declare(metadata !{i32** %5}, metadata !72), !dbg !68
  store i32 %ws_size, i32* %6, align 4
  call void @llvm.dbg.declare(metadata !{i32* %6}, metadata !73), !dbg !74
  store float %C, float* %7, align 4
  call void @llvm.dbg.declare(metadata !{float* %7}, metadata !75), !dbg !74
  store float* %k_mat_rows, float** %8, align 8
  call void @llvm.dbg.declare(metadata !{float** %8}, metadata !76), !dbg !74
  store float* %k_mat_diag, float** %9, align 8
  call void @llvm.dbg.declare(metadata !{float** %9}, metadata !77), !dbg !74
  store i32 %row_len, i32* %10, align 4
  call void @llvm.dbg.declare(metadata !{i32* %10}, metadata !78), !dbg !74
  store float %eps, float* %11, align 4
  call void @llvm.dbg.declare(metadata !{float* %11}, metadata !79), !dbg !74
  store float* %diff_and_bias, float** %12, align 8
  call void @llvm.dbg.declare(metadata !{float** %12}, metadata !80), !dbg !81
  call void @llvm.dbg.declare(metadata !{i32** %f_idx2reduce}, metadata !82), !dbg !84
  store i32* getelementptr inbounds ([256 x i32]* @_ZZ19nu_smo_solve_kernelPKiPfS1_S1_S0_ifPKfS3_ifS1_E10shared_mem, i32 0, i32 0), i32** %f_idx2reduce, align 8, !dbg !84
  call void @llvm.dbg.declare(metadata !{float** %f_val2reduce}, metadata !85), !dbg !86
  %13 = load i32* %6, align 4, !dbg !86
  %14 = sext i32 %13 to i64, !dbg !86
  %15 = load i32** %f_idx2reduce, align 8, !dbg !86
  %16 = getelementptr inbounds i32* %15, i64 %14, !dbg !86
  %17 = bitcast i32* %16 to float*, !dbg !86
  store float* %17, float** %f_val2reduce, align 8, !dbg !86
  call void @llvm.dbg.declare(metadata !{float** %alpha_i_diff}, metadata !87), !dbg !88
  %18 = load i32* %6, align 4, !dbg !88
  %19 = sext i32 %18 to i64, !dbg !88
  %20 = load float** %f_val2reduce, align 8, !dbg !88
  %21 = getelementptr inbounds float* %20, i64 %19, !dbg !88
  store float* %21, float** %alpha_i_diff, align 8, !dbg !88
  call void @llvm.dbg.declare(metadata !{float** %alpha_j_diff}, metadata !89), !dbg !90
  %22 = load float** %alpha_i_diff, align 8, !dbg !90
  %23 = getelementptr inbounds float* %22, i64 1, !dbg !90
  store float* %23, float** %alpha_j_diff, align 8, !dbg !90
  call void @llvm.dbg.declare(metadata !{float** %kd}, metadata !91), !dbg !92
  %24 = load float** %alpha_j_diff, align 8, !dbg !92
  %25 = getelementptr inbounds float* %24, i64 1, !dbg !92
  store float* %25, float** %kd, align 8, !dbg !92
  call void @llvm.dbg.declare(metadata !{i32* %tid}, metadata !93), !dbg !94
  %26 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !94
  store i32 %26, i32* %tid, align 4, !dbg !94
  call void @llvm.dbg.declare(metadata !{i32* %wsi}, metadata !95), !dbg !96
  %27 = load i32* %tid, align 4, !dbg !96
  %28 = sext i32 %27 to i64, !dbg !96
  %29 = load i32** %5, align 8, !dbg !96
  %30 = getelementptr inbounds i32* %29, i64 %28, !dbg !96
  %31 = load i32* %30, align 4, !dbg !96
  store i32 %31, i32* %wsi, align 4, !dbg !96
  %32 = load i32* %wsi, align 4, !dbg !97
  %33 = sext i32 %32 to i64, !dbg !97
  %34 = load float** %9, align 8, !dbg !97
  %35 = getelementptr inbounds float* %34, i64 %33, !dbg !97
  %36 = load float* %35, align 4, !dbg !97
  %37 = load i32* %tid, align 4, !dbg !97
  %38 = sext i32 %37 to i64, !dbg !97
  %39 = load float** %kd, align 8, !dbg !97
  %40 = getelementptr inbounds float* %39, i64 %38, !dbg !97
  store float %36, float* %40, align 4, !dbg !97
  call void @llvm.dbg.declare(metadata !{float* %y}, metadata !98), !dbg !99
  %41 = load i32* %wsi, align 4, !dbg !99
  %42 = sext i32 %41 to i64, !dbg !99
  %43 = load i32** %1, align 8, !dbg !99
  %44 = getelementptr inbounds i32* %43, i64 %42, !dbg !99
  %45 = load i32* %44, align 4, !dbg !99
  %46 = sitofp i32 %45 to float, !dbg !99
  store float %46, float* %y, align 4, !dbg !99
  call void @llvm.dbg.declare(metadata !{float* %f}, metadata !100), !dbg !101
  %47 = load i32* %wsi, align 4, !dbg !101
  %48 = sext i32 %47 to i64, !dbg !101
  %49 = load float** %2, align 8, !dbg !101
  %50 = getelementptr inbounds float* %49, i64 %48, !dbg !101
  %51 = load float* %50, align 4, !dbg !101
  store float %51, float* %f, align 4, !dbg !101
  call void @llvm.dbg.declare(metadata !{float* %a}, metadata !102), !dbg !103
  %52 = load i32* %wsi, align 4, !dbg !103
  %53 = sext i32 %52 to i64, !dbg !103
  %54 = load float** %3, align 8, !dbg !103
  %55 = getelementptr inbounds float* %54, i64 %53, !dbg !103
  %56 = load float* %55, align 4, !dbg !103
  store float %56, float* %a, align 4, !dbg !103
  call void @llvm.dbg.declare(metadata !{float* %aold}, metadata !104), !dbg !105
  %57 = load float* %a, align 4, !dbg !105
  store float %57, float* %aold, align 4, !dbg !105
  call void @__syncthreads(), !dbg !106
  call void @llvm.dbg.declare(metadata !{float* %local_eps}, metadata !107), !dbg !108
  store float 0.000000e+00, float* %local_eps, align 4, !dbg !108
  call void @llvm.dbg.declare(metadata !{i32* %numOfIter}, metadata !109), !dbg !110
  store i32 0, i32* %numOfIter, align 4, !dbg !110
  br label %58, !dbg !111

; <label>:58                                      ; preds = %127, %0
  %59 = load float* %y, align 4, !dbg !112
  %60 = fcmp ogt float %59, 0.000000e+00, !dbg !112
  br i1 %60, label %61, label %71, !dbg !112

; <label>:61                                      ; preds = %58
  %62 = load float* %a, align 4, !dbg !112
  %63 = load float* %7, align 4, !dbg !112
  %64 = fcmp olt float %62, %63, !dbg !112
  br i1 %64, label %65, label %71, !dbg !112

; <label>:65                                      ; preds = %61
  %66 = load float* %f, align 4, !dbg !114
  %67 = load i32* %tid, align 4, !dbg !114
  %68 = sext i32 %67 to i64, !dbg !114
  %69 = load float** %f_val2reduce, align 8, !dbg !114
  %70 = getelementptr inbounds float* %69, i64 %68, !dbg !114
  store float %66, float* %70, align 4, !dbg !114
  br label %76, !dbg !114

; <label>:71                                      ; preds = %61, %58
  %72 = load i32* %tid, align 4, !dbg !115
  %73 = sext i32 %72 to i64, !dbg !115
  %74 = load float** %f_val2reduce, align 8, !dbg !115
  %75 = getelementptr inbounds float* %74, i64 %73, !dbg !115
  store float 0x7FF0000000000000, float* %75, align 4, !dbg !115
  br label %76

; <label>:76                                      ; preds = %71, %65

  call void @llvm.dbg.declare(metadata !{i32* %ip}, metadata !117), !dbg !118
  %77 = load float** %f_val2reduce, align 8, !dbg !118
  %78 = load i32** %f_idx2reduce, align 8, !dbg !118
  %79 = call i32 @_Z13get_block_minPKfPi(float* %77, i32* %78), !dbg !118
  store i32 %79, i32* %ip, align 4, !dbg !118
  call void @llvm.dbg.declare(metadata !{float* %up_value_p}, metadata !119), !dbg !120
  %80 = load i32* %ip, align 4, !dbg !120
  %81 = sext i32 %80 to i64, !dbg !120
  %82 = load float** %f_val2reduce, align 8, !dbg !120
  %83 = getelementptr inbounds float* %82, i64 %81, !dbg !120
  %84 = load float* %83, align 4, !dbg !120
  store float %84, float* %up_value_p, align 4, !dbg !120
  call void @llvm.dbg.declare(metadata !{float* %kIpwsI}, metadata !121), !dbg !122
  %85 = load i32* %10, align 4, !dbg !122
  %86 = load i32* %ip, align 4, !dbg !122
  %87 = mul nsw i32 %85, %86, !dbg !122
  %88 = load i32* %wsi, align 4, !dbg !122
  %89 = add nsw i32 %87, %88, !dbg !122
  %90 = sext i32 %89 to i64, !dbg !122
  %91 = load float** %8, align 8, !dbg !122
  %92 = getelementptr inbounds float* %91, i64 %90, !dbg !122
  %93 = load float* %92, align 4, !dbg !122
  store float %93, float* %kIpwsI, align 4, !dbg !122

  call void @llvm.dbg.declare(metadata !{float* %local_diff}, metadata !124), !dbg !125
  %94 = load float* %up_value_p, align 4, !dbg !125
  store float %94, float* %local_diff, align 4, !dbg !125
  %95 = load i32* %numOfIter, align 4, !dbg !126
  %96 = icmp eq i32 %95, 0, !dbg !126
  br i1 %96, label %97, label %100, !dbg !126

; <label>:97                                      ; preds = %76
  %98 = load float* %local_diff, align 4, !dbg !127
  %99 = fmul float 0x3FB99999A0000000, %98, !dbg !127
  store float %99, float* %local_eps, align 4, !dbg !127
  br label %100, !dbg !129

; <label>:100                                     ; preds = %97, %76
  %101 = load float* %local_diff, align 4, !dbg !130
  %102 = load float* %local_eps, align 4, !dbg !130
  %103 = fcmp olt float %101, %102, !dbg !130
  br i1 %103, label %104, label %127, !dbg !130

; <label>:104                                     ; preds = %100
  %105 = load float* %a, align 4, !dbg !131
  %106 = load i32* %wsi, align 4, !dbg !131
  %107 = sext i32 %106 to i64, !dbg !131
  %108 = load float** %3, align 8, !dbg !131
  %109 = getelementptr inbounds float* %108, i64 %107, !dbg !131
  store float %105, float* %109, align 4, !dbg !131
  %110 = load float* %a, align 4, !dbg !133
  %111 = load float* %aold, align 4, !dbg !133
  %112 = fsub float %110, %111, !dbg !133
  %113 = fsub float -0.000000e+00, %112, !dbg !133
  %114 = load float* %y, align 4, !dbg !133
  %115 = fmul float %113, %114, !dbg !133
  %116 = load i32* %tid, align 4, !dbg !133
  %117 = sext i32 %116 to i64, !dbg !133
  %118 = load float** %4, align 8, !dbg !133
  %119 = getelementptr inbounds float* %118, i64 %117, !dbg !133
  store float %115, float* %119, align 4, !dbg !133
  %120 = load i32* %tid, align 4, !dbg !134
  %121 = icmp eq i32 %120, 0, !dbg !134
  br i1 %121, label %122, label %126, !dbg !134

; <label>:122                                     ; preds = %104
  %123 = load float* %local_diff, align 4, !dbg !135
  %124 = load float** %12, align 8, !dbg !135
  %125 = getelementptr inbounds float* %124, i64 0, !dbg !135
  store float %123, float* %125, align 4, !dbg !135
  br label %126, !dbg !137

; <label>:126                                     ; preds = %122, %104
  br label %128, !dbg !138

; <label>:127                                     ; preds = %100
  br label %58, !dbg !139

; <label>:128                                     ; preds = %126
  ret void, !dbg !140
}

!llvm.dbg.cu = !{!0}

!0 = metadata !{i32 786449, i32 0, i32 4, metadata !"smo_kernel.cpp", metadata !"/home/mingyuanwu/thundersvm-repair", metadata !"clang version 3.2 (tags/RELEASE_32/final)", i1 true, i1 false, metadata !"", i32 0, metadata !1, metadata !1, metadata !3, metadata !25} ; [ DW_TAG_compile_unit ] [/home/mingyuanwu/thundersvm-repair/smo_kernel.cpp] [DW_LANG_C_plus_plus]
!1 = metadata !{metadata !2}
!2 = metadata !{i32 0}
!3 = metadata !{metadata !4}
!4 = metadata !{metadata !5, metadata !14, metadata !18, metadata !19}
!5 = metadata !{i32 786478, i32 0, metadata !6, metadata !"get_block_min", metadata !"get_block_min", metadata !"_Z13get_block_minPKfPi", metadata !6, i32 2, metadata !7, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, i32 (float*, i32*)* @_Z13get_block_minPKfPi, null, null, metadata !1, i32 2} ; [ DW_TAG_subprogram ] [line 2] [def] [get_block_min]
!6 = metadata !{i32 786473, metadata !"smo_kernel.cpp", metadata !"/home/mingyuanwu/thundersvm-repair", null} ; [ DW_TAG_file_type ]
!7 = metadata !{i32 786453, i32 0, metadata !"", i32 0, i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !8, i32 0, i32 0} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!8 = metadata !{metadata !9, metadata !10, metadata !13}
!9 = metadata !{i32 786468, null, metadata !"int", null, i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!10 = metadata !{i32 786447, null, metadata !"", null, i32 0, i64 64, i64 64, i64 0, i32 0, metadata !11} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from ]
!11 = metadata !{i32 786470, null, metadata !"", null, i32 0, i64 0, i64 0, i64 0, i32 0, metadata !12} ; [ DW_TAG_const_type ] [line 0, size 0, align 0, offset 0] [from float]
!12 = metadata !{i32 786468, null, metadata !"float", null, i32 0, i64 32, i64 32, i64 0, i32 0, i32 4} ; [ DW_TAG_base_type ] [float] [line 0, size 32, align 32, offset 0, enc DW_ATE_float]
!13 = metadata !{i32 786447, null, metadata !"", null, i32 0, i64 64, i64 64, i64 0, i32 0, metadata !9} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from int]
!14 = metadata !{i32 786478, i32 0, metadata !6, metadata !"is_I_up", metadata !"is_I_up", metadata !"_Z7is_I_upfff", metadata !6, i32 18, metadata !15, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, i1 (float, float, float)* @_Z7is_I_upfff, null, null, metadata !1, i32 18} ; [ DW_TAG_subprogram ] [line 18] [def] [is_I_up]
!15 = metadata !{i32 786453, i32 0, metadata !"", i32 0, i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !16, i32 0, i32 0} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!16 = metadata !{metadata !17, metadata !12, metadata !12, metadata !12}
!17 = metadata !{i32 786468, null, metadata !"bool", null, i32 0, i64 8, i64 8, i64 0, i32 0, i32 2} ; [ DW_TAG_base_type ] [bool] [line 0, size 8, align 8, offset 0, enc DW_ATE_boolean]
!18 = metadata !{i32 786478, i32 0, metadata !6, metadata !"is_I_low", metadata !"is_I_low", metadata !"_Z8is_I_lowfff", metadata !6, i32 22, metadata !15, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, i1 (float, float, float)* @_Z8is_I_lowfff, null, null, metadata !1, i32 22} ; [ DW_TAG_subprogram ] [line 22] [def] [is_I_low]
!19 = metadata !{i32 786478, i32 0, metadata !6, metadata !"nu_smo_solve_kernel", metadata !"nu_smo_solve_kernel", metadata !"_Z19nu_smo_solve_kernelPKiPfS1_S1_S0_ifPKfS3_ifS1_", metadata !6, i32 27, metadata !20, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, void (i32*, float*, float*, float*, i32*, i32, float, float*, float*, i32, float, float*)* @_Z19nu_smo_solve_kernelPKiPfS1_S1_S0_ifPKfS3_ifS1_, null, null, metadata !1, i32 29} ; [ DW_TAG_subprogram ] [line 27] [def] [scope 29] [nu_smo_solve_kernel]
!20 = metadata !{i32 786453, i32 0, metadata !"", i32 0, i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !21, i32 0, i32 0} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!21 = metadata !{null, metadata !22, metadata !24, metadata !24, metadata !24, metadata !22, metadata !9, metadata !12, metadata !10, metadata !10, metadata !9, metadata !12, metadata !24}
!22 = metadata !{i32 786447, null, metadata !"", null, i32 0, i64 64, i64 64, i64 0, i32 0, metadata !23} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from ]
!23 = metadata !{i32 786470, null, metadata !"", null, i32 0, i64 0, i64 0, i64 0, i32 0, metadata !9} ; [ DW_TAG_const_type ] [line 0, size 0, align 0, offset 0] [from int]
!24 = metadata !{i32 786447, null, metadata !"", null, i32 0, i64 64, i64 64, i64 0, i32 0, metadata !12} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from float]
!25 = metadata !{metadata !26}
!26 = metadata !{metadata !27}
!27 = metadata !{i32 786484, i32 0, metadata !19, metadata !"shared_mem", metadata !"shared_mem", metadata !"", metadata !6, i32 32, metadata !28, i32 1, i32 1, [256 x i32]* @_ZZ19nu_smo_solve_kernelPKiPfS1_S1_S0_ifPKfS3_ifS1_E10shared_mem} ; [ DW_TAG_variable ] [shared_mem] [line 32] [local] [def]
!28 = metadata !{i32 786433, null, metadata !"", null, i32 0, i64 8192, i64 32, i32 0, i32 0, metadata !9, metadata !29, i32 0, i32 0} ; [ DW_TAG_array_type ] [line 0, size 8192, align 32, offset 0] [from int]
!29 = metadata !{metadata !30}
!30 = metadata !{i32 786465, i64 0, i64 255}      ; [ DW_TAG_subrange_type ] [0, 255]
!31 = metadata !{i32 786689, metadata !5, metadata !"values", metadata !6, i32 16777218, metadata !10, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [values] [line 2]
!32 = metadata !{i32 2, i32 0, metadata !5, null}
!33 = metadata !{i32 786689, metadata !5, metadata !"index", metadata !6, i32 33554434, metadata !13, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [index] [line 2]
!34 = metadata !{i32 786688, metadata !35, metadata !"tid", metadata !6, i32 3, metadata !9, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [tid] [line 3]
!35 = metadata !{i32 786443, metadata !5, i32 2, i32 0, metadata !6, i32 0} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/thundersvm-repair/smo_kernel.cpp]
!36 = metadata !{i32 3, i32 0, metadata !35, null}
!37 = metadata !{i32 4, i32 0, metadata !35, null}
!38 = metadata !{i32 5, i32 0, metadata !35, null}
!39 = metadata !{i32 786688, metadata !40, metadata !"offset", metadata !6, i32 7, metadata !9, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [offset] [line 7]
!40 = metadata !{i32 786443, metadata !35, i32 7, i32 0, metadata !6, i32 1} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/thundersvm-repair/smo_kernel.cpp]
!41 = metadata !{i32 7, i32 0, metadata !40, null}
!42 = metadata !{i32 8, i32 0, metadata !43, null}
!43 = metadata !{i32 786443, metadata !40, i32 7, i32 0, metadata !6, i32 2} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/thundersvm-repair/smo_kernel.cpp]
!44 = metadata !{i32 9, i32 0, metadata !45, null}
!45 = metadata !{i32 786443, metadata !43, i32 8, i32 0, metadata !6, i32 3} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/thundersvm-repair/smo_kernel.cpp]
!46 = metadata !{i32 10, i32 0, metadata !47, null}
!47 = metadata !{i32 786443, metadata !45, i32 9, i32 0, metadata !6, i32 4} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/thundersvm-repair/smo_kernel.cpp]
!48 = metadata !{i32 11, i32 0, metadata !47, null}
!49 = metadata !{i32 12, i32 0, metadata !45, null}
!50 = metadata !{i32 13, i32 0, metadata !43, null}
!51 = metadata !{i32 14, i32 0, metadata !43, null}
!52 = metadata !{i32 15, i32 0, metadata !35, null}
!53 = metadata !{i32 786689, metadata !14, metadata !"a", metadata !6, i32 16777234, metadata !12, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [a] [line 18]
!54 = metadata !{i32 18, i32 0, metadata !14, null}
!55 = metadata !{i32 786689, metadata !14, metadata !"y", metadata !6, i32 33554450, metadata !12, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [y] [line 18]
!56 = metadata !{i32 786689, metadata !14, metadata !"C", metadata !6, i32 50331666, metadata !12, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [C] [line 18]
!57 = metadata !{i32 19, i32 0, metadata !58, null}
!58 = metadata !{i32 786443, metadata !14, i32 18, i32 0, metadata !6, i32 5} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/thundersvm-repair/smo_kernel.cpp]
!59 = metadata !{i32 20, i32 0, metadata !14, null}
!60 = metadata !{i32 786689, metadata !18, metadata !"a", metadata !6, i32 16777238, metadata !12, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [a] [line 22]
!61 = metadata !{i32 22, i32 0, metadata !18, null}
!62 = metadata !{i32 786689, metadata !18, metadata !"y", metadata !6, i32 33554454, metadata !12, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [y] [line 22]
!63 = metadata !{i32 786689, metadata !18, metadata !"C", metadata !6, i32 50331670, metadata !12, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [C] [line 22]
!64 = metadata !{i32 23, i32 0, metadata !65, null}
!65 = metadata !{i32 786443, metadata !18, i32 22, i32 0, metadata !6, i32 6} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/thundersvm-repair/smo_kernel.cpp]
!66 = metadata !{i32 24, i32 0, metadata !18, null}
!67 = metadata !{i32 786689, metadata !19, metadata !"label", metadata !6, i32 16777243, metadata !22, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [label] [line 27]
!68 = metadata !{i32 27, i32 0, metadata !19, null}
!69 = metadata !{i32 786689, metadata !19, metadata !"f_values", metadata !6, i32 33554459, metadata !24, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [f_values] [line 27]
!70 = metadata !{i32 786689, metadata !19, metadata !"alpha", metadata !6, i32 50331675, metadata !24, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [alpha] [line 27]
!71 = metadata !{i32 786689, metadata !19, metadata !"alpha_diff", metadata !6, i32 67108891, metadata !24, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [alpha_diff] [line 27]
!72 = metadata !{i32 786689, metadata !19, metadata !"working_set", metadata !6, i32 83886107, metadata !22, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [working_set] [line 27]
!73 = metadata !{i32 786689, metadata !19, metadata !"ws_size", metadata !6, i32 100663324, metadata !9, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [ws_size] [line 28]
!74 = metadata !{i32 28, i32 0, metadata !19, null}
!75 = metadata !{i32 786689, metadata !19, metadata !"C", metadata !6, i32 117440540, metadata !12, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [C] [line 28]
!76 = metadata !{i32 786689, metadata !19, metadata !"k_mat_rows", metadata !6, i32 134217756, metadata !10, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [k_mat_rows] [line 28]
!77 = metadata !{i32 786689, metadata !19, metadata !"k_mat_diag", metadata !6, i32 150994972, metadata !10, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [k_mat_diag] [line 28]
!78 = metadata !{i32 786689, metadata !19, metadata !"row_len", metadata !6, i32 167772188, metadata !9, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [row_len] [line 28]
!79 = metadata !{i32 786689, metadata !19, metadata !"eps", metadata !6, i32 184549404, metadata !12, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [eps] [line 28]
!80 = metadata !{i32 786689, metadata !19, metadata !"diff_and_bias", metadata !6, i32 201326621, metadata !24, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [diff_and_bias] [line 29]
!81 = metadata !{i32 29, i32 0, metadata !19, null}
!82 = metadata !{i32 786688, metadata !83, metadata !"f_idx2reduce", metadata !6, i32 33, metadata !13, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [f_idx2reduce] [line 33]
!83 = metadata !{i32 786443, metadata !19, i32 29, i32 0, metadata !6, i32 7} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/thundersvm-repair/smo_kernel.cpp]
!84 = metadata !{i32 33, i32 0, metadata !83, null}
!85 = metadata !{i32 786688, metadata !83, metadata !"f_val2reduce", metadata !6, i32 34, metadata !24, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [f_val2reduce] [line 34]
!86 = metadata !{i32 34, i32 0, metadata !83, null}
!87 = metadata !{i32 786688, metadata !83, metadata !"alpha_i_diff", metadata !6, i32 35, metadata !24, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [alpha_i_diff] [line 35]
!88 = metadata !{i32 35, i32 0, metadata !83, null}
!89 = metadata !{i32 786688, metadata !83, metadata !"alpha_j_diff", metadata !6, i32 36, metadata !24, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [alpha_j_diff] [line 36]
!90 = metadata !{i32 36, i32 0, metadata !83, null}
!91 = metadata !{i32 786688, metadata !83, metadata !"kd", metadata !6, i32 37, metadata !24, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [kd] [line 37]
!92 = metadata !{i32 37, i32 0, metadata !83, null}
!93 = metadata !{i32 786688, metadata !83, metadata !"tid", metadata !6, i32 40, metadata !9, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [tid] [line 40]
!94 = metadata !{i32 40, i32 0, metadata !83, null}
!95 = metadata !{i32 786688, metadata !83, metadata !"wsi", metadata !6, i32 41, metadata !9, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [wsi] [line 41]
!96 = metadata !{i32 41, i32 0, metadata !83, null}
!97 = metadata !{i32 42, i32 0, metadata !83, null}
!98 = metadata !{i32 786688, metadata !83, metadata !"y", metadata !6, i32 43, metadata !12, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [y] [line 43]
!99 = metadata !{i32 43, i32 0, metadata !83, null}
!100 = metadata !{i32 786688, metadata !83, metadata !"f", metadata !6, i32 44, metadata !12, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [f] [line 44]
!101 = metadata !{i32 44, i32 0, metadata !83, null}
!102 = metadata !{i32 786688, metadata !83, metadata !"a", metadata !6, i32 45, metadata !12, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [a] [line 45]
!103 = metadata !{i32 45, i32 0, metadata !83, null}
!104 = metadata !{i32 786688, metadata !83, metadata !"aold", metadata !6, i32 46, metadata !12, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [aold] [line 46]
!105 = metadata !{i32 46, i32 0, metadata !83, null}
!106 = metadata !{i32 47, i32 0, metadata !83, null}
!107 = metadata !{i32 786688, metadata !83, metadata !"local_eps", metadata !6, i32 48, metadata !12, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [local_eps] [line 48]
!108 = metadata !{i32 48, i32 0, metadata !83, null}
!109 = metadata !{i32 786688, metadata !83, metadata !"numOfIter", metadata !6, i32 49, metadata !9, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [numOfIter] [line 49]
!110 = metadata !{i32 49, i32 0, metadata !83, null}
!111 = metadata !{i32 50, i32 0, metadata !83, null}
!112 = metadata !{i32 52, i32 0, metadata !113, null}
!113 = metadata !{i32 786443, metadata !83, i32 50, i32 0, metadata !6, i32 8} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/thundersvm-repair/smo_kernel.cpp]
!114 = metadata !{i32 53, i32 0, metadata !113, null}
!115 = metadata !{i32 55, i32 0, metadata !113, null}
!116 = metadata !{i32 56, i32 0, metadata !113, null}
!117 = metadata !{i32 786688, metadata !113, metadata !"ip", metadata !6, i32 57, metadata !9, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [ip] [line 57]
!118 = metadata !{i32 57, i32 0, metadata !113, null}
!119 = metadata !{i32 786688, metadata !113, metadata !"up_value_p", metadata !6, i32 58, metadata !12, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [up_value_p] [line 58]
!120 = metadata !{i32 58, i32 0, metadata !113, null}
!121 = metadata !{i32 786688, metadata !113, metadata !"kIpwsI", metadata !6, i32 59, metadata !12, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [kIpwsI] [line 59]
!122 = metadata !{i32 59, i32 0, metadata !113, null}
!123 = metadata !{i32 60, i32 0, metadata !113, null}
!124 = metadata !{i32 786688, metadata !113, metadata !"local_diff", metadata !6, i32 63, metadata !12, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [local_diff] [line 63]
!125 = metadata !{i32 63, i32 0, metadata !113, null}
!126 = metadata !{i32 65, i32 0, metadata !113, null}
!127 = metadata !{i32 66, i32 0, metadata !128, null}
!128 = metadata !{i32 786443, metadata !113, i32 65, i32 0, metadata !6, i32 9} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/thundersvm-repair/smo_kernel.cpp]
!129 = metadata !{i32 67, i32 0, metadata !128, null}
!130 = metadata !{i32 69, i32 0, metadata !113, null}
!131 = metadata !{i32 70, i32 0, metadata !132, null}
!132 = metadata !{i32 786443, metadata !113, i32 69, i32 0, metadata !6, i32 10} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/thundersvm-repair/smo_kernel.cpp]
!133 = metadata !{i32 71, i32 0, metadata !132, null}
!134 = metadata !{i32 72, i32 0, metadata !132, null}
!135 = metadata !{i32 73, i32 0, metadata !136, null}
!136 = metadata !{i32 786443, metadata !132, i32 72, i32 0, metadata !6, i32 11} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/thundersvm-repair/smo_kernel.cpp]
!137 = metadata !{i32 74, i32 0, metadata !136, null}
!138 = metadata !{i32 75, i32 0, metadata !132, null}
!139 = metadata !{i32 77, i32 0, metadata !113, null}
!140 = metadata !{i32 78, i32 0, metadata !83, null}
