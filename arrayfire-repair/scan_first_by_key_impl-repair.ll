define void @_Z20scan_nonfinal_kerneljjj(i32 %blocks_x, i32 %blocks_y, i32 %lim) uwtable noinline {
%label106 = alloca i1, align 4
%label120not = alloca i1, align 4
%label83not = alloca i1, align 4
%label76 = alloca i1, align 4
%label63not = alloca i1, align 4
%label76not = alloca i1, align 4
%label59not = alloca i1, align 4
%label106not = alloca i1, align 4
%label120 = alloca i1, align 4
%label63 = alloca i1, align 4
%label59 = alloca i1, align 4
%label83 = alloca i1, align 4
%label97 = alloca i1, align 4
%label97not = alloca i1, align 4
%1 = alloca i32, align 4
%2 = alloca i32, align 4
%3 = alloca i32, align 4
%DIMY = alloca i32, align 4
%SHARED_MEM_SIZE = alloca i32, align 4
%tidx = alloca i32, align 4
%tidy = alloca i32, align 4
%zid = alloca i32, align 4
%wid = alloca i32, align 4
%blockIdx_x = alloca i32, align 4
%blockIdx_y = alloca i32, align 4
%xid = alloca i32, align 4
%yid = alloca i32, align 4
%sptr = alloca i32*, align 8
%sfptr = alloca i8*, align 8
%id = alloca i32, align 4
%isLast = alloca i8, align 1
%flag = alloca i8, align 1
%val = alloca i32, align 4
%k = alloca i32, align 4
%start = alloca i32, align 4
store i32 %blocks_x, i32* %1, align 4
store i32 %blocks_y, i32* %2, align 4
store i32 %lim, i32* %3, align 4
store i32 5, i32* %DIMY, align 4, !dbg !38
store i32 55, i32* %SHARED_MEM_SIZE, align 4, !dbg !40
%4 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !42
store i32 %4, i32* %tidx, align 4, !dbg !42
%5 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 1), align 4, !dbg !44
store i32 %5, i32* %tidy, align 4, !dbg !44
%6 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 0), align 4, !dbg !46
%7 = load i32* %1, align 4, !dbg !46
%8 = udiv i32 %6, %7, !dbg !46
store i32 %8, i32* %zid, align 4, !dbg !46
%9 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 1), align 4, !dbg !48
%10 = load i32* %2, align 4, !dbg !48
%11 = udiv i32 %9, %10, !dbg !48
store i32 %11, i32* %wid, align 4, !dbg !48
%12 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 0), align 4, !dbg !50
%13 = load i32* %1, align 4, !dbg !50
%14 = load i32* %zid, align 4, !dbg !50
%15 = mul i32 %13, %14, !dbg !50
%16 = sub i32 %12, %15, !dbg !50
store i32 %16, i32* %blockIdx_x, align 4, !dbg !50
%17 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 1), align 4, !dbg !52
%18 = load i32* %2, align 4, !dbg !52
%19 = load i32* %wid, align 4, !dbg !52
%20 = mul i32 %18, %19, !dbg !52
%21 = sub i32 %17, %20, !dbg !52
store i32 %21, i32* %blockIdx_y, align 4, !dbg !52
%22 = load i32* %blockIdx_x, align 4, !dbg !54
%23 = load i32* getelementptr inbounds (%struct.dim3* @blockDim, i32 0, i32 0), align 4, !dbg !54
%24 = mul i32 %22, %23, !dbg !54
%25 = load i32* %3, align 4, !dbg !54
%26 = mul i32 %24, %25, !dbg !54
%27 = load i32* %tidx, align 4, !dbg !54
%28 = add i32 %26, %27, !dbg !54
store i32 %28, i32* %xid, align 4, !dbg !54
%29 = load i32* %blockIdx_y, align 4, !dbg !56
%30 = load i32* getelementptr inbounds (%struct.dim3* @blockDim, i32 0, i32 1), align 4, !dbg !56
%31 = mul i32 %29, %30, !dbg !56
%32 = load i32* %tidy, align 4, !dbg !56
%33 = add i32 %31, %32, !dbg !56
store i32 %33, i32* %yid, align 4, !dbg !56
%34 = load i32* %tidy, align 4, !dbg !59
%35 = mul nsw i32 %34, 11, !dbg !59
%36 = sext i32 %35 to i64, !dbg !59
%37 = getelementptr inbounds i32* getelementptr inbounds ([55 x i32]* @_ZZ20scan_nonfinal_kerneljjjE5s_val, i32 0, i32 0), i64 %36, !dbg !59
store i32* %37, i32** %sptr, align 8, !dbg !59
%38 = load i32* %tidy, align 4, !dbg !62
%39 = mul nsw i32 %38, 11, !dbg !62
%40 = sext i32 %39 to i64, !dbg !62
%41 = getelementptr inbounds i8* getelementptr inbounds ([55 x i8]* @_ZZ20scan_nonfinal_kerneljjjE5s_flg, i32 0, i32 0), i64 %40, !dbg !62
store i8* %41, i8** %sfptr, align 8, !dbg !62
%42 = load i32* %xid, align 4, !dbg !64
store i32 %42, i32* %id, align 4, !dbg !64
%43 = load i32* %tidx, align 4, !dbg !68
%44 = icmp eq i32 %43, 4, !dbg !68
%45 = zext i1 %44 to i8, !dbg !68
store i8 %45, i8* %isLast, align 1, !dbg !68
%46 = load i32* %tidx, align 4, !dbg !69
%47 = icmp eq i32 %46, 4, !dbg !69
br i1 %47, label %48, label %58, !dbg !69

; <label>:48                                      ; preds = %0
%49 = load i32* %tidy, align 4, !dbg !70
%50 = sext i32 %49 to i64, !dbg !70
%51 = getelementptr inbounds [5 x i32]* @_ZZ20scan_nonfinal_kerneljjjE5s_tmp, i32 0, i64 %50, !dbg !70
store i32 0, i32* %51, align 4, !dbg !70
%52 = load i32* %tidy, align 4, !dbg !72
%53 = sext i32 %52 to i64, !dbg !72
%54 = getelementptr inbounds [5 x i8]* @_ZZ20scan_nonfinal_kerneljjjE6s_ftmp, i32 0, i64 %53, !dbg !72
store i8 0, i8* %54, align 1, !dbg !72
%55 = load i32* %tidy, align 4, !dbg !73
%56 = sext i32 %55 to i64, !dbg !73
%57 = getelementptr inbounds [5 x i32]* @_ZZ20scan_nonfinal_kerneljjjE10boundaryid, i32 0, i64 %56, !dbg !73
store i32 -1, i32* %57, align 4, !dbg !73
br label %58, !dbg !74

; <label>:58                                      ; preds = %48, %0
call void @__syncthreads(), !dbg !75
store i8 0, i8* %flag, align 1, !dbg !77
store i32 0, i32* %val, align 4, !dbg !79
store i32 6, i32* %3, align 4, !dbg !80
store i32 0, i32* %k, align 4, !dbg !83
br label %59, !dbg !83

; <label>:59                                      ; preds = %136, %58
%60 = load i32* %k, align 4, !dbg !83
%61 = load i32* %3, align 4, !dbg !83
%62 = icmp ult i32 %60, %61, !dbg !83
%label59 = load i1 %62
%label59not = icmp uge i32 %60, %61, !dbg !83
br label %141

; <label>:141
%label141 = load i1 %label59
br i1 %label141, label %63, label %142

; <label>:63                                      ; preds = %59
%64 = load i32* %val, align 4, !dbg !84
%65 = load i32* %tidx, align 4, !dbg !84
%66 = sext i32 %65 to i64, !dbg !84
%67 = load i32** %sptr, align 8, !dbg !84
%68 = getelementptr inbounds i32* %67, i64 %66, !dbg !84
store i32 %64, i32* %68, align 4, !dbg !84
%69 = load i8* %flag, align 1, !dbg !86
%70 = load i32* %tidx, align 4, !dbg !86
%71 = sext i32 %70 to i64, !dbg !86
%72 = load i8** %sfptr, align 8, !dbg !86
%73 = getelementptr inbounds i8* %72, i64 %71, !dbg !86
store i8 %69, i8* %73, align 1, !dbg !86
call void @__syncthreads(), !dbg !87
store i32 0, i32* %start, align 4, !dbg !89
%74 = load i32* %tidx, align 4, !dbg !90
%75 = icmp eq i32 %74, 0, !dbg !90
%label63 = load i1 %75
%label63not = icmp ne i32 %74, 0, !dbg !90
br label %142

; <label>:142
%label142 = load i1 %label59
%label142 = and i1 %label142, %label63not
br i1 %label142, label %97, label %143

; <label>:97                                      ; preds = %63
%98 = load i32* %tidx, align 4, !dbg !97
%99 = sub nsw i32 %98, 1, !dbg !97
%100 = sext i32 %99 to i64, !dbg !97
%101 = load i8** %sfptr, align 8, !dbg !97
%102 = getelementptr inbounds i8* %101, i64 %100, !dbg !97
%103 = load i8* %102, align 1, !dbg !97
%104 = sext i8 %103 to i32, !dbg !97
%105 = icmp eq i32 %104, 0, !dbg !97
%label97 = load i1 %105
%label97not = icmp ne i32 %104, 0, !dbg !97
br label %143

; <label>:143
%label143 = load i1 %label97
%label143 = and i1 %label143, %label59
%label143 = and i1 %label143, %label63not
br i1 %label143, label %106, label %144

; <label>:106                                     ; preds = %97
%107 = load i32* %tidx, align 4, !dbg !97
%108 = sext i32 %107 to i64, !dbg !97
%109 = load i8** %sfptr, align 8, !dbg !97
%110 = getelementptr inbounds i8* %109, i64 %108, !dbg !97
%111 = load i8* %110, align 1, !dbg !97
%112 = sext i8 %111 to i32, !dbg !97
%113 = icmp eq i32 %112, 1, !dbg !97
%label106 = load i1 %113
%label106not = icmp ne i32 %112, 1, !dbg !97
br label %144

; <label>:144
%label144 = load i1 %label97
%label144 = and i1 %label144, %label59
%label144 = and i1 %label144, %label106
%label144 = and i1 %label144, %label63not
br i1 %label144, label %114, label %145

; <label>:114                                     ; preds = %106
%115 = load i32* %id, align 4, !dbg !99
%116 = load i32* %tidy, align 4, !dbg !99
%117 = sext i32 %116 to i64, !dbg !99
%118 = getelementptr inbounds [5 x i32]* @_ZZ20scan_nonfinal_kerneljjjE10boundaryid, i32 0, i64 %117, !dbg !99
store i32 %115, i32* %118, align 4, !dbg !99
br label %145

; <label>:145
%label145 = load i1 %label59
%label145 = and i1 %label145, %label63not
br i1 %label145, label %119, label %146

; <label>:119                                     ; preds = %114, %106, %97
br label %146

; <label>:146
%label146 = load i1 %label59
%label146 = and i1 %label146, %label63
br i1 %label146, label %76, label %147

; <label>:76                                      ; preds = %63
%77 = load i32* %tidy, align 4, !dbg !91
%78 = sext i32 %77 to i64, !dbg !91
%79 = getelementptr inbounds [5 x i8]* @_ZZ20scan_nonfinal_kerneljjjE6s_ftmp, i32 0, i64 %78, !dbg !91
%80 = load i8* %79, align 1, !dbg !91
%81 = sext i8 %80 to i32, !dbg !91
%82 = icmp eq i32 %81, 0, !dbg !91
%label76 = load i1 %82
%label76not = icmp ne i32 %81, 0, !dbg !91
br label %147

; <label>:147
call void @__syncthreads(), 0
%label147 = load i1 %label59
%label147 = and i1 %label147, %label63
%label147 = and i1 %label147, %label76
br i1 %label147, label %83, label %148

; <label>:83                                      ; preds = %76
%84 = load i32* %tidx, align 4, !dbg !91
%85 = sext i32 %84 to i64, !dbg !91
%86 = load i8** %sfptr, align 8, !dbg !91
%87 = getelementptr inbounds i8* %86, i64 %85, !dbg !91
%88 = load i8* %87, align 1, !dbg !91
%89 = sext i8 %88 to i32, !dbg !91
%90 = icmp eq i32 %89, 1, !dbg !91
%label83 = load i1 %90
%label83not = icmp ne i32 %89, 1, !dbg !91
br label %148

; <label>:148
%label148 = load i1 %label59
%label148 = and i1 %label148, %label63
%label148 = and i1 %label148, %label76
%label148 = and i1 %label148, %label83
br i1 %label148, label %91, label %149

; <label>:91                                      ; preds = %83
%92 = load i32* %id, align 4, !dbg !93
%93 = load i32* %tidy, align 4, !dbg !93
%94 = sext i32 %93 to i64, !dbg !93
%95 = getelementptr inbounds [5 x i32]* @_ZZ20scan_nonfinal_kerneljjjE10boundaryid, i32 0, i64 %94, !dbg !93
store i32 %92, i32* %95, align 4, !dbg !93
br label %149

; <label>:149
%label149 = load i1 %label59
%label149 = and i1 %label149, %label63
br i1 %label149, label %96, label %150

; <label>:96                                      ; preds = %91, %83, %76
br label %150

; <label>:150
%label150 = load i1 %label59
br i1 %label150, label %120, label %151

; <label>:120                                     ; preds = %119, %96
%121 = load i32* %tidx, align 4, !dbg !102
%122 = icmp eq i32 %121, 4, !dbg !102
%label120 = load i1 %122
%label120not = icmp ne i32 %121, 4, !dbg !102
br label %151

; <label>:151
%label151 = load i1 %label59
%label151 = and i1 %label151, %label120
br i1 %label151, label %123, label %152

; <label>:123                                     ; preds = %120
%124 = load i32* %val, align 4, !dbg !103
%125 = load i32* %tidy, align 4, !dbg !103
%126 = sext i32 %125 to i64, !dbg !103
%127 = getelementptr inbounds [5 x i32]* @_ZZ20scan_nonfinal_kerneljjjE5s_tmp, i32 0, i64 %126, !dbg !103
store i32 %124, i32* %127, align 4, !dbg !103
%128 = load i8* %flag, align 1, !dbg !105
%129 = load i32* %tidy, align 4, !dbg !105
%130 = sext i32 %129 to i64, !dbg !105
%131 = getelementptr inbounds [5 x i8]* @_ZZ20scan_nonfinal_kerneljjjE6s_ftmp, i32 0, i64 %130, !dbg !105
store i8 %128, i8* %131, align 1, !dbg !105
br label %152

; <label>:152
call void @__syncthreads(), 1
%label152 = load i1 %label59
br i1 %label152, label %132, label %153

; <label>:132                                     ; preds = %123, %120
%133 = load i32* getelementptr inbounds (%struct.dim3* @blockDim, i32 0, i32 0), align 4, !dbg !107
%134 = load i32* %id, align 4, !dbg !107
%135 = add i32 %134, %133, !dbg !107
store i32 %135, i32* %id, align 4, !dbg !107
call void @__syncthreads(), !dbg !108
br label %153

; <label>:153
%label153 = load i1 %label59
br i1 %label153, label %136, label %154

; <label>:136                                     ; preds = %132
%137 = load i32* %k, align 4, !dbg !83
%138 = add nsw i32 %137, 1, !dbg !83
store i32 %138, i32* %k, align 4, !dbg !83
br label %59, !dbg !83
br label %154

; <label>:154
br label %139

; <label>:139                                     ; preds = %59
ret void, !dbg !110


}