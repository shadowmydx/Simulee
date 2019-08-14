define void @_Z24scan_dim_nonfinal_kerneljjj(i32 %blocks_x, i32 %blocks_y, i32 %lim) uwtable noinline {
%label80 = alloca i1, align 4
%label58not = alloca i1, align 4
%label65not = alloca i1, align 4
%label55not = alloca i1, align 4
%label51 = alloca i1, align 4
%label65 = alloca i1, align 4
%label90not = alloca i1, align 4
%label55 = alloca i1, align 4
%label105 = alloca i1, align 4
%label105not = alloca i1, align 4
%label58 = alloca i1, align 4
%label51not = alloca i1, align 4
%label80not = alloca i1, align 4
%label90 = alloca i1, align 4
%1 = alloca i32, align 4
%2 = alloca i32, align 4
%3 = alloca i32, align 4
%tidx = alloca i32, align 4
%tidy = alloca i32, align 4
%tid = alloca i32, align 4
%zid = alloca i32, align 4
%wid = alloca i32, align 4
%blockIdx_x = alloca i32, align 4
%blockIdx_y = alloca i32, align 4
%xid = alloca i32, align 4
%yid = alloca i32, align 4
%sptr = alloca i32*, align 8
%sfptr = alloca i8*, align 8
%id_dim = alloca i32, align 4
%flag = alloca i8, align 1
%start = alloca i32, align 4
%val = alloca i32, align 4
%k = alloca i32, align 4
store i32 %blocks_x, i32* %1, align 4
store i32 %blocks_y, i32* %2, align 4
store i32 %lim, i32* %3, align 4
%4 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !37
store i32 %4, i32* %tidx, align 4, !dbg !37
%5 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 1), align 4, !dbg !39
store i32 %5, i32* %tidy, align 4, !dbg !39
%6 = load i32* %tidy, align 4, !dbg !41
%7 = mul nsw i32 %6, 32, !dbg !41
%8 = load i32* %tidx, align 4, !dbg !41
%9 = add nsw i32 %7, %8, !dbg !41
store i32 %9, i32* %tid, align 4, !dbg !41
%10 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 0), align 4, !dbg !43
%11 = load i32* %1, align 4, !dbg !43
%12 = udiv i32 %10, %11, !dbg !43
store i32 %12, i32* %zid, align 4, !dbg !43
%13 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 1), align 4, !dbg !45
%14 = load i32* %2, align 4, !dbg !45
%15 = udiv i32 %13, %14, !dbg !45
store i32 %15, i32* %wid, align 4, !dbg !45
%16 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 0), align 4, !dbg !47
%17 = load i32* %1, align 4, !dbg !47
%18 = load i32* %zid, align 4, !dbg !47
%19 = mul i32 %17, %18, !dbg !47
%20 = sub i32 %16, %19, !dbg !47
store i32 %20, i32* %blockIdx_x, align 4, !dbg !47
%21 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 1), align 4, !dbg !49
%22 = load i32* %2, align 4, !dbg !49
%23 = load i32* %wid, align 4, !dbg !49
%24 = mul i32 %22, %23, !dbg !49
%25 = sub i32 %21, %24, !dbg !49
store i32 %25, i32* %blockIdx_y, align 4, !dbg !49
%26 = load i32* %blockIdx_x, align 4, !dbg !51
%27 = load i32* getelementptr inbounds (%struct.dim3* @blockDim, i32 0, i32 0), align 4, !dbg !51
%28 = mul i32 %26, %27, !dbg !51
%29 = load i32* %tidx, align 4, !dbg !51
%30 = add i32 %28, %29, !dbg !51
store i32 %30, i32* %xid, align 4, !dbg !51
%31 = load i32* %blockIdx_y, align 4, !dbg !53
store i32 %31, i32* %yid, align 4, !dbg !53
%32 = load i32* %tid, align 4, !dbg !56
%33 = sext i32 %32 to i64, !dbg !56
%34 = getelementptr inbounds i32* getelementptr inbounds ([320 x i32]* @_ZZ24scan_dim_nonfinal_kerneljjjE5s_val, i32 0, i32 0), i64 %33, !dbg !56
store i32* %34, i32** %sptr, align 8, !dbg !56
%35 = load i32* %tid, align 4, !dbg !59
%36 = sext i32 %35 to i64, !dbg !59
%37 = getelementptr inbounds i8* getelementptr inbounds ([320 x i8]* @_ZZ24scan_dim_nonfinal_kerneljjjE5s_flg, i32 0, i32 0), i64 %36, !dbg !59
store i8* %37, i8** %sfptr, align 8, !dbg !59
store i32 256, i32* %id_dim, align 4, !dbg !61
%38 = load i32* %tidy, align 4, !dbg !62
%39 = icmp eq i32 %38, 4, !dbg !62
br i1 %39, label %40, label %50, !dbg !62

; <label>:40                                      ; preds = %0
%41 = load i32* %tidx, align 4, !dbg !63
%42 = sext i32 %41 to i64, !dbg !63
%43 = getelementptr inbounds [32 x i32]* @_ZZ24scan_dim_nonfinal_kerneljjjE5s_tmp, i32 0, i64 %42, !dbg !63
store i32 0, i32* %43, align 4, !dbg !63
%44 = load i32* %tidx, align 4, !dbg !65
%45 = sext i32 %44 to i64, !dbg !65
%46 = getelementptr inbounds [32 x i8]* @_ZZ24scan_dim_nonfinal_kerneljjjE6s_ftmp, i32 0, i64 %45, !dbg !65
store i8 0, i8* %46, align 1, !dbg !65
%47 = load i32* %tidx, align 4, !dbg !66
%48 = sext i32 %47 to i64, !dbg !66
%49 = getelementptr inbounds [32 x i32]* @_ZZ24scan_dim_nonfinal_kerneljjjE10boundaryid, i32 0, i64 %48, !dbg !66
store i32 -1, i32* %49, align 4, !dbg !66
br label %50, !dbg !67

; <label>:50                                      ; preds = %40, %0
call void @__syncthreads(), !dbg !68
store i8 0, i8* %flag, align 1, !dbg !70
store i32 3, i32* %3, align 4, !dbg !71
store i32 1, i32* %start, align 4, !dbg !73
store i32 0, i32* %val, align 4, !dbg !73
store i32 0, i32* %k, align 4, !dbg !77
br label %51, !dbg !77

; <label>:51                                      ; preds = %121, %50
%52 = load i32* %k, align 4, !dbg !77
%53 = load i32* %3, align 4, !dbg !77
%54 = icmp ult i32 %52, %53, !dbg !77
%label51 = load i1 %54
%label51not = icmp uge i32 %52, %53, !dbg !77
br label %126

; <label>:126
%label126 = load i1 %label51
br i1 %label126, label %55, label %127

; <label>:55                                      ; preds = %51
%56 = load i32* %tidy, align 4, !dbg !78
%57 = icmp eq i32 %56, 0, !dbg !78
%label55 = load i1 %57
%label55not = icmp ne i32 %56, 0, !dbg !78
br label %127

; <label>:127
%label127 = load i1 %label51
%label127 = and i1 %label127, %label55
br i1 %label127, label %58, label %128

; <label>:58                                      ; preds = %55
%59 = load i32* %tidx, align 4, !dbg !80
%60 = sext i32 %59 to i64, !dbg !80
%61 = getelementptr inbounds [32 x i8]* @_ZZ24scan_dim_nonfinal_kerneljjjE6s_ftmp, i32 0, i64 %60, !dbg !80
%62 = load i8* %61, align 1, !dbg !80
%63 = sext i8 %62 to i32, !dbg !80
%64 = icmp eq i32 %63, 0, !dbg !80
%label58 = load i1 %64
%label58not = icmp ne i32 %63, 0, !dbg !80
br label %128

; <label>:128
call void @__syncthreads(), 0
%label128 = load i1 %label58
%label128 = and i1 %label128, %label51
%label128 = and i1 %label128, %label55
br i1 %label128, label %65, label %129

; <label>:65                                      ; preds = %58
%66 = load i32* %start, align 4, !dbg !80
%67 = mul nsw i32 %66, 32, !dbg !80
%68 = sext i32 %67 to i64, !dbg !80
%69 = load i8** %sfptr, align 8, !dbg !80
%70 = getelementptr inbounds i8* %69, i64 %68, !dbg !80
%71 = load i8* %70, align 1, !dbg !80
%72 = sext i8 %71 to i32, !dbg !80
%73 = icmp eq i32 %72, 1, !dbg !80
%label65 = load i1 %73
%label65not = icmp ne i32 %72, 1, !dbg !80
br label %129

; <label>:129
%label129 = load i1 %label65
%label129 = and i1 %label129, %label51
%label129 = and i1 %label129, %label58
%label129 = and i1 %label129, %label55
br i1 %label129, label %74, label %130

; <label>:74                                      ; preds = %65
%75 = load i32* %id_dim, align 4, !dbg !82
%76 = load i32* %tidx, align 4, !dbg !82
%77 = sext i32 %76 to i64, !dbg !82
%78 = getelementptr inbounds [32 x i32]* @_ZZ24scan_dim_nonfinal_kerneljjjE10boundaryid, i32 0, i64 %77, !dbg !82
store i32 %75, i32* %78, align 4, !dbg !82
br label %130

; <label>:130
%label130 = load i1 %label51
%label130 = and i1 %label130, %label55
br i1 %label130, label %79, label %131

; <label>:79                                      ; preds = %74, %65, %58
br label %131

; <label>:131
%label131 = load i1 %label51
%label131 = and i1 %label131, %label55not
br i1 %label131, label %80, label %132

; <label>:80                                      ; preds = %55
%81 = load i32* %start, align 4, !dbg !86
%82 = sub nsw i32 %81, 1, !dbg !86
%83 = mul nsw i32 %82, 32, !dbg !86
%84 = sext i32 %83 to i64, !dbg !86
%85 = load i8** %sfptr, align 8, !dbg !86
%86 = getelementptr inbounds i8* %85, i64 %84, !dbg !86
%87 = load i8* %86, align 1, !dbg !86
%88 = sext i8 %87 to i32, !dbg !86
%89 = icmp eq i32 %88, 0, !dbg !86
%label80 = load i1 %89
%label80not = icmp ne i32 %88, 0, !dbg !86
br label %132

; <label>:132
%label132 = load i1 %label51
%label132 = and i1 %label132, %label80
%label132 = and i1 %label132, %label55not
br i1 %label132, label %90, label %133

; <label>:90                                      ; preds = %80
%91 = load i32* %start, align 4, !dbg !86
%92 = mul nsw i32 %91, 32, !dbg !86
%93 = sext i32 %92 to i64, !dbg !86
%94 = load i8** %sfptr, align 8, !dbg !86
%95 = getelementptr inbounds i8* %94, i64 %93, !dbg !86
%96 = load i8* %95, align 1, !dbg !86
%97 = sext i8 %96 to i32, !dbg !86
%98 = icmp eq i32 %97, 1, !dbg !86
%label90 = load i1 %98
%label90not = icmp ne i32 %97, 1, !dbg !86
br label %133

; <label>:133
%label133 = load i1 %label51
%label133 = and i1 %label133, %label80
%label133 = and i1 %label133, %label90
%label133 = and i1 %label133, %label55not
br i1 %label133, label %99, label %134

; <label>:99                                      ; preds = %90
%100 = load i32* %id_dim, align 4, !dbg !88
%101 = load i32* %tidx, align 4, !dbg !88
%102 = sext i32 %101 to i64, !dbg !88
%103 = getelementptr inbounds [32 x i32]* @_ZZ24scan_dim_nonfinal_kerneljjjE10boundaryid, i32 0, i64 %102, !dbg !88
store i32 %100, i32* %103, align 4, !dbg !88
br label %134

; <label>:134
%label134 = load i1 %label51
%label134 = and i1 %label134, %label55not
br i1 %label134, label %104, label %135

; <label>:104                                     ; preds = %99, %90, %80
br label %135

; <label>:135
%label135 = load i1 %label51
br i1 %label135, label %105, label %136

; <label>:105                                     ; preds = %104, %79
%106 = load i32* %tidy, align 4, !dbg !91
%107 = icmp eq i32 %106, 4, !dbg !91
%label105 = load i1 %107
%label105not = icmp ne i32 %106, 4, !dbg !91
br label %136

; <label>:136
%label136 = load i1 %label105
%label136 = and i1 %label136, %label51
br i1 %label136, label %108, label %137

; <label>:108                                     ; preds = %105
%109 = load i32* %val, align 4, !dbg !92
%110 = load i32* %tidx, align 4, !dbg !92
%111 = sext i32 %110 to i64, !dbg !92
%112 = getelementptr inbounds [32 x i32]* @_ZZ24scan_dim_nonfinal_kerneljjjE5s_tmp, i32 0, i64 %111, !dbg !92
store i32 %109, i32* %112, align 4, !dbg !92
%113 = load i8* %flag, align 1, !dbg !94
%114 = load i32* %tidx, align 4, !dbg !94
%115 = sext i32 %114 to i64, !dbg !94
%116 = getelementptr inbounds [32 x i8]* @_ZZ24scan_dim_nonfinal_kerneljjjE6s_ftmp, i32 0, i64 %115, !dbg !94
store i8 %113, i8* %116, align 1, !dbg !94
br label %137

; <label>:137
call void @__syncthreads(), 1
%label137 = load i1 %label51
br i1 %label137, label %117, label %138

; <label>:117                                     ; preds = %108, %105
%118 = load i32* getelementptr inbounds (%struct.dim3* @blockDim, i32 0, i32 1), align 4, !dbg !96
%119 = load i32* %id_dim, align 4, !dbg !96
%120 = add i32 %119, %118, !dbg !96
store i32 %120, i32* %id_dim, align 4, !dbg !96
call void @__syncthreads(), !dbg !97
br label %138

; <label>:138
%label138 = load i1 %label51
br i1 %label138, label %121, label %139

; <label>:121                                     ; preds = %117
%122 = load i32* %k, align 4, !dbg !77
%123 = add nsw i32 %122, 1, !dbg !77
store i32 %123, i32* %k, align 4, !dbg !77
br label %51, !dbg !77
br label %139

; <label>:139
br label %124

; <label>:124                                     ; preds = %51
ret void, !dbg !99


}