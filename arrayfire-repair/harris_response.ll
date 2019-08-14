; ModuleID = 'harris_response'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.dim3 = type { i32, i32, i32 }

@_ZZ16block_reduce_sumfE4data = internal global [256 x float] zeroinitializer, section "__shared__", align 16
@threadIdx = external global %struct.dim3
@blockDim = external global %struct.dim3
@blockIdx = external global %struct.dim3

define float @_Z16block_reduce_sumf(float %val) uwtable section "__device__" {
  %1 = alloca float, align 4
  %idx = alloca i32, align 4
  %i = alloca i32, align 4
  store float %val, float* %1, align 4
  call void @llvm.dbg.declare(metadata !{float* %1}, metadata !24), !dbg !25
  call void @llvm.dbg.declare(metadata !{i32* %idx}, metadata !26), !dbg !28
  %2 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !28
  %3 = load i32* getelementptr inbounds (%struct.dim3* @blockDim, i32 0, i32 0), align 4, !dbg !28
  %4 = mul i32 %2, %3, !dbg !28
  %5 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 1), align 4, !dbg !28
  %6 = add i32 %4, %5, !dbg !28
  store i32 %6, i32* %idx, align 4, !dbg !28
  %7 = load float* %1, align 4, !dbg !29
  %8 = load i32* %idx, align 4, !dbg !29
  %9 = zext i32 %8 to i64, !dbg !29
  %10 = getelementptr inbounds [256 x float]* @_ZZ16block_reduce_sumfE4data, i32 0, i64 %9, !dbg !29
  store float %7, float* %10, align 4, !dbg !29
  call void @__syncthreads(), !dbg !30
  call void @llvm.dbg.declare(metadata !{i32* %i}, metadata !31), !dbg !33
  %11 = load i32* getelementptr inbounds (%struct.dim3* @blockDim, i32 0, i32 1), align 4, !dbg !33
  %12 = udiv i32 %11, 2, !dbg !33
  store i32 %12, i32* %i, align 4, !dbg !33
  br label %13, !dbg !33

; <label>:13                                      ; preds = %33, %0
  %14 = load i32* %i, align 4, !dbg !33
  %15 = icmp ugt i32 %14, 0, !dbg !33
  br i1 %15, label %16, label %36, !dbg !33

; <label>:16                                      ; preds = %13
  %17 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 1), align 4, !dbg !34
  %18 = load i32* %i, align 4, !dbg !34
  %19 = icmp ult i32 %17, %18, !dbg !34
  br i1 %19, label %20, label %32, !dbg !34

; <label>:20                                      ; preds = %16
  %21 = load i32* %idx, align 4, !dbg !36
  %22 = load i32* %i, align 4, !dbg !36
  %23 = add i32 %21, %22, !dbg !36
  %24 = zext i32 %23 to i64, !dbg !36
  %25 = getelementptr inbounds [256 x float]* @_ZZ16block_reduce_sumfE4data, i32 0, i64 %24, !dbg !36
  %26 = load float* %25, align 4, !dbg !36
  %27 = load i32* %idx, align 4, !dbg !36
  %28 = zext i32 %27 to i64, !dbg !36
  %29 = getelementptr inbounds [256 x float]* @_ZZ16block_reduce_sumfE4data, i32 0, i64 %28, !dbg !36
  %30 = load float* %29, align 4, !dbg !36
  %31 = fadd float %30, %26, !dbg !36
  store float %31, float* %29, align 4, !dbg !36
  br label %32, !dbg !38

; <label>:32                                      ; preds = %20, %16
  call void @__syncthreads(), !dbg !39
  br label %33, !dbg !40

; <label>:33                                      ; preds = %32
  %34 = load i32* %i, align 4, !dbg !33
  %35 = lshr i32 %34, 1, !dbg !33
  store i32 %35, i32* %i, align 4, !dbg !33
  br label %13, !dbg !33

; <label>:36                                      ; preds = %13
  %37 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !41
  %38 = load i32* getelementptr inbounds (%struct.dim3* @blockDim, i32 0, i32 0), align 4, !dbg !41
  %39 = mul i32 %37, %38, !dbg !41
  %40 = zext i32 %39 to i64, !dbg !41
  %41 = getelementptr inbounds [256 x float]* @_ZZ16block_reduce_sumfE4data, i32 0, i64 %40, !dbg !41
  %42 = load float* %41, align 4, !dbg !41
  ret float %42, !dbg !41
}

declare void @llvm.dbg.declare(metadata, metadata) nounwind readnone

declare void @__syncthreads() section "__device__"

define void @_Z15harris_responsePfS_PKfS1_S1_jS_jfj(float* %score_out, float* %size_out, float* %x_in, float* %y_in, float* %scl_in, i32 %total_feat, float* %image_ptr, i32 %block_size, float %k_thr, i32 %patch_size) uwtable noinline {
  %1 = alloca float*, align 8
  %2 = alloca float*, align 8
  %3 = alloca float*, align 8
  %4 = alloca float*, align 8
  %5 = alloca float*, align 8
  %6 = alloca i32, align 4
  %7 = alloca float*, align 8
  %8 = alloca i32, align 4
  %9 = alloca float, align 4
  %10 = alloca i32, align 4
  %f = alloca i32, align 4
  %x = alloca i32, align 4
  %y = alloca i32, align 4
  %scl = alloca float, align 4
  %size = alloca float, align 4
  %r = alloca i32, align 4
  %ixx = alloca float, align 4
  %iyy = alloca float, align 4
  %ixy = alloca float, align 4
  %block_size_sq = alloca i32, align 4
  %k = alloca i32, align 4
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  %ix = alloca float, align 4
  %iy = alloca float, align 4
  store float* %score_out, float** %1, align 8
  call void @llvm.dbg.declare(metadata !{float** %1}, metadata !42), !dbg !43
  store float* %size_out, float** %2, align 8
  call void @llvm.dbg.declare(metadata !{float** %2}, metadata !44), !dbg !45
  store float* %x_in, float** %3, align 8
  call void @llvm.dbg.declare(metadata !{float** %3}, metadata !46), !dbg !47
  store float* %y_in, float** %4, align 8
  call void @llvm.dbg.declare(metadata !{float** %4}, metadata !48), !dbg !49
  store float* %scl_in, float** %5, align 8
  call void @llvm.dbg.declare(metadata !{float** %5}, metadata !50), !dbg !51
  store i32 %total_feat, i32* %6, align 4
  call void @llvm.dbg.declare(metadata !{i32* %6}, metadata !52), !dbg !53
  store float* %image_ptr, float** %7, align 8
  call void @llvm.dbg.declare(metadata !{float** %7}, metadata !54), !dbg !55
  store i32 %block_size, i32* %8, align 4
  call void @llvm.dbg.declare(metadata !{i32* %8}, metadata !56), !dbg !57
  store float %k_thr, float* %9, align 4
  call void @llvm.dbg.declare(metadata !{float* %9}, metadata !58), !dbg !59
  store i32 %patch_size, i32* %10, align 4
  call void @llvm.dbg.declare(metadata !{i32* %10}, metadata !60), !dbg !61
  call void @llvm.dbg.declare(metadata !{i32* %f}, metadata !62), !dbg !64
  %11 = load i32* getelementptr inbounds (%struct.dim3* @blockDim, i32 0, i32 0), align 4, !dbg !64
  %12 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 0), align 4, !dbg !64
  %13 = mul i32 %11, %12, !dbg !64
  %14 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !64
  %15 = add i32 %13, %14, !dbg !64
  store i32 %15, i32* %f, align 4, !dbg !64
  store i32 1000, i32* %6, align 4, !dbg !65
  store i32 16, i32* %8, align 4, !dbg !66
  %16 = load i32* %f, align 4, !dbg !67
  %17 = load i32* %6, align 4, !dbg !67
  %18 = icmp ult i32 %16, %17, !dbg !67
  br i1 %18, label %19, label %137, !dbg !67

; <label>:19                                      ; preds = %0
  call void @llvm.dbg.declare(metadata !{i32* %x}, metadata !68), !dbg !70
  call void @llvm.dbg.declare(metadata !{i32* %y}, metadata !71), !dbg !70
  call void @llvm.dbg.declare(metadata !{float* %scl}, metadata !72), !dbg !73
  store float 1.000000e+00, float* %scl, align 4, !dbg !73
  %20 = load float* %scl, align 4, !dbg !74
  %21 = fcmp ogt float %20, 0.000000e+00, !dbg !74
  br i1 %21, label %22, label %44, !dbg !74

; <label>:22                                      ; preds = %19
  %23 = load i32* %f, align 4, !dbg !75
  %24 = zext i32 %23 to i64, !dbg !75
  %25 = load float** %5, align 8, !dbg !75
  %26 = getelementptr inbounds float* %25, i64 %24, !dbg !75
  %27 = load float* %26, align 4, !dbg !75
  store float %27, float* %scl, align 4, !dbg !75
  %28 = load i32* %f, align 4, !dbg !77
  %29 = zext i32 %28 to i64, !dbg !77
  %30 = load float** %3, align 8, !dbg !77
  %31 = getelementptr inbounds float* %30, i64 %29, !dbg !77
  %32 = load float* %31, align 4, !dbg !77
  %33 = load float* %scl, align 4, !dbg !77
  %34 = fmul float %32, %33, !dbg !77
  %35 = fptoui float %34 to i32, !dbg !77
  store i32 %35, i32* %x, align 4, !dbg !77
  %36 = load i32* %f, align 4, !dbg !78
  %37 = zext i32 %36 to i64, !dbg !78
  %38 = load float** %4, align 8, !dbg !78
  %39 = getelementptr inbounds float* %38, i64 %37, !dbg !78
  %40 = load float* %39, align 4, !dbg !78
  %41 = load float* %scl, align 4, !dbg !78
  %42 = fmul float %40, %41, !dbg !78
  %43 = fptoui float %42 to i32, !dbg !78
  store i32 %43, i32* %y, align 4, !dbg !78
  br label %57, !dbg !79

; <label>:44                                      ; preds = %19
  %45 = load i32* %f, align 4, !dbg !80
  %46 = zext i32 %45 to i64, !dbg !80
  %47 = load float** %3, align 8, !dbg !80
  %48 = getelementptr inbounds float* %47, i64 %46, !dbg !80
  %49 = load float* %48, align 4, !dbg !80
  %50 = fptoui float %49 to i32, !dbg !80
  store i32 %50, i32* %x, align 4, !dbg !80
  %51 = load i32* %f, align 4, !dbg !82
  %52 = zext i32 %51 to i64, !dbg !82
  %53 = load float** %4, align 8, !dbg !82
  %54 = getelementptr inbounds float* %53, i64 %52, !dbg !82
  %55 = load float* %54, align 4, !dbg !82
  %56 = fptoui float %55 to i32, !dbg !82
  store i32 %56, i32* %y, align 4, !dbg !82
  br label %57

; <label>:57                                      ; preds = %44, %22
  call void @llvm.dbg.declare(metadata !{float* %size}, metadata !83), !dbg !84
  store float 1.000000e+00, float* %size, align 4, !dbg !84
  call void @llvm.dbg.declare(metadata !{i32* %r}, metadata !85), !dbg !86
  %58 = load i32* %8, align 4, !dbg !86
  %59 = udiv i32 %58, 2, !dbg !86
  store i32 %59, i32* %r, align 4, !dbg !86
  call void @llvm.dbg.declare(metadata !{float* %ixx}, metadata !87), !dbg !88
  store float 0.000000e+00, float* %ixx, align 4, !dbg !88
  call void @llvm.dbg.declare(metadata !{float* %iyy}, metadata !89), !dbg !88
  store float 0.000000e+00, float* %iyy, align 4, !dbg !88
  call void @llvm.dbg.declare(metadata !{float* %ixy}, metadata !90), !dbg !88
  store float 0.000000e+00, float* %ixy, align 4, !dbg !88
  call void @llvm.dbg.declare(metadata !{i32* %block_size_sq}, metadata !91), !dbg !92
  %60 = load i32* %8, align 4, !dbg !92
  %61 = load i32* %8, align 4, !dbg !92
  %62 = mul i32 %60, %61, !dbg !92
  store i32 %62, i32* %block_size_sq, align 4, !dbg !92
  call void @llvm.dbg.declare(metadata !{i32* %k}, metadata !93), !dbg !95
  %63 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 1), align 4, !dbg !95
  store i32 %63, i32* %k, align 4, !dbg !95
  br label %64, !dbg !95

; <label>:64                                      ; preds = %126, %57
  %65 = load i32* %k, align 4, !dbg !95
  %66 = load i32* %block_size_sq, align 4, !dbg !95
  %67 = icmp ult i32 %65, %66, !dbg !95
  br i1 %67, label %68, label %130, !dbg !95

; <label>:68                                      ; preds = %64
  call void @llvm.dbg.declare(metadata !{i32* %i}, metadata !96), !dbg !99
  %69 = load i32* %k, align 4, !dbg !99
  %70 = load i32* %8, align 4, !dbg !99
  %71 = udiv i32 %69, %70, !dbg !99
  %72 = load i32* %r, align 4, !dbg !99
  %73 = sub i32 %71, %72, !dbg !99
  store i32 %73, i32* %i, align 4, !dbg !99
  call void @llvm.dbg.declare(metadata !{i32* %j}, metadata !100), !dbg !101
  %74 = load i32* %k, align 4, !dbg !101
  %75 = load i32* %8, align 4, !dbg !101
  %76 = urem i32 %74, %75, !dbg !101
  %77 = load i32* %r, align 4, !dbg !101
  %78 = sub i32 %76, %77, !dbg !101
  store i32 %78, i32* %j, align 4, !dbg !101
  call void @llvm.dbg.declare(metadata !{float* %ix}, metadata !102), !dbg !103
  %79 = load i32* %x, align 4, !dbg !103
  %80 = load i32* %i, align 4, !dbg !103
  %81 = add i32 %79, %80, !dbg !103
  %82 = add i32 %81, 1, !dbg !103
  %83 = zext i32 %82 to i64, !dbg !103
  %84 = load float** %7, align 8, !dbg !103
  %85 = getelementptr inbounds float* %84, i64 %83, !dbg !103
  %86 = load float* %85, align 4, !dbg !103
  %87 = load i32* %x, align 4, !dbg !103
  %88 = load i32* %i, align 4, !dbg !103
  %89 = add i32 %87, %88, !dbg !103
  %90 = sub i32 %89, 1, !dbg !103
  %91 = zext i32 %90 to i64, !dbg !103
  %92 = load float** %7, align 8, !dbg !103
  %93 = getelementptr inbounds float* %92, i64 %91, !dbg !103
  %94 = load float* %93, align 4, !dbg !103
  %95 = fsub float %86, %94, !dbg !103
  store float %95, float* %ix, align 4, !dbg !103
  call void @llvm.dbg.declare(metadata !{float* %iy}, metadata !104), !dbg !105
  %96 = load i32* %x, align 4, !dbg !105
  %97 = load i32* %i, align 4, !dbg !105
  %98 = add i32 %96, %97, !dbg !105
  %99 = zext i32 %98 to i64, !dbg !105
  %100 = load float** %7, align 8, !dbg !105
  %101 = getelementptr inbounds float* %100, i64 %99, !dbg !105
  %102 = load float* %101, align 4, !dbg !105
  %103 = load i32* %x, align 4, !dbg !105
  %104 = load i32* %i, align 4, !dbg !105
  %105 = add i32 %103, %104, !dbg !105
  %106 = zext i32 %105 to i64, !dbg !105
  %107 = load float** %7, align 8, !dbg !105
  %108 = getelementptr inbounds float* %107, i64 %106, !dbg !105
  %109 = load float* %108, align 4, !dbg !105
  %110 = fsub float %102, %109, !dbg !105
  store float %110, float* %iy, align 4, !dbg !105
  %111 = load float* %ix, align 4, !dbg !106
  %112 = load float* %ix, align 4, !dbg !106
  %113 = fmul float %111, %112, !dbg !106
  %114 = load float* %ixx, align 4, !dbg !106
  %115 = fadd float %114, %113, !dbg !106
  store float %115, float* %ixx, align 4, !dbg !106
  %116 = load float* %iy, align 4, !dbg !107
  %117 = load float* %iy, align 4, !dbg !107
  %118 = fmul float %116, %117, !dbg !107
  %119 = load float* %iyy, align 4, !dbg !107
  %120 = fadd float %119, %118, !dbg !107
  store float %120, float* %iyy, align 4, !dbg !107
  %121 = load float* %ix, align 4, !dbg !108
  %122 = load float* %iy, align 4, !dbg !108
  %123 = fmul float %121, %122, !dbg !108
  %124 = load float* %ixy, align 4, !dbg !108
  %125 = fadd float %124, %123, !dbg !108
  store float %125, float* %ixy, align 4, !dbg !108
  br label %126, !dbg !109

; <label>:126                                     ; preds = %68
  %127 = load i32* getelementptr inbounds (%struct.dim3* @blockDim, i32 0, i32 1), align 4, !dbg !95
  %128 = load i32* %k, align 4, !dbg !95
  %129 = add i32 %128, %127, !dbg !95
  store i32 %129, i32* %k, align 4, !dbg !95
  br label %64, !dbg !95

; <label>:130                                     ; preds = %64
  call void @__syncthreads(), !dbg !110
  %131 = load float* %ixx, align 4, !dbg !111
  %132 = call float @_Z16block_reduce_sumf(float %131), !dbg !111
  store float %132, float* %ixx, align 4, !dbg !111
  %133 = load float* %iyy, align 4, !dbg !112
  %134 = call float @_Z16block_reduce_sumf(float %133), !dbg !112
  store float %134, float* %iyy, align 4, !dbg !112
  %135 = load float* %ixy, align 4, !dbg !113
  %136 = call float @_Z16block_reduce_sumf(float %135), !dbg !113
  store float %136, float* %ixy, align 4, !dbg !113
  br label %137, !dbg !114

; <label>:137                                     ; preds = %130, %0
  ret void, !dbg !115
}

!llvm.dbg.cu = !{!0}

!0 = metadata !{i32 786449, i32 0, i32 4, metadata !"harris_response.cpp", metadata !"/home/mingyuanwu/arrayfire-repair", metadata !"clang version 3.2 (tags/RELEASE_32/final)", i1 true, i1 false, metadata !"", i32 0, metadata !1, metadata !1, metadata !3, metadata !18} ; [ DW_TAG_compile_unit ] [/home/mingyuanwu/arrayfire-repair/harris_response.cpp] [DW_LANG_C_plus_plus]
!1 = metadata !{metadata !2}
!2 = metadata !{i32 0}
!3 = metadata !{metadata !4}
!4 = metadata !{metadata !5, metadata !10}
!5 = metadata !{i32 786478, i32 0, metadata !6, metadata !"block_reduce_sum", metadata !"block_reduce_sum", metadata !"_Z16block_reduce_sumf", metadata !6, i32 1, metadata !7, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, float (float)* @_Z16block_reduce_sumf, null, null, metadata !1, i32 2} ; [ DW_TAG_subprogram ] [line 1] [def] [scope 2] [block_reduce_sum]
!6 = metadata !{i32 786473, metadata !"harris_response.cpp", metadata !"/home/mingyuanwu/arrayfire-repair", null} ; [ DW_TAG_file_type ]
!7 = metadata !{i32 786453, i32 0, metadata !"", i32 0, i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !8, i32 0, i32 0} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!8 = metadata !{metadata !9, metadata !9}
!9 = metadata !{i32 786468, null, metadata !"float", null, i32 0, i64 32, i64 32, i64 0, i32 0, i32 4} ; [ DW_TAG_base_type ] [float] [line 0, size 32, align 32, offset 0, enc DW_ATE_float]
!10 = metadata !{i32 786478, i32 0, metadata !6, metadata !"harris_response", metadata !"harris_response", metadata !"_Z15harris_responsePfS_PKfS1_S1_jS_jfj", metadata !6, i32 24, metadata !11, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, void (float*, float*, float*, float*, float*, i32, float*, i32, float, i32)* @_Z15harris_responsePfS_PKfS1_S1_jS_jfj, null, null, metadata !1, i32 35} ; [ DW_TAG_subprogram ] [line 24] [def] [scope 35] [harris_response]
!11 = metadata !{i32 786453, i32 0, metadata !"", i32 0, i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !12, i32 0, i32 0} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!12 = metadata !{null, metadata !13, metadata !13, metadata !14, metadata !14, metadata !14, metadata !16, metadata !13, metadata !16, metadata !15, metadata !17}
!13 = metadata !{i32 786447, null, metadata !"", null, i32 0, i64 64, i64 64, i64 0, i32 0, metadata !9} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from float]
!14 = metadata !{i32 786447, null, metadata !"", null, i32 0, i64 64, i64 64, i64 0, i32 0, metadata !15} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from ]
!15 = metadata !{i32 786470, null, metadata !"", null, i32 0, i64 0, i64 0, i64 0, i32 0, metadata !9} ; [ DW_TAG_const_type ] [line 0, size 0, align 0, offset 0] [from float]
!16 = metadata !{i32 786468, null, metadata !"unsigned int", null, i32 0, i64 32, i64 32, i64 0, i32 0, i32 7} ; [ DW_TAG_base_type ] [unsigned int] [line 0, size 32, align 32, offset 0, enc DW_ATE_unsigned]
!17 = metadata !{i32 786470, null, metadata !"", null, i32 0, i64 0, i64 0, i64 0, i32 0, metadata !16} ; [ DW_TAG_const_type ] [line 0, size 0, align 0, offset 0] [from unsigned int]
!18 = metadata !{metadata !19}
!19 = metadata !{metadata !20}
!20 = metadata !{i32 786484, i32 0, metadata !5, metadata !"data", metadata !"data", metadata !"", metadata !6, i32 3, metadata !21, i32 1, i32 1, [256 x float]* @_ZZ16block_reduce_sumfE4data} ; [ DW_TAG_variable ] [data] [line 3] [local] [def]
!21 = metadata !{i32 786433, null, metadata !"", null, i32 0, i64 8192, i64 32, i32 0, i32 0, metadata !9, metadata !22, i32 0, i32 0} ; [ DW_TAG_array_type ] [line 0, size 8192, align 32, offset 0] [from float]
!22 = metadata !{metadata !23}
!23 = metadata !{i32 786465, i64 0, i64 255}      ; [ DW_TAG_subrange_type ] [0, 255]
!24 = metadata !{i32 786689, metadata !5, metadata !"val", metadata !6, i32 16777217, metadata !9, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [val] [line 1]
!25 = metadata !{i32 1, i32 0, metadata !5, null}
!26 = metadata !{i32 786688, metadata !27, metadata !"idx", metadata !6, i32 5, metadata !16, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [idx] [line 5]
!27 = metadata !{i32 786443, metadata !5, i32 2, i32 0, metadata !6, i32 0} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire-repair/harris_response.cpp]
!28 = metadata !{i32 5, i32 0, metadata !27, null}
!29 = metadata !{i32 7, i32 0, metadata !27, null}
!30 = metadata !{i32 8, i32 0, metadata !27, null}
!31 = metadata !{i32 786688, metadata !32, metadata !"i", metadata !6, i32 10, metadata !16, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [i] [line 10]
!32 = metadata !{i32 786443, metadata !27, i32 10, i32 0, metadata !6, i32 1} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire-repair/harris_response.cpp]
!33 = metadata !{i32 10, i32 0, metadata !32, null}
!34 = metadata !{i32 12, i32 0, metadata !35, null}
!35 = metadata !{i32 786443, metadata !32, i32 11, i32 0, metadata !6, i32 2} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire-repair/harris_response.cpp]
!36 = metadata !{i32 14, i32 0, metadata !37, null}
!37 = metadata !{i32 786443, metadata !35, i32 13, i32 0, metadata !6, i32 3} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire-repair/harris_response.cpp]
!38 = metadata !{i32 15, i32 0, metadata !37, null}
!39 = metadata !{i32 17, i32 0, metadata !35, null}
!40 = metadata !{i32 18, i32 0, metadata !35, null}
!41 = metadata !{i32 20, i32 0, metadata !27, null}
!42 = metadata !{i32 786689, metadata !10, metadata !"score_out", metadata !6, i32 16777241, metadata !13, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [score_out] [line 25]
!43 = metadata !{i32 25, i32 0, metadata !10, null}
!44 = metadata !{i32 786689, metadata !10, metadata !"size_out", metadata !6, i32 33554458, metadata !13, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [size_out] [line 26]
!45 = metadata !{i32 26, i32 0, metadata !10, null}
!46 = metadata !{i32 786689, metadata !10, metadata !"x_in", metadata !6, i32 50331675, metadata !14, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [x_in] [line 27]
!47 = metadata !{i32 27, i32 0, metadata !10, null}
!48 = metadata !{i32 786689, metadata !10, metadata !"y_in", metadata !6, i32 67108892, metadata !14, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [y_in] [line 28]
!49 = metadata !{i32 28, i32 0, metadata !10, null}
!50 = metadata !{i32 786689, metadata !10, metadata !"scl_in", metadata !6, i32 83886109, metadata !14, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [scl_in] [line 29]
!51 = metadata !{i32 29, i32 0, metadata !10, null}
!52 = metadata !{i32 786689, metadata !10, metadata !"total_feat", metadata !6, i32 100663326, metadata !16, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [total_feat] [line 30]
!53 = metadata !{i32 30, i32 0, metadata !10, null}
!54 = metadata !{i32 786689, metadata !10, metadata !"image_ptr", metadata !6, i32 117440543, metadata !13, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [image_ptr] [line 31]
!55 = metadata !{i32 31, i32 0, metadata !10, null}
!56 = metadata !{i32 786689, metadata !10, metadata !"block_size", metadata !6, i32 134217760, metadata !16, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [block_size] [line 32]
!57 = metadata !{i32 32, i32 0, metadata !10, null}
!58 = metadata !{i32 786689, metadata !10, metadata !"k_thr", metadata !6, i32 150994977, metadata !15, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [k_thr] [line 33]
!59 = metadata !{i32 33, i32 0, metadata !10, null}
!60 = metadata !{i32 786689, metadata !10, metadata !"patch_size", metadata !6, i32 167772194, metadata !17, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [patch_size] [line 34]
!61 = metadata !{i32 34, i32 0, metadata !10, null}
!62 = metadata !{i32 786688, metadata !63, metadata !"f", metadata !6, i32 36, metadata !16, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [f] [line 36]
!63 = metadata !{i32 786443, metadata !10, i32 35, i32 0, metadata !6, i32 4} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire-repair/harris_response.cpp]
!64 = metadata !{i32 36, i32 0, metadata !63, null}
!65 = metadata !{i32 37, i32 0, metadata !63, null}
!66 = metadata !{i32 38, i32 0, metadata !63, null}
!67 = metadata !{i32 39, i32 0, metadata !63, null}
!68 = metadata !{i32 786688, metadata !69, metadata !"x", metadata !6, i32 40, metadata !16, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [x] [line 40]
!69 = metadata !{i32 786443, metadata !63, i32 39, i32 0, metadata !6, i32 5} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire-repair/harris_response.cpp]
!70 = metadata !{i32 40, i32 0, metadata !69, null}
!71 = metadata !{i32 786688, metadata !69, metadata !"y", metadata !6, i32 40, metadata !16, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [y] [line 40]
!72 = metadata !{i32 786688, metadata !69, metadata !"scl", metadata !6, i32 41, metadata !9, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [scl] [line 41]
!73 = metadata !{i32 41, i32 0, metadata !69, null}
!74 = metadata !{i32 42, i32 0, metadata !69, null}
!75 = metadata !{i32 44, i32 0, metadata !76, null}
!76 = metadata !{i32 786443, metadata !69, i32 42, i32 0, metadata !6, i32 6} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire-repair/harris_response.cpp]
!77 = metadata !{i32 45, i32 0, metadata !76, null}
!78 = metadata !{i32 46, i32 0, metadata !76, null}
!79 = metadata !{i32 47, i32 0, metadata !76, null}
!80 = metadata !{i32 49, i32 0, metadata !81, null}
!81 = metadata !{i32 786443, metadata !69, i32 48, i32 0, metadata !6, i32 7} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire-repair/harris_response.cpp]
!82 = metadata !{i32 50, i32 0, metadata !81, null}
!83 = metadata !{i32 786688, metadata !69, metadata !"size", metadata !6, i32 54, metadata !9, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [size] [line 54]
!84 = metadata !{i32 54, i32 0, metadata !69, null}
!85 = metadata !{i32 786688, metadata !69, metadata !"r", metadata !6, i32 58, metadata !16, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [r] [line 58]
!86 = metadata !{i32 58, i32 0, metadata !69, null}
!87 = metadata !{i32 786688, metadata !69, metadata !"ixx", metadata !6, i32 60, metadata !9, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [ixx] [line 60]
!88 = metadata !{i32 60, i32 0, metadata !69, null}
!89 = metadata !{i32 786688, metadata !69, metadata !"iyy", metadata !6, i32 60, metadata !9, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [iyy] [line 60]
!90 = metadata !{i32 786688, metadata !69, metadata !"ixy", metadata !6, i32 60, metadata !9, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [ixy] [line 60]
!91 = metadata !{i32 786688, metadata !69, metadata !"block_size_sq", metadata !6, i32 61, metadata !16, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [block_size_sq] [line 61]
!92 = metadata !{i32 61, i32 0, metadata !69, null}
!93 = metadata !{i32 786688, metadata !94, metadata !"k", metadata !6, i32 62, metadata !16, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [k] [line 62]
!94 = metadata !{i32 786443, metadata !69, i32 62, i32 0, metadata !6, i32 8} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire-repair/harris_response.cpp]
!95 = metadata !{i32 62, i32 0, metadata !94, null}
!96 = metadata !{i32 786688, metadata !97, metadata !"i", metadata !6, i32 63, metadata !98, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [i] [line 63]
!97 = metadata !{i32 786443, metadata !94, i32 62, i32 0, metadata !6, i32 9} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire-repair/harris_response.cpp]
!98 = metadata !{i32 786468, null, metadata !"int", null, i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!99 = metadata !{i32 63, i32 0, metadata !97, null}
!100 = metadata !{i32 786688, metadata !97, metadata !"j", metadata !6, i32 64, metadata !98, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [j] [line 64]
!101 = metadata !{i32 64, i32 0, metadata !97, null}
!102 = metadata !{i32 786688, metadata !97, metadata !"ix", metadata !6, i32 67, metadata !9, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [ix] [line 67]
!103 = metadata !{i32 67, i32 0, metadata !97, null}
!104 = metadata !{i32 786688, metadata !97, metadata !"iy", metadata !6, i32 68, metadata !9, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [iy] [line 68]
!105 = metadata !{i32 68, i32 0, metadata !97, null}
!106 = metadata !{i32 71, i32 0, metadata !97, null}
!107 = metadata !{i32 72, i32 0, metadata !97, null}
!108 = metadata !{i32 73, i32 0, metadata !97, null}
!109 = metadata !{i32 74, i32 0, metadata !97, null}
!110 = metadata !{i32 75, i32 0, metadata !69, null}
!111 = metadata !{i32 77, i32 0, metadata !69, null}
!112 = metadata !{i32 78, i32 0, metadata !69, null}
!113 = metadata !{i32 79, i32 0, metadata !69, null}
!114 = metadata !{i32 80, i32 0, metadata !69, null}
!115 = metadata !{i32 81, i32 0, metadata !63, null}
