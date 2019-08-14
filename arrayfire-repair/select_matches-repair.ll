define void @_Z14select_matchesPKjPKijji(i32* %in_idx, i32* %in_dist, i32 %nfeat, i32 %nelem, i32 %max_dist) uwtable noinline {
%label25 = alloca i1, align 4
%label21not = alloca i1, align 4
%label18 = alloca i1, align 4
%label18not = alloca i1, align 4
%label21 = alloca i1, align 4
%label25not = alloca i1, align 4
%1 = alloca i32*, align 8
%2 = alloca i32*, align 8
%3 = alloca i32, align 4
%4 = alloca i32, align 4
%5 = alloca i32, align 4
%f = alloca i32, align 4
%sid = alloca i32, align 4
%i = alloca i32, align 4
%dist = alloca i32, align 4
store i32* %in_idx, i32** %1, align 8
store i32* %in_dist, i32** %2, align 8
store i32 %nfeat, i32* %3, align 4
store i32 %nelem, i32* %4, align 4
store i32 %max_dist, i32* %5, align 4
%6 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 0), align 4, !dbg !35
%7 = load i32* getelementptr inbounds (%struct.dim3* @blockDim, i32 0, i32 0), align 4, !dbg !35
%8 = mul i32 %6, %7, !dbg !35
%9 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !35
%10 = add i32 %8, %9, !dbg !35
store i32 %10, i32* %f, align 4, !dbg !35
%11 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !37
%12 = load i32* getelementptr inbounds (%struct.dim3* @blockDim, i32 0, i32 1), align 4, !dbg !37
%13 = mul i32 %11, %12, !dbg !37
%14 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 1), align 4, !dbg !37
%15 = add i32 %13, %14, !dbg !37
store i32 %15, i32* %sid, align 4, !dbg !37
%16 = load i32* getelementptr inbounds (%struct.dim3* @blockDim, i32 0, i32 1), align 4, !dbg !40
%17 = udiv i32 %16, 2, !dbg !40
store i32 %17, i32* %i, align 4, !dbg !40
br label %18, !dbg !40

; <label>:18                                      ; preds = %54, %0
%19 = load i32* %i, align 4, !dbg !40
%20 = icmp ugt i32 %19, 0, !dbg !40
%label18 = load i1 %20
%label18not = icmp ule i32 %19, 0, !dbg !40
br label %59

; <label>:59
%label59 = load i1 %label18
br i1 %label59, label %21, label %60

; <label>:21                                      ; preds = %18
%22 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 1), align 4, !dbg !41
%23 = load i32* %i, align 4, !dbg !41
%24 = icmp ult i32 %22, %23, !dbg !41
%label21 = load i1 %24
%label21not = icmp uge i32 %22, %23, !dbg !41
br label %60

; <label>:60
%label60 = load i1 %label21
%label60 = and i1 %label60, %label18
br i1 %label60, label %25, label %61

; <label>:25                                      ; preds = %21
%26 = load i32* %sid, align 4, !dbg !45
%27 = load i32* %i, align 4, !dbg !45
%28 = add i32 %26, %27, !dbg !45
%29 = zext i32 %28 to i64, !dbg !45
%30 = getelementptr inbounds [256 x i32]* @_ZZ14select_matchesPKjPKijjiE6s_dist, i32 0, i64 %29, !dbg !45
%31 = load i32* %30, align 4, !dbg !45
store i32 %31, i32* %dist, align 4, !dbg !45
%32 = load i32* %dist, align 4, !dbg !46
%33 = load i32* %sid, align 4, !dbg !46
%34 = zext i32 %33 to i64, !dbg !46
%35 = getelementptr inbounds [256 x i32]* @_ZZ14select_matchesPKjPKijjiE6s_dist, i32 0, i64 %34, !dbg !46
%36 = load i32* %35, align 4, !dbg !46
%37 = icmp slt i32 %32, %36, !dbg !46
%label25 = load i1 %37
%label25not = icmp sge i32 %32, %36, !dbg !46
br label %61

; <label>:61
call void @__syncthreads(), 0
%label61 = load i1 %label21
%label61 = and i1 %label61, %label18
%label61 = and i1 %label61, %label25
br i1 %label61, label %38, label %62

; <label>:38                                      ; preds = %25
%39 = load i32* %dist, align 4, !dbg !47
%40 = load i32* %sid, align 4, !dbg !47
%41 = zext i32 %40 to i64, !dbg !47
%42 = getelementptr inbounds [256 x i32]* @_ZZ14select_matchesPKjPKijjiE6s_dist, i32 0, i64 %41, !dbg !47
store i32 %39, i32* %42, align 4, !dbg !47
%43 = load i32* %sid, align 4, !dbg !49
%44 = load i32* %i, align 4, !dbg !49
%45 = add i32 %43, %44, !dbg !49
%46 = zext i32 %45 to i64, !dbg !49
%47 = getelementptr inbounds [256 x i32]* @_ZZ14select_matchesPKjPKijjiE5s_idx, i32 0, i64 %46, !dbg !49
%48 = load i32* %47, align 4, !dbg !49
%49 = load i32* %sid, align 4, !dbg !49
%50 = zext i32 %49 to i64, !dbg !49
%51 = getelementptr inbounds [256 x i32]* @_ZZ14select_matchesPKjPKijjiE5s_idx, i32 0, i64 %50, !dbg !49
store i32 %48, i32* %51, align 4, !dbg !49
br label %62

; <label>:62
call void @__syncthreads(), 1
%label62 = load i1 %label21
%label62 = and i1 %label62, %label18
br i1 %label62, label %52, label %63

; <label>:52                                      ; preds = %38, %25
br label %63

; <label>:63
%label63 = load i1 %label18
br i1 %label63, label %53, label %64

; <label>:53                                      ; preds = %52, %21
br label %64

; <label>:64
%label64 = load i1 %label18
br i1 %label64, label %54, label %65

; <label>:54                                      ; preds = %53
%55 = load i32* %i, align 4, !dbg !40
%56 = lshr i32 %55, 1, !dbg !40
store i32 %56, i32* %i, align 4, !dbg !40
br label %18, !dbg !40
br label %65

; <label>:65
br label %57

; <label>:57                                      ; preds = %18
ret void, !dbg !54


}