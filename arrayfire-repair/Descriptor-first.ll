define void @_Z17computeDescriptorPfjjPKfS1_PKjS1_S1_S1_jiiffi(float* %desc_out, i32 %desc_len, i32 %histsz, float* %x_in, float* %y_in, i32* %layer_in, float* %response_in, float* %size_in, float* %ori_in, i32 %total_feat, i32 %d, i32 %n, float %scale, float %sigma, i32 %n_layers) uwtable noinline {
%label58not = alloca i1, align 4
%label0not = alloca i1, align 4
%label83not = alloca i1, align 4
%label0 = alloca i1, align 4
%label40not = alloca i1, align 4
%label58 = alloca i1, align 4
%label83 = alloca i1, align 4
%label40 = alloca i1, align 4
%1 = alloca float*, align 8
%2 = alloca i32, align 4
%3 = alloca i32, align 4
%4 = alloca float*, align 8
%5 = alloca float*, align 8
%6 = alloca i32*, align 8
%7 = alloca float*, align 8
%8 = alloca float*, align 8
%9 = alloca float*, align 8
%10 = alloca i32, align 4
%11 = alloca i32, align 4
%12 = alloca i32, align 4
%13 = alloca float, align 4
%14 = alloca float, align 4
%15 = alloca i32, align 4
%tid_x = alloca i32, align 4
%tid_y = alloca i32, align 4
%bsz_x = alloca i32, align 4
%bsz_y = alloca i32, align 4
%f = alloca i32, align 4
%desc = alloca float*, align 8
%accum = alloca float*, align 8
%histlen = alloca i32, align 4
%hist_off = alloca i32, align 4
%i = alloca i32, align 4
%l = alloca i32, align 4
store float* %desc_out, float** %1, align 8
store i32 %desc_len, i32* %2, align 4
store i32 %histsz, i32* %3, align 4
store float* %x_in, float** %4, align 8
store float* %y_in, float** %5, align 8
store i32* %layer_in, i32** %6, align 8
store float* %response_in, float** %7, align 8
store float* %size_in, float** %8, align 8
store float* %ori_in, float** %9, align 8
store i32 %total_feat, i32* %10, align 4
store i32 %d, i32* %11, align 4
store i32 %n, i32* %12, align 4
store float %scale, float* %13, align 4
store float %sigma, float* %14, align 4
store i32 %n_layers, i32* %15, align 4
%16 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !57
store i32 %16, i32* %tid_x, align 4, !dbg !57
%17 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 1), align 4, !dbg !59
store i32 %17, i32* %tid_y, align 4, !dbg !59
%18 = load i32* getelementptr inbounds (%struct.dim3* @blockDim, i32 0, i32 0), align 4, !dbg !61
store i32 %18, i32* %bsz_x, align 4, !dbg !61
%19 = load i32* getelementptr inbounds (%struct.dim3* @blockDim, i32 0, i32 1), align 4, !dbg !63
store i32 %19, i32* %bsz_y, align 4, !dbg !63
%20 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 1), align 4, !dbg !65
%21 = load i32* %bsz_y, align 4, !dbg !65
%22 = mul i32 %20, %21, !dbg !65
%23 = load i32* %tid_y, align 4, !dbg !65
%24 = add i32 %22, %23, !dbg !65
store i32 %24, i32* %f, align 4, !dbg !65
store i32 6, i32* %2, align 4, !dbg !66
store i32 8, i32* %10, align 4, !dbg !67
store float* getelementptr inbounds ([512 x float]* @_ZZ17computeDescriptorPfjjPKfS1_PKjS1_S1_S1_jiiffiE7shrdMem, i32 0, i32 0), float** %desc, align 8, !dbg !69
%25 = load i32* %2, align 4, !dbg !71
%26 = load i32* %3, align 4, !dbg !71
%27 = mul i32 %25, %26, !dbg !71
%28 = zext i32 %27 to i64, !dbg !71
%29 = getelementptr inbounds float* getelementptr inbounds ([512 x float]* @_ZZ17computeDescriptorPfjjPKfS1_PKjS1_S1_S1_jiiffiE7shrdMem, i32 0, i32 0), i64 %28, !dbg !71
store float* %29, float** %accum, align 8, !dbg !71
store i32 1, i32* %3, align 4, !dbg !72
%30 = load i32* %f, align 4, !dbg !73
%31 = load i32* %10, align 4, !dbg !73
%32 = icmp ult i32 %30, %31, !dbg !73
%label0 = load i1 %32
%label0not = icmp uge i32 %30, %31, !dbg !73
br label %107

; <label>:107
%label107 = load i1 %label0
br i1 %label107, label %33, label %108

; <label>:33                                      ; preds = %0
store i32 16, i32* %histlen, align 4, !dbg !76
%34 = load i32* %tid_x, align 4, !dbg !78
%35 = load i32* %3, align 4, !dbg !78
%36 = urem i32 %34, %35, !dbg !78
%37 = load i32* %2, align 4, !dbg !78
%38 = mul i32 %36, %37, !dbg !78
store i32 %38, i32* %hist_off, align 4, !dbg !78
%39 = load i32* %tid_x, align 4, !dbg !80
store i32 %39, i32* %i, align 4, !dbg !80
br label %108

; <label>:108
%label108 = load i1 %label0
br i1 %label108, label %40, label %109

; <label>:40                                      ; preds = %45, %33
%41 = load i32* %i, align 4, !dbg !81
%42 = load i32* %3, align 4, !dbg !81
%43 = mul i32 16, %42, !dbg !81
%44 = icmp ult i32 %41, %43, !dbg !81
%label40 = load i1 %44
%label40not = icmp uge i32 %41, %43, !dbg !81
br label %109

; <label>:109
%label109 = load i1 %label40
%label109 = and i1 %label109, %label0
br i1 %label109, label %45, label %110

; <label>:45                                      ; preds = %40
%46 = load i32* %tid_y, align 4, !dbg !82
%47 = mul nsw i32 %46, 16, !dbg !82
%48 = load i32* %i, align 4, !dbg !82
%49 = add nsw i32 %47, %48, !dbg !82
%50 = sext i32 %49 to i64, !dbg !82
%51 = load float** %desc, align 8, !dbg !82
%52 = getelementptr inbounds float* %51, i64 %50, !dbg !82
store float 0.000000e+00, float* %52, align 4, !dbg !82
%53 = load i32* %bsz_x, align 4, !dbg !84
%54 = load i32* %i, align 4, !dbg !84
%55 = add nsw i32 %54, %53, !dbg !84
store i32 %55, i32* %i, align 4, !dbg !84
br label %40, !dbg !85
br label %110

; <label>:110
call void @__syncthreads(), 0
%label110 = load i1 %label0
br i1 %label110, label %56, label %111

; <label>:56                                      ; preds = %40
%57 = load i32* %tid_x, align 4, !dbg !88
store i32 %57, i32* %l, align 4, !dbg !88
br label %111

; <label>:111
%label111 = load i1 %label0
br i1 %label111, label %58, label %112

; <label>:58                                      ; preds = %63, %56
%59 = load i32* %l, align 4, !dbg !89
%60 = load i32* %2, align 4, !dbg !89
%61 = mul i32 %60, 2, !dbg !89
%62 = icmp ult i32 %59, %61, !dbg !89
%label58 = load i1 %62
%label58not = icmp uge i32 %59, %61, !dbg !89
br label %112

; <label>:112
%label112 = load i1 %label58
%label112 = and i1 %label112, %label0
br i1 %label112, label %63, label %113

; <label>:63                                      ; preds = %58
%64 = load i32* %l, align 4, !dbg !90
%65 = load i32* %2, align 4, !dbg !90
%66 = mul i32 2, %65, !dbg !90
%67 = add i32 %64, %66, !dbg !90
%68 = zext i32 %67 to i64, !dbg !90
%69 = load float** %desc, align 8, !dbg !90
%70 = getelementptr inbounds float* %69, i64 %68, !dbg !90
%71 = load float* %70, align 4, !dbg !90
%72 = load i32* %l, align 4, !dbg !90
%73 = sext i32 %72 to i64, !dbg !90
%74 = load float** %desc, align 8, !dbg !90
%75 = getelementptr inbounds float* %74, i64 %73, !dbg !90
%76 = load float* %75, align 4, !dbg !90
%77 = fadd float %76, %71, !dbg !90
store float %77, float* %75, align 4, !dbg !90
%78 = load i32* %bsz_x, align 4, !dbg !92
%79 = load i32* %l, align 4, !dbg !92
%80 = add nsw i32 %79, %78, !dbg !92
store i32 %80, i32* %l, align 4, !dbg !92
br label %58, !dbg !93
br label %113

; <label>:113
call void @__syncthreads(), 1
%label113 = load i1 %label0
br i1 %label113, label %81, label %114

; <label>:81                                      ; preds = %58
%82 = load i32* %tid_x, align 4, !dbg !95
store i32 %82, i32* %l, align 4, !dbg !95
br label %114

; <label>:114
%label114 = load i1 %label0
br i1 %label114, label %83, label %115

; <label>:83                                      ; preds = %87, %81
%84 = load i32* %l, align 4, !dbg !96
%85 = load i32* %2, align 4, !dbg !96
%86 = icmp ult i32 %84, %85, !dbg !96
%label83 = load i1 %86
%label83not = icmp uge i32 %84, %85, !dbg !96
br label %115

; <label>:115
%label115 = load i1 %label0
%label115 = and i1 %label115, %label83
br i1 %label115, label %87, label %116

; <label>:87                                      ; preds = %83
%88 = load i32* %l, align 4, !dbg !97
%89 = load i32* %2, align 4, !dbg !97
%90 = add i32 %88, %89, !dbg !97
%91 = zext i32 %90 to i64, !dbg !97
%92 = load float** %desc, align 8, !dbg !97
%93 = getelementptr inbounds float* %92, i64 %91, !dbg !97
%94 = load float* %93, align 4, !dbg !97
%95 = load i32* %l, align 4, !dbg !97
%96 = sext i32 %95 to i64, !dbg !97
%97 = load float** %desc, align 8, !dbg !97
%98 = getelementptr inbounds float* %97, i64 %96, !dbg !97
%99 = load float* %98, align 4, !dbg !97
%100 = fadd float %99, %94, !dbg !97
store float %100, float* %98, align 4, !dbg !97
%101 = load i32* %bsz_x, align 4, !dbg !99
%102 = load i32* %l, align 4, !dbg !99
%103 = add nsw i32 %102, %101, !dbg !99
store i32 %103, i32* %l, align 4, !dbg !99
br label %83, !dbg !100
br label %116

; <label>:116
%label116 = load i1 %label0
br i1 %label116, label %104, label %117

; <label>:104                                     ; preds = %83
br label %117

; <label>:117
br label %105

; <label>:105                                     ; preds = %104, %0
ret void, !dbg !102

}