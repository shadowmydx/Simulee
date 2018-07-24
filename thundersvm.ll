define void @_Z19nu_smo_solve_kernelPKiPfS1_S1_S0_ifPKfS3_ifS1_(i32* %label, float* %f_values, float* %alpha, float* %alpha_diff, i32* %working_set, i32 %ws_size, float %C, float* %k_mat_rows, float* %k_mat_diag, i32 %row_len, float %eps, float* %diff_and_bias) uwtable noinline {
  %1 = alloca i32*, align 8
  %2 = alloca float*, align 8
  %3 = alloca float*, align 8
  %4 = alloca float*, align 8
  %5 = alloca i32*, align 8
  %6 = alloca i32, align 4
  %7 = alloca float, align 4
  %8 = alloca float*, align 8
  %9 = alloca float*, align 8
  %10 = alloca i32, align 4
  %11 = alloca float, align 4
  %12 = alloca float*, align 8
  %f_idx2reduce = alloca i32*, align 8
  %f_val2reduce = alloca float*, align 8
  %alpha_i_diff = alloca float*, align 8
  %alpha_j_diff = alloca float*, align 8
  %kd = alloca float*, align 8
  %tid = alloca i32, align 4
  %wsi = alloca i32, align 4
  %y = alloca float, align 4
  %f = alloca float, align 4
  %a = alloca float, align 4
  %aold = alloca float, align 4
  %local_eps = alloca float, align 4
  %numOfIter = alloca i32, align 4
  %ip = alloca i32, align 4
  %up_value_p = alloca float, align 4
  %kIpwsI = alloca float, align 4
  %in = alloca i32, align 4
  %up_value_n = alloca float, align 4
  %kInwsI = alloca float, align 4
  %j1p = alloca i32, align 4
  %low_value_p = alloca float, align 4
  %j1n = alloca i32, align 4
  %low_value_n = alloca float, align 4
  %local_diff = alloca float, align 4
  %aIJ = alloca float, align 4
  %bIJ = alloca float, align 4
  %j2p = alloca i32, align 4
  %f_val_j2p = alloca float, align 4
  %aIJ1 = alloca float, align 4
  %bIJ2 = alloca float, align 4
  %j2n = alloca i32, align 4
  %i = alloca i32, align 4
  %j2 = alloca i32, align 4
  %up_value = alloca float, align 4
  %kIwsI = alloca float, align 4
  %l = alloca float, align 4
  %kJ2wsI = alloca float, align 4
  store i32* %label, i32** %1, align 8
  call void @llvm.dbg.declare(metadata !{i32** %1}, metadata !201), !dbg !202
  store float* %f_values, float** %2, align 8
  call void @llvm.dbg.declare(metadata !{float** %2}, metadata !203), !dbg !202
  store float* %alpha, float** %3, align 8
  call void @llvm.dbg.declare(metadata !{float** %3}, metadata !204), !dbg !202
  store float* %alpha_diff, float** %4, align 8
  call void @llvm.dbg.declare(metadata !{float** %4}, metadata !205), !dbg !202
  store i32* %working_set, i32** %5, align 8
  call void @llvm.dbg.declare(metadata !{i32** %5}, metadata !206), !dbg !202
  store i32 %ws_size, i32* %6, align 4
  call void @llvm.dbg.declare(metadata !{i32* %6}, metadata !207), !dbg !208
  store float %C, float* %7, align 4
  call void @llvm.dbg.declare(metadata !{float* %7}, metadata !209), !dbg !208
  store float* %k_mat_rows, float** %8, align 8
  call void @llvm.dbg.declare(metadata !{float** %8}, metadata !210), !dbg !208
  store float* %k_mat_diag, float** %9, align 8
  call void @llvm.dbg.declare(metadata !{float** %9}, metadata !211), !dbg !208
  store i32 %row_len, i32* %10, align 4
  call void @llvm.dbg.declare(metadata !{i32* %10}, metadata !212), !dbg !208
  store float %eps, float* %11, align 4
  call void @llvm.dbg.declare(metadata !{float* %11}, metadata !213), !dbg !208
  store float* %diff_and_bias, float** %12, align 8
  call void @llvm.dbg.declare(metadata !{float** %12}, metadata !214), !dbg !215
  call void @llvm.dbg.declare(metadata !{i32** %f_idx2reduce}, metadata !216), !dbg !218
  store i32* getelementptr inbounds ([256 x i32]* @_ZZ19nu_smo_solve_kernelPKiPfS1_S1_S0_ifPKfS3_ifS1_E10shared_mem, i32 0, i32 0), i32** %f_idx2reduce, align 8, !dbg !218
  call void @llvm.dbg.declare(metadata !{float** %f_val2reduce}, metadata !219), !dbg !220
  %13 = load i32* %6, align 4, !dbg !220
  %14 = sext i32 %13 to i64, !dbg !220
  %15 = load i32** %f_idx2reduce, align 8, !dbg !220
  %16 = getelementptr inbounds i32* %15, i64 %14, !dbg !220
  %17 = bitcast i32* %16 to float*, !dbg !220
  store float* %17, float** %f_val2reduce, align 8, !dbg !220
  call void @llvm.dbg.declare(metadata !{float** %alpha_i_diff}, metadata !221), !dbg !222
  %18 = load i32* %6, align 4, !dbg !222
  %19 = sext i32 %18 to i64, !dbg !222
  %20 = load float** %f_val2reduce, align 8, !dbg !222
  %21 = getelementptr inbounds float* %20, i64 %19, !dbg !222
  store float* %21, float** %alpha_i_diff, align 8, !dbg !222
  call void @llvm.dbg.declare(metadata !{float** %alpha_j_diff}, metadata !223), !dbg !224
  %22 = load float** %alpha_i_diff, align 8, !dbg !224
  %23 = getelementptr inbounds float* %22, i64 1, !dbg !224
  store float* %23, float** %alpha_j_diff, align 8, !dbg !224
  call void @llvm.dbg.declare(metadata !{float** %kd}, metadata !225), !dbg !226
  %24 = load float** %alpha_j_diff, align 8, !dbg !226
  %25 = getelementptr inbounds float* %24, i64 1, !dbg !226
  store float* %25, float** %kd, align 8, !dbg !226
  call void @llvm.dbg.declare(metadata !{i32* %tid}, metadata !227), !dbg !228
  %26 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !228
  store i32 %26, i32* %tid, align 4, !dbg !228
  call void @llvm.dbg.declare(metadata !{i32* %wsi}, metadata !229), !dbg !230
  %27 = load i32* %tid, align 4, !dbg !230
  %28 = sext i32 %27 to i64, !dbg !230
  %29 = load i32** %5, align 8, !dbg !230
  %30 = getelementptr inbounds i32* %29, i64 %28, !dbg !230
  %31 = load i32* %30, align 4, !dbg !230
  store i32 %31, i32* %wsi, align 4, !dbg !230
  %32 = load i32* %wsi, align 4, !dbg !231
  %33 = sext i32 %32 to i64, !dbg !231
  %34 = load float** %9, align 8, !dbg !231
  %35 = getelementptr inbounds float* %34, i64 %33, !dbg !231
  %36 = load float* %35, align 4, !dbg !231
  %37 = load i32* %tid, align 4, !dbg !231
  %38 = sext i32 %37 to i64, !dbg !231
  %39 = load float** %kd, align 8, !dbg !231
  %40 = getelementptr inbounds float* %39, i64 %38, !dbg !231
  store float %36, float* %40, align 4, !dbg !231
  call void @llvm.dbg.declare(metadata !{float* %y}, metadata !232), !dbg !233
  %41 = load i32* %wsi, align 4, !dbg !233
  %42 = sext i32 %41 to i64, !dbg !233
  %43 = load i32** %1, align 8, !dbg !233
  %44 = getelementptr inbounds i32* %43, i64 %42, !dbg !233
  %45 = load i32* %44, align 4, !dbg !233
  %46 = sitofp i32 %45 to float, !dbg !233
  store float %46, float* %y, align 4, !dbg !233
  call void @llvm.dbg.declare(metadata !{float* %f}, metadata !234), !dbg !235
  %47 = load i32* %wsi, align 4, !dbg !235
  %48 = sext i32 %47 to i64, !dbg !235
  %49 = load float** %2, align 8, !dbg !235
  %50 = getelementptr inbounds float* %49, i64 %48, !dbg !235
  %51 = load float* %50, align 4, !dbg !235
  store float %51, float* %f, align 4, !dbg !235
  call void @llvm.dbg.declare(metadata !{float* %a}, metadata !236), !dbg !237
  %52 = load i32* %wsi, align 4, !dbg !237
  %53 = sext i32 %52 to i64, !dbg !237
  %54 = load float** %3, align 8, !dbg !237
  %55 = getelementptr inbounds float* %54, i64 %53, !dbg !237
  %56 = load float* %55, align 4, !dbg !237
  store float %56, float* %a, align 4, !dbg !237
  call void @llvm.dbg.declare(metadata !{float* %aold}, metadata !238), !dbg !239
  %57 = load float* %a, align 4, !dbg !239
  store float %57, float* %aold, align 4, !dbg !239
  call void @__syncthreads(), !dbg !240
  call void @llvm.dbg.declare(metadata !{float* %local_eps}, metadata !241), !dbg !242
  call void @llvm.dbg.declare(metadata !{i32* %numOfIter}, metadata !243), !dbg !244
  store i32 0, i32* %numOfIter, align 4, !dbg !244
  br label %58, !dbg !245

; <label>:58                                      ; preds = %430, %0
  %59 = load float* %y, align 4, !dbg !246
  %60 = fcmp ogt float %59, 0.000000e+00, !dbg !246
  br i1 %60, label %61, label %72, !dbg !246

; <label>:61                                      ; preds = %58
  %62 = load float* %a, align 4, !dbg !246
  %63 = load float* %y, align 4, !dbg !246
  %64 = load float* %7, align 4, !dbg !246
  %65 = call zeroext i1 @_Z7is_I_upfff(float %62, float %63, float %64), !dbg !246
  br i1 %65, label %66, label %72, !dbg !246

; <label>:66                                      ; preds = %61
  %67 = load float* %f, align 4, !dbg !248
  %68 = load i32* %tid, align 4, !dbg !248
  %69 = sext i32 %68 to i64, !dbg !248
  %70 = load float** %f_val2reduce, align 8, !dbg !248
  %71 = getelementptr inbounds float* %70, i64 %69, !dbg !248
  store float %67, float* %71, align 4, !dbg !248
  br label %77, !dbg !248

; <label>:72                                      ; preds = %61, %58
  %73 = load i32* %tid, align 4, !dbg !249
  %74 = sext i32 %73 to i64, !dbg !249
  %75 = load float** %f_val2reduce, align 8, !dbg !249
  %76 = getelementptr inbounds float* %75, i64 %74, !dbg !249
  store float 0x7FF0000000000000, float* %76, align 4, !dbg !249
  br label %77

; <label>:77                                      ; preds = %72, %66
  call void @llvm.dbg.declare(metadata !{i32* %ip}, metadata !250), !dbg !251
  %78 = load float** %f_val2reduce, align 8, !dbg !251
  %79 = load i32** %f_idx2reduce, align 8, !dbg !251
  %80 = call i32 @_Z13get_block_minPKfPi(float* %78, i32* %79), !dbg !251
  store i32 %80, i32* %ip, align 4, !dbg !251
  call void @llvm.dbg.declare(metadata !{float* %up_value_p}, metadata !252), !dbg !253
  %81 = load i32* %ip, align 4, !dbg !253
  %82 = sext i32 %81 to i64, !dbg !253
  %83 = load float** %f_val2reduce, align 8, !dbg !253
  %84 = getelementptr inbounds float* %83, i64 %82, !dbg !253
  %85 = load float* %84, align 4, !dbg !253
  store float %85, float* %up_value_p, align 4, !dbg !253
  call void @llvm.dbg.declare(metadata !{float* %kIpwsI}, metadata !254), !dbg !255
  %86 = load i32* %10, align 4, !dbg !255
  %87 = load i32* %ip, align 4, !dbg !255
  %88 = mul nsw i32 %86, %87, !dbg !255
  %89 = load i32* %wsi, align 4, !dbg !255
  %90 = add nsw i32 %88, %89, !dbg !255
  %91 = sext i32 %90 to i64, !dbg !255
  %92 = load float** %8, align 8, !dbg !255
  %93 = getelementptr inbounds float* %92, i64 %91, !dbg !255
  %94 = load float* %93, align 4, !dbg !255
  store float %94, float* %kIpwsI, align 4, !dbg !255
  call void @__syncthreads(), !dbg !256
  %95 = load float* %y, align 4, !dbg !257
  %96 = fcmp olt float %95, 0.000000e+00, !dbg !257
  br i1 %96, label %97, label %108, !dbg !257

; <label>:97                                      ; preds = %77
  %98 = load float* %a, align 4, !dbg !257
  %99 = load float* %y, align 4, !dbg !257
  %100 = load float* %7, align 4, !dbg !257
  %101 = call zeroext i1 @_Z7is_I_upfff(float %98, float %99, float %100), !dbg !257
  br i1 %101, label %102, label %108, !dbg !257

; <label>:102                                     ; preds = %97
  %103 = load float* %f, align 4, !dbg !258
  %104 = load i32* %tid, align 4, !dbg !258
  %105 = sext i32 %104 to i64, !dbg !258
  %106 = load float** %f_val2reduce, align 8, !dbg !258
  %107 = getelementptr inbounds float* %106, i64 %105, !dbg !258
  store float %103, float* %107, align 4, !dbg !258
  br label %113, !dbg !258

; <label>:108                                     ; preds = %97, %77
  %109 = load i32* %tid, align 4, !dbg !259
  %110 = sext i32 %109 to i64, !dbg !259
  %111 = load float** %f_val2reduce, align 8, !dbg !259
  %112 = getelementptr inbounds float* %111, i64 %110, !dbg !259
  store float 0x7FF0000000000000, float* %112, align 4, !dbg !259
  br label %113

; <label>:113                                     ; preds = %108, %102
  call void @llvm.dbg.declare(metadata !{i32* %in}, metadata !260), !dbg !261
  %114 = load float** %f_val2reduce, align 8, !dbg !261
  %115 = load i32** %f_idx2reduce, align 8, !dbg !261
  %116 = call i32 @_Z13get_block_minPKfPi(float* %114, i32* %115), !dbg !261
  store i32 %116, i32* %in, align 4, !dbg !261
  call void @llvm.dbg.declare(metadata !{float* %up_value_n}, metadata !262), !dbg !263
  %117 = load i32* %in, align 4, !dbg !263
  %118 = sext i32 %117 to i64, !dbg !263
  %119 = load float** %f_val2reduce, align 8, !dbg !263
  %120 = getelementptr inbounds float* %119, i64 %118, !dbg !263
  %121 = load float* %120, align 4, !dbg !263
  store float %121, float* %up_value_n, align 4, !dbg !263
  call void @llvm.dbg.declare(metadata !{float* %kInwsI}, metadata !264), !dbg !265
  %122 = load i32* %10, align 4, !dbg !265
  %123 = load i32* %in, align 4, !dbg !265
  %124 = mul nsw i32 %122, %123, !dbg !265
  %125 = load i32* %wsi, align 4, !dbg !265
  %126 = add nsw i32 %124, %125, !dbg !265
  %127 = sext i32 %126 to i64, !dbg !265
  %128 = load float** %8, align 8, !dbg !265
  %129 = getelementptr inbounds float* %128, i64 %127, !dbg !265
  %130 = load float* %129, align 4, !dbg !265
  store float %130, float* %kInwsI, align 4, !dbg !265
  call void @__syncthreads(), !dbg !266
  %131 = load float* %y, align 4, !dbg !267
  %132 = fcmp ogt float %131, 0.000000e+00, !dbg !267
  br i1 %132, label %133, label %145, !dbg !267

; <label>:133                                     ; preds = %113
  %134 = load float* %a, align 4, !dbg !267
  %135 = load float* %y, align 4, !dbg !267
  %136 = load float* %7, align 4, !dbg !267
  %137 = call zeroext i1 @_Z8is_I_lowfff(float %134, float %135, float %136), !dbg !267
  br i1 %137, label %138, label %145, !dbg !267

; <label>:138                                     ; preds = %133
  %139 = load float* %f, align 4, !dbg !268
  %140 = fsub float -0.000000e+00, %139, !dbg !268
  %141 = load i32* %tid, align 4, !dbg !268
  %142 = sext i32 %141 to i64, !dbg !268
  %143 = load float** %f_val2reduce, align 8, !dbg !268
  %144 = getelementptr inbounds float* %143, i64 %142, !dbg !268
  store float %140, float* %144, align 4, !dbg !268
  br label %150, !dbg !268

; <label>:145                                     ; preds = %133, %113
  %146 = load i32* %tid, align 4, !dbg !269
  %147 = sext i32 %146 to i64, !dbg !269
  %148 = load float** %f_val2reduce, align 8, !dbg !269
  %149 = getelementptr inbounds float* %148, i64 %147, !dbg !269
  store float 0x7FF0000000000000, float* %149, align 4, !dbg !269
  br label %150

; <label>:150                                     ; preds = %145, %138
  call void @llvm.dbg.declare(metadata !{i32* %j1p}, metadata !270), !dbg !271
  %151 = load float** %f_val2reduce, align 8, !dbg !271
  %152 = load i32** %f_idx2reduce, align 8, !dbg !271
  %153 = call i32 @_Z13get_block_minPKfPi(float* %151, i32* %152), !dbg !271
  store i32 %153, i32* %j1p, align 4, !dbg !271
  call void @llvm.dbg.declare(metadata !{float* %low_value_p}, metadata !272), !dbg !273
  %154 = load i32* %j1p, align 4, !dbg !273
  %155 = sext i32 %154 to i64, !dbg !273
  %156 = load float** %f_val2reduce, align 8, !dbg !273
  %157 = getelementptr inbounds float* %156, i64 %155, !dbg !273
  %158 = load float* %157, align 4, !dbg !273
  %159 = fsub float -0.000000e+00, %158, !dbg !273
  store float %159, float* %low_value_p, align 4, !dbg !273
  %160 = load float* %y, align 4, !dbg !274
  %161 = fcmp olt float %160, 0.000000e+00, !dbg !274
  br i1 %161, label %162, label %174, !dbg !274

; <label>:162                                     ; preds = %150
  %163 = load float* %a, align 4, !dbg !274
  %164 = load float* %y, align 4, !dbg !274
  %165 = load float* %7, align 4, !dbg !274
  %166 = call zeroext i1 @_Z8is_I_lowfff(float %163, float %164, float %165), !dbg !274
  br i1 %166, label %167, label %174, !dbg !274

; <label>:167                                     ; preds = %162
  %168 = load float* %f, align 4, !dbg !275
  %169 = fsub float -0.000000e+00, %168, !dbg !275
  %170 = load i32* %tid, align 4, !dbg !275
  %171 = sext i32 %170 to i64, !dbg !275
  %172 = load float** %f_val2reduce, align 8, !dbg !275
  %173 = getelementptr inbounds float* %172, i64 %171, !dbg !275
  store float %169, float* %173, align 4, !dbg !275
  br label %179, !dbg !275

; <label>:174                                     ; preds = %162, %150
  %175 = load i32* %tid, align 4, !dbg !276
  %176 = sext i32 %175 to i64, !dbg !276
  %177 = load float** %f_val2reduce, align 8, !dbg !276
  %178 = getelementptr inbounds float* %177, i64 %176, !dbg !276
  store float 0x7FF0000000000000, float* %178, align 4, !dbg !276
  br label %179

; <label>:179                                     ; preds = %174, %167
  call void @llvm.dbg.declare(metadata !{i32* %j1n}, metadata !277), !dbg !278
  %180 = load float** %f_val2reduce, align 8, !dbg !278
  %181 = load i32** %f_idx2reduce, align 8, !dbg !278
  %182 = call i32 @_Z13get_block_minPKfPi(float* %180, i32* %181), !dbg !278
  store i32 %182, i32* %j1n, align 4, !dbg !278
  call void @llvm.dbg.declare(metadata !{float* %low_value_n}, metadata !279), !dbg !280
  %183 = load i32* %j1n, align 4, !dbg !280
  %184 = sext i32 %183 to i64, !dbg !280
  %185 = load float** %f_val2reduce, align 8, !dbg !280
  %186 = getelementptr inbounds float* %185, i64 %184, !dbg !280
  %187 = load float* %186, align 4, !dbg !280
  %188 = fsub float -0.000000e+00, %187, !dbg !280
  store float %188, float* %low_value_n, align 4, !dbg !280
  call void @llvm.dbg.declare(metadata !{float* %local_diff}, metadata !281), !dbg !282
  %189 = load float* %low_value_p, align 4, !dbg !282
  %190 = load float* %up_value_p, align 4, !dbg !282
  %191 = fsub float %189, %190, !dbg !282
  %192 = load float* %low_value_n, align 4, !dbg !282
  %193 = load float* %up_value_n, align 4, !dbg !282
  %194 = fsub float %192, %193, !dbg !282
  %195 = call float @_ZL3maxff(float %191, float %194), !dbg !282
  store float %195, float* %local_diff, align 4, !dbg !282
  %196 = load i32* %numOfIter, align 4, !dbg !283
  %197 = icmp eq i32 %196, 0, !dbg !283
  br i1 %197, label %198, label %203, !dbg !283

; <label>:198                                     ; preds = %179
  %199 = load float* %11, align 4, !dbg !284
  %200 = load float* %local_diff, align 4, !dbg !284
  %201 = fmul float 0x3FB99999A0000000, %200, !dbg !284
  %202 = call float @_ZL3maxff(float %199, float %201), !dbg !284
  store float %202, float* %local_eps, align 4, !dbg !284
  br label %203, !dbg !286

; <label>:203                                     ; preds = %198, %179
  %204 = load float* %local_diff, align 4, !dbg !287
  %205 = load float* %local_eps, align 4, !dbg !287
  %206 = fcmp olt float %204, %205, !dbg !287
  br i1 %206, label %207, label %230, !dbg !287

; <label>:207                                     ; preds = %203
  %208 = load float* %a, align 4, !dbg !288
  %209 = load i32* %wsi, align 4, !dbg !288
  %210 = sext i32 %209 to i64, !dbg !288
  %211 = load float** %3, align 8, !dbg !288
  %212 = getelementptr inbounds float* %211, i64 %210, !dbg !288
  store float %208, float* %212, align 4, !dbg !288
  %213 = load float* %a, align 4, !dbg !290
  %214 = load float* %aold, align 4, !dbg !290
  %215 = fsub float %213, %214, !dbg !290
  %216 = fsub float -0.000000e+00, %215, !dbg !290
  %217 = load float* %y, align 4, !dbg !290
  %218 = fmul float %216, %217, !dbg !290
  %219 = load i32* %tid, align 4, !dbg !290
  %220 = sext i32 %219 to i64, !dbg !290
  %221 = load float** %4, align 8, !dbg !290
  %222 = getelementptr inbounds float* %221, i64 %220, !dbg !290
  store float %218, float* %222, align 4, !dbg !290
  %223 = load i32* %tid, align 4, !dbg !291
  %224 = icmp eq i32 %223, 0, !dbg !291
  br i1 %224, label %225, label %229, !dbg !291

; <label>:225                                     ; preds = %207
  %226 = load float* %local_diff, align 4, !dbg !292
  %227 = load float** %12, align 8, !dbg !292
  %228 = getelementptr inbounds float* %227, i64 0, !dbg !292
  store float %226, float* %228, align 4, !dbg !292
  br label %229, !dbg !294

; <label>:229                                     ; preds = %225, %207
  br label %449, !dbg !295

; <label>:230                                     ; preds = %203
  call void @__syncthreads(), !dbg !296
  %231 = load float* %up_value_p, align 4, !dbg !297
  %232 = fsub float -0.000000e+00, %231, !dbg !297
  %233 = load float* %f, align 4, !dbg !297
  %234 = fsub float -0.000000e+00, %233, !dbg !297
  %235 = fcmp ogt float %232, %234, !dbg !297
  br i1 %235, label %236, label %273, !dbg !297

; <label>:236                                     ; preds = %230
  %237 = load float* %y, align 4, !dbg !297
  %238 = fcmp ogt float %237, 0.000000e+00, !dbg !297
  br i1 %238, label %239, label %273, !dbg !297

; <label>:239                                     ; preds = %236
  %240 = load float* %a, align 4, !dbg !297
  %241 = load float* %y, align 4, !dbg !297
  %242 = load float* %7, align 4, !dbg !297
  %243 = call zeroext i1 @_Z8is_I_lowfff(float %240, float %241, float %242), !dbg !297
  br i1 %243, label %244, label %273, !dbg !297

; <label>:244                                     ; preds = %239
  call void @llvm.dbg.declare(metadata !{float* %aIJ}, metadata !298), !dbg !300
  %245 = load i32* %ip, align 4, !dbg !300
  %246 = sext i32 %245 to i64, !dbg !300
  %247 = load float** %kd, align 8, !dbg !300
  %248 = getelementptr inbounds float* %247, i64 %246, !dbg !300
  %249 = load float* %248, align 4, !dbg !300
  %250 = load i32* %tid, align 4, !dbg !300
  %251 = sext i32 %250 to i64, !dbg !300
  %252 = load float** %kd, align 8, !dbg !300
  %253 = getelementptr inbounds float* %252, i64 %251, !dbg !300
  %254 = load float* %253, align 4, !dbg !300
  %255 = fadd float %249, %254, !dbg !300
  %256 = load float* %kIpwsI, align 4, !dbg !300
  %257 = fmul float 2.000000e+00, %256, !dbg !300
  %258 = fsub float %255, %257, !dbg !300
  store float %258, float* %aIJ, align 4, !dbg !300
  call void @llvm.dbg.declare(metadata !{float* %bIJ}, metadata !301), !dbg !302
  %259 = load float* %up_value_p, align 4, !dbg !302
  %260 = fsub float -0.000000e+00, %259, !dbg !302
  %261 = load float* %f, align 4, !dbg !302
  %262 = fadd float %260, %261, !dbg !302
  store float %262, float* %bIJ, align 4, !dbg !302
  %263 = load float* %bIJ, align 4, !dbg !303
  %264 = fsub float -0.000000e+00, %263, !dbg !303
  %265 = load float* %bIJ, align 4, !dbg !303
  %266 = fmul float %264, %265, !dbg !303
  %267 = load float* %aIJ, align 4, !dbg !303
  %268 = fdiv float %266, %267, !dbg !303
  %269 = load i32* %tid, align 4, !dbg !303
  %270 = sext i32 %269 to i64, !dbg !303
  %271 = load float** %f_val2reduce, align 8, !dbg !303
  %272 = getelementptr inbounds float* %271, i64 %270, !dbg !303
  store float %268, float* %272, align 4, !dbg !303
  br label %278, !dbg !304

; <label>:273                                     ; preds = %239, %236, %230
  %274 = load i32* %tid, align 4, !dbg !305
  %275 = sext i32 %274 to i64, !dbg !305
  %276 = load float** %f_val2reduce, align 8, !dbg !305
  %277 = getelementptr inbounds float* %276, i64 %275, !dbg !305
  store float 0x7FF0000000000000, float* %277, align 4, !dbg !305
  br label %278

; <label>:278                                     ; preds = %273, %244
  call void @llvm.dbg.declare(metadata !{i32* %j2p}, metadata !306), !dbg !307
  %279 = load float** %f_val2reduce, align 8, !dbg !307
  %280 = load i32** %f_idx2reduce, align 8, !dbg !307
  %281 = call i32 @_Z13get_block_minPKfPi(float* %279, i32* %280), !dbg !307
  store i32 %281, i32* %j2p, align 4, !dbg !307
  call void @llvm.dbg.declare(metadata !{float* %f_val_j2p}, metadata !308), !dbg !309
  %282 = load i32* %j2p, align 4, !dbg !309
  %283 = sext i32 %282 to i64, !dbg !309
  %284 = load float** %f_val2reduce, align 8, !dbg !309
  %285 = getelementptr inbounds float* %284, i64 %283, !dbg !309
  %286 = load float* %285, align 4, !dbg !309
  store float %286, float* %f_val_j2p, align 4, !dbg !309
  %287 = load float* %up_value_n, align 4, !dbg !310
  %288 = fsub float -0.000000e+00, %287, !dbg !310
  %289 = load float* %f, align 4, !dbg !310
  %290 = fsub float -0.000000e+00, %289, !dbg !310
  %291 = fcmp ogt float %288, %290, !dbg !310
  br i1 %291, label %292, label %329, !dbg !310

; <label>:292                                     ; preds = %278
  %293 = load float* %y, align 4, !dbg !310
  %294 = fcmp olt float %293, 0.000000e+00, !dbg !310
  br i1 %294, label %295, label %329, !dbg !310

; <label>:295                                     ; preds = %292
  %296 = load float* %a, align 4, !dbg !310
  %297 = load float* %y, align 4, !dbg !310
  %298 = load float* %7, align 4, !dbg !310
  %299 = call zeroext i1 @_Z8is_I_lowfff(float %296, float %297, float %298), !dbg !310
  br i1 %299, label %300, label %329, !dbg !310

; <label>:300                                     ; preds = %295
  call void @llvm.dbg.declare(metadata !{float* %aIJ1}, metadata !311), !dbg !313
  %301 = load i32* %in, align 4, !dbg !313
  %302 = sext i32 %301 to i64, !dbg !313
  %303 = load float** %kd, align 8, !dbg !313
  %304 = getelementptr inbounds float* %303, i64 %302, !dbg !313
  %305 = load float* %304, align 4, !dbg !313
  %306 = load i32* %tid, align 4, !dbg !313
  %307 = sext i32 %306 to i64, !dbg !313
  %308 = load float** %kd, align 8, !dbg !313
  %309 = getelementptr inbounds float* %308, i64 %307, !dbg !313
  %310 = load float* %309, align 4, !dbg !313
  %311 = fadd float %305, %310, !dbg !313
  %312 = load float* %kInwsI, align 4, !dbg !313
  %313 = fmul float 2.000000e+00, %312, !dbg !313
  %314 = fsub float %311, %313, !dbg !313
  store float %314, float* %aIJ1, align 4, !dbg !313
  call void @llvm.dbg.declare(metadata !{float* %bIJ2}, metadata !314), !dbg !315
  %315 = load float* %up_value_n, align 4, !dbg !315
  %316 = fsub float -0.000000e+00, %315, !dbg !315
  %317 = load float* %f, align 4, !dbg !315
  %318 = fadd float %316, %317, !dbg !315
  store float %318, float* %bIJ2, align 4, !dbg !315
  %319 = load float* %bIJ2, align 4, !dbg !316
  %320 = fsub float -0.000000e+00, %319, !dbg !316
  %321 = load float* %bIJ2, align 4, !dbg !316
  %322 = fmul float %320, %321, !dbg !316
  %323 = load float* %aIJ1, align 4, !dbg !316
  %324 = fdiv float %322, %323, !dbg !316
  %325 = load i32* %tid, align 4, !dbg !316
  %326 = sext i32 %325 to i64, !dbg !316
  %327 = load float** %f_val2reduce, align 8, !dbg !316
  %328 = getelementptr inbounds float* %327, i64 %326, !dbg !316
  store float %324, float* %328, align 4, !dbg !316
  br label %334, !dbg !317

; <label>:329                                     ; preds = %295, %292, %278
  %330 = load i32* %tid, align 4, !dbg !318
  %331 = sext i32 %330 to i64, !dbg !318
  %332 = load float** %f_val2reduce, align 8, !dbg !318
  %333 = getelementptr inbounds float* %332, i64 %331, !dbg !318
  store float 0x7FF0000000000000, float* %333, align 4, !dbg !318
  br label %334

; <label>:334                                     ; preds = %329, %300
  call void @llvm.dbg.declare(metadata !{i32* %j2n}, metadata !319), !dbg !320
  %335 = load float** %f_val2reduce, align 8, !dbg !320
  %336 = load i32** %f_idx2reduce, align 8, !dbg !320
  %337 = call i32 @_Z13get_block_minPKfPi(float* %335, i32* %336), !dbg !320
  store i32 %337, i32* %j2n, align 4, !dbg !320
  call void @llvm.dbg.declare(metadata !{i32* %i}, metadata !321), !dbg !322
  call void @llvm.dbg.declare(metadata !{i32* %j2}, metadata !323), !dbg !322
  call void @llvm.dbg.declare(metadata !{float* %up_value}, metadata !324), !dbg !325
  call void @llvm.dbg.declare(metadata !{float* %kIwsI}, metadata !326), !dbg !327
  %338 = load float* %f_val_j2p, align 4, !dbg !328
  %339 = load i32* %j2n, align 4, !dbg !328
  %340 = sext i32 %339 to i64, !dbg !328
  %341 = load float** %f_val2reduce, align 8, !dbg !328
  %342 = getelementptr inbounds float* %341, i64 %340, !dbg !328
  %343 = load float* %342, align 4, !dbg !328
  %344 = fcmp olt float %338, %343, !dbg !328
  br i1 %344, label %345, label %349, !dbg !328

; <label>:345                                     ; preds = %334
  %346 = load i32* %ip, align 4, !dbg !329
  store i32 %346, i32* %i, align 4, !dbg !329
  %347 = load i32* %j2p, align 4, !dbg !331
  store i32 %347, i32* %j2, align 4, !dbg !331
  %348 = load float* %kIpwsI, align 4, !dbg !332
  store float %348, float* %kIwsI, align 4, !dbg !332
  br label %353, !dbg !333

; <label>:349                                     ; preds = %334
  %350 = load i32* %in, align 4, !dbg !334
  store i32 %350, i32* %i, align 4, !dbg !334
  %351 = load i32* %j2n, align 4, !dbg !336
  store i32 %351, i32* %j2, align 4, !dbg !336
  %352 = load float* %kInwsI, align 4, !dbg !337
  store float %352, float* %kIwsI, align 4, !dbg !337
  br label %353

; <label>:353                                     ; preds = %349, %345
  %354 = load i32* %tid, align 4, !dbg !338
  %355 = load i32* %i, align 4, !dbg !338
  %356 = icmp eq i32 %354, %355, !dbg !338
  br i1 %356, label %357, label %369, !dbg !338

; <label>:357                                     ; preds = %353
  %358 = load float* %y, align 4, !dbg !339
  %359 = fcmp ogt float %358, 0.000000e+00, !dbg !339
  br i1 %359, label %360, label %364, !dbg !339

; <label>:360                                     ; preds = %357
  %361 = load float* %7, align 4, !dbg !339
  %362 = load float* %a, align 4, !dbg !339
  %363 = fsub float %361, %362, !dbg !339
  br label %366, !dbg !339

; <label>:364                                     ; preds = %357
  %365 = load float* %a, align 4, !dbg !339
  br label %366, !dbg !339

; <label>:366                                     ; preds = %364, %360
  %367 = phi float [ %363, %360 ], [ %365, %364 ], !dbg !339
  %368 = load float** %alpha_i_diff, align 8, !dbg !339
  store float %367, float* %368, align 4, !dbg !339
  br label %369, !dbg !339

; <label>:369                                     ; preds = %366, %353
  %370 = load i32* %tid, align 4, !dbg !340
  %371 = load i32* %j2, align 4, !dbg !340
  %372 = icmp eq i32 %370, %371, !dbg !340
  br i1 %372, label %373, label %405, !dbg !340

; <label>:373                                     ; preds = %369
  %374 = load float* %y, align 4, !dbg !341
  %375 = fcmp ogt float %374, 0.000000e+00, !dbg !341
  br i1 %375, label %376, label %378, !dbg !341

; <label>:376                                     ; preds = %373
  %377 = load float* %a, align 4, !dbg !341
  br label %382, !dbg !341

; <label>:378                                     ; preds = %373
  %379 = load float* %7, align 4, !dbg !341
  %380 = load float* %a, align 4, !dbg !341
  %381 = fsub float %379, %380, !dbg !341
  br label %382, !dbg !341

; <label>:382                                     ; preds = %378, %376
  %383 = phi float [ %377, %376 ], [ %381, %378 ], !dbg !341
  %384 = load float* %up_value, align 4, !dbg !341
  %385 = fsub float -0.000000e+00, %384, !dbg !341
  %386 = load float* %f, align 4, !dbg !341
  %387 = fadd float %385, %386, !dbg !341
  %388 = load i32* %i, align 4, !dbg !341
  %389 = sext i32 %388 to i64, !dbg !341
  %390 = load float** %kd, align 8, !dbg !341
  %391 = getelementptr inbounds float* %390, i64 %389, !dbg !341
  %392 = load float* %391, align 4, !dbg !341
  %393 = load i32* %j2, align 4, !dbg !341
  %394 = sext i32 %393 to i64, !dbg !341
  %395 = load float** %kd, align 8, !dbg !341
  %396 = getelementptr inbounds float* %395, i64 %394, !dbg !341
  %397 = load float* %396, align 4, !dbg !341
  %398 = fadd float %392, %397, !dbg !341
  %399 = load float* %kIwsI, align 4, !dbg !341
  %400 = fmul float 2.000000e+00, %399, !dbg !341
  %401 = fsub float %398, %400, !dbg !341
  %402 = fdiv float %387, %401, !dbg !341
  %403 = call float @_ZL3minff(float %383, float %402), !dbg !341
  %404 = load float** %alpha_j_diff, align 8, !dbg !341
  store float %403, float* %404, align 4, !dbg !341
  br label %405, !dbg !341

; <label>:405                                     ; preds = %382, %369
  call void @__syncthreads(), !dbg !342
  call void @llvm.dbg.declare(metadata !{float* %l}, metadata !343), !dbg !344
  %406 = load float** %alpha_i_diff, align 8, !dbg !344
  %407 = load float* %406, align 4, !dbg !344
  %408 = load float** %alpha_j_diff, align 8, !dbg !344
  %409 = load float* %408, align 4, !dbg !344
  %410 = call float @_ZL3minff(float %407, float %409), !dbg !344
  store float %410, float* %l, align 4, !dbg !344
  %411 = load i32* %tid, align 4, !dbg !345
  %412 = load i32* %i, align 4, !dbg !345
  %413 = icmp eq i32 %411, %412, !dbg !345
  br i1 %413, label %414, label %420, !dbg !345

; <label>:414                                     ; preds = %405
  %415 = load float* %l, align 4, !dbg !346
  %416 = load float* %y, align 4, !dbg !346
  %417 = fmul float %415, %416, !dbg !346
  %418 = load float* %a, align 4, !dbg !346
  %419 = fadd float %418, %417, !dbg !346
  store float %419, float* %a, align 4, !dbg !346
  br label %420, !dbg !346

; <label>:420                                     ; preds = %414, %405
  %421 = load i32* %tid, align 4, !dbg !347
  %422 = load i32* %j2, align 4, !dbg !347
  %423 = icmp eq i32 %421, %422, !dbg !347
  br i1 %423, label %424, label %430, !dbg !347

; <label>:424                                     ; preds = %420
  %425 = load float* %l, align 4, !dbg !348
  %426 = load float* %y, align 4, !dbg !348
  %427 = fmul float %425, %426, !dbg !348
  %428 = load float* %a, align 4, !dbg !348
  %429 = fsub float %428, %427, !dbg !348
  store float %429, float* %a, align 4, !dbg !348
  br label %430, !dbg !348

; <label>:430                                     ; preds = %424, %420
  call void @llvm.dbg.declare(metadata !{float* %kJ2wsI}, metadata !349), !dbg !350
  %431 = load i32* %10, align 4, !dbg !350
  %432 = load i32* %j2, align 4, !dbg !350
  %433 = mul nsw i32 %431, %432, !dbg !350
  %434 = load i32* %wsi, align 4, !dbg !350
  %435 = add nsw i32 %433, %434, !dbg !350
  %436 = sext i32 %435 to i64, !dbg !350
  %437 = load float** %8, align 8, !dbg !350
  %438 = getelementptr inbounds float* %437, i64 %436, !dbg !350
  %439 = load float* %438, align 4, !dbg !350
  store float %439, float* %kJ2wsI, align 4, !dbg !350
  %440 = load float* %l, align 4, !dbg !351
  %441 = load float* %kJ2wsI, align 4, !dbg !351
  %442 = load float* %kIwsI, align 4, !dbg !351
  %443 = fsub float %441, %442, !dbg !351
  %444 = fmul float %440, %443, !dbg !351
  %445 = load float* %f, align 4, !dbg !351
  %446 = fsub float %445, %444, !dbg !351
  store float %446, float* %f, align 4, !dbg !351
  %447 = load i32* %numOfIter, align 4, !dbg !352
  %448 = add nsw i32 %447, 1, !dbg !352
  store i32 %448, i32* %numOfIter, align 4, !dbg !352
  br label %58, !dbg !353

; <label>:449                                     ; preds = %229
  ret void, !dbg !354
}

define float @_ZL3minff(float %value1, float %value2) {
  ret float %value1
}

define float @_ZL3maxff(float %value1, float %value2) {
  ret float %value1
}


define i32 @_Z13get_block_minPKfPi(float* %values, i32* %index) uwtable section "__device__" {
  %1 = alloca float*, align 8
  %2 = alloca i32*, align 8
  %tid = alloca i32, align 4
  %offset = alloca i32, align 4
  store float* %values, float** %1, align 8
  call void @llvm.dbg.declare(metadata !{float** %1}, metadata !47), !dbg !48
  store i32* %index, i32** %2, align 8
  call void @llvm.dbg.declare(metadata !{i32** %2}, metadata !49), !dbg !48
  call void @llvm.dbg.declare(metadata !{i32* %tid}, metadata !50), !dbg !52
  %3 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !52
  store i32 %3, i32* %tid, align 4, !dbg !52
  %4 = load i32* %tid, align 4, !dbg !53
  %5 = load i32* %tid, align 4, !dbg !53
  %6 = sext i32 %5 to i64, !dbg !53
  %7 = load i32** %2, align 8, !dbg !53
  %8 = getelementptr inbounds i32* %7, i64 %6, !dbg !53
  store i32 %4, i32* %8, align 4, !dbg !53
  call void @__syncthreads(), !dbg !54
  call void @llvm.dbg.declare(metadata !{i32* %offset}, metadata !55), !dbg !57
  %9 = load i32* getelementptr inbounds (%struct.dim3* @blockDim, i32 0, i32 0), align 4, !dbg !57
  %10 = udiv i32 %9, 2, !dbg !57
  store i32 %10, i32* %offset, align 4, !dbg !57
  br label %11, !dbg !57

; <label>:11                                      ; preds = %54, %0
  %12 = load i32* %offset, align 4, !dbg !57
  %13 = icmp sgt i32 %12, 0, !dbg !57
  br i1 %13, label %14, label %57, !dbg !57

; <label>:14                                      ; preds = %11
  %15 = load i32* %tid, align 4, !dbg !58
  %16 = load i32* %offset, align 4, !dbg !58
  %17 = icmp slt i32 %15, %16, !dbg !58
  br i1 %17, label %18, label %53, !dbg !58

; <label>:18                                      ; preds = %14
  %19 = load i32* %tid, align 4, !dbg !60
  %20 = load i32* %offset, align 4, !dbg !60
  %21 = add nsw i32 %19, %20, !dbg !60
  %22 = sext i32 %21 to i64, !dbg !60
  %23 = load i32** %2, align 8, !dbg !60
  %24 = getelementptr inbounds i32* %23, i64 %22, !dbg !60
  %25 = load i32* %24, align 4, !dbg !60
  %26 = sext i32 %25 to i64, !dbg !60
  %27 = load float** %1, align 8, !dbg !60
  %28 = getelementptr inbounds float* %27, i64 %26, !dbg !60
  %29 = load float* %28, align 4, !dbg !60
  %30 = load i32* %tid, align 4, !dbg !60
  %31 = sext i32 %30 to i64, !dbg !60
  %32 = load i32** %2, align 8, !dbg !60
  %33 = getelementptr inbounds i32* %32, i64 %31, !dbg !60
  %34 = load i32* %33, align 4, !dbg !60
  %35 = sext i32 %34 to i64, !dbg !60
  %36 = load float** %1, align 8, !dbg !60
  %37 = getelementptr inbounds float* %36, i64 %35, !dbg !60
  %38 = load float* %37, align 4, !dbg !60
  %39 = fcmp olt float %29, %38, !dbg !60
  br i1 %39, label %40, label %52, !dbg !60

; <label>:40                                      ; preds = %18
  %41 = load i32* %tid, align 4, !dbg !62
  %42 = load i32* %offset, align 4, !dbg !62
  %43 = add nsw i32 %41, %42, !dbg !62
  %44 = sext i32 %43 to i64, !dbg !62
  %45 = load i32** %2, align 8, !dbg !62
  %46 = getelementptr inbounds i32* %45, i64 %44, !dbg !62
  %47 = load i32* %46, align 4, !dbg !62
  %48 = load i32* %tid, align 4, !dbg !62
  %49 = sext i32 %48 to i64, !dbg !62
  %50 = load i32** %2, align 8, !dbg !62
  %51 = getelementptr inbounds i32* %50, i64 %49, !dbg !62
  store i32 %47, i32* %51, align 4, !dbg !62
  br label %52, !dbg !64

; <label>:52                                      ; preds = %40, %18
  br label %53, !dbg !65

; <label>:53                                      ; preds = %52, %14
  call void @__syncthreads(), !dbg !66
  br label %54, !dbg !67

; <label>:54                                      ; preds = %53
  %55 = load i32* %offset, align 4, !dbg !57
  %56 = ashr i32 %55, 1, !dbg !57
  store i32 %56, i32* %offset, align 4, !dbg !57
  br label %11, !dbg !57

; <label>:57                                      ; preds = %11
  %58 = load i32** %2, align 8, !dbg !68
  %59 = getelementptr inbounds i32* %58, i64 0, !dbg !68
  %60 = load i32* %59, align 4, !dbg !68
  ret i32 %60, !dbg !68
}
define zeroext i1 @_Z7is_I_upfff(float %a, float %y, float %C) nounwind uwtable section "__device__" {
  %1 = alloca float, align 4
  %2 = alloca float, align 4
  %3 = alloca float, align 4
  store float %a, float* %1, align 4
  call void @llvm.dbg.declare(metadata !{float* %1}, metadata !69), !dbg !70
  store float %y, float* %2, align 4
  call void @llvm.dbg.declare(metadata !{float* %2}, metadata !71), !dbg !70
  store float %C, float* %3, align 4
  call void @llvm.dbg.declare(metadata !{float* %3}, metadata !72), !dbg !70
  %4 = load float* %2, align 4, !dbg !73
  %5 = fcmp ogt float %4, 0.000000e+00, !dbg !73
  br i1 %5, label %6, label %10, !dbg !73

; <label>:6                                       ; preds = %0
  %7 = load float* %1, align 4, !dbg !73
  %8 = load float* %3, align 4, !dbg !73
  %9 = fcmp olt float %7, %8, !dbg !73
  br i1 %9, label %18, label %10, !dbg !73

; <label>:10                                      ; preds = %6, %0
  %11 = load float* %2, align 4, !dbg !73
  %12 = fcmp olt float %11, 0.000000e+00, !dbg !73
  br i1 %12, label %13, label %16, !dbg !73

; <label>:13                                      ; preds = %10
  %14 = load float* %1, align 4, !dbg !73
  %15 = fcmp ogt float %14, 0.000000e+00, !dbg !73
  br label %16

; <label>:16                                      ; preds = %13, %10
  %17 = phi i1 [ false, %10 ], [ %15, %13 ]
  br label %18

; <label>:18                                      ; preds = %16, %6
  %19 = phi i1 [ true, %6 ], [ %17, %16 ]
  ret i1 %19, !dbg !75
}

define zeroext i1 @_Z8is_I_lowfff(float %a, float %y, float %C) nounwind uwtable section "__device__" {
  %1 = alloca float, align 4
  %2 = alloca float, align 4
  %3 = alloca float, align 4
  store float %a, float* %1, align 4
  call void @llvm.dbg.declare(metadata !{float* %1}, metadata !76), !dbg !77
  store float %y, float* %2, align 4
  call void @llvm.dbg.declare(metadata !{float* %2}, metadata !78), !dbg !77
  store float %C, float* %3, align 4
  call void @llvm.dbg.declare(metadata !{float* %3}, metadata !79), !dbg !77
  %4 = load float* %2, align 4, !dbg !80
  %5 = fcmp ogt float %4, 0.000000e+00, !dbg !80
  br i1 %5, label %6, label %9, !dbg !80

; <label>:6                                       ; preds = %0
  %7 = load float* %1, align 4, !dbg !80
  %8 = fcmp ogt float %7, 0.000000e+00, !dbg !80
  br i1 %8, label %18, label %9, !dbg !80

; <label>:9                                       ; preds = %6, %0
  %10 = load float* %2, align 4, !dbg !80
  %11 = fcmp olt float %10, 0.000000e+00, !dbg !80
  br i1 %11, label %12, label %16, !dbg !80

; <label>:12                                      ; preds = %9
  %13 = load float* %1, align 4, !dbg !80
  %14 = load float* %3, align 4, !dbg !80
  %15 = fcmp olt float %13, %14, !dbg !80
  br label %16

; <label>:16                                      ; preds = %12, %9
  %17 = phi i1 [ false, %9 ], [ %15, %12 ]
  br label %18

; <label>:18                                      ; preds = %16, %6
  %19 = phi i1 [ true, %6 ], [ %17, %16 ]
  ret i1 %19, !dbg !82
}
