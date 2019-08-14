define void @_Z2dlPi(i32* %in) uwtable noinline {
%label9 = alloca i1, align 4
%label37not = alloca i1, align 4
%label0not = alloca i1, align 4
%label0 = alloca i1, align 4
%label20not = alloca i1, align 4
%label9not = alloca i1, align 4
%label20 = alloca i1, align 4
%label37 = alloca i1, align 4
%1 = alloca i32*, align 8
%tid = alloca i32, align 4
%sum = alloca i32, align 4
store i32* %in, i32** %1, align 8
%2 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !15
%3 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 0), align 4, !dbg !15
%4 = load i32* getelementptr inbounds (%struct.dim3* @blockDim, i32 0, i32 0), align 4, !dbg !15
%5 = mul i32 %3, %4, !dbg !15
%6 = add i32 %2, %5, !dbg !15
store i32 %6, i32* %tid, align 4, !dbg !15
%7 = load i32* %tid, align 4, !dbg !16
%8 = icmp slt i32 %7, 50, !dbg !16
%label0 = load i1 %8
%label0not = icmp sge i32 %7, 50, !dbg !16
br label %58

; <label>:58
%label58 = load i1 %label0
br i1 %label58, label %9, label %59
br label %9
br label %9

; <label>:9                                       ; preds = %0
%10 = load i32* %tid, align 4, !dbg !17
%11 = srem i32 %10, 2, !dbg !17
%12 = icmp eq i32 %11, 0, !dbg !17
%label9 = load i1 %12
%label9not = icmp ne i32 %11, 0, !dbg !17
br label %59

; <label>:59
%label59 = load i1 %label0
%label59 = and i1 %label59, %label9
br i1 %label59, label %13, label %60
br label %13
br label %13

; <label>:13                                      ; preds = %9
%14 = load i32* %tid, align 4, !dbg !19
%15 = sext i32 %14 to i64, !dbg !19
%16 = load i32** %1, align 8, !dbg !19
%17 = getelementptr inbounds i32* %16, i64 %15, !dbg !19
%18 = load i32* %17, align 4, !dbg !19
%19 = add nsw i32 %18, 1, !dbg !19
store i32 %19, i32* %17, align 4, !dbg !19
br label %60

; <label>:60
call void @__syncthreads(), 0
%label60 = load i1 %label0
br i1 %label60, label %20, label %61
br label %20
br label %20

; <label>:20                                      ; preds = %13, %9
%21 = load i32* %tid, align 4, !dbg !22
%22 = sext i32 %21 to i64, !dbg !22
%23 = load i32** %1, align 8, !dbg !22
%24 = getelementptr inbounds i32* %23, i64 %22, !dbg !22
%25 = load i32* %24, align 4, !dbg !22
store i32 %25, i32* %sum, align 4, !dbg !22
%26 = load i32* %tid, align 4, !dbg !23
%27 = icmp sgt i32 %26, 0, !dbg !23
%label20 = load i1 %27
%label20not = icmp sle i32 %26, 0, !dbg !23
br label %61

; <label>:61
%label61 = load i1 %label20
%label61 = and i1 %label61, %label0
br i1 %label61, label %28, label %62
br label %28
br label %28

; <label>:28                                      ; preds = %20
%29 = load i32* %tid, align 4, !dbg !24
%30 = sub nsw i32 %29, 1, !dbg !24
%31 = sext i32 %30 to i64, !dbg !24
%32 = load i32** %1, align 8, !dbg !24
%33 = getelementptr inbounds i32* %32, i64 %31, !dbg !24
%34 = load i32* %33, align 4, !dbg !24
%35 = load i32* %sum, align 4, !dbg !24
%36 = add nsw i32 %35, %34, !dbg !24
store i32 %36, i32* %sum, align 4, !dbg !24
br label %62

; <label>:62
call void @__syncthreads(), 1
%label62 = load i1 %label0
br i1 %label62, label %37, label %63
br label %37
br label %37

; <label>:37                                      ; preds = %28, %20
%38 = load i32* %tid, align 4, !dbg !25
%39 = icmp slt i32 %38, 49, !dbg !25
%label37 = load i1 %39
%label37not = icmp sge i32 %38, 49, !dbg !25
br label %63

; <label>:63
%label63 = load i1 %label37
%label63 = and i1 %label63, %label0
br i1 %label63, label %40, label %64
br label %40
br label %40

; <label>:40                                      ; preds = %37
%41 = load i32* %tid, align 4, !dbg !26
%42 = add nsw i32 %41, 1, !dbg !26
%43 = sext i32 %42 to i64, !dbg !26
%44 = load i32** %1, align 8, !dbg !26
%45 = getelementptr inbounds i32* %44, i64 %43, !dbg !26
%46 = load i32* %45, align 4, !dbg !26
%47 = load i32* %sum, align 4, !dbg !26
%48 = add nsw i32 %47, %46, !dbg !26
store i32 %48, i32* %sum, align 4, !dbg !26
br label %64

; <label>:64
call void @__syncthreads()
%label64 = load i1 %label0
br i1 %label64, label %49, label %65
br label %49
br label %49

; <label>:49                                      ; preds = %40, %37
%50 = load i32* %sum, align 4, !dbg !27
%51 = sdiv i32 %50, 3, !dbg !27
%52 = load i32* %tid, align 4, !dbg !27
%53 = sext i32 %52 to i64, !dbg !27
%54 = load i32** %1, align 8, !dbg !27
%55 = getelementptr inbounds i32* %54, i64 %53, !dbg !27
store i32 %51, i32* %55, align 4, !dbg !27
br label %65

; <label>:65
call void @__syncthreads()
br label %56
br label %56
br label %56

; <label>:56                                      ; preds = %49, %0
ret void, !dbg !29

}