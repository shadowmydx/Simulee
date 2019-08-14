; ModuleID = 'hamming4'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.dim3 = type { i32, i32, i32 }

@blockDim = external global %struct.dim3
@blockIdx = external global %struct.dim3
@threadIdx = external global %struct.dim3
@_ZZ22hamming_matcher_unrollPjS_jjE6s_dist = internal global [256 x i32] zeroinitializer, section "__shared__", align 16
@_ZZ22hamming_matcher_unrollPjS_jjE5s_idx = internal global [256 x i32] zeroinitializer, section "__shared__", align 16
@gridDim = external global %struct.dim3

define void @_Z22hamming_matcher_unrollPjS_jj(i32* %out_idx, i32* %out_dist, i32 %max_dist, i32 %feat_len) uwtable noinline {
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
  call void @llvm.dbg.declare(metadata !{i32** %1}, metadata !19), !dbg !20
  store i32* %out_dist, i32** %2, align 8
  call void @llvm.dbg.declare(metadata !{i32** %2}, metadata !21), !dbg !22
  store i32 %max_dist, i32* %3, align 4
  call void @llvm.dbg.declare(metadata !{i32* %3}, metadata !23), !dbg !24
  store i32 %feat_len, i32* %4, align 4
  call void @llvm.dbg.declare(metadata !{i32* %4}, metadata !25), !dbg !26
  call void @llvm.dbg.declare(metadata !{i32* %nquery}, metadata !27), !dbg !29
  store i32 6, i32* %nquery, align 4, !dbg !29
  call void @llvm.dbg.declare(metadata !{i32* %ntrain}, metadata !30), !dbg !31
  store i32 6, i32* %ntrain, align 4, !dbg !31
  call void @llvm.dbg.declare(metadata !{i32* %f}, metadata !32), !dbg !33
  %5 = load i32* getelementptr inbounds (%struct.dim3* @blockDim, i32 0, i32 0), align 4, !dbg !33
  %6 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 0), align 4, !dbg !33
  %7 = mul i32 %5, %6, !dbg !33
  %8 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !33
  %9 = add i32 %7, %8, !dbg !33
  store i32 %9, i32* %f, align 4, !dbg !33
  call void @llvm.dbg.declare(metadata !{i32* %tid}, metadata !34), !dbg !35
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
  call void @llvm.dbg.declare(metadata !{i8* %valid_feat}, metadata !38), !dbg !40
  %18 = load i32* %f, align 4, !dbg !40
  %19 = load i32* %ntrain, align 4, !dbg !40
  %20 = icmp ult i32 %18, %19, !dbg !40
  %21 = zext i1 %20 to i8, !dbg !40
  store i8 %21, i8* %valid_feat, align 1, !dbg !40
  call void @llvm.dbg.declare(metadata !{i32* %j}, metadata !41), !dbg !43
  store i32 0, i32* %j, align 4, !dbg !43
  br label %22, !dbg !43

; <label>:22                                      ; preds = %252, %0
  %23 = load i32* %j, align 4, !dbg !43
  %24 = load i32* %nquery, align 4, !dbg !43
  %25 = icmp ult i32 %23, %24, !dbg !43
  br i1 %25, label %26, label %255, !dbg !43

; <label>:26                                      ; preds = %22
  %27 = load i32* %3, align 4, !dbg !44
  %28 = load i32* %tid, align 4, !dbg !44
  %29 = zext i32 %28 to i64, !dbg !44
  %30 = getelementptr inbounds [256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jjE6s_dist, i32 0, i64 %29, !dbg !44
  store i32 %27, i32* %30, align 4, !dbg !44
  %31 = load i32* %tid, align 4, !dbg !46
  %32 = load i32* %4, align 4, !dbg !46
  %33 = icmp ult i32 %31, %32, !dbg !46
  br i1 %33, label %34, label %48, !dbg !46

; <label>:34                                      ; preds = %26
  %35 = load i32* %f, align 4, !dbg !46
  %36 = load i32* %ntrain, align 4, !dbg !46
  %37 = icmp ult i32 %35, %36, !dbg !46
  br i1 %37, label %38, label %48, !dbg !46

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
  br label %48, !dbg !49

; <label>:48                                      ; preds = %38, %34, %26
  call void @__syncthreads(), !dbg !50
  call void @llvm.dbg.declare(metadata !{i32* %dist}, metadata !51), !dbg !52
  store i32 0, i32* %dist, align 4, !dbg !52
  %49 = load i32* %tid, align 4, !dbg !53
  %50 = icmp ult i32 %49, 32, !dbg !53
  br i1 %50, label %51, label %80, !dbg !53

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
  br i1 %61, label %62, label %79, !dbg !54

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
  br label %79, !dbg !59

; <label>:79                                      ; preds = %62, %51
  br label %80, !dbg !60

; <label>:80                                      ; preds = %79, %48
  call void @__syncthreads(), !dbg !61
  %81 = load i32* %tid, align 4, !dbg !62
  %82 = icmp ult i32 %81, 16, !dbg !62
  br i1 %82, label %83, label %112, !dbg !62

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
  br i1 %93, label %94, label %111, !dbg !63

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
  br label %111, !dbg !68

; <label>:111                                     ; preds = %94, %83
  br label %112, !dbg !69

; <label>:112                                     ; preds = %111, %80
  call void @__syncthreads(), !dbg !70
  %113 = load i32* %tid, align 4, !dbg !71
  %114 = icmp ult i32 %113, 8, !dbg !71
  br i1 %114, label %115, label %228, !dbg !71

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
  br i1 %125, label %126, label %143, !dbg !72

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
  br label %143, !dbg !77

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
  br i1 %153, label %154, label %171, !dbg !78

; <label>:154                                     ; preds = %143
  %155 = load i32* %tid, align 4, !dbg !79
  %156 = add i32 %155, 4, !dbg !79
  %157 = zext i32 %156 to i64, !dbg !79
  %158 = getelementptr inbounds [256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jjE6s_dist, i32 0, i64 %157, !dbg !79
  %159 = load i32* %158, align 4, !dbg !79
  %160 = load i32* %tid, align 4, !dbg !79
  %161 = zext i32 %160 to i64, !dbg !79
  %162 = getelementptr inbounds [256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jjE6s_dist, i32 0, i64 %161, !dbg !79
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
  br label %171, !dbg !82

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
  br i1 %181, label %182, label %199, !dbg !83

; <label>:182                                     ; preds = %171
  %183 = load i32* %tid, align 4, !dbg !84
  %184 = add i32 %183, 2, !dbg !84
  %185 = zext i32 %184 to i64, !dbg !84
  %186 = getelementptr inbounds [256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jjE6s_dist, i32 0, i64 %185, !dbg !84
  %187 = load i32* %186, align 4, !dbg !84
  %188 = load i32* %tid, align 4, !dbg !84
  %189 = zext i32 %188 to i64, !dbg !84
  %190 = getelementptr inbounds [256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jjE6s_dist, i32 0, i64 %189, !dbg !84
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
  br label %199, !dbg !87

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
  br i1 %209, label %210, label %227, !dbg !88

; <label>:210                                     ; preds = %199
  %211 = load i32* %tid, align 4, !dbg !89
  %212 = add i32 %211, 1, !dbg !89
  %213 = zext i32 %212 to i64, !dbg !89
  %214 = getelementptr inbounds [256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jjE6s_dist, i32 0, i64 %213, !dbg !89
  %215 = load i32* %214, align 4, !dbg !89
  %216 = load i32* %tid, align 4, !dbg !89
  %217 = zext i32 %216 to i64, !dbg !89
  %218 = getelementptr inbounds [256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jjE6s_dist, i32 0, i64 %217, !dbg !89
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
  br label %227, !dbg !92

; <label>:227                                     ; preds = %210, %199
  br label %228, !dbg !93

; <label>:228                                     ; preds = %227, %112
  call void @__syncthreads(), !dbg !94
  %229 = load i32* %f, align 4, !dbg !95
  %230 = load i32* %ntrain, align 4, !dbg !95
  %231 = icmp ult i32 %229, %230, !dbg !95
  br i1 %231, label %232, label %251, !dbg !95

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
  br label %251, !dbg !99

; <label>:251                                     ; preds = %232, %228
  call void @__syncthreads(), !dbg !100
  br label %252, !dbg !101

; <label>:252                                     ; preds = %251
  %253 = load i32* %j, align 4, !dbg !43
  %254 = add i32 %253, 1, !dbg !43
  store i32 %254, i32* %j, align 4, !dbg !43
  br label %22, !dbg !43

; <label>:255                                     ; preds = %22
  ret void, !dbg !102
}

declare void @llvm.dbg.declare(metadata, metadata) nounwind readnone

declare void @__syncthreads() section "__device__"

!llvm.dbg.cu = !{!0}

!0 = metadata !{i32 786449, i32 0, i32 4, metadata !"hamming4.cpp", metadata !"/home/mingyuanwu/arrayfire-repair", metadata !"clang version 3.2 (tags/RELEASE_32/final)", i1 true, i1 false, metadata !"", i32 0, metadata !1, metadata !1, metadata !3, metadata !12} ; [ DW_TAG_compile_unit ] [/home/mingyuanwu/arrayfire-repair/hamming4.cpp] [DW_LANG_C_plus_plus]
!1 = metadata !{metadata !2}
!2 = metadata !{i32 0}
!3 = metadata !{metadata !4}
!4 = metadata !{metadata !5}
!5 = metadata !{i32 786478, i32 0, metadata !6, metadata !"hamming_matcher_unroll", metadata !"hamming_matcher_unroll", metadata !"_Z22hamming_matcher_unrollPjS_jj", metadata !6, i32 4, metadata !7, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, void (i32*, i32*, i32, i32)* @_Z22hamming_matcher_unrollPjS_jj, null, null, metadata !1, i32 9} ; [ DW_TAG_subprogram ] [line 4] [def] [scope 9] [hamming_matcher_unroll]
!6 = metadata !{i32 786473, metadata !"hamming4.cpp", metadata !"/home/mingyuanwu/arrayfire-repair", null} ; [ DW_TAG_file_type ]
!7 = metadata !{i32 786453, i32 0, metadata !"", i32 0, i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !8, i32 0, i32 0} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!8 = metadata !{null, metadata !9, metadata !9, metadata !11, metadata !11}
!9 = metadata !{i32 786447, null, metadata !"", null, i32 0, i64 64, i64 64, i64 0, i32 0, metadata !10} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from unsigned int]
!10 = metadata !{i32 786468, null, metadata !"unsigned int", null, i32 0, i64 32, i64 32, i64 0, i32 0, i32 7} ; [ DW_TAG_base_type ] [unsigned int] [line 0, size 32, align 32, offset 0, enc DW_ATE_unsigned]
!11 = metadata !{i32 786470, null, metadata !"", null, i32 0, i64 0, i64 0, i64 0, i32 0, metadata !10} ; [ DW_TAG_const_type ] [line 0, size 0, align 0, offset 0] [from unsigned int]
!12 = metadata !{metadata !13}
!13 = metadata !{metadata !14, metadata !18}
!14 = metadata !{i32 786484, i32 0, metadata !5, metadata !"s_dist", metadata !"s_dist", metadata !"", metadata !6, i32 16, metadata !15, i32 1, i32 1, [256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jjE6s_dist} ; [ DW_TAG_variable ] [s_dist] [line 16] [local] [def]
!15 = metadata !{i32 786433, null, metadata !"", null, i32 0, i64 8192, i64 32, i32 0, i32 0, metadata !10, metadata !16, i32 0, i32 0} ; [ DW_TAG_array_type ] [line 0, size 8192, align 32, offset 0] [from unsigned int]
!16 = metadata !{metadata !17}
!17 = metadata !{i32 786465, i64 0, i64 255}      ; [ DW_TAG_subrange_type ] [0, 255]
!18 = metadata !{i32 786484, i32 0, metadata !5, metadata !"s_idx", metadata !"s_idx", metadata !"", metadata !6, i32 17, metadata !15, i32 1, i32 1, [256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jjE5s_idx} ; [ DW_TAG_variable ] [s_idx] [line 17] [local] [def]
!19 = metadata !{i32 786689, metadata !5, metadata !"out_idx", metadata !6, i32 16777221, metadata !9, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [out_idx] [line 5]
!20 = metadata !{i32 5, i32 0, metadata !5, null}
!21 = metadata !{i32 786689, metadata !5, metadata !"out_dist", metadata !6, i32 33554438, metadata !9, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [out_dist] [line 6]
!22 = metadata !{i32 6, i32 0, metadata !5, null}
!23 = metadata !{i32 786689, metadata !5, metadata !"max_dist", metadata !6, i32 50331655, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [max_dist] [line 7]
!24 = metadata !{i32 7, i32 0, metadata !5, null}
!25 = metadata !{i32 786689, metadata !5, metadata !"feat_len", metadata !6, i32 67108872, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [feat_len] [line 8]
!26 = metadata !{i32 8, i32 0, metadata !5, null}
!27 = metadata !{i32 786688, metadata !28, metadata !"nquery", metadata !6, i32 10, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [nquery] [line 10]
!28 = metadata !{i32 786443, metadata !5, i32 9, i32 0, metadata !6, i32 0} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire-repair/hamming4.cpp]
!29 = metadata !{i32 10, i32 0, metadata !28, null}
!30 = metadata !{i32 786688, metadata !28, metadata !"ntrain", metadata !6, i32 11, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [ntrain] [line 11]
!31 = metadata !{i32 11, i32 0, metadata !28, null}
!32 = metadata !{i32 786688, metadata !28, metadata !"f", metadata !6, i32 13, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [f] [line 13]
!33 = metadata !{i32 13, i32 0, metadata !28, null}
!34 = metadata !{i32 786688, metadata !28, metadata !"tid", metadata !6, i32 14, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [tid] [line 14]
!35 = metadata !{i32 14, i32 0, metadata !28, null}
!36 = metadata !{i32 20, i32 0, metadata !28, null}
!37 = metadata !{i32 21, i32 0, metadata !28, null}
!38 = metadata !{i32 786688, metadata !28, metadata !"valid_feat", metadata !6, i32 23, metadata !39, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [valid_feat] [line 23]
!39 = metadata !{i32 786468, null, metadata !"bool", null, i32 0, i64 8, i64 8, i64 0, i32 0, i32 2} ; [ DW_TAG_base_type ] [bool] [line 0, size 8, align 8, offset 0, enc DW_ATE_boolean]
!40 = metadata !{i32 23, i32 0, metadata !28, null}
!41 = metadata !{i32 786688, metadata !42, metadata !"j", metadata !6, i32 25, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [j] [line 25]
!42 = metadata !{i32 786443, metadata !28, i32 25, i32 0, metadata !6, i32 1} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire-repair/hamming4.cpp]
!43 = metadata !{i32 25, i32 0, metadata !42, null}
!44 = metadata !{i32 26, i32 0, metadata !45, null}
!45 = metadata !{i32 786443, metadata !42, i32 25, i32 0, metadata !6, i32 2} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire-repair/hamming4.cpp]
!46 = metadata !{i32 30, i32 0, metadata !45, null}
!47 = metadata !{i32 31, i32 0, metadata !48, null}
!48 = metadata !{i32 786443, metadata !45, i32 30, i32 0, metadata !6, i32 3} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire-repair/hamming4.cpp]
!49 = metadata !{i32 32, i32 0, metadata !48, null}
!50 = metadata !{i32 33, i32 0, metadata !45, null}
!51 = metadata !{i32 786688, metadata !45, metadata !"dist", metadata !6, i32 35, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [dist] [line 35]
!52 = metadata !{i32 35, i32 0, metadata !45, null}
!53 = metadata !{i32 37, i32 0, metadata !45, null}
!54 = metadata !{i32 38, i32 0, metadata !55, null}
!55 = metadata !{i32 786443, metadata !45, i32 37, i32 0, metadata !6, i32 4} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire-repair/hamming4.cpp]
!56 = metadata !{i32 39, i32 0, metadata !57, null}
!57 = metadata !{i32 786443, metadata !55, i32 38, i32 0, metadata !6, i32 5} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire-repair/hamming4.cpp]
!58 = metadata !{i32 40, i32 0, metadata !57, null}
!59 = metadata !{i32 41, i32 0, metadata !57, null}
!60 = metadata !{i32 42, i32 0, metadata !55, null}
!61 = metadata !{i32 43, i32 0, metadata !45, null}
!62 = metadata !{i32 44, i32 0, metadata !45, null}
!63 = metadata !{i32 45, i32 0, metadata !64, null}
!64 = metadata !{i32 786443, metadata !45, i32 44, i32 0, metadata !6, i32 6} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire-repair/hamming4.cpp]
!65 = metadata !{i32 46, i32 0, metadata !66, null}
!66 = metadata !{i32 786443, metadata !64, i32 45, i32 0, metadata !6, i32 7} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire-repair/hamming4.cpp]
!67 = metadata !{i32 47, i32 0, metadata !66, null}
!68 = metadata !{i32 48, i32 0, metadata !66, null}
!69 = metadata !{i32 49, i32 0, metadata !64, null}
!70 = metadata !{i32 50, i32 0, metadata !45, null}
!71 = metadata !{i32 51, i32 0, metadata !45, null}
!72 = metadata !{i32 52, i32 0, metadata !73, null}
!73 = metadata !{i32 786443, metadata !45, i32 51, i32 0, metadata !6, i32 8} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire-repair/hamming4.cpp]
!74 = metadata !{i32 53, i32 0, metadata !75, null}
!75 = metadata !{i32 786443, metadata !73, i32 52, i32 0, metadata !6, i32 9} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire-repair/hamming4.cpp]
!76 = metadata !{i32 54, i32 0, metadata !75, null}
!77 = metadata !{i32 55, i32 0, metadata !75, null}
!78 = metadata !{i32 56, i32 0, metadata !73, null}
!79 = metadata !{i32 57, i32 0, metadata !80, null}
!80 = metadata !{i32 786443, metadata !73, i32 56, i32 0, metadata !6, i32 10} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire-repair/hamming4.cpp]
!81 = metadata !{i32 58, i32 0, metadata !80, null}
!82 = metadata !{i32 59, i32 0, metadata !80, null}
!83 = metadata !{i32 60, i32 0, metadata !73, null}
!84 = metadata !{i32 61, i32 0, metadata !85, null}
!85 = metadata !{i32 786443, metadata !73, i32 60, i32 0, metadata !6, i32 11} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire-repair/hamming4.cpp]
!86 = metadata !{i32 62, i32 0, metadata !85, null}
!87 = metadata !{i32 63, i32 0, metadata !85, null}
!88 = metadata !{i32 64, i32 0, metadata !73, null}
!89 = metadata !{i32 65, i32 0, metadata !90, null}
!90 = metadata !{i32 786443, metadata !73, i32 64, i32 0, metadata !6, i32 12} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire-repair/hamming4.cpp]
!91 = metadata !{i32 66, i32 0, metadata !90, null}
!92 = metadata !{i32 67, i32 0, metadata !90, null}
!93 = metadata !{i32 68, i32 0, metadata !73, null}
!94 = metadata !{i32 69, i32 0, metadata !45, null}
!95 = metadata !{i32 72, i32 0, metadata !45, null}
!96 = metadata !{i32 73, i32 0, metadata !97, null}
!97 = metadata !{i32 786443, metadata !45, i32 72, i32 0, metadata !6, i32 13} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire-repair/hamming4.cpp]
!98 = metadata !{i32 74, i32 0, metadata !97, null}
!99 = metadata !{i32 75, i32 0, metadata !97, null}
!100 = metadata !{i32 76, i32 0, metadata !45, null}
!101 = metadata !{i32 77, i32 0, metadata !45, null}
!102 = metadata !{i32 78, i32 0, metadata !28, null}
