define void @_Z22hamming_matcher_unrollPjS_jj(i32* %out_idx, i32* %out_dist, i32 %max_dist, i32 %feat_len) uwtable noinline {
%label143 = alloca i1, align 4
%label143not = alloca i1, align 4
%label115not = alloca i1, align 4
%label48 = alloca i1, align 4
%label48not = alloca i1, align 4
%label22 = alloca i1, align 4
%label26 = alloca i1, align 4
%label115 = alloca i1, align 4
%label26not = alloca i1, align 4
%label171 = alloca i1, align 4
%label83 = alloca i1, align 4
%label80 = alloca i1, align 4
%label22not = alloca i1, align 4
%label112 = alloca i1, align 4
%label199not = alloca i1, align 4
%label112not = alloca i1, align 4
%label228not = alloca i1, align 4
%label34not = alloca i1, align 4
%label228 = alloca i1, align 4
%label51 = alloca i1, align 4
%label80not = alloca i1, align 4
%label199 = alloca i1, align 4
%label34 = alloca i1, align 4
%label51not = alloca i1, align 4
%label83not = alloca i1, align 4
%label171not = alloca i1, align 4
%1 = alloca i32*, align 8
%2 = alloca i32*, align 8
%3 = alloca i32, align 4
%4 = alloca i32, align 4
%nquery = alloca i32, align 4
%ntrain = alloca i32, align 4
%f = alloca i32, align 4
%tid = alloca i32, align 4
%valid_feat = alloca i8, align 1
%j = alloca i32, align 4
%dist = alloca i32, align 4
store i32* %out_idx, i32** %1, align 8
store i32* %out_dist, i32** %2, align 8
store i32 %max_dist, i32* %3, align 4
store i32 %feat_len, i32* %4, align 4
store i32 6, i32* %nquery, align 4, !dbg !29
store i32 6, i32* %ntrain, align 4, !dbg !31
%5 = load i32* getelementptr inbounds (%struct.dim3* @blockDim, i32 0, i32 0), align 4, !dbg !33
%6 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 0), align 4, !dbg !33
%7 = mul i32 %5, %6, !dbg !33
%8 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !33
%9 = add i32 %7, %8, !dbg !33
store i32 %9, i32* %f, align 4, !dbg !33
%10 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !35
store i32 %10, i32* %tid, align 4, !dbg !35
%11 = load i32* %3, align 4, !dbg !36
%12 = load i32* %tid, align 4, !dbg !36
%13 = zext i32 %12 to i64, !dbg !36
%14 = getelementptr inbounds [256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jjE6s_dist, i32 0, i64 %13, !dbg !36
store i32 %11, i32* %14, align 4, !dbg !36
%15 = load i32* %tid, align 4, !dbg !37
%16 = zext i32 %15 to i64, !dbg !37
%17 = getelementptr inbounds [256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jjE5s_idx, i32 0, i64 %16, !dbg !37
store i32 -1, i32* %17, align 4, !dbg !37
%18 = load i32* %f, align 4, !dbg !40
%19 = load i32* %ntrain, align 4, !dbg !40
%20 = icmp ult i32 %18, %19, !dbg !40
%21 = zext i1 %20 to i8, !dbg !40
store i8 %21, i8* %valid_feat, align 1, !dbg !40
store i32 0, i32* %j, align 4, !dbg !43
br label %22, !dbg !43

; <label>:22                                      ; preds = %252, %0
%23 = load i32* %j, align 4, !dbg !43
%24 = load i32* %nquery, align 4, !dbg !43
%25 = icmp ult i32 %23, %24, !dbg !43
%label22 = load i1 %25
%label22not = icmp uge i32 %23, %24, !dbg !43
br label %257

; <label>:257
%label257 = load i1 %label22
br i1 %label257, label %26, label %258
br label %26

; <label>:26                                      ; preds = %22
%27 = load i32* %3, align 4, !dbg !44
%28 = load i32* %tid, align 4, !dbg !44
%29 = zext i32 %28 to i64, !dbg !44
%30 = getelementptr inbounds [256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jjE6s_dist, i32 0, i64 %29, !dbg !44
store i32 %27, i32* %30, align 4, !dbg !44
%31 = load i32* %tid, align 4, !dbg !46
%32 = load i32* %4, align 4, !dbg !46
%33 = icmp ult i32 %31, %32, !dbg !46
%label26 = load i1 %33
%label26not = icmp uge i32 %31, %32, !dbg !46
br label %258

; <label>:258
%label258 = load i1 %label22
%label258 = and i1 %label258, %label26
br i1 %label258, label %34, label %259
br label %34

; <label>:34                                      ; preds = %26
%35 = load i32* %f, align 4, !dbg !46
%36 = load i32* %ntrain, align 4, !dbg !46
%37 = icmp ult i32 %35, %36, !dbg !46
%label34 = load i1 %37
%label34not = icmp uge i32 %35, %36, !dbg !46
br label %259

; <label>:259
%label259 = load i1 %label34
%label259 = and i1 %label259, %label22
%label259 = and i1 %label259, %label26
br i1 %label259, label %38, label %260
br label %38

; <label>:38                                      ; preds = %34
%39 = load i32* %tid, align 4, !dbg !47
%40 = load i32* %nquery, align 4, !dbg !47
%41 = mul i32 %39, %40, !dbg !47
%42 = load i32* %j, align 4, !dbg !47
%43 = add i32 %41, %42, !dbg !47
%44 = load i32* %tid, align 4, !dbg !47
%45 = zext i32 %44 to i64, !dbg !47
%46 = load i32** %2, align 8, !dbg !47
%47 = getelementptr inbounds i32* %46, i64 %45, !dbg !47
store i32 %43, i32* %47, align 4, !dbg !47
br label %260

; <label>:260
%label260 = load i1 %label22
br i1 %label260, label %48, label %261
br label %48

; <label>:48                                      ; preds = %38, %34, %26
call void @__syncthreads(), !dbg !50
store i32 0, i32* %dist, align 4, !dbg !52
%49 = load i32* %tid, align 4, !dbg !53
%50 = icmp ult i32 %49, 32, !dbg !53
%label48 = load i1 %50
%label48not = icmp uge i32 %49, 32, !dbg !53
br label %261

; <label>:261
%label261 = load i1 %label48
%label261 = and i1 %label261, %label22
br i1 %label261, label %51, label %262
br label %51

; <label>:51                                      ; preds = %48
%52 = load i32* %tid, align 4, !dbg !54
%53 = add i32 %52, 64, !dbg !54
%54 = zext i32 %53 to i64, !dbg !54
%55 = getelementptr inbounds [256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jjE6s_dist, i32 0, i64 %54, !dbg !54
%56 = load i32* %55, align 4, !dbg !54
%57 = load i32* %tid, align 4, !dbg !54
%58 = zext i32 %57 to i64, !dbg !54
%59 = getelementptr inbounds [256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jjE6s_dist, i32 0, i64 %58, !dbg !54
%60 = load i32* %59, align 4, !dbg !54
%61 = icmp ult i32 %56, %60, !dbg !54
%label51 = load i1 %61
%label51not = icmp uge i32 %56, %60, !dbg !54
br label %262

; <label>:262
%label262 = load i1 %label48
%label262 = and i1 %label262, %label51
%label262 = and i1 %label262, %label22
br i1 %label262, label %62, label %263
br label %62

; <label>:62                                      ; preds = %51
%63 = load i32* %tid, align 4, !dbg !56
%64 = add i32 %63, 128, !dbg !56
%65 = zext i32 %64 to i64, !dbg !56
%66 = getelementptr inbounds [256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jjE6s_dist, i32 0, i64 %65, !dbg !56
%67 = load i32* %66, align 4, !dbg !56
%68 = load i32* %tid, align 4, !dbg !56
%69 = zext i32 %68 to i64, !dbg !56
%70 = getelementptr inbounds [256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jjE6s_dist, i32 0, i64 %69, !dbg !56
store i32 %67, i32* %70, align 4, !dbg !56
%71 = load i32* %tid, align 4, !dbg !58
%72 = add i32 %71, 128, !dbg !58
%73 = zext i32 %72 to i64, !dbg !58
%74 = getelementptr inbounds [256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jjE5s_idx, i32 0, i64 %73, !dbg !58
%75 = load i32* %74, align 4, !dbg !58
%76 = load i32* %tid, align 4, !dbg !58
%77 = zext i32 %76 to i64, !dbg !58
%78 = getelementptr inbounds [256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jjE5s_idx, i32 0, i64 %77, !dbg !58
store i32 %75, i32* %78, align 4, !dbg !58
br label %263

; <label>:263
%label263 = load i1 %label48
%label263 = and i1 %label263, %label22
br i1 %label263, label %79, label %264
br label %79

; <label>:79                                      ; preds = %62, %51
br label %264

; <label>:264
%label264 = load i1 %label22
br i1 %label264, label %80, label %265
br label %80

; <label>:80                                      ; preds = %79, %48
call void @__syncthreads(), !dbg !61
%81 = load i32* %tid, align 4, !dbg !62
%82 = icmp ult i32 %81, 16, !dbg !62
%label80 = load i1 %82
%label80not = icmp uge i32 %81, 16, !dbg !62
br label %265

; <label>:265
%label265 = load i1 %label22
%label265 = and i1 %label265, %label80
br i1 %label265, label %83, label %266
br label %83

; <label>:83                                      ; preds = %80
%84 = load i32* %tid, align 4, !dbg !63
%85 = add i32 %84, 32, !dbg !63
%86 = zext i32 %85 to i64, !dbg !63
%87 = getelementptr inbounds [256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jjE6s_dist, i32 0, i64 %86, !dbg !63
%88 = load i32* %87, align 4, !dbg !63
%89 = load i32* %tid, align 4, !dbg !63
%90 = zext i32 %89 to i64, !dbg !63
%91 = getelementptr inbounds [256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jjE6s_dist, i32 0, i64 %90, !dbg !63
%92 = load i32* %91, align 4, !dbg !63
%93 = icmp ult i32 %88, %92, !dbg !63
%label83 = load i1 %93
%label83not = icmp uge i32 %88, %92, !dbg !63
br label %266

; <label>:266
%label266 = load i1 %label22
%label266 = and i1 %label266, %label80
%label266 = and i1 %label266, %label83
br i1 %label266, label %94, label %267
br label %94

; <label>:94                                      ; preds = %83
%95 = load i32* %tid, align 4, !dbg !65
%96 = add i32 %95, 64, !dbg !65
%97 = zext i32 %96 to i64, !dbg !65
%98 = getelementptr inbounds [256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jjE6s_dist, i32 0, i64 %97, !dbg !65
%99 = load i32* %98, align 4, !dbg !65
%100 = load i32* %tid, align 4, !dbg !65
%101 = zext i32 %100 to i64, !dbg !65
%102 = getelementptr inbounds [256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jjE6s_dist, i32 0, i64 %101, !dbg !65
store i32 %99, i32* %102, align 4, !dbg !65
%103 = load i32* %tid, align 4, !dbg !67
%104 = add i32 %103, 64, !dbg !67
%105 = zext i32 %104 to i64, !dbg !67
%106 = getelementptr inbounds [256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jjE5s_idx, i32 0, i64 %105, !dbg !67
%107 = load i32* %106, align 4, !dbg !67
%108 = load i32* %tid, align 4, !dbg !67
%109 = zext i32 %108 to i64, !dbg !67
%110 = getelementptr inbounds [256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jjE5s_idx, i32 0, i64 %109, !dbg !67
store i32 %107, i32* %110, align 4, !dbg !67
br label %267

; <label>:267
%label267 = load i1 %label22
%label267 = and i1 %label267, %label80
br i1 %label267, label %111, label %268
br label %111

; <label>:111                                     ; preds = %94, %83
br label %268

; <label>:268
%label268 = load i1 %label22
br i1 %label268, label %112, label %269
br label %112

; <label>:112                                     ; preds = %111, %80
call void @__syncthreads(), !dbg !70
%113 = load i32* %tid, align 4, !dbg !71
%114 = icmp ult i32 %113, 8, !dbg !71
%label112 = load i1 %114
%label112not = icmp uge i32 %113, 8, !dbg !71
br label %269

; <label>:269
%label269 = load i1 %label112
%label269 = and i1 %label269, %label22
br i1 %label269, label %115, label %270
br label %115

; <label>:115                                     ; preds = %112
%116 = load i32* %tid, align 4, !dbg !72
%117 = add i32 %116, 16, !dbg !72
%118 = zext i32 %117 to i64, !dbg !72
%119 = getelementptr inbounds [256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jjE6s_dist, i32 0, i64 %118, !dbg !72
%120 = load i32* %119, align 4, !dbg !72
%121 = load i32* %tid, align 4, !dbg !72
%122 = zext i32 %121 to i64, !dbg !72
%123 = getelementptr inbounds [256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jjE6s_dist, i32 0, i64 %122, !dbg !72
%124 = load i32* %123, align 4, !dbg !72
%125 = icmp ult i32 %120, %124, !dbg !72
%label115 = load i1 %125
%label115not = icmp uge i32 %120, %124, !dbg !72
br label %270

; <label>:270
%label270 = load i1 %label112
%label270 = and i1 %label270, %label22
%label270 = and i1 %label270, %label115
br i1 %label270, label %126, label %271
br label %126

; <label>:126                                     ; preds = %115
%127 = load i32* %tid, align 4, !dbg !74
%128 = add i32 %127, 32, !dbg !74
%129 = zext i32 %128 to i64, !dbg !74
%130 = getelementptr inbounds [256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jjE6s_dist, i32 0, i64 %129, !dbg !74
%131 = load i32* %130, align 4, !dbg !74
%132 = load i32* %tid, align 4, !dbg !74
%133 = zext i32 %132 to i64, !dbg !74
%134 = getelementptr inbounds [256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jjE6s_dist, i32 0, i64 %133, !dbg !74
store i32 %131, i32* %134, align 4, !dbg !74
%135 = load i32* %tid, align 4, !dbg !76
%136 = add i32 %135, 32, !dbg !76
%137 = zext i32 %136 to i64, !dbg !76
%138 = getelementptr inbounds [256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jjE5s_idx, i32 0, i64 %137, !dbg !76
%139 = load i32* %138, align 4, !dbg !76
%140 = load i32* %tid, align 4, !dbg !76
%141 = zext i32 %140 to i64, !dbg !76
%142 = getelementptr inbounds [256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jjE5s_idx, i32 0, i64 %141, !dbg !76
store i32 %139, i32* %142, align 4, !dbg !76
br label %271

; <label>:271
call void @__syncthreads()
%label271 = load i1 %label112
%label271 = and i1 %label271, %label22
br i1 %label271, label %143, label %272
br label %143

; <label>:143                                     ; preds = %126, %115
%144 = load i32* %tid, align 4, !dbg !78
%145 = add i32 %144, 4, !dbg !78
%146 = zext i32 %145 to i64, !dbg !78
%147 = getelementptr inbounds [256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jjE6s_dist, i32 0, i64 %146, !dbg !78
%148 = load i32* %147, align 4, !dbg !78
%149 = load i32* %tid, align 4, !dbg !78
%150 = zext i32 %149 to i64, !dbg !78
%151 = getelementptr inbounds [256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jjE6s_dist, i32 0, i64 %150, !dbg !78
%152 = load i32* %151, align 4, !dbg !78
%153 = icmp ult i32 %148, %152, !dbg !78
%label143 = load i1 %153
%label143not = icmp uge i32 %148, %152, !dbg !78
br label %272

; <label>:272
call void @__syncthreads()
%label272 = load i1 %label112
%label272 = and i1 %label272, %label22
%label272 = and i1 %label272, %label143
br label %291
br label %291

; <label>:291
br label %273

; <label>:273
call void @__syncthreads(), 0
%label273 = load i1 %label112
%label273 = and i1 %label273, %label22
br i1 %label273, label %171, label %274
br label %171

; <label>:154                                     ; preds = %143
%155 = load i32* %tid, align 4, !dbg !79
%156 = add i32 %155, 4, !dbg !79
%157 = zext i32 %156 to i64, !dbg !79
%158 = getelementptr inbounds [256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jjE6s_dist, i32 0, i64 %157, !dbg !79
%159 = load i32* %158, align 4, !dbg !79
%160 = load i32* %tid, align 4, !dbg !79
%161 = zext i32 %160 to i64, !dbg !79
%162 = getelementptr inbounds [256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jjE6s_dist, i32 0, i64 %161, !dbg !79
br label %289

; <label>:289
store i32 %159, i32* %162, align 4, !dbg !79
%163 = load i32* %tid, align 4, !dbg !81
%164 = add i32 %163, 4, !dbg !81
%165 = zext i32 %164 to i64, !dbg !81
%166 = getelementptr inbounds [256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jjE5s_idx, i32 0, i64 %165, !dbg !81
%167 = load i32* %166, align 4, !dbg !81
%168 = load i32* %tid, align 4, !dbg !81
%169 = zext i32 %168 to i64, !dbg !81
%170 = getelementptr inbounds [256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jjE5s_idx, i32 0, i64 %169, !dbg !81
store i32 %167, i32* %170, align 4, !dbg !81
br label %273

; <label>:171                                     ; preds = %154, %143
%172 = load i32* %tid, align 4, !dbg !83
%173 = add i32 %172, 2, !dbg !83
%174 = zext i32 %173 to i64, !dbg !83
%175 = getelementptr inbounds [256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jjE6s_dist, i32 0, i64 %174, !dbg !83
%176 = load i32* %175, align 4, !dbg !83
%177 = load i32* %tid, align 4, !dbg !83
%178 = zext i32 %177 to i64, !dbg !83
%179 = getelementptr inbounds [256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jjE6s_dist, i32 0, i64 %178, !dbg !83
%180 = load i32* %179, align 4, !dbg !83
%181 = icmp ult i32 %176, %180, !dbg !83
%label171 = load i1 %181
%label171not = icmp uge i32 %176, %180, !dbg !83
br label %274

; <label>:274
call void @__syncthreads()
%label274 = load i1 %label112
%label274 = and i1 %label274, %label171
%label274 = and i1 %label274, %label22
br label %288
br label %288

; <label>:288
br label %275

; <label>:275
call void @__syncthreads()
%label275 = load i1 %label112
%label275 = and i1 %label275, %label22
br i1 %label275, label %199, label %276
br label %199
br label %182

; <label>:182                                     ; preds = %171
%183 = load i32* %tid, align 4, !dbg !84
%184 = add i32 %183, 2, !dbg !84
%185 = zext i32 %184 to i64, !dbg !84
%186 = getelementptr inbounds [256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jjE6s_dist, i32 0, i64 %185, !dbg !84
%187 = load i32* %186, align 4, !dbg !84
%188 = load i32* %tid, align 4, !dbg !84
%189 = zext i32 %188 to i64, !dbg !84
%190 = getelementptr inbounds [256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jjE6s_dist, i32 0, i64 %189, !dbg !84
br label %286

; <label>:286
store i32 %187, i32* %190, align 4, !dbg !84
%191 = load i32* %tid, align 4, !dbg !86
%192 = add i32 %191, 2, !dbg !86
%193 = zext i32 %192 to i64, !dbg !86
%194 = getelementptr inbounds [256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jjE5s_idx, i32 0, i64 %193, !dbg !86
%195 = load i32* %194, align 4, !dbg !86
%196 = load i32* %tid, align 4, !dbg !86
%197 = zext i32 %196 to i64, !dbg !86
%198 = getelementptr inbounds [256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jjE5s_idx, i32 0, i64 %197, !dbg !86
store i32 %195, i32* %198, align 4, !dbg !86
br label %275
br label %199

; <label>:199                                     ; preds = %182, %171
%200 = load i32* %tid, align 4, !dbg !88
%201 = add i32 %200, 1, !dbg !88
%202 = zext i32 %201 to i64, !dbg !88
%203 = getelementptr inbounds [256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jjE6s_dist, i32 0, i64 %202, !dbg !88
%204 = load i32* %203, align 4, !dbg !88
%205 = load i32* %tid, align 4, !dbg !88
%206 = zext i32 %205 to i64, !dbg !88
%207 = getelementptr inbounds [256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jjE6s_dist, i32 0, i64 %206, !dbg !88
%208 = load i32* %207, align 4, !dbg !88
%209 = icmp ult i32 %204, %208, !dbg !88
%label199 = load i1 %209
%label199not = icmp uge i32 %204, %208, !dbg !88
br label %276

; <label>:276
call void @__syncthreads(), 1
%label276 = load i1 %label112
%label276 = and i1 %label276, %label22
%label276 = and i1 %label276, %label199
br label %285
br label %285

; <label>:285
br label %277

; <label>:277
%label277 = load i1 %label112
%label277 = and i1 %label277, %label22
br i1 %label277, label %227, label %278
br label %227
br label %210

; <label>:210                                     ; preds = %199
%211 = load i32* %tid, align 4, !dbg !89
%212 = add i32 %211, 1, !dbg !89
%213 = zext i32 %212 to i64, !dbg !89
%214 = getelementptr inbounds [256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jjE6s_dist, i32 0, i64 %213, !dbg !89
%215 = load i32* %214, align 4, !dbg !89
%216 = load i32* %tid, align 4, !dbg !89
%217 = zext i32 %216 to i64, !dbg !89
%218 = getelementptr inbounds [256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jjE6s_dist, i32 0, i64 %217, !dbg !89
br label %283

; <label>:283
store i32 %215, i32* %218, align 4, !dbg !89
%219 = load i32* %tid, align 4, !dbg !91
%220 = add i32 %219, 1, !dbg !91
%221 = zext i32 %220 to i64, !dbg !91
%222 = getelementptr inbounds [256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jjE5s_idx, i32 0, i64 %221, !dbg !91
%223 = load i32* %222, align 4, !dbg !91
%224 = load i32* %tid, align 4, !dbg !91
%225 = zext i32 %224 to i64, !dbg !91
%226 = getelementptr inbounds [256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jjE5s_idx, i32 0, i64 %225, !dbg !91
store i32 %223, i32* %226, align 4, !dbg !91
br label %277
br label %227

; <label>:227                                     ; preds = %210, %199
br label %278

; <label>:278
%label278 = load i1 %label22
br i1 %label278, label %228, label %279
br label %228

; <label>:228                                     ; preds = %227, %112
call void @__syncthreads(), !dbg !94
%229 = load i32* %f, align 4, !dbg !95
%230 = load i32* %ntrain, align 4, !dbg !95
%231 = icmp ult i32 %229, %230, !dbg !95
%label228 = load i1 %231
%label228not = icmp uge i32 %229, %230, !dbg !95
br label %279

; <label>:279
%label279 = load i1 %label228
%label279 = and i1 %label279, %label22
br i1 %label279, label %232, label %280
br label %232

; <label>:232                                     ; preds = %228
%233 = load i32* getelementptr inbounds ([256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jjE6s_dist, i32 0, i64 0), align 4, !dbg !96
%234 = load i32* %j, align 4, !dbg !96
%235 = load i32* getelementptr inbounds (%struct.dim3* @gridDim, i32 0, i32 0), align 4, !dbg !96
%236 = mul i32 %234, %235, !dbg !96
%237 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 0), align 4, !dbg !96
%238 = add i32 %236, %237, !dbg !96
%239 = zext i32 %238 to i64, !dbg !96
%240 = load i32** %2, align 8, !dbg !96
%241 = getelementptr inbounds i32* %240, i64 %239, !dbg !96
store i32 %233, i32* %241, align 4, !dbg !96
%242 = load i32* getelementptr inbounds ([256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jjE5s_idx, i32 0, i64 0), align 4, !dbg !98
%243 = load i32* %j, align 4, !dbg !98
%244 = load i32* getelementptr inbounds (%struct.dim3* @gridDim, i32 0, i32 0), align 4, !dbg !98
%245 = mul i32 %243, %244, !dbg !98
%246 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 0), align 4, !dbg !98
%247 = add i32 %245, %246, !dbg !98
%248 = zext i32 %247 to i64, !dbg !98
%249 = load i32** %1, align 8, !dbg !98
%250 = getelementptr inbounds i32* %249, i64 %248, !dbg !98
store i32 %242, i32* %250, align 4, !dbg !98
br label %280

; <label>:280
%label280 = load i1 %label22
br i1 %label280, label %251, label %281
br label %251

; <label>:251                                     ; preds = %232, %228
call void @__syncthreads(), !dbg !100
br label %281

; <label>:281
%label281 = load i1 %label22
br i1 %label281, label %252, label %282
br label %252

; <label>:252                                     ; preds = %251
%253 = load i32* %j, align 4, !dbg !43
%254 = add i32 %253, 1, !dbg !43
store i32 %254, i32* %j, align 4, !dbg !43
br label %22, !dbg !43
br label %282

; <label>:282
br label %255

; <label>:255                                     ; preds = %22
ret void, !dbg !102


}