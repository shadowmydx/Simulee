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

define adfadf @adsfas(adsfasdf) {}