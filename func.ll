define internal double @_ZL11_sum_reduceIdET_PS0_(double* %buffer) uwtable section "__device__" {
  %1 = alloca double*, align 8
  %nTotalThreads = alloca i32, align 4
  %halfPoint = alloca i32, align 4
  %temp = alloca double, align 8
  store double* %buffer, double** %1, align 8
  call void @llvm.dbg.declare(metadata !{double** %1}, metadata !5478), !dbg !5479
  call void @llvm.dbg.declare(metadata !{i32* %nTotalThreads}, metadata !5480), !dbg !5482
  %2 = load i32* getelementptr inbounds (%struct.dim3* @blockDim, i32 0, i32 0), align 4, !dbg !5482
  store i32 %2, i32* %nTotalThreads, align 4, !dbg !5482
  call void @__syncthreads(), !dbg !5483
  br label %3, !dbg !5484

; <label>:3                                       ; preds = %35, %0
  %4 = load i32* %nTotalThreads, align 4, !dbg !5484
  %5 = icmp sgt i32 %4, 1, !dbg !5484
  br i1 %5, label %6, label %39, !dbg !5484

; <label>:6                                       ; preds = %3
  call void @llvm.dbg.declare(metadata !{i32* %halfPoint}, metadata !5485), !dbg !5487
  %7 = load i32* %nTotalThreads, align 4, !dbg !5487
  %8 = add nsw i32 1, %7, !dbg !5487
  %9 = ashr i32 %8, 1, !dbg !5487
  store i32 %9, i32* %halfPoint, align 4, !dbg !5487
  %10 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !5488
  %11 = load i32* %halfPoint, align 4, !dbg !5488
  %12 = icmp ult i32 %10, %11, !dbg !5488
  br i1 %12, label %13, label %35, !dbg !5488

; <label>:13                                      ; preds = %6
  call void @llvm.dbg.declare(metadata !{double* %temp}, metadata !5489), !dbg !5491
  store double 0.000000e+00, double* %temp, align 8, !dbg !5491
  %14 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !5492
  %15 = load i32* %halfPoint, align 4, !dbg !5492
  %16 = add i32 %14, %15, !dbg !5492
  %17 = load i32* %nTotalThreads, align 4, !dbg !5492
  %18 = icmp ult i32 %16, %17, !dbg !5492
  br i1 %18, label %19, label %27, !dbg !5492

; <label>:19                                      ; preds = %13
  %20 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !5493
  %21 = load i32* %halfPoint, align 4, !dbg !5493
  %22 = add i32 %20, %21, !dbg !5493
  %23 = zext i32 %22 to i64, !dbg !5493
  %24 = load double** %1, align 8, !dbg !5493
  %25 = getelementptr inbounds double* %24, i64 %23, !dbg !5493
  %26 = load double* %25, align 8, !dbg !5493
  store double %26, double* %temp, align 8, !dbg !5493
  br label %27, !dbg !5495

; <label>:27                                      ; preds = %19, %13
  %28 = load double* %temp, align 8, !dbg !5496
  %29 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !5496
  %30 = zext i32 %29 to i64, !dbg !5496
  %31 = load double** %1, align 8, !dbg !5496
  %32 = getelementptr inbounds double* %31, i64 %30, !dbg !5496
  %33 = load double* %32, align 8, !dbg !5496
  %34 = fadd double %33, %28, !dbg !5496
  store double %34, double* %32, align 8, !dbg !5496
  br label %35, !dbg !5497

; <label>:35                                      ; preds = %27, %6
  call void @__syncthreads(), !dbg !5498
  %36 = load i32* %nTotalThreads, align 4, !dbg !5499
  %37 = add nsw i32 1, %36, !dbg !5499
  %38 = ashr i32 %37, 1, !dbg !5499
  store i32 %38, i32* %nTotalThreads, align 4, !dbg !5499
  br label %3, !dbg !5500

; <label>:39                                      ; preds = %3
  %40 = load double** %1, align 8, !dbg !5501
  %41 = getelementptr inbounds double* %40, i64 0, !dbg !5501
  %42 = load double* %41, align 8, !dbg !5501
  ret double %42, !dbg !5501
}

define internal void @_ZL8_vec_sumIdEvPT_S1_i(double* %v, double* %sum, i32 %dim) uwtable noinline {
  %1 = alloca double*, align 8
  %2 = alloca double*, align 8
  %3 = alloca i32, align 4
  %i = alloca i32, align 4
  %ans = alloca double, align 8
  store double* %v, double** %1, align 8
  call void @llvm.dbg.declare(metadata !{double** %1}, metadata !4393), !dbg !4394
  store double* %sum, double** %2, align 8
  call void @llvm.dbg.declare(metadata !{double** %2}, metadata !4395), !dbg !4394
  store i32 %dim, i32* %3, align 4
  call void @llvm.dbg.declare(metadata !{i32* %3}, metadata !4396), !dbg !4394
  call void @llvm.dbg.declare(metadata !{i32* %i}, metadata !4397), !dbg !4399
  %4 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 0), align 4, !dbg !4399
  %5 = load i32* getelementptr inbounds (%struct.dim3* @blockDim, i32 0, i32 0), align 4, !dbg !4399
  %6 = mul i32 %4, %5, !dbg !4399
  %7 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !4399
  %8 = add i32 %6, %7, !dbg !4399
  store i32 %8, i32* %i, align 4, !dbg !4399
  %9 = load i32* %i, align 4, !dbg !4400
  %10 = load i32* %3, align 4, !dbg !4400
  %11 = icmp slt i32 %9, %10, !dbg !4400
  br i1 %11, label %12, label %21, !dbg !4400

; <label>:12                                      ; preds = %0
  %13 = load i32* %i, align 4, !dbg !4401
  %14 = sext i32 %13 to i64, !dbg !4401
  %15 = load double** %1, align 8, !dbg !4401
  %16 = getelementptr inbounds double* %15, i64 %14, !dbg !4401
  %17 = load double* %16, align 8, !dbg !4401
  %18 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !4401
  %19 = zext i32 %18 to i64, !dbg !4401
  %20 = getelementptr inbounds [256 x double]* @_ZZL8_vec_sumIdEvPT_S1_iE8row_data, i32 0, i64 %19, !dbg !4401
  store double %17, double* %20, align 8, !dbg !4401
  br label %25, !dbg !4401

; <label>:21                                      ; preds = %0
  %22 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !4402
  %23 = zext i32 %22 to i64, !dbg !4402
  %24 = getelementptr inbounds [256 x double]* @_ZZL8_vec_sumIdEvPT_S1_iE8row_data, i32 0, i64 %23, !dbg !4402
  store double 0.000000e+00, double* %24, align 8, !dbg !4402
  br label %25

; <label>:25                                      ; preds = %21, %12
  call void @__syncthreads(), !dbg !4403
  call void @llvm.dbg.declare(metadata !{double* %ans}, metadata !4404), !dbg !4405
  %26 = call double @_ZL11_sum_reduceIdET_PS0_(double* getelementptr inbounds ([256 x double]* @_ZZL8_vec_sumIdEvPT_S1_iE8row_data, i32 0, i32 0)), !dbg !4405
  store double %26, double* %ans, align 8, !dbg !4405
  %27 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !4406
  %28 = icmp eq i32 %27, 0, !dbg !4406
  br i1 %28, label %29, label %34, !dbg !4406

; <label>:29                                      ; preds = %25
  %30 = load double* %ans, align 8, !dbg !4407
  %31 = load double** %2, align 8, !dbg !4407
  %32 = load double* %31, align 8, !dbg !4407
  %33 = fadd double %32, %30, !dbg !4407
  store double %33, double* %31, align 8, !dbg !4407
  br label %34, !dbg !4407

; <label>:34                                      ; preds = %29, %25
  ret void, !dbg !4408
}
