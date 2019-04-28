define void @_Z11warp_reducePd(double* %s_ptr) nounwind uwtable noinline {
    %1 = alloca double*, align 8
    %tidx = alloca i32, align 4
    %s_ptr_vol = alloca double*, align 8
    %tmp = alloca double, align 8
    %n = alloca i32, align 4
    %val1 = alloca double, align 8
    %val2 = alloca double, align 8
    store double* %s_ptr, double** %1, align 8
    %2 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !16
    store i32 %2, i32* %tidx, align 4, !dbg !16
    %3 = load double** %1, align 8, !dbg !18
    %4 = load i32* %tidx, align 4, !dbg !18
    %5 = sext i32 %4 to i64, !dbg !18
    %6 = getelementptr inbounds double* %3, i64 %5, !dbg !18
    store double* %6, double** %s_ptr_vol, align 8, !dbg !18
    %7 = load double** %1, align 8, !dbg !20
    %8 = load double* %7, align 8, !dbg !20
    store double %8, double* %tmp, align 8, !dbg !20
    store i32 16, i32* %n, align 4, !dbg !23
    br label %9, !dbg !23


    ; <label>:9                                       ; preds = %32, %0
    %10 = load i32* %n, align 4, !dbg !23
    %11 = icmp sge i32 %10, 1, !dbg !23
    %label9 = load i1 %11
    %label9not = icmp slt i32 %10, 1, !dbg !23
    br label %38


    ; <label>:38
    %label38 = load i1 %label9
    br i1 %label38, label %12, label %39


    ; <label>:12                                      ; preds = %9
    %13 = load i32* %tidx, align 4, !dbg !24
    %14 = load i32* %n, align 4, !dbg !24
    %15 = icmp slt i32 %13, %14, !dbg !24
    %label12 = load i1 %15
    %label12not = icmp sge i32 %13, %14, !dbg !24
    br label %39


    ; <label>:39
    %label39 = load i1 %label12
    %label39 = and i1 %label39, %label9
    br i1 %label39, label %16, label %40


    ; <label>:16                                      ; preds = %12
    %17 = load double** %s_ptr_vol, align 8, !dbg !30
    %18 = getelementptr inbounds double* %17, i64 0, !dbg !30
    %19 = load double* %18, align 8, !dbg !30
    store double %19, double* %val1, align 8, !dbg !30
    %20 = load i32* %n, align 4, !dbg !31
    %21 = sext i32 %20 to i64, !dbg !31
    %22 = load double** %s_ptr_vol, align 8, !dbg !31
    %23 = getelementptr inbounds double* %22, i64 %21, !dbg !31
    %24 = load double* %23, align 8, !dbg !31
    store double %24, double* %val2, align 8, !dbg !31
    %25 = load double* %val1, align 8, !dbg !32
    %26 = load double* %val2, align 8, !dbg !32
    %27 = fadd double %25, %26, !dbg !32
    store double %27, double* %tmp, align 8, !dbg !32
    %28 = load double* %tmp, align 8, !dbg !33
    %29 = load double** %s_ptr_vol, align 8, !dbg !33
    %30 = getelementptr inbounds double* %29, i64 0, !dbg !33
    br label %40


    ; <label>:40
    call void @__syncthreads(), 0
    %label40 = load i1 %label12
    %label40 = and i1 %label40, %label9
    br i1 %label40, label %36, label %41


    ; <label>:36
    store double %28, double* %30, align 8, !dbg !33
    br label %41


    ; <label>:41
    call void @__syncthreads(), 1
    %label41 = load i1 %label9
    br i1 %label41, label %31, label %42


    ; <label>:31                                      ; preds = %16, %12
    br label %42


    ; <label>:42
    %label42 = load i1 %label9
    br i1 %label42, label %32, label %43


    ; <label>:32                                      ; preds = %31
    %33 = load i32* %n, align 4, !dbg !23
    %34 = ashr i32 %33, 1, !dbg !23
    store i32 %34, i32* %n, align 4, !dbg !23
    br label %9, !dbg !23
    br label %43


    ; <label>:43
    br label %35


    ; <label>:35                                      ; preds = %9
    ret void, !dbg !36
}