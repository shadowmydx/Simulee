define void @_Z22hamming_matcher_unrollPjS_j(i32* %out_idx, i32* %out_dist, i32 %max_dist) uwtable noinline {
%label111not = alloca i1, align 4
%label79not = alloca i1, align 4
%label114not = alloca i1, align 4
%label143 = alloca i1, align 4
%label21not = alloca i1, align 4
%label50not = alloca i1, align 4
%label47 = alloca i1, align 4
%label143not = alloca i1, align 4
%label82not = alloca i1, align 4
%label50 = alloca i1, align 4
%label33not = alloca i1, align 4
%label82 = alloca i1, align 4
%label47not = alloca i1, align 4
%label79 = alloca i1, align 4
%label33 = alloca i1, align 4
%label21 = alloca i1, align 4
%label25not = alloca i1, align 4
%label114 = alloca i1, align 4
%label25 = alloca i1, align 4
%label111 = alloca i1, align 4
%1 = alloca i32*, align 8
%2 = alloca i32*, align 8
%3 = alloca i32, align 4
%f = alloca i32, align 4
%tid = alloca i32, align 4
%feat_len = alloca i32, align 4
%nquery = alloca i32, align 4
%ntrain = alloca i32, align 4
%valid_feat = alloca i8, align 1
%j = alloca i32, align 4
store i32* %out_idx, i32** %1, align 8
store i32* %out_dist, i32** %2, align 8
store i32 %max_dist, i32* %3, align 4
%4 = load i32* getelementptr inbounds (%struct.dim3* @blockDim, i32 0, i32 0), align 4, !dbg !27
%5 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 0), align 4, !dbg !27
%6 = mul i32 %4, %5, !dbg !27
%7 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !27
%8 = add i32 %6, %7, !dbg !27
store i32 %8, i32* %f, align 4, !dbg !27
%9 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !29
store i32 %9, i32* %tid, align 4, !dbg !29
store i32 6, i32* %feat_len, align 4, !dbg !31
store i32 6, i32* %nquery, align 4, !dbg !31
%10 = load i32* %3, align 4, !dbg !33
%11 = load i32* %tid, align 4, !dbg !33
%12 = zext i32 %11 to i64, !dbg !33
%13 = getelementptr inbounds [256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jE6s_dist, i32 0, i64 %12, !dbg !33
store i32 %10, i32* %13, align 4, !dbg !33
%14 = load i32* %tid, align 4, !dbg !34
%15 = zext i32 %14 to i64, !dbg !34
%16 = getelementptr inbounds [256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jE5s_idx, i32 0, i64 %15, !dbg !34
store i32 -1, i32* %16, align 4, !dbg !34
store i32 64, i32* %ntrain, align 4, !dbg !36
%17 = load i32* %f, align 4, !dbg !39
%18 = load i32* %ntrain, align 4, !dbg !39
%19 = icmp ult i32 %17, %18, !dbg !39
%20 = zext i1 %19 to i8, !dbg !39
store i8 %20, i8* %valid_feat, align 1, !dbg !39
store i32 0, i32* %j, align 4, !dbg !42
br label %21, !dbg !42

; <label>:21                                      ; preds = %167, %0
%22 = load i32* %j, align 4, !dbg !42
%23 = load i32* %nquery, align 4, !dbg !42
%24 = icmp ult i32 %22, %23, !dbg !42
%label21 = load i1 %24
%label21not = icmp uge i32 %22, %23, !dbg !42
br label %172

; <label>:172
%label172 = load i1 %label21
br i1 %label172, label %25, label %173

; <label>:25                                      ; preds = %21
%26 = load i32* %3, align 4, !dbg !43
%27 = load i32* %tid, align 4, !dbg !43
%28 = zext i32 %27 to i64, !dbg !43
%29 = getelementptr inbounds [256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jE6s_dist, i32 0, i64 %28, !dbg !43
store i32 %26, i32* %29, align 4, !dbg !43
%30 = load i32* %tid, align 4, !dbg !45
%31 = load i32* %feat_len, align 4, !dbg !45
%32 = icmp ult i32 %30, %31, !dbg !45
%label25 = load i1 %32
%label25not = icmp uge i32 %30, %31, !dbg !45
br label %173

; <label>:173
call void @__syncthreads(), 0
%label173 = load i1 %label21
%label173 = and i1 %label173, %label25
br i1 %label173, label %33, label %174

; <label>:33                                      ; preds = %25
%34 = load i32* %f, align 4, !dbg !45
%35 = load i32* %ntrain, align 4, !dbg !45
%36 = icmp ult i32 %34, %35, !dbg !45
%label33 = load i1 %36
%label33not = icmp uge i32 %34, %35, !dbg !45
br label %174

; <label>:174
%label174 = load i1 %label21
%label174 = and i1 %label174, %label25
%label174 = and i1 %label174, %label33
br i1 %label174, label %37, label %175

; <label>:37                                      ; preds = %33
%38 = load i32* %tid, align 4, !dbg !46
%39 = load i32* %nquery, align 4, !dbg !46
%40 = mul i32 %38, %39, !dbg !46
%41 = load i32* %j, align 4, !dbg !46
%42 = add i32 %40, %41, !dbg !46
%43 = load i32* %tid, align 4, !dbg !46
%44 = zext i32 %43 to i64, !dbg !46
%45 = load i32** %1, align 8, !dbg !46
%46 = getelementptr inbounds i32* %45, i64 %44, !dbg !46
store i32 %42, i32* %46, align 4, !dbg !46
br label %175

; <label>:175
%label175 = load i1 %label21
br i1 %label175, label %47, label %176

; <label>:47                                      ; preds = %37, %33, %25
call void @__syncthreads(), !dbg !49
%48 = load i32* %tid, align 4, !dbg !50
%49 = icmp ult i32 %48, 32, !dbg !50
%label47 = load i1 %49
%label47not = icmp uge i32 %48, 32, !dbg !50
br label %176

; <label>:176
%label176 = load i1 %label21
%label176 = and i1 %label176, %label47
br i1 %label176, label %50, label %177

; <label>:50                                      ; preds = %47
%51 = load i32* %tid, align 4, !dbg !51
%52 = add i32 %51, 128, !dbg !51
%53 = zext i32 %52 to i64, !dbg !51
%54 = getelementptr inbounds [256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jE6s_dist, i32 0, i64 %53, !dbg !51
%55 = load i32* %54, align 4, !dbg !51
%56 = load i32* %tid, align 4, !dbg !51
%57 = zext i32 %56 to i64, !dbg !51
%58 = getelementptr inbounds [256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jE6s_dist, i32 0, i64 %57, !dbg !51
%59 = load i32* %58, align 4, !dbg !51
%60 = icmp ult i32 %55, %59, !dbg !51
%label50 = load i1 %60
%label50not = icmp uge i32 %55, %59, !dbg !51
br label %177

; <label>:177
%label177 = load i1 %label50
%label177 = and i1 %label177, %label21
%label177 = and i1 %label177, %label47
br i1 %label177, label %61, label %178

; <label>:61                                      ; preds = %50
%62 = load i32* %tid, align 4, !dbg !53
%63 = add i32 %62, 128, !dbg !53
%64 = zext i32 %63 to i64, !dbg !53
%65 = getelementptr inbounds [256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jE6s_dist, i32 0, i64 %64, !dbg !53
%66 = load i32* %65, align 4, !dbg !53
%67 = load i32* %tid, align 4, !dbg !53
%68 = zext i32 %67 to i64, !dbg !53
%69 = getelementptr inbounds [256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jE6s_dist, i32 0, i64 %68, !dbg !53
store i32 %66, i32* %69, align 4, !dbg !53
%70 = load i32* %tid, align 4, !dbg !55
%71 = add i32 %70, 128, !dbg !55
%72 = zext i32 %71 to i64, !dbg !55
%73 = getelementptr inbounds [256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jE5s_idx, i32 0, i64 %72, !dbg !55
%74 = load i32* %73, align 4, !dbg !55
%75 = load i32* %tid, align 4, !dbg !55
%76 = zext i32 %75 to i64, !dbg !55
%77 = getelementptr inbounds [256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jE5s_idx, i32 0, i64 %76, !dbg !55
store i32 %74, i32* %77, align 4, !dbg !55
br label %178

; <label>:178
%label178 = load i1 %label21
%label178 = and i1 %label178, %label47
br i1 %label178, label %78, label %179

; <label>:78                                      ; preds = %61, %50
br label %179

; <label>:179
%label179 = load i1 %label21
br i1 %label179, label %79, label %180

; <label>:79                                      ; preds = %78, %47
call void @__syncthreads(), !dbg !58
%80 = load i32* %tid, align 4, !dbg !59
%81 = icmp ult i32 %80, 16, !dbg !59
%label79 = load i1 %81
%label79not = icmp uge i32 %80, 16, !dbg !59
br label %180

; <label>:180
%label180 = load i1 %label79
%label180 = and i1 %label180, %label21
br i1 %label180, label %82, label %181

; <label>:82                                      ; preds = %79
%83 = load i32* %tid, align 4, !dbg !60
%84 = add i32 %83, 64, !dbg !60
%85 = zext i32 %84 to i64, !dbg !60
%86 = getelementptr inbounds [256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jE6s_dist, i32 0, i64 %85, !dbg !60
%87 = load i32* %86, align 4, !dbg !60
%88 = load i32* %tid, align 4, !dbg !60
%89 = zext i32 %88 to i64, !dbg !60
%90 = getelementptr inbounds [256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jE6s_dist, i32 0, i64 %89, !dbg !60
%91 = load i32* %90, align 4, !dbg !60
%92 = icmp ult i32 %87, %91, !dbg !60
%label82 = load i1 %92
%label82not = icmp uge i32 %87, %91, !dbg !60
br label %181

; <label>:181
%label181 = load i1 %label79
%label181 = and i1 %label181, %label21
%label181 = and i1 %label181, %label82
br i1 %label181, label %93, label %182

; <label>:93                                      ; preds = %82
%94 = load i32* %tid, align 4, !dbg !62
%95 = add i32 %94, 64, !dbg !62
%96 = zext i32 %95 to i64, !dbg !62
%97 = getelementptr inbounds [256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jE6s_dist, i32 0, i64 %96, !dbg !62
%98 = load i32* %97, align 4, !dbg !62
%99 = load i32* %tid, align 4, !dbg !62
%100 = zext i32 %99 to i64, !dbg !62
%101 = getelementptr inbounds [256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jE6s_dist, i32 0, i64 %100, !dbg !62
store i32 %98, i32* %101, align 4, !dbg !62
%102 = load i32* %tid, align 4, !dbg !64
%103 = add i32 %102, 64, !dbg !64
%104 = zext i32 %103 to i64, !dbg !64
%105 = getelementptr inbounds [256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jE5s_idx, i32 0, i64 %104, !dbg !64
%106 = load i32* %105, align 4, !dbg !64
%107 = load i32* %tid, align 4, !dbg !64
%108 = zext i32 %107 to i64, !dbg !64
%109 = getelementptr inbounds [256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jE5s_idx, i32 0, i64 %108, !dbg !64
store i32 %106, i32* %109, align 4, !dbg !64
br label %182

; <label>:182
%label182 = load i1 %label79
%label182 = and i1 %label182, %label21
br i1 %label182, label %110, label %183

; <label>:110                                     ; preds = %93, %82
br label %183

; <label>:183
%label183 = load i1 %label21
br i1 %label183, label %111, label %184

; <label>:111                                     ; preds = %110, %79
call void @__syncthreads(), !dbg !67
%112 = load i32* %tid, align 4, !dbg !68
%113 = icmp ult i32 %112, 8, !dbg !68
%label111 = load i1 %113
%label111not = icmp uge i32 %112, 8, !dbg !68
br label %184

; <label>:184
%label184 = load i1 %label21
%label184 = and i1 %label184, %label111
br i1 %label184, label %114, label %185

; <label>:114                                     ; preds = %111
%115 = load i32* %tid, align 4, !dbg !69
%116 = add i32 %115, 32, !dbg !69
%117 = zext i32 %116 to i64, !dbg !69
%118 = getelementptr inbounds [256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jE6s_dist, i32 0, i64 %117, !dbg !69
%119 = load i32* %118, align 4, !dbg !69
%120 = load i32* %tid, align 4, !dbg !69
%121 = zext i32 %120 to i64, !dbg !69
%122 = getelementptr inbounds [256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jE6s_dist, i32 0, i64 %121, !dbg !69
%123 = load i32* %122, align 4, !dbg !69
%124 = icmp ult i32 %119, %123, !dbg !69
%label114 = load i1 %124
%label114not = icmp uge i32 %119, %123, !dbg !69
br label %185

; <label>:185
%label185 = load i1 %label21
%label185 = and i1 %label185, %label111
%label185 = and i1 %label185, %label114
br i1 %label185, label %125, label %186

; <label>:125                                     ; preds = %114
%126 = load i32* %tid, align 4, !dbg !71
%127 = add i32 %126, 32, !dbg !71
%128 = zext i32 %127 to i64, !dbg !71
%129 = getelementptr inbounds [256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jE6s_dist, i32 0, i64 %128, !dbg !71
%130 = load i32* %129, align 4, !dbg !71
%131 = load i32* %tid, align 4, !dbg !71
%132 = zext i32 %131 to i64, !dbg !71
%133 = getelementptr inbounds [256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jE6s_dist, i32 0, i64 %132, !dbg !71
store i32 %130, i32* %133, align 4, !dbg !71
%134 = load i32* %tid, align 4, !dbg !73
%135 = add i32 %134, 32, !dbg !73
%136 = zext i32 %135 to i64, !dbg !73
%137 = getelementptr inbounds [256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jE5s_idx, i32 0, i64 %136, !dbg !73
%138 = load i32* %137, align 4, !dbg !73
%139 = load i32* %tid, align 4, !dbg !73
%140 = zext i32 %139 to i64, !dbg !73
%141 = getelementptr inbounds [256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jE5s_idx, i32 0, i64 %140, !dbg !73
store i32 %138, i32* %141, align 4, !dbg !73
br label %186

; <label>:186
%label186 = load i1 %label21
%label186 = and i1 %label186, %label111
br i1 %label186, label %142, label %187

; <label>:142                                     ; preds = %125, %114
br label %187

; <label>:187
%label187 = load i1 %label21
br i1 %label187, label %143, label %188

; <label>:143                                     ; preds = %142, %111
call void @__syncthreads(), !dbg !76
%144 = load i32* %f, align 4, !dbg !77
%145 = load i32* %ntrain, align 4, !dbg !77
%146 = icmp ult i32 %144, %145, !dbg !77
%label143 = load i1 %146
%label143not = icmp uge i32 %144, %145, !dbg !77
br label %188

; <label>:188
%label188 = load i1 %label143
%label188 = and i1 %label188, %label21
br i1 %label188, label %147, label %189

; <label>:147                                     ; preds = %143
%148 = load i32* getelementptr inbounds ([256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jE6s_dist, i32 0, i64 0), align 4, !dbg !78
%149 = load i32* %j, align 4, !dbg !78
%150 = load i32* getelementptr inbounds (%struct.dim3* @gridDim, i32 0, i32 0), align 4, !dbg !78
%151 = mul i32 %149, %150, !dbg !78
%152 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 0), align 4, !dbg !78
%153 = add i32 %151, %152, !dbg !78
%154 = zext i32 %153 to i64, !dbg !78
%155 = load i32** %1, align 8, !dbg !78
%156 = getelementptr inbounds i32* %155, i64 %154, !dbg !78
store i32 %148, i32* %156, align 4, !dbg !78
%157 = load i32* getelementptr inbounds ([256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jE5s_idx, i32 0, i64 0), align 4, !dbg !80
%158 = load i32* %j, align 4, !dbg !80
%159 = load i32* getelementptr inbounds (%struct.dim3* @gridDim, i32 0, i32 0), align 4, !dbg !80
%160 = mul i32 %158, %159, !dbg !80
%161 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 0), align 4, !dbg !80
%162 = add i32 %160, %161, !dbg !80
%163 = zext i32 %162 to i64, !dbg !80
%164 = load i32** %2, align 8, !dbg !80
%165 = getelementptr inbounds i32* %164, i64 %163, !dbg !80
store i32 %157, i32* %165, align 4, !dbg !80
br label %189

; <label>:189
call void @__syncthreads(), 1
%label189 = load i1 %label21
br i1 %label189, label %166, label %190

; <label>:166                                     ; preds = %147, %143
br label %190

; <label>:190
%label190 = load i1 %label21
br i1 %label190, label %167, label %191

; <label>:167                                     ; preds = %166
%168 = load i32* %j, align 4, !dbg !42
%169 = add i32 %168, 1, !dbg !42
store i32 %169, i32* %j, align 4, !dbg !42
br label %21, !dbg !42
br label %191

; <label>:191
br label %170

; <label>:170                                     ; preds = %21
ret void, !dbg !83


}