  %1 = alloca i32*, align 8
  %2 = alloca i32, align 4
  %i = alloca i32, align 4
  %max = alloca i32, align 4
  %sum = alloca i32, align 4
  %j = alloca i32, align 4
  %j1 = alloca i32, align 4
  %j2 = alloca i32, align 4
  store i32* %x, i32** %1, align 8
  call void @llvm.dbg.declare(metadata !{i32** %1}, metadata !153), !dbg !154
  store i32 %dim, i32* %2, align 4
  call void @llvm.dbg.declare(metadata !{i32* %2}, metadata !155), !dbg !154
  call void @llvm.dbg.declare(metadata !{i32* %i}, metadata !156), !dbg !158
  %3 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 0), align 4, !dbg !158
  %4 = load i32* getelementptr inbounds (%struct.dim3* @blockDim, i32 0, i32 0), align 4, !dbg !158
  %5 = mul i32 %3, %4, !dbg !158
  %6 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !158
  %7 = add i32 %5, %6, !dbg !158
  store i32 %7, i32* %i, align 4, !dbg !158
  call void @llvm.dbg.declare(metadata !{i32* %max}, metadata !159), !dbg !160
  store i32 -1, i32* %max, align 4, !dbg !160
  call void @llvm.dbg.declare(metadata !{i32* %sum}, metadata !161), !dbg !162
  store i32 0, i32* %sum, align 4, !dbg !162
  %8 = load i32* %i, align 4, !dbg !163
  %9 = load i32* %2, align 4, !dbg !163
  %10 = icmp slt i32 %8, %9, !dbg !163
  br i1 %10, label %11, label %69, !dbg !163

; <label>:11                                      ; preds = %0
  call void @llvm.dbg.declare(metadata !{i32* %j}, metadata !164), !dbg !167
  store i32 0, i32* %j, align 4, !dbg !167
  br label %12, !dbg !167

; <label>:12                                      ; preds = %22, %11
  %13 = load i32* %j, align 4, !dbg !167
  %14 = load i32* %2, align 4, !dbg !167
  %15 = icmp slt i32 %13, %14, !dbg !167
  br i1 %15, label %16, label %25, !dbg !167

; <label>:16                                      ; preds = %12
  %17 = load i32* %i, align 4, !dbg !168
  %18 = sext i32 %17 to i64, !dbg !168
  %19 = load i32** %1, align 8, !dbg !168
  %20 = getelementptr inbounds i32* %19, i64 %18, !dbg !168
  %21 = load i32* %20, align 4, !dbg !168
  store i32 %21, i32* %max, align 4, !dbg !168
  br label %22, !dbg !170

; <label>:22                                      ; preds = %16
  %23 = load i32* %j, align 4, !dbg !167
  %24 = add nsw i32 %23, 1, !dbg !167
  store i32 %24, i32* %j, align 4, !dbg !167
  br label %12, !dbg !167

; <label>:25                                      ; preds = %12
  call void @llvm.dbg.declare(metadata !{i32* %j1}, metadata !171), !dbg !173
  store i32 0, i32* %j1, align 4, !dbg !173
  br label %26, !dbg !173

; <label>:26                                      ; preds = %49, %25
  %27 = load i32* %j1, align 4, !dbg !173
  %28 = load i32* %2, align 4, !dbg !173
  %29 = icmp slt i32 %27, %28, !dbg !173
  br i1 %29, label %30, label %52, !dbg !173

; <label>:30                                      ; preds = %26
  %31 = load i32* %i, align 4, !dbg !174
  %32 = sext i32 %31 to i64, !dbg !174
  %33 = load i32** %1, align 8, !dbg !174
  %34 = getelementptr inbounds i32* %33, i64 %32, !dbg !174
  %35 = load i32* %34, align 4, !dbg !174
  %36 = load i32* %max, align 4, !dbg !174
  %37 = sub nsw i32 %35, %36, !dbg !174
  %38 = load i32* %i, align 4, !dbg !174
  %39 = sext i32 %38 to i64, !dbg !174
  %40 = load i32** %1, align 8, !dbg !174
  %41 = getelementptr inbounds i32* %40, i64 %39, !dbg !174
  store i32 %37, i32* %41, align 4, !dbg !174
  %42 = load i32* %i, align 4, !dbg !176
  %43 = sext i32 %42 to i64, !dbg !176
  %44 = load i32** %1, align 8, !dbg !176
  %45 = getelementptr inbounds i32* %44, i64 %43, !dbg !176
  %46 = load i32* %45, align 4, !dbg !176
  %47 = load i32* %sum, align 4, !dbg !176
  %48 = add nsw i32 %47, %46, !dbg !176
  store i32 %48, i32* %sum, align 4, !dbg !176
  br label %49, !dbg !177

; <label>:49                                      ; preds = %30
  %50 = load i32* %j1, align 4, !dbg !173
  %51 = add nsw i32 %50, 1, !dbg !173
  store i32 %51, i32* %j1, align 4, !dbg !173
  br label %26, !dbg !173

; <label>:52                                      ; preds = %26
  call void @llvm.dbg.declare(metadata !{i32* %j2}, metadata !178), !dbg !180
  store i32 0, i32* %j2, align 4, !dbg !180
  br label %53, !dbg !180

; <label>:53                                      ; preds = %65, %52
  %54 = load i32* %j2, align 4, !dbg !180
  %55 = load i32* %2, align 4, !dbg !180
  %56 = icmp slt i32 %54, %55, !dbg !180
  br i1 %56, label %57, label %68, !dbg !180

; <label>:57                                      ; preds = %53
  %58 = load i32* %sum, align 4, !dbg !181
  %59 = load i32* %i, align 4, !dbg !181
  %60 = sext i32 %59 to i64, !dbg !181
  %61 = load i32** %1, align 8, !dbg !181
  %62 = getelementptr inbounds i32* %61, i64 %60, !dbg !181
  %63 = load i32* %62, align 4, !dbg !181
  %64 = sdiv i32 %63, %58, !dbg !181
  store i32 %64, i32* %62, align 4, !dbg !181
  br label %65, !dbg !183

; <label>:65                                      ; preds = %57
  %66 = load i32* %j2, align 4, !dbg !180
  %67 = add nsw i32 %66, 1, !dbg !180
  store i32 %67, i32* %j2, align 4, !dbg !180
  br label %53, !dbg !180

; <label>:68                                      ; preds = %53
  br label %69, !dbg !184

; <label>:69                                      ; preds = %68, %0
  ret void, !dbg !185