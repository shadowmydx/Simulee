  %1 = alloca i32*, align 8
  %2 = alloca i32, align 4
  %my_index = alloca i32, align 4
  store i32* %input_array, i32** %1, align 8
  call void @llvm.dbg.declare(metadata !{i32** %1}, metadata !149), !dbg !150
  store i32 %num_elements, i32* %2, align 4
  call void @llvm.dbg.declare(metadata !{i32* %2}, metadata !151), !dbg !150
  call void @llvm.dbg.declare(metadata !{i32* %my_index}, metadata !152), !dbg !154
  %3 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 0), align 4, !dbg !154
  %4 = load i32* getelementptr inbounds (%struct.dim3* @blockDim, i32 0, i32 0), align 4, !dbg !154
  %5 = mul i32 %3, %4, !dbg !154
  %6 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !154
  %7 = add i32 %5, %6, !dbg !154
  store i32 %7, i32* %my_index, align 4, !dbg !154
  %8 = load i32* %my_index, align 4, !dbg !155
  %9 = load i32* %2, align 4, !dbg !155
  %10 = icmp slt i32 %8, %9, !dbg !155
  br i1 %10, label %11, label %33, !dbg !155

; <label>:11                                      ; preds = %0
  %12 = load i32* %my_index, align 4, !dbg !156
  %13 = srem i32 %12, 2, !dbg !156
  %14 = icmp eq i32 %13, 1, !dbg !156
  br i1 %14, label %15, label %21, !dbg !156

; <label>:15                                      ; preds = %11
  %16 = load i32* %my_index, align 4, !dbg !158
  %17 = load i32* %my_index, align 4, !dbg !158
  %18 = sext i32 %17 to i64, !dbg !158
  %19 = load i32** %1, align 8, !dbg !158
  %20 = getelementptr inbounds i32* %19, i64 %18, !dbg !158
  store i32 %16, i32* %20, align 4, !dbg !158
  br label %32, !dbg !160

; <label>:21                                      ; preds = %11
  %22 = load i32* %my_index, align 4, !dbg !161
  %23 = add nsw i32 %22, 1, !dbg !161
  %24 = sext i32 %23 to i64, !dbg !161
  %25 = load i32** %1, align 8, !dbg !161
  %26 = getelementptr inbounds i32* %25, i64 %24, !dbg !161
  %27 = load i32* %26, align 4, !dbg !161
  %28 = load i32* %my_index, align 4, !dbg !161
  %29 = sext i32 %28 to i64, !dbg !161
  %30 = load i32** %1, align 8, !dbg !161
  %31 = getelementptr inbounds i32* %30, i64 %29, !dbg !161
  store i32 %27, i32* %31, align 4, !dbg !161
  br label %32

; <label>:32                                      ; preds = %21, %15
  br label %33, !dbg !163

; <label>:33                                      ; preds = %32, %0
  ret void, !dbg !164