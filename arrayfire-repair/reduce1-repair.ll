define void @_Z11warp_reducePiPj(i32* %s_ptr, i32* %s_idx) nounwind uwtable section "__device__" {%label7 = alloca i1, align 4
%label4 = alloca i1, align 4
%label7not = alloca i1, align 4
%label4not = alloca i1, align 4
%1 = alloca i32*, align 8
%2 = alloca i32*, align 8
%tidx = alloca i32, align 4
%n = alloca i32, align 4
%val1 = alloca i32, align 4
%val2 = alloca i32, align 4
%idx1 = alloca i32, align 4
%idx2 = alloca i32, align 4
store i32* %s_ptr, i32** %1, align 8
store i32* %s_idx, i32** %2, align 8
%3 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !19
store i32 %3, i32* %tidx, align 4, !dbg !19
store i32 16, i32* %n, align 4, !dbg !22
br label %4, !dbg !22

; <label>:4                                       ; preds = %47, %0
%5 = load i32* %n, align 4, !dbg !22
%6 = icmp sge i32 %5, 1, !dbg !22
%label4 = load i1 %6
%label4not = icmp slt i32 %5, 1, !dbg !22
br label %53

; <label>:53
%label53 = load i1 %label4
br i1 %label53, label %7, label %54

; <label>:7                                       ; preds = %4
%8 = load i32* %tidx, align 4, !dbg !23
%9 = load i32* %n, align 4, !dbg !23
%10 = icmp slt i32 %8, %9, !dbg !23
%label7 = load i1 %10
%label7not = icmp sge i32 %8, %9, !dbg !23
br label %54

; <label>:54
%label54 = load i1 %label7
%label54 = and i1 %label54, %label4
br i1 %label54, label %11, label %55

; <label>:11                                      ; preds = %7
%12 = load i32* %tidx, align 4, !dbg !29
%13 = sext i32 %12 to i64, !dbg !29
%14 = load i32** %1, align 8, !dbg !29
%15 = getelementptr inbounds i32* %14, i64 %13, !dbg !29
%16 = load i32* %15, align 4, !dbg !29
store i32 %16, i32* %val1, align 4, !dbg !29
%17 = load i32* %tidx, align 4, !dbg !30
%18 = load i32* %n, align 4, !dbg !30
%19 = add nsw i32 %17, %18, !dbg !30
%20 = sext i32 %19 to i64, !dbg !30
%21 = load i32** %1, align 8, !dbg !30
%22 = getelementptr inbounds i32* %21, i64 %20, !dbg !30
%23 = load i32* %22, align 4, !dbg !30
store i32 %23, i32* %val2, align 4, !dbg !30
%24 = load i32* %tidx, align 4, !dbg !34
%25 = sext i32 %24 to i64, !dbg !34
%26 = load i32** %2, align 8, !dbg !34
%27 = getelementptr inbounds i32* %26, i64 %25, !dbg !34
%28 = load i32* %27, align 4, !dbg !34
store i32 %28, i32* %idx1, align 4, !dbg !34
%29 = load i32* %tidx, align 4, !dbg !35
%30 = load i32* %n, align 4, !dbg !35
%31 = add nsw i32 %29, %30, !dbg !35
%32 = sext i32 %31 to i64, !dbg !35
%33 = load i32** %2, align 8, !dbg !35
%34 = getelementptr inbounds i32* %33, i64 %32, !dbg !35
%35 = load i32* %34, align 4, !dbg !35
store i32 %35, i32* %idx2, align 4, !dbg !35
%36 = load i32* %idx2, align 4, !dbg !36
%37 = load i32* %tidx, align 4, !dbg !36
%38 = sext i32 %37 to i64, !dbg !36
%39 = load i32** %1, align 8, !dbg !36
%40 = getelementptr inbounds i32* %39, i64 %38, !dbg !36
br label %55

; <label>:55
call void @__syncthreads(), 0
%label55 = load i1 %label7
%label55 = and i1 %label55, %label4
br i1 %label55, label %51, label %56

; <label>:51
store i32 %36, i32* %40, align 4, !dbg !36
%41 = load i32* %val2, align 4, !dbg !37
%42 = load i32* %tidx, align 4, !dbg !37
%43 = sext i32 %42 to i64, !dbg !37
%44 = load i32** %2, align 8, !dbg !37
%45 = getelementptr inbounds i32* %44, i64 %43, !dbg !37
store i32 %41, i32* %45, align 4, !dbg !37
br label %56

; <label>:56
call void @__syncthreads(), 1
%label56 = load i1 %label4
br i1 %label56, label %46, label %57

; <label>:46                                      ; preds = %11, %7
br label %57

; <label>:57
%label57 = load i1 %label4
br i1 %label57, label %47, label %58

; <label>:47                                      ; preds = %46
%48 = load i32* %n, align 4, !dbg !22
%49 = ashr i32 %48, 1, !dbg !22
store i32 %49, i32* %n, align 4, !dbg !22
br label %4, !dbg !22
br label %58

; <label>:58
br label %50

; <label>:50                                      ; preds = %4
ret void, !dbg !40

}
