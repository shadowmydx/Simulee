define void @_Z15hamming_matcherPjS_jj(i32* %out_idx, i32* %out_dist, i32 %max_dist, i32 %feat_len) uwtable noinline {
%label51not = alloca i1, align 4
%label112not = alloca i1, align 4
%label51 = alloca i1, align 4
%label144not = alloca i1, align 4
%label34not = alloca i1, align 4
%label115 = alloca i1, align 4
%label83not = alloca i1, align 4
%label80not = alloca i1, align 4
%label144 = alloca i1, align 4
%label26not = alloca i1, align 4
%label115not = alloca i1, align 4
%label80 = alloca i1, align 4
%label48 = alloca i1, align 4
%label48not = alloca i1, align 4
%label83 = alloca i1, align 4
%label22 = alloca i1, align 4
%label22not = alloca i1, align 4
%label112 = alloca i1, align 4
%label26 = alloca i1, align 4
%label34 = alloca i1, align 4
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
%14 = getelementptr inbounds [256 x i32]* @_ZZ15hamming_matcherPjS_jjE6s_dist, i32 0, i64 %13, !dbg !36
store i32 %11, i32* %14, align 4, !dbg !36
%15 = load i32* %tid, align 4, !dbg !37
%16 = zext i32 %15 to i64, !dbg !37
%17 = getelementptr inbounds [256 x i32]* @_ZZ15hamming_matcherPjS_jjE5s_idx, i32 0, i64 %16, !dbg !37
store i32 -1, i32* %17, align 4, !dbg !37
%18 = load i32* %f, align 4, !dbg !40
%19 = load i32* %ntrain, align 4, !dbg !40
%20 = icmp ult i32 %18, %19, !dbg !40
%21 = zext i1 %20 to i8, !dbg !40
store i8 %21, i8* %valid_feat, align 1, !dbg !40
store i32 0, i32* %j, align 4, !dbg !43
br label %22, !dbg !43

; <label>:22                                      ; preds = %168, %0
%23 = load i32* %j, align 4, !dbg !43
%24 = load i32* %nquery, align 4, !dbg !43
%25 = icmp ult i32 %23, %24, !dbg !43
%label22 = load i1 %25
%label22not = icmp uge i32 %23, %24, !dbg !43
br label %173

; <label>:173
%label173 = load i1 %label22
br i1 %label173, label %26, label %174

; <label>:26                                      ; preds = %22
%27 = load i32* %3, align 4, !dbg !44
%28 = load i32* %tid, align 4, !dbg !44
%29 = zext i32 %28 to i64, !dbg !44
%30 = getelementptr inbounds [256 x i32]* @_ZZ15hamming_matcherPjS_jjE6s_dist, i32 0, i64 %29, !dbg !44
store i32 %27, i32* %30, align 4, !dbg !44
%31 = load i32* %tid, align 4, !dbg !46
%32 = load i32* %4, align 4, !dbg !46
%33 = icmp ult i32 %31, %32, !dbg !46
%label26 = load i1 %33
%label26not = icmp uge i32 %31, %32, !dbg !46
br label %174

; <label>:174
call void @__syncthreads(), 0
%label174 = load i1 %label22
%label174 = and i1 %label174, %label26
br i1 %label174, label %34, label %175

; <label>:34                                      ; preds = %26
%35 = load i32* %f, align 4, !dbg !46
%36 = load i32* %ntrain, align 4, !dbg !46
%37 = icmp ult i32 %35, %36, !dbg !46
%label34 = load i1 %37
%label34not = icmp uge i32 %35, %36, !dbg !46
br label %175

; <label>:175
%label175 = load i1 %label34
%label175 = and i1 %label175, %label22
%label175 = and i1 %label175, %label26
br i1 %label175, label %38, label %176

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
br label %176

; <label>:176
%label176 = load i1 %label22
br i1 %label176, label %48, label %177

; <label>:48                                      ; preds = %38, %34, %26
call void @__syncthreads(), !dbg !50
store i32 0, i32* %dist, align 4, !dbg !52
%49 = load i32* %tid, align 4, !dbg !53
%50 = icmp ult i32 %49, 32, !dbg !53
%label48 = load i1 %50
%label48not = icmp uge i32 %49, 32, !dbg !53
br label %177

; <label>:177
%label177 = load i1 %label48
%label177 = and i1 %label177, %label22
br i1 %label177, label %51, label %178

; <label>:51                                      ; preds = %48
%52 = load i32* %tid, align 4, !dbg !54
%53 = add i32 %52, 128, !dbg !54
%54 = zext i32 %53 to i64, !dbg !54
%55 = getelementptr inbounds [256 x i32]* @_ZZ15hamming_matcherPjS_jjE6s_dist, i32 0, i64 %54, !dbg !54
%56 = load i32* %55, align 4, !dbg !54
%57 = load i32* %tid, align 4, !dbg !54
%58 = zext i32 %57 to i64, !dbg !54
%59 = getelementptr inbounds [256 x i32]* @_ZZ15hamming_matcherPjS_jjE6s_dist, i32 0, i64 %58, !dbg !54
%60 = load i32* %59, align 4, !dbg !54
%61 = icmp ult i32 %56, %60, !dbg !54
%label51 = load i1 %61
%label51not = icmp uge i32 %56, %60, !dbg !54
br label %178

; <label>:178
%label178 = load i1 %label48
%label178 = and i1 %label178, %label51
%label178 = and i1 %label178, %label22
br i1 %label178, label %62, label %179

; <label>:62                                      ; preds = %51
%63 = load i32* %tid, align 4, !dbg !56
%64 = add i32 %63, 128, !dbg !56
%65 = zext i32 %64 to i64, !dbg !56
%66 = getelementptr inbounds [256 x i32]* @_ZZ15hamming_matcherPjS_jjE6s_dist, i32 0, i64 %65, !dbg !56
%67 = load i32* %66, align 4, !dbg !56
%68 = load i32* %tid, align 4, !dbg !56
%69 = zext i32 %68 to i64, !dbg !56
%70 = getelementptr inbounds [256 x i32]* @_ZZ15hamming_matcherPjS_jjE6s_dist, i32 0, i64 %69, !dbg !56
store i32 %67, i32* %70, align 4, !dbg !56
%71 = load i32* %tid, align 4, !dbg !58
%72 = add i32 %71, 128, !dbg !58
%73 = zext i32 %72 to i64, !dbg !58
%74 = getelementptr inbounds [256 x i32]* @_ZZ15hamming_matcherPjS_jjE5s_idx, i32 0, i64 %73, !dbg !58
%75 = load i32* %74, align 4, !dbg !58
%76 = load i32* %tid, align 4, !dbg !58
%77 = zext i32 %76 to i64, !dbg !58
%78 = getelementptr inbounds [256 x i32]* @_ZZ15hamming_matcherPjS_jjE5s_idx, i32 0, i64 %77, !dbg !58
store i32 %75, i32* %78, align 4, !dbg !58
br label %179

; <label>:179
%label179 = load i1 %label48
%label179 = and i1 %label179, %label22
br i1 %label179, label %79, label %180

; <label>:79                                      ; preds = %62, %51
br label %180

; <label>:180
%label180 = load i1 %label22
br i1 %label180, label %80, label %181

; <label>:80                                      ; preds = %79, %48
call void @__syncthreads(), !dbg !61
%81 = load i32* %tid, align 4, !dbg !62
%82 = icmp ult i32 %81, 16, !dbg !62
%label80 = load i1 %82
%label80not = icmp uge i32 %81, 16, !dbg !62
br label %181

; <label>:181
%label181 = load i1 %label22
%label181 = and i1 %label181, %label80
br i1 %label181, label %83, label %182

; <label>:83                                      ; preds = %80
%84 = load i32* %tid, align 4, !dbg !63
%85 = add i32 %84, 64, !dbg !63
%86 = zext i32 %85 to i64, !dbg !63
%87 = getelementptr inbounds [256 x i32]* @_ZZ15hamming_matcherPjS_jjE6s_dist, i32 0, i64 %86, !dbg !63
%88 = load i32* %87, align 4, !dbg !63
%89 = load i32* %tid, align 4, !dbg !63
%90 = zext i32 %89 to i64, !dbg !63
%91 = getelementptr inbounds [256 x i32]* @_ZZ15hamming_matcherPjS_jjE6s_dist, i32 0, i64 %90, !dbg !63
%92 = load i32* %91, align 4, !dbg !63
%93 = icmp ult i32 %88, %92, !dbg !63
%label83 = load i1 %93
%label83not = icmp uge i32 %88, %92, !dbg !63
br label %182

; <label>:182
%label182 = load i1 %label22
%label182 = and i1 %label182, %label80
%label182 = and i1 %label182, %label83
br i1 %label182, label %94, label %183

; <label>:94                                      ; preds = %83
%95 = load i32* %tid, align 4, !dbg !65
%96 = add i32 %95, 64, !dbg !65
%97 = zext i32 %96 to i64, !dbg !65
%98 = getelementptr inbounds [256 x i32]* @_ZZ15hamming_matcherPjS_jjE6s_dist, i32 0, i64 %97, !dbg !65
%99 = load i32* %98, align 4, !dbg !65
%100 = load i32* %tid, align 4, !dbg !65
%101 = zext i32 %100 to i64, !dbg !65
%102 = getelementptr inbounds [256 x i32]* @_ZZ15hamming_matcherPjS_jjE6s_dist, i32 0, i64 %101, !dbg !65
store i32 %99, i32* %102, align 4, !dbg !65
%103 = load i32* %tid, align 4, !dbg !67
%104 = add i32 %103, 64, !dbg !67
%105 = zext i32 %104 to i64, !dbg !67
%106 = getelementptr inbounds [256 x i32]* @_ZZ15hamming_matcherPjS_jjE5s_idx, i32 0, i64 %105, !dbg !67
%107 = load i32* %106, align 4, !dbg !67
%108 = load i32* %tid, align 4, !dbg !67
%109 = zext i32 %108 to i64, !dbg !67
%110 = getelementptr inbounds [256 x i32]* @_ZZ15hamming_matcherPjS_jjE5s_idx, i32 0, i64 %109, !dbg !67
store i32 %107, i32* %110, align 4, !dbg !67
br label %183

; <label>:183
%label183 = load i1 %label22
%label183 = and i1 %label183, %label80
br i1 %label183, label %111, label %184

; <label>:111                                     ; preds = %94, %83
br label %184

; <label>:184
%label184 = load i1 %label22
br i1 %label184, label %112, label %185

; <label>:112                                     ; preds = %111, %80
call void @__syncthreads(), !dbg !70
%113 = load i32* %tid, align 4, !dbg !71
%114 = icmp ult i32 %113, 8, !dbg !71
%label112 = load i1 %114
%label112not = icmp uge i32 %113, 8, !dbg !71
br label %185

; <label>:185
%label185 = load i1 %label112
%label185 = and i1 %label185, %label22
br i1 %label185, label %115, label %186

; <label>:115                                     ; preds = %112
%116 = load i32* %tid, align 4, !dbg !72
%117 = add i32 %116, 32, !dbg !72
%118 = zext i32 %117 to i64, !dbg !72
%119 = getelementptr inbounds [256 x i32]* @_ZZ15hamming_matcherPjS_jjE6s_dist, i32 0, i64 %118, !dbg !72
%120 = load i32* %119, align 4, !dbg !72
%121 = load i32* %tid, align 4, !dbg !72
%122 = zext i32 %121 to i64, !dbg !72
%123 = getelementptr inbounds [256 x i32]* @_ZZ15hamming_matcherPjS_jjE6s_dist, i32 0, i64 %122, !dbg !72
%124 = load i32* %123, align 4, !dbg !72
%125 = icmp ult i32 %120, %124, !dbg !72
%label115 = load i1 %125
%label115not = icmp uge i32 %120, %124, !dbg !72
br label %186

; <label>:186
%label186 = load i1 %label112
%label186 = and i1 %label186, %label22
%label186 = and i1 %label186, %label115
br i1 %label186, label %126, label %187

; <label>:126                                     ; preds = %115
%127 = load i32* %tid, align 4, !dbg !74
%128 = add i32 %127, 32, !dbg !74
%129 = zext i32 %128 to i64, !dbg !74
%130 = getelementptr inbounds [256 x i32]* @_ZZ15hamming_matcherPjS_jjE6s_dist, i32 0, i64 %129, !dbg !74
%131 = load i32* %130, align 4, !dbg !74
%132 = load i32* %tid, align 4, !dbg !74
%133 = zext i32 %132 to i64, !dbg !74
%134 = getelementptr inbounds [256 x i32]* @_ZZ15hamming_matcherPjS_jjE6s_dist, i32 0, i64 %133, !dbg !74
store i32 %131, i32* %134, align 4, !dbg !74
%135 = load i32* %tid, align 4, !dbg !76
%136 = add i32 %135, 32, !dbg !76
%137 = zext i32 %136 to i64, !dbg !76
%138 = getelementptr inbounds [256 x i32]* @_ZZ15hamming_matcherPjS_jjE5s_idx, i32 0, i64 %137, !dbg !76
%139 = load i32* %138, align 4, !dbg !76
%140 = load i32* %tid, align 4, !dbg !76
%141 = zext i32 %140 to i64, !dbg !76
%142 = getelementptr inbounds [256 x i32]* @_ZZ15hamming_matcherPjS_jjE5s_idx, i32 0, i64 %141, !dbg !76
store i32 %139, i32* %142, align 4, !dbg !76
br label %187

; <label>:187
%label187 = load i1 %label112
%label187 = and i1 %label187, %label22
br i1 %label187, label %143, label %188

; <label>:143                                     ; preds = %126, %115
br label %188

; <label>:188
%label188 = load i1 %label22
br i1 %label188, label %144, label %189

; <label>:144                                     ; preds = %143, %112
call void @__syncthreads(), !dbg !79
%145 = load i32* %f, align 4, !dbg !80
%146 = load i32* %ntrain, align 4, !dbg !80
%147 = icmp ult i32 %145, %146, !dbg !80
%label144 = load i1 %147
%label144not = icmp uge i32 %145, %146, !dbg !80
br label %189

; <label>:189
%label189 = load i1 %label22
%label189 = and i1 %label189, %label144
br i1 %label189, label %148, label %190

; <label>:148                                     ; preds = %144
%149 = load i32* getelementptr inbounds ([256 x i32]* @_ZZ15hamming_matcherPjS_jjE6s_dist, i32 0, i64 0), align 4, !dbg !81
%150 = load i32* %j, align 4, !dbg !81
%151 = load i32* getelementptr inbounds (%struct.dim3* @gridDim, i32 0, i32 0), align 4, !dbg !81
%152 = mul i32 %150, %151, !dbg !81
%153 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 0), align 4, !dbg !81
%154 = add i32 %152, %153, !dbg !81
%155 = zext i32 %154 to i64, !dbg !81
%156 = load i32** %2, align 8, !dbg !81
%157 = getelementptr inbounds i32* %156, i64 %155, !dbg !81
store i32 %149, i32* %157, align 4, !dbg !81
%158 = load i32* getelementptr inbounds ([256 x i32]* @_ZZ15hamming_matcherPjS_jjE5s_idx, i32 0, i64 0), align 4, !dbg !83
%159 = load i32* %j, align 4, !dbg !83
%160 = load i32* getelementptr inbounds (%struct.dim3* @gridDim, i32 0, i32 0), align 4, !dbg !83
%161 = mul i32 %159, %160, !dbg !83
%162 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 0), align 4, !dbg !83
%163 = add i32 %161, %162, !dbg !83
%164 = zext i32 %163 to i64, !dbg !83
%165 = load i32** %1, align 8, !dbg !83
%166 = getelementptr inbounds i32* %165, i64 %164, !dbg !83
store i32 %158, i32* %166, align 4, !dbg !83
br label %190

; <label>:190
call void @__syncthreads(), 1
%label190 = load i1 %label22
br i1 %label190, label %167, label %191

; <label>:167                                     ; preds = %148, %144
br label %191

; <label>:191
%label191 = load i1 %label22
br i1 %label191, label %168, label %192

; <label>:168                                     ; preds = %167
%169 = load i32* %j, align 4, !dbg !43
%170 = add i32 %169, 1, !dbg !43
store i32 %170, i32* %j, align 4, !dbg !43
br label %22, !dbg !43
br label %192

; <label>:192
br label %171

; <label>:171                                     ; preds = %22
ret void, !dbg !86


}