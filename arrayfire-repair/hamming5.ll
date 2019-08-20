; ModuleID = 'hamming5'
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
  %22 = load i32* %f, align 4, !dbg !41
  %23 = load i32* %ntrain, align 4, !dbg !41
  %24 = icmp ult i32 %22, %23, !dbg !41
  br i1 %24, label %25, label %260, !dbg !41

; <label>:25                                      ; preds = %0
  call void @llvm.dbg.declare(metadata !{i32* %j}, metadata !42), !dbg !45
  store i32 0, i32* %j, align 4, !dbg !45
  br label %26, !dbg !45

; <label>:26                                      ; preds = %256, %25
  %27 = load i32* %j, align 4, !dbg !45
  %28 = load i32* %nquery, align 4, !dbg !45
  %29 = icmp ult i32 %27, %28, !dbg !45
  br i1 %29, label %30, label %259, !dbg !45

; <label>:30                                      ; preds = %26
  %31 = load i32* %3, align 4, !dbg !46
  %32 = load i32* %tid, align 4, !dbg !46
  %33 = zext i32 %32 to i64, !dbg !46
  %34 = getelementptr inbounds [256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jjE6s_dist, i32 0, i64 %33, !dbg !46
  store i32 %31, i32* %34, align 4, !dbg !46
  %35 = load i32* %tid, align 4, !dbg !48
  %36 = load i32* %4, align 4, !dbg !48
  %37 = icmp ult i32 %35, %36, !dbg !48
  br i1 %37, label %38, label %52, !dbg !48

; <label>:38                                      ; preds = %30
  %39 = load i32* %f, align 4, !dbg !48
  %40 = load i32* %ntrain, align 4, !dbg !48
  %41 = icmp ult i32 %39, %40, !dbg !48
  br i1 %41, label %42, label %52, !dbg !48

; <label>:42                                      ; preds = %38
  %43 = load i32* %tid, align 4, !dbg !49
  %44 = load i32* %nquery, align 4, !dbg !49
  %45 = mul i32 %43, %44, !dbg !49
  %46 = load i32* %j, align 4, !dbg !49
  %47 = add i32 %45, %46, !dbg !49
  %48 = load i32* %tid, align 4, !dbg !49
  %49 = zext i32 %48 to i64, !dbg !49
  %50 = load i32** %2, align 8, !dbg !49
  %51 = getelementptr inbounds i32* %50, i64 %49, !dbg !49
  store i32 %47, i32* %51, align 4, !dbg !49
  br label %52, !dbg !51

; <label>:52                                      ; preds = %42, %38, %30
  call void @__syncthreads(), !dbg !52
  call void @llvm.dbg.declare(metadata !{i32* %dist}, metadata !53), !dbg !54
  store i32 0, i32* %dist, align 4, !dbg !54
  %53 = load i32* %tid, align 4, !dbg !55
  %54 = icmp ult i32 %53, 32, !dbg !55
  br i1 %54, label %55, label %84, !dbg !55

; <label>:55                                      ; preds = %52
  %56 = load i32* %tid, align 4, !dbg !56
  %57 = add i32 %56, 64, !dbg !56
  %58 = zext i32 %57 to i64, !dbg !56
  %59 = getelementptr inbounds [256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jjE6s_dist, i32 0, i64 %58, !dbg !56
  %60 = load i32* %59, align 4, !dbg !56
  %61 = load i32* %tid, align 4, !dbg !56
  %62 = zext i32 %61 to i64, !dbg !56
  %63 = getelementptr inbounds [256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jjE6s_dist, i32 0, i64 %62, !dbg !56
  %64 = load i32* %63, align 4, !dbg !56
  %65 = icmp ult i32 %60, %64, !dbg !56
  br i1 %65, label %66, label %83, !dbg !56

; <label>:66                                      ; preds = %55
  %67 = load i32* %tid, align 4, !dbg !58
  %68 = add i32 %67, 128, !dbg !58
  %69 = zext i32 %68 to i64, !dbg !58
  %70 = getelementptr inbounds [256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jjE6s_dist, i32 0, i64 %69, !dbg !58
  %71 = load i32* %70, align 4, !dbg !58
  %72 = load i32* %tid, align 4, !dbg !58
  %73 = zext i32 %72 to i64, !dbg !58
  %74 = getelementptr inbounds [256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jjE6s_dist, i32 0, i64 %73, !dbg !58
  store i32 %71, i32* %74, align 4, !dbg !58
  %75 = load i32* %tid, align 4, !dbg !60
  %76 = add i32 %75, 128, !dbg !60
  %77 = zext i32 %76 to i64, !dbg !60
  %78 = getelementptr inbounds [256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jjE5s_idx, i32 0, i64 %77, !dbg !60
  %79 = load i32* %78, align 4, !dbg !60
  %80 = load i32* %tid, align 4, !dbg !60
  %81 = zext i32 %80 to i64, !dbg !60
  %82 = getelementptr inbounds [256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jjE5s_idx, i32 0, i64 %81, !dbg !60
  store i32 %79, i32* %82, align 4, !dbg !60
  br label %83, !dbg !61

; <label>:83                                      ; preds = %66, %55
  br label %84, !dbg !62

; <label>:84                                      ; preds = %83, %52
  call void @__syncthreads(), !dbg !63
  %85 = load i32* %tid, align 4, !dbg !64
  %86 = icmp ult i32 %85, 16, !dbg !64
  br i1 %86, label %87, label %116, !dbg !64

; <label>:87                                      ; preds = %84
  %88 = load i32* %tid, align 4, !dbg !65
  %89 = add i32 %88, 32, !dbg !65
  %90 = zext i32 %89 to i64, !dbg !65
  %91 = getelementptr inbounds [256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jjE6s_dist, i32 0, i64 %90, !dbg !65
  %92 = load i32* %91, align 4, !dbg !65
  %93 = load i32* %tid, align 4, !dbg !65
  %94 = zext i32 %93 to i64, !dbg !65
  %95 = getelementptr inbounds [256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jjE6s_dist, i32 0, i64 %94, !dbg !65
  %96 = load i32* %95, align 4, !dbg !65
  %97 = icmp ult i32 %92, %96, !dbg !65
  br i1 %97, label %98, label %115, !dbg !65

; <label>:98                                      ; preds = %87
  %99 = load i32* %tid, align 4, !dbg !67
  %100 = add i32 %99, 64, !dbg !67
  %101 = zext i32 %100 to i64, !dbg !67
  %102 = getelementptr inbounds [256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jjE6s_dist, i32 0, i64 %101, !dbg !67
  %103 = load i32* %102, align 4, !dbg !67
  %104 = load i32* %tid, align 4, !dbg !67
  %105 = zext i32 %104 to i64, !dbg !67
  %106 = getelementptr inbounds [256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jjE6s_dist, i32 0, i64 %105, !dbg !67
  store i32 %103, i32* %106, align 4, !dbg !67
  %107 = load i32* %tid, align 4, !dbg !69
  %108 = add i32 %107, 64, !dbg !69
  %109 = zext i32 %108 to i64, !dbg !69
  %110 = getelementptr inbounds [256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jjE5s_idx, i32 0, i64 %109, !dbg !69
  %111 = load i32* %110, align 4, !dbg !69
  %112 = load i32* %tid, align 4, !dbg !69
  %113 = zext i32 %112 to i64, !dbg !69
  %114 = getelementptr inbounds [256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jjE5s_idx, i32 0, i64 %113, !dbg !69
  store i32 %111, i32* %114, align 4, !dbg !69
  br label %115, !dbg !70

; <label>:115                                     ; preds = %98, %87
  br label %116, !dbg !71

; <label>:116                                     ; preds = %115, %84
  call void @__syncthreads(), !dbg !72
  %117 = load i32* %tid, align 4, !dbg !73
  %118 = icmp ult i32 %117, 8, !dbg !73
  br i1 %118, label %119, label %232, !dbg !73

; <label>:119                                     ; preds = %116
  %120 = load i32* %tid, align 4, !dbg !74
  %121 = add i32 %120, 16, !dbg !74
  %122 = zext i32 %121 to i64, !dbg !74
  %123 = getelementptr inbounds [256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jjE6s_dist, i32 0, i64 %122, !dbg !74
  %124 = load i32* %123, align 4, !dbg !74
  %125 = load i32* %tid, align 4, !dbg !74
  %126 = zext i32 %125 to i64, !dbg !74
  %127 = getelementptr inbounds [256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jjE6s_dist, i32 0, i64 %126, !dbg !74
  %128 = load i32* %127, align 4, !dbg !74
  %129 = icmp ult i32 %124, %128, !dbg !74
  br i1 %129, label %130, label %147, !dbg !74

; <label>:130                                     ; preds = %119
  %131 = load i32* %tid, align 4, !dbg !76
  %132 = add i32 %131, 32, !dbg !76
  %133 = zext i32 %132 to i64, !dbg !76
  %134 = getelementptr inbounds [256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jjE6s_dist, i32 0, i64 %133, !dbg !76
  %135 = load i32* %134, align 4, !dbg !76
  %136 = load i32* %tid, align 4, !dbg !76
  %137 = zext i32 %136 to i64, !dbg !76
  %138 = getelementptr inbounds [256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jjE6s_dist, i32 0, i64 %137, !dbg !76
  store i32 %135, i32* %138, align 4, !dbg !76
  %139 = load i32* %tid, align 4, !dbg !78
  %140 = add i32 %139, 32, !dbg !78
  %141 = zext i32 %140 to i64, !dbg !78
  %142 = getelementptr inbounds [256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jjE5s_idx, i32 0, i64 %141, !dbg !78
  %143 = load i32* %142, align 4, !dbg !78
  %144 = load i32* %tid, align 4, !dbg !78
  %145 = zext i32 %144 to i64, !dbg !78
  %146 = getelementptr inbounds [256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jjE5s_idx, i32 0, i64 %145, !dbg !78
  store i32 %143, i32* %146, align 4, !dbg !78
  br label %147, !dbg !79

; <label>:147                                     ; preds = %130, %119
  %148 = load i32* %tid, align 4, !dbg !80
  %149 = add i32 %148, 4, !dbg !80
  %150 = zext i32 %149 to i64, !dbg !80
  %151 = getelementptr inbounds [256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jjE6s_dist, i32 0, i64 %150, !dbg !80
  %152 = load i32* %151, align 4, !dbg !80
  %153 = load i32* %tid, align 4, !dbg !80
  %154 = zext i32 %153 to i64, !dbg !80
  %155 = getelementptr inbounds [256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jjE6s_dist, i32 0, i64 %154, !dbg !80
  %156 = load i32* %155, align 4, !dbg !80
  %157 = icmp ult i32 %152, %156, !dbg !80
  br i1 %157, label %158, label %175, !dbg !80

; <label>:158                                     ; preds = %147
  %159 = load i32* %tid, align 4, !dbg !81
  %160 = add i32 %159, 4, !dbg !81
  %161 = zext i32 %160 to i64, !dbg !81
  %162 = getelementptr inbounds [256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jjE6s_dist, i32 0, i64 %161, !dbg !81
  %163 = load i32* %162, align 4, !dbg !81
  %164 = load i32* %tid, align 4, !dbg !81
  %165 = zext i32 %164 to i64, !dbg !81
  %166 = getelementptr inbounds [256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jjE6s_dist, i32 0, i64 %165, !dbg !81
  store i32 %163, i32* %166, align 4, !dbg !81
  %167 = load i32* %tid, align 4, !dbg !83
  %168 = add i32 %167, 4, !dbg !83
  %169 = zext i32 %168 to i64, !dbg !83
  %170 = getelementptr inbounds [256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jjE5s_idx, i32 0, i64 %169, !dbg !83
  %171 = load i32* %170, align 4, !dbg !83
  %172 = load i32* %tid, align 4, !dbg !83
  %173 = zext i32 %172 to i64, !dbg !83
  %174 = getelementptr inbounds [256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jjE5s_idx, i32 0, i64 %173, !dbg !83
  store i32 %171, i32* %174, align 4, !dbg !83
  br label %175, !dbg !84

; <label>:175                                     ; preds = %158, %147
  %176 = load i32* %tid, align 4, !dbg !85
  %177 = add i32 %176, 2, !dbg !85
  %178 = zext i32 %177 to i64, !dbg !85
  %179 = getelementptr inbounds [256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jjE6s_dist, i32 0, i64 %178, !dbg !85
  %180 = load i32* %179, align 4, !dbg !85
  %181 = load i32* %tid, align 4, !dbg !85
  %182 = zext i32 %181 to i64, !dbg !85
  %183 = getelementptr inbounds [256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jjE6s_dist, i32 0, i64 %182, !dbg !85
  %184 = load i32* %183, align 4, !dbg !85
  %185 = icmp ult i32 %180, %184, !dbg !85
  br i1 %185, label %186, label %203, !dbg !85

; <label>:186                                     ; preds = %175
  %187 = load i32* %tid, align 4, !dbg !86
  %188 = add i32 %187, 2, !dbg !86
  %189 = zext i32 %188 to i64, !dbg !86
  %190 = getelementptr inbounds [256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jjE6s_dist, i32 0, i64 %189, !dbg !86
  %191 = load i32* %190, align 4, !dbg !86
  %192 = load i32* %tid, align 4, !dbg !86
  %193 = zext i32 %192 to i64, !dbg !86
  %194 = getelementptr inbounds [256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jjE6s_dist, i32 0, i64 %193, !dbg !86
  store i32 %191, i32* %194, align 4, !dbg !86
  %195 = load i32* %tid, align 4, !dbg !88
  %196 = add i32 %195, 2, !dbg !88
  %197 = zext i32 %196 to i64, !dbg !88
  %198 = getelementptr inbounds [256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jjE5s_idx, i32 0, i64 %197, !dbg !88
  %199 = load i32* %198, align 4, !dbg !88
  %200 = load i32* %tid, align 4, !dbg !88
  %201 = zext i32 %200 to i64, !dbg !88
  %202 = getelementptr inbounds [256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jjE5s_idx, i32 0, i64 %201, !dbg !88
  store i32 %199, i32* %202, align 4, !dbg !88
  br label %203, !dbg !89

; <label>:203                                     ; preds = %186, %175
  %204 = load i32* %tid, align 4, !dbg !90
  %205 = add i32 %204, 1, !dbg !90
  %206 = zext i32 %205 to i64, !dbg !90
  %207 = getelementptr inbounds [256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jjE6s_dist, i32 0, i64 %206, !dbg !90
  %208 = load i32* %207, align 4, !dbg !90
  %209 = load i32* %tid, align 4, !dbg !90
  %210 = zext i32 %209 to i64, !dbg !90
  %211 = getelementptr inbounds [256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jjE6s_dist, i32 0, i64 %210, !dbg !90
  %212 = load i32* %211, align 4, !dbg !90
  %213 = icmp ult i32 %208, %212, !dbg !90
  br i1 %213, label %214, label %231, !dbg !90

; <label>:214                                     ; preds = %203
  %215 = load i32* %tid, align 4, !dbg !91
  %216 = add i32 %215, 1, !dbg !91
  %217 = zext i32 %216 to i64, !dbg !91
  %218 = getelementptr inbounds [256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jjE6s_dist, i32 0, i64 %217, !dbg !91
  %219 = load i32* %218, align 4, !dbg !91
  %220 = load i32* %tid, align 4, !dbg !91
  %221 = zext i32 %220 to i64, !dbg !91
  %222 = getelementptr inbounds [256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jjE6s_dist, i32 0, i64 %221, !dbg !91
  store i32 %219, i32* %222, align 4, !dbg !91
  %223 = load i32* %tid, align 4, !dbg !93
  %224 = add i32 %223, 1, !dbg !93
  %225 = zext i32 %224 to i64, !dbg !93
  %226 = getelementptr inbounds [256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jjE5s_idx, i32 0, i64 %225, !dbg !93
  %227 = load i32* %226, align 4, !dbg !93
  %228 = load i32* %tid, align 4, !dbg !93
  %229 = zext i32 %228 to i64, !dbg !93
  %230 = getelementptr inbounds [256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jjE5s_idx, i32 0, i64 %229, !dbg !93
  store i32 %227, i32* %230, align 4, !dbg !93
  br label %231, !dbg !94

; <label>:231                                     ; preds = %214, %203
  br label %232, !dbg !95

; <label>:232                                     ; preds = %231, %116
  call void @__syncthreads(), !dbg !96
  %233 = load i32* %f, align 4, !dbg !97
  %234 = load i32* %ntrain, align 4, !dbg !97
  %235 = icmp ult i32 %233, %234, !dbg !97
  br i1 %235, label %236, label %255, !dbg !97

; <label>:236                                     ; preds = %232
  %237 = load i32* getelementptr inbounds ([256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jjE6s_dist, i32 0, i64 0), align 4, !dbg !98
  %238 = load i32* %j, align 4, !dbg !98
  %239 = load i32* getelementptr inbounds (%struct.dim3* @gridDim, i32 0, i32 0), align 4, !dbg !98
  %240 = mul i32 %238, %239, !dbg !98
  %241 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 0), align 4, !dbg !98
  %242 = add i32 %240, %241, !dbg !98
  %243 = zext i32 %242 to i64, !dbg !98
  %244 = load i32** %2, align 8, !dbg !98
  %245 = getelementptr inbounds i32* %244, i64 %243, !dbg !98
  store i32 %237, i32* %245, align 4, !dbg !98
  %246 = load i32* getelementptr inbounds ([256 x i32]* @_ZZ22hamming_matcher_unrollPjS_jjE5s_idx, i32 0, i64 0), align 4, !dbg !100
  %247 = load i32* %j, align 4, !dbg !100
  %248 = load i32* getelementptr inbounds (%struct.dim3* @gridDim, i32 0, i32 0), align 4, !dbg !100
  %249 = mul i32 %247, %248, !dbg !100
  %250 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 0), align 4, !dbg !100
  %251 = add i32 %249, %250, !dbg !100
  %252 = zext i32 %251 to i64, !dbg !100
  %253 = load i32** %1, align 8, !dbg !100
  %254 = getelementptr inbounds i32* %253, i64 %252, !dbg !100
  store i32 %246, i32* %254, align 4, !dbg !100
  br label %255, !dbg !101

; <label>:255                                     ; preds = %236, %232
  call void @__syncthreads(), !dbg !102
  br label %256, !dbg !103

; <label>:256                                     ; preds = %255
  %257 = load i32* %j, align 4, !dbg !45
  %258 = add i32 %257, 1, !dbg !45
  store i32 %258, i32* %j, align 4, !dbg !45
  br label %26, !dbg !45

; <label>:259                                     ; preds = %26
  br label %260, !dbg !104

; <label>:260                                     ; preds = %259, %0
  ret void, !dbg !105
}

declare void @llvm.dbg.declare(metadata, metadata) nounwind readnone

declare void @__syncthreads() section "__device__"

!llvm.dbg.cu = !{!0}

!0 = metadata !{i32 786449, i32 0, i32 4, metadata !"hamming5.cpp", metadata !"/home/mingyuanwu/arrayfire-repair", metadata !"clang version 3.2 (tags/RELEASE_32/final)", i1 true, i1 false, metadata !"", i32 0, metadata !1, metadata !1, metadata !3, metadata !12} ; [ DW_TAG_compile_unit ] [/home/mingyuanwu/arrayfire-repair/hamming5.cpp] [DW_LANG_C_plus_plus]
!1 = metadata !{metadata !2}
!2 = metadata !{i32 0}
!3 = metadata !{metadata !4}
!4 = metadata !{metadata !5}
!5 = metadata !{i32 786478, i32 0, metadata !6, metadata !"hamming_matcher_unroll", metadata !"hamming_matcher_unroll", metadata !"_Z22hamming_matcher_unrollPjS_jj", metadata !6, i32 4, metadata !7, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, void (i32*, i32*, i32, i32)* @_Z22hamming_matcher_unrollPjS_jj, null, null, metadata !1, i32 9} ; [ DW_TAG_subprogram ] [line 4] [def] [scope 9] [hamming_matcher_unroll]
!6 = metadata !{i32 786473, metadata !"hamming5.cpp", metadata !"/home/mingyuanwu/arrayfire-repair", null} ; [ DW_TAG_file_type ]
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
!28 = metadata !{i32 786443, metadata !5, i32 9, i32 0, metadata !6, i32 0} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire-repair/hamming5.cpp]
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
!41 = metadata !{i32 24, i32 0, metadata !28, null}
!42 = metadata !{i32 786688, metadata !43, metadata !"j", metadata !6, i32 25, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [j] [line 25]
!43 = metadata !{i32 786443, metadata !44, i32 25, i32 0, metadata !6, i32 2} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire-repair/hamming5.cpp]
!44 = metadata !{i32 786443, metadata !28, i32 24, i32 0, metadata !6, i32 1} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire-repair/hamming5.cpp]
!45 = metadata !{i32 25, i32 0, metadata !43, null}
!46 = metadata !{i32 26, i32 0, metadata !47, null}
!47 = metadata !{i32 786443, metadata !43, i32 25, i32 0, metadata !6, i32 3} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire-repair/hamming5.cpp]
!48 = metadata !{i32 30, i32 0, metadata !47, null}
!49 = metadata !{i32 31, i32 0, metadata !50, null}
!50 = metadata !{i32 786443, metadata !47, i32 30, i32 0, metadata !6, i32 4} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire-repair/hamming5.cpp]
!51 = metadata !{i32 32, i32 0, metadata !50, null}
!52 = metadata !{i32 33, i32 0, metadata !47, null}
!53 = metadata !{i32 786688, metadata !47, metadata !"dist", metadata !6, i32 35, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [dist] [line 35]
!54 = metadata !{i32 35, i32 0, metadata !47, null}
!55 = metadata !{i32 37, i32 0, metadata !47, null}
!56 = metadata !{i32 38, i32 0, metadata !57, null}
!57 = metadata !{i32 786443, metadata !47, i32 37, i32 0, metadata !6, i32 5} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire-repair/hamming5.cpp]
!58 = metadata !{i32 39, i32 0, metadata !59, null}
!59 = metadata !{i32 786443, metadata !57, i32 38, i32 0, metadata !6, i32 6} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire-repair/hamming5.cpp]
!60 = metadata !{i32 40, i32 0, metadata !59, null}
!61 = metadata !{i32 41, i32 0, metadata !59, null}
!62 = metadata !{i32 42, i32 0, metadata !57, null}
!63 = metadata !{i32 43, i32 0, metadata !47, null}
!64 = metadata !{i32 44, i32 0, metadata !47, null}
!65 = metadata !{i32 45, i32 0, metadata !66, null}
!66 = metadata !{i32 786443, metadata !47, i32 44, i32 0, metadata !6, i32 7} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire-repair/hamming5.cpp]
!67 = metadata !{i32 46, i32 0, metadata !68, null}
!68 = metadata !{i32 786443, metadata !66, i32 45, i32 0, metadata !6, i32 8} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire-repair/hamming5.cpp]
!69 = metadata !{i32 47, i32 0, metadata !68, null}
!70 = metadata !{i32 48, i32 0, metadata !68, null}
!71 = metadata !{i32 49, i32 0, metadata !66, null}
!72 = metadata !{i32 50, i32 0, metadata !47, null}
!73 = metadata !{i32 51, i32 0, metadata !47, null}
!74 = metadata !{i32 52, i32 0, metadata !75, null}
!75 = metadata !{i32 786443, metadata !47, i32 51, i32 0, metadata !6, i32 9} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire-repair/hamming5.cpp]
!76 = metadata !{i32 53, i32 0, metadata !77, null}
!77 = metadata !{i32 786443, metadata !75, i32 52, i32 0, metadata !6, i32 10} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire-repair/hamming5.cpp]
!78 = metadata !{i32 54, i32 0, metadata !77, null}
!79 = metadata !{i32 55, i32 0, metadata !77, null}
!80 = metadata !{i32 56, i32 0, metadata !75, null}
!81 = metadata !{i32 57, i32 0, metadata !82, null}
!82 = metadata !{i32 786443, metadata !75, i32 56, i32 0, metadata !6, i32 11} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire-repair/hamming5.cpp]
!83 = metadata !{i32 58, i32 0, metadata !82, null}
!84 = metadata !{i32 59, i32 0, metadata !82, null}
!85 = metadata !{i32 60, i32 0, metadata !75, null}
!86 = metadata !{i32 61, i32 0, metadata !87, null}
!87 = metadata !{i32 786443, metadata !75, i32 60, i32 0, metadata !6, i32 12} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire-repair/hamming5.cpp]
!88 = metadata !{i32 62, i32 0, metadata !87, null}
!89 = metadata !{i32 63, i32 0, metadata !87, null}
!90 = metadata !{i32 64, i32 0, metadata !75, null}
!91 = metadata !{i32 65, i32 0, metadata !92, null}
!92 = metadata !{i32 786443, metadata !75, i32 64, i32 0, metadata !6, i32 13} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire-repair/hamming5.cpp]
!93 = metadata !{i32 66, i32 0, metadata !92, null}
!94 = metadata !{i32 67, i32 0, metadata !92, null}
!95 = metadata !{i32 68, i32 0, metadata !75, null}
!96 = metadata !{i32 69, i32 0, metadata !47, null}
!97 = metadata !{i32 73, i32 0, metadata !47, null}
!98 = metadata !{i32 74, i32 0, metadata !99, null}
!99 = metadata !{i32 786443, metadata !47, i32 73, i32 0, metadata !6, i32 14} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire-repair/hamming5.cpp]
!100 = metadata !{i32 75, i32 0, metadata !99, null}
!101 = metadata !{i32 76, i32 0, metadata !99, null}
!102 = metadata !{i32 77, i32 0, metadata !47, null}
!103 = metadata !{i32 78, i32 0, metadata !47, null}
!104 = metadata !{i32 79, i32 0, metadata !44, null}
!105 = metadata !{i32 80, i32 0, metadata !28, null}
