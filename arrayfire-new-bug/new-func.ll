; ModuleID = 'new-func'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.dim3 = type { i32, i32, i32 }

@_ZZ9convolve2PiS_iS_S_S_S_iiiiiiiiE7shrdMem = internal global [512 x i32] zeroinitializer, section "__shared__", align 16
@blockIdx = external global %struct.dim3
@gridDim = external global %struct.dim3
@threadIdx = external global %struct.dim3

define void @_Z9convolve2PiS_iS_S_S_S_iiiiiiii(i32* %out_ptr, i32* %signal_ptr, i32 %nBBS0, i32* %out_strides, i32* %out_dims, i32* %signal_strides, i32* %signal_dims, i32 %nBBS1, i32 %o2, i32 %o3, i32 %s2, i32 %s3, i32 %expand, i32 %fLen0, i32 %fLen1) uwtable noinline {
  %1 = alloca i32*, align 8
  %2 = alloca i32*, align 8
  %3 = alloca i32, align 4
  %4 = alloca i32*, align 8
  %5 = alloca i32*, align 8
  %6 = alloca i32*, align 8
  %7 = alloca i32*, align 8
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  %13 = alloca i32, align 4
  %14 = alloca i32, align 4
  %15 = alloca i32, align 4
  %C_SIZE = alloca i32, align 4
  %radius0 = alloca i32, align 4
  %radius1 = alloca i32, align 4
  %padding0 = alloca i32, align 4
  %padding1 = alloca i32, align 4
  %shrdLen0 = alloca i32, align 4
  %shrdLen1 = alloca i32, align 4
  %b0 = alloca i32, align 4
  %b1 = alloca i32, align 4
  %dst = alloca i32*, align 8
  %src = alloca i32*, align 8
  %lx = alloca i32, align 4
  %ly = alloca i32, align 4
  %gx = alloca i32, align 4
  %gy = alloca i32, align 4
  %s0 = alloca i32, align 4
  %s1 = alloca i32, align 4
  %d0 = alloca i32, align 4
  %d1 = alloca i32, align 4
  %b = alloca i32, align 4
  %gy2 = alloca i32, align 4
  %j = alloca i32, align 4
  %is_j = alloca i8, align 1
  %a = alloca i32, align 4
  %gx2 = alloca i32, align 4
  %i = alloca i32, align 4
  %is_i = alloca i8, align 1
  %ci = alloca i32, align 4
  %cj = alloca i32, align 4
  %accum = alloca i32, align 4
  %fj = alloca i32, align 4
  %fi = alloca i32, align 4
  %s_val = alloca i32, align 4
  store i32* %out_ptr, i32** %1, align 8
  call void @llvm.dbg.declare(metadata !{i32** %1}, metadata !17), !dbg !18
  store i32* %signal_ptr, i32** %2, align 8
  call void @llvm.dbg.declare(metadata !{i32** %2}, metadata !19), !dbg !18
  store i32 %nBBS0, i32* %3, align 4
  call void @llvm.dbg.declare(metadata !{i32* %3}, metadata !20), !dbg !18
  store i32* %out_strides, i32** %4, align 8
  call void @llvm.dbg.declare(metadata !{i32** %4}, metadata !21), !dbg !18
  store i32* %out_dims, i32** %5, align 8
  call void @llvm.dbg.declare(metadata !{i32** %5}, metadata !22), !dbg !18
  store i32* %signal_strides, i32** %6, align 8
  call void @llvm.dbg.declare(metadata !{i32** %6}, metadata !23), !dbg !18
  store i32* %signal_dims, i32** %7, align 8
  call void @llvm.dbg.declare(metadata !{i32** %7}, metadata !24), !dbg !18
  store i32 %nBBS1, i32* %8, align 4
  call void @llvm.dbg.declare(metadata !{i32* %8}, metadata !25), !dbg !26
  store i32 %o2, i32* %9, align 4
  call void @llvm.dbg.declare(metadata !{i32* %9}, metadata !27), !dbg !26
  store i32 %o3, i32* %10, align 4
  call void @llvm.dbg.declare(metadata !{i32* %10}, metadata !28), !dbg !26
  store i32 %s2, i32* %11, align 4
  call void @llvm.dbg.declare(metadata !{i32* %11}, metadata !29), !dbg !26
  store i32 %s3, i32* %12, align 4
  call void @llvm.dbg.declare(metadata !{i32* %12}, metadata !30), !dbg !26
  store i32 %expand, i32* %13, align 4
  call void @llvm.dbg.declare(metadata !{i32* %13}, metadata !31), !dbg !26
  store i32 %fLen0, i32* %14, align 4
  call void @llvm.dbg.declare(metadata !{i32* %14}, metadata !32), !dbg !26
  store i32 %fLen1, i32* %15, align 4
  call void @llvm.dbg.declare(metadata !{i32* %15}, metadata !33), !dbg !26
  call void @llvm.dbg.declare(metadata !{i32* %C_SIZE}, metadata !34), !dbg !38
  store i32 512, i32* %C_SIZE, align 4, !dbg !38
  call void @llvm.dbg.declare(metadata !{i32* %radius0}, metadata !39), !dbg !41
  %16 = load i32* %14, align 4, !dbg !41
  %17 = sub nsw i32 %16, 1, !dbg !41
  store i32 %17, i32* %radius0, align 4, !dbg !41
  call void @llvm.dbg.declare(metadata !{i32* %radius1}, metadata !42), !dbg !43
  %18 = load i32* %15, align 4, !dbg !43
  %19 = sub nsw i32 %18, 1, !dbg !43
  store i32 %19, i32* %radius1, align 4, !dbg !43
  call void @llvm.dbg.declare(metadata !{i32* %padding0}, metadata !44), !dbg !45
  %20 = load i32* %radius0, align 4, !dbg !45
  %21 = mul nsw i32 2, %20, !dbg !45
  store i32 %21, i32* %padding0, align 4, !dbg !45
  call void @llvm.dbg.declare(metadata !{i32* %padding1}, metadata !46), !dbg !47
  %22 = load i32* %radius1, align 4, !dbg !47
  %23 = mul nsw i32 2, %22, !dbg !47
  store i32 %23, i32* %padding1, align 4, !dbg !47
  call void @llvm.dbg.declare(metadata !{i32* %shrdLen0}, metadata !48), !dbg !49
  %24 = load i32* %padding0, align 4, !dbg !49
  %25 = add nsw i32 16, %24, !dbg !49
  store i32 %25, i32* %shrdLen0, align 4, !dbg !49
  call void @llvm.dbg.declare(metadata !{i32* %shrdLen1}, metadata !50), !dbg !51
  %26 = load i32* %padding1, align 4, !dbg !51
  %27 = add nsw i32 16, %26, !dbg !51
  store i32 %27, i32* %shrdLen1, align 4, !dbg !51
  call void @llvm.dbg.declare(metadata !{i32* %b0}, metadata !52), !dbg !53
  %28 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 0), align 4, !dbg !53
  %29 = load i32* %3, align 4, !dbg !53
  %30 = udiv i32 %28, %29, !dbg !53
  store i32 %30, i32* %b0, align 4, !dbg !53
  call void @llvm.dbg.declare(metadata !{i32* %b1}, metadata !54), !dbg !55
  %31 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 1), align 4, !dbg !55
  %32 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 2), align 4, !dbg !55
  %33 = load i32* getelementptr inbounds (%struct.dim3* @gridDim, i32 0, i32 1), align 4, !dbg !55
  %34 = mul i32 %32, %33, !dbg !55
  %35 = add i32 %31, %34, !dbg !55
  %36 = load i32* %8, align 4, !dbg !55
  %37 = udiv i32 %35, %36, !dbg !55
  store i32 %37, i32* %b1, align 4, !dbg !55
  call void @llvm.dbg.declare(metadata !{i32** %dst}, metadata !56), !dbg !57
  %38 = load i32** %1, align 8, !dbg !58
  %39 = load i32* %b0, align 4, !dbg !58
  %40 = load i32** %4, align 8, !dbg !58
  %41 = getelementptr inbounds i32* %40, i64 2, !dbg !58
  %42 = load i32* %41, align 4, !dbg !58
  %43 = mul i32 %39, %42, !dbg !58
  %44 = load i32* %9, align 4, !dbg !58
  %45 = load i32** %4, align 8, !dbg !58
  %46 = getelementptr inbounds i32* %45, i64 2, !dbg !58
  %47 = load i32* %46, align 4, !dbg !58
  %48 = mul nsw i32 %44, %47, !dbg !58
  %49 = add i32 %43, %48, !dbg !58
  %50 = load i32* %b1, align 4, !dbg !58
  %51 = load i32** %4, align 8, !dbg !58
  %52 = getelementptr inbounds i32* %51, i64 3, !dbg !58
  %53 = load i32* %52, align 4, !dbg !58
  %54 = mul i32 %50, %53, !dbg !58
  %55 = add i32 %49, %54, !dbg !58
  %56 = load i32* %10, align 4, !dbg !58
  %57 = load i32** %4, align 8, !dbg !58
  %58 = getelementptr inbounds i32* %57, i64 3, !dbg !58
  %59 = load i32* %58, align 4, !dbg !58
  %60 = mul nsw i32 %56, %59, !dbg !58
  %61 = add i32 %55, %60, !dbg !58
  %62 = zext i32 %61 to i64, !dbg !58
  %63 = getelementptr inbounds i32* %38, i64 %62, !dbg !58
  store i32* %63, i32** %dst, align 8, !dbg !58
  call void @llvm.dbg.declare(metadata !{i32** %src}, metadata !59), !dbg !61
  %64 = load i32** %2, align 8, !dbg !62
  %65 = load i32* %b0, align 4, !dbg !62
  %66 = load i32** %6, align 8, !dbg !62
  %67 = getelementptr inbounds i32* %66, i64 2, !dbg !62
  %68 = load i32* %67, align 4, !dbg !62
  %69 = mul i32 %65, %68, !dbg !62
  %70 = load i32* %11, align 4, !dbg !62
  %71 = load i32** %6, align 8, !dbg !62
  %72 = getelementptr inbounds i32* %71, i64 2, !dbg !62
  %73 = load i32* %72, align 4, !dbg !62
  %74 = mul nsw i32 %70, %73, !dbg !62
  %75 = add i32 %69, %74, !dbg !62
  %76 = load i32* %b1, align 4, !dbg !62
  %77 = load i32** %6, align 8, !dbg !62
  %78 = getelementptr inbounds i32* %77, i64 3, !dbg !62
  %79 = load i32* %78, align 4, !dbg !62
  %80 = mul i32 %76, %79, !dbg !62
  %81 = add i32 %75, %80, !dbg !62
  %82 = load i32* %12, align 4, !dbg !62
  %83 = load i32** %6, align 8, !dbg !62
  %84 = getelementptr inbounds i32* %83, i64 3, !dbg !62
  %85 = load i32* %84, align 4, !dbg !62
  %86 = mul nsw i32 %82, %85, !dbg !62
  %87 = add i32 %81, %86, !dbg !62
  %88 = zext i32 %87 to i64, !dbg !62
  %89 = getelementptr inbounds i32* %64, i64 %88, !dbg !62
  store i32* %89, i32** %src, align 8, !dbg !62
  call void @llvm.dbg.declare(metadata !{i32* %lx}, metadata !63), !dbg !64
  %90 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !64
  store i32 %90, i32* %lx, align 4, !dbg !64
  call void @llvm.dbg.declare(metadata !{i32* %ly}, metadata !65), !dbg !66
  %91 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 1), align 4, !dbg !66
  store i32 %91, i32* %ly, align 4, !dbg !66
  call void @llvm.dbg.declare(metadata !{i32* %gx}, metadata !67), !dbg !68
  %92 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 0), align 4, !dbg !68
  %93 = load i32* %b0, align 4, !dbg !68
  %94 = load i32* %3, align 4, !dbg !68
  %95 = mul i32 %93, %94, !dbg !68
  %96 = sub i32 %92, %95, !dbg !68
  %97 = mul i32 16, %96, !dbg !68
  %98 = load i32* %lx, align 4, !dbg !68
  %99 = add i32 %97, %98, !dbg !68
  store i32 %99, i32* %gx, align 4, !dbg !68
  call void @llvm.dbg.declare(metadata !{i32* %gy}, metadata !69), !dbg !70
  %100 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 1), align 4, !dbg !70
  %101 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 2), align 4, !dbg !70
  %102 = load i32* getelementptr inbounds (%struct.dim3* @gridDim, i32 0, i32 1), align 4, !dbg !70
  %103 = mul i32 %101, %102, !dbg !70
  %104 = add i32 %100, %103, !dbg !70
  %105 = load i32* %b1, align 4, !dbg !70
  %106 = load i32* %8, align 4, !dbg !70
  %107 = mul i32 %105, %106, !dbg !70
  %108 = sub i32 %104, %107, !dbg !70
  %109 = mul i32 16, %108, !dbg !70
  %110 = load i32* %ly, align 4, !dbg !70
  %111 = add i32 %109, %110, !dbg !70
  store i32 %111, i32* %gy, align 4, !dbg !70
  %112 = load i32* %b1, align 4, !dbg !71
  %113 = load i32** %5, align 8, !dbg !71
  %114 = getelementptr inbounds i32* %113, i64 3, !dbg !71
  %115 = load i32* %114, align 4, !dbg !71
  %116 = icmp uge i32 %112, %115, !dbg !71
  br i1 %116, label %117, label %118, !dbg !71

; <label>:117                                     ; preds = %0
  br label %288, !dbg !72

; <label>:118                                     ; preds = %0
  call void @llvm.dbg.declare(metadata !{i32* %s0}, metadata !73), !dbg !74
  %119 = load i32** %6, align 8, !dbg !74
  %120 = getelementptr inbounds i32* %119, i64 0, !dbg !74
  %121 = load i32* %120, align 4, !dbg !74
  store i32 %121, i32* %s0, align 4, !dbg !74
  call void @llvm.dbg.declare(metadata !{i32* %s1}, metadata !75), !dbg !76
  %122 = load i32** %6, align 8, !dbg !76
  %123 = getelementptr inbounds i32* %122, i64 1, !dbg !76
  %124 = load i32* %123, align 4, !dbg !76
  store i32 %124, i32* %s1, align 4, !dbg !76
  call void @llvm.dbg.declare(metadata !{i32* %d0}, metadata !77), !dbg !78
  %125 = load i32** %7, align 8, !dbg !78
  %126 = getelementptr inbounds i32* %125, i64 0, !dbg !78
  %127 = load i32* %126, align 4, !dbg !78
  store i32 %127, i32* %d0, align 4, !dbg !78
  call void @llvm.dbg.declare(metadata !{i32* %d1}, metadata !79), !dbg !80
  %128 = load i32** %7, align 8, !dbg !80
  %129 = getelementptr inbounds i32* %128, i64 1, !dbg !80
  %130 = load i32* %129, align 4, !dbg !80
  store i32 %130, i32* %d1, align 4, !dbg !80
  call void @llvm.dbg.declare(metadata !{i32* %b}, metadata !81), !dbg !83
  %131 = load i32* %ly, align 4, !dbg !83
  store i32 %131, i32* %b, align 4, !dbg !83
  call void @llvm.dbg.declare(metadata !{i32* %gy2}, metadata !84), !dbg !83
  %132 = load i32* %gy, align 4, !dbg !83
  store i32 %132, i32* %gy2, align 4, !dbg !83
  br label %133, !dbg !83

; <label>:133                                     ; preds = %202, %118
  %134 = load i32* %b, align 4, !dbg !83
  %135 = load i32* %shrdLen1, align 4, !dbg !83
  %136 = icmp slt i32 %134, %135, !dbg !83
  br i1 %136, label %137, label %207, !dbg !83

; <label>:137                                     ; preds = %133
  call void @llvm.dbg.declare(metadata !{i32* %j}, metadata !85), !dbg !87
  %138 = load i32* %gy2, align 4, !dbg !87
  %139 = load i32* %radius1, align 4, !dbg !87
  %140 = sub nsw i32 %138, %139, !dbg !87
  store i32 %140, i32* %j, align 4, !dbg !87
  call void @llvm.dbg.declare(metadata !{i8* %is_j}, metadata !88), !dbg !90
  %141 = load i32* %j, align 4, !dbg !90
  %142 = icmp sge i32 %141, 0, !dbg !90
  br i1 %142, label %143, label %147, !dbg !90

; <label>:143                                     ; preds = %137
  %144 = load i32* %j, align 4, !dbg !90
  %145 = load i32* %d1, align 4, !dbg !90
  %146 = icmp slt i32 %144, %145, !dbg !90
  br label %147

; <label>:147                                     ; preds = %143, %137
  %148 = phi i1 [ false, %137 ], [ %146, %143 ]
  %149 = zext i1 %148 to i8
  store i8 %149, i8* %is_j, align 1
  call void @llvm.dbg.declare(metadata !{i32* %a}, metadata !91), !dbg !93
  %150 = load i32* %lx, align 4, !dbg !93
  store i32 %150, i32* %a, align 4, !dbg !93
  call void @llvm.dbg.declare(metadata !{i32* %gx2}, metadata !94), !dbg !93
  %151 = load i32* %gx, align 4, !dbg !93
  store i32 %151, i32* %gx2, align 4, !dbg !93
  br label %152, !dbg !93

; <label>:152                                     ; preds = %196, %147
  %153 = load i32* %a, align 4, !dbg !93
  %154 = load i32* %shrdLen0, align 4, !dbg !93
  %155 = icmp slt i32 %153, %154, !dbg !93
  br i1 %155, label %156, label %201, !dbg !93

; <label>:156                                     ; preds = %152
  call void @llvm.dbg.declare(metadata !{i32* %i}, metadata !95), !dbg !97
  %157 = load i32* %gx2, align 4, !dbg !97
  %158 = load i32* %radius0, align 4, !dbg !97
  %159 = sub nsw i32 %157, %158, !dbg !97
  store i32 %159, i32* %i, align 4, !dbg !97
  call void @llvm.dbg.declare(metadata !{i8* %is_i}, metadata !98), !dbg !99
  %160 = load i32* %i, align 4, !dbg !99
  %161 = icmp sge i32 %160, 0, !dbg !99
  br i1 %161, label %162, label %166, !dbg !99

; <label>:162                                     ; preds = %156
  %163 = load i32* %i, align 4, !dbg !99
  %164 = load i32* %d0, align 4, !dbg !99
  %165 = icmp slt i32 %163, %164, !dbg !99
  br label %166

; <label>:166                                     ; preds = %162, %156
  %167 = phi i1 [ false, %156 ], [ %165, %162 ]
  %168 = zext i1 %167 to i8
  store i8 %168, i8* %is_i, align 1
  %169 = load i8* %is_i, align 1, !dbg !100
  %170 = trunc i8 %169 to i1, !dbg !100
  br i1 %170, label %171, label %186, !dbg !100

; <label>:171                                     ; preds = %166
  %172 = load i8* %is_j, align 1, !dbg !100
  %173 = trunc i8 %172 to i1, !dbg !100
  br i1 %173, label %174, label %186, !dbg !100

; <label>:174                                     ; preds = %171
  %175 = load i32* %i, align 4, !dbg !100
  %176 = load i32* %s0, align 4, !dbg !100
  %177 = mul nsw i32 %175, %176, !dbg !100
  %178 = load i32* %j, align 4, !dbg !100
  %179 = load i32* %s1, align 4, !dbg !100
  %180 = mul nsw i32 %178, %179, !dbg !100
  %181 = add nsw i32 %177, %180, !dbg !100
  %182 = sext i32 %181 to i64, !dbg !100
  %183 = load i32** %src, align 8, !dbg !100
  %184 = getelementptr inbounds i32* %183, i64 %182, !dbg !100
  %185 = load i32* %184, align 4, !dbg !100
  br label %187, !dbg !100

; <label>:186                                     ; preds = %171, %166
  br label %187, !dbg !100

; <label>:187                                     ; preds = %186, %174
  %188 = phi i32 [ %185, %174 ], [ 0, %186 ], !dbg !100
  %189 = load i32* %b, align 4, !dbg !100
  %190 = load i32* %shrdLen0, align 4, !dbg !100
  %191 = mul nsw i32 %189, %190, !dbg !100
  %192 = load i32* %a, align 4, !dbg !100
  %193 = add nsw i32 %191, %192, !dbg !100
  %194 = sext i32 %193 to i64, !dbg !100
  %195 = getelementptr inbounds [512 x i32]* @_ZZ9convolve2PiS_iS_S_S_S_iiiiiiiiE7shrdMem, i32 0, i64 %194, !dbg !100
  store i32 %188, i32* %195, align 4, !dbg !100
  br label %196, !dbg !101

; <label>:196                                     ; preds = %187
  %197 = load i32* %a, align 4, !dbg !93
  %198 = add nsw i32 %197, 16, !dbg !93
  store i32 %198, i32* %a, align 4, !dbg !93
  %199 = load i32* %gx2, align 4, !dbg !93
  %200 = add nsw i32 %199, 16, !dbg !93
  store i32 %200, i32* %gx2, align 4, !dbg !93
  br label %152, !dbg !93

; <label>:201                                     ; preds = %152
  br label %202, !dbg !102

; <label>:202                                     ; preds = %201
  %203 = load i32* %b, align 4, !dbg !83
  %204 = add nsw i32 %203, 16, !dbg !83
  store i32 %204, i32* %b, align 4, !dbg !83
  %205 = load i32* %gy2, align 4, !dbg !83
  %206 = add nsw i32 %205, 16, !dbg !83
  store i32 %206, i32* %gy2, align 4, !dbg !83
  br label %133, !dbg !83

; <label>:207                                     ; preds = %133
  call void @__syncthreads(), !dbg !103
  %208 = load i32* %gx, align 4, !dbg !104
  %209 = load i32** %5, align 8, !dbg !104
  %210 = getelementptr inbounds i32* %209, i64 0, !dbg !104
  %211 = load i32* %210, align 4, !dbg !104
  %212 = icmp slt i32 %208, %211, !dbg !104
  br i1 %212, label %213, label %288, !dbg !104

; <label>:213                                     ; preds = %207
  %214 = load i32* %gy, align 4, !dbg !104
  %215 = load i32** %5, align 8, !dbg !104
  %216 = getelementptr inbounds i32* %215, i64 1, !dbg !104
  %217 = load i32* %216, align 4, !dbg !104
  %218 = icmp slt i32 %214, %217, !dbg !104
  br i1 %218, label %219, label %288, !dbg !104

; <label>:219                                     ; preds = %213
  call void @llvm.dbg.declare(metadata !{i32* %ci}, metadata !105), !dbg !107
  %220 = load i32* %lx, align 4, !dbg !107
  %221 = load i32* %radius0, align 4, !dbg !107
  %222 = add nsw i32 %220, %221, !dbg !107
  %223 = load i32* %13, align 4, !dbg !107
  %224 = icmp ne i32 %223, 0, !dbg !107
  br i1 %224, label %225, label %226, !dbg !107

; <label>:225                                     ; preds = %219
  br label %229, !dbg !107

; <label>:226                                     ; preds = %219
  %227 = load i32* %14, align 4, !dbg !107
  %228 = ashr i32 %227, 1, !dbg !107
  br label %229, !dbg !107

; <label>:229                                     ; preds = %226, %225
  %230 = phi i32 [ 0, %225 ], [ %228, %226 ], !dbg !107
  %231 = add nsw i32 %222, %230, !dbg !107
  store i32 %231, i32* %ci, align 4, !dbg !107
  call void @llvm.dbg.declare(metadata !{i32* %cj}, metadata !108), !dbg !109
  %232 = load i32* %ly, align 4, !dbg !109
  %233 = load i32* %radius1, align 4, !dbg !109
  %234 = add nsw i32 %232, %233, !dbg !109
  %235 = load i32* %13, align 4, !dbg !109
  %236 = icmp ne i32 %235, 0, !dbg !109
  br i1 %236, label %237, label %238, !dbg !109

; <label>:237                                     ; preds = %229
  br label %241, !dbg !109

; <label>:238                                     ; preds = %229
  %239 = load i32* %15, align 4, !dbg !109
  %240 = ashr i32 %239, 1, !dbg !109
  br label %241, !dbg !109

; <label>:241                                     ; preds = %238, %237
  %242 = phi i32 [ 0, %237 ], [ %240, %238 ], !dbg !109
  %243 = add nsw i32 %234, %242, !dbg !109
  store i32 %243, i32* %cj, align 4, !dbg !109
  call void @llvm.dbg.declare(metadata !{i32* %accum}, metadata !110), !dbg !111
  store i32 0, i32* %accum, align 4, !dbg !111
  call void @llvm.dbg.declare(metadata !{i32* %fj}, metadata !112), !dbg !114
  store i32 0, i32* %fj, align 4, !dbg !114
  br label %244, !dbg !114

; <label>:244                                     ; preds = %273, %241
  %245 = load i32* %fj, align 4, !dbg !114
  %246 = load i32* %15, align 4, !dbg !114
  %247 = icmp slt i32 %245, %246, !dbg !114
  br i1 %247, label %248, label %276, !dbg !114

; <label>:248                                     ; preds = %244
  call void @llvm.dbg.declare(metadata !{i32* %fi}, metadata !115), !dbg !118
  store i32 0, i32* %fi, align 4, !dbg !118
  br label %249, !dbg !118

; <label>:249                                     ; preds = %269, %248
  %250 = load i32* %fi, align 4, !dbg !118
  %251 = load i32* %14, align 4, !dbg !118
  %252 = icmp slt i32 %250, %251, !dbg !118
  br i1 %252, label %253, label %272, !dbg !118

; <label>:253                                     ; preds = %249
  call void @llvm.dbg.declare(metadata !{i32* %s_val}, metadata !119), !dbg !121
  %254 = load i32* %cj, align 4, !dbg !121
  %255 = load i32* %fj, align 4, !dbg !121
  %256 = sub nsw i32 %254, %255, !dbg !121
  %257 = load i32* %shrdLen0, align 4, !dbg !121
  %258 = mul nsw i32 %256, %257, !dbg !121
  %259 = load i32* %ci, align 4, !dbg !121
  %260 = load i32* %fi, align 4, !dbg !121
  %261 = sub nsw i32 %259, %260, !dbg !121
  %262 = add nsw i32 %258, %261, !dbg !121
  %263 = sext i32 %262 to i64, !dbg !121
  %264 = getelementptr inbounds [512 x i32]* @_ZZ9convolve2PiS_iS_S_S_S_iiiiiiiiE7shrdMem, i32 0, i64 %263, !dbg !121
  %265 = load i32* %264, align 4, !dbg !121
  store i32 %265, i32* %s_val, align 4, !dbg !121
  %266 = load i32* %accum, align 4, !dbg !122
  %267 = load i32* %s_val, align 4, !dbg !122
  %268 = add nsw i32 %266, %267, !dbg !122
  store i32 %268, i32* %accum, align 4, !dbg !122
  br label %269, !dbg !123

; <label>:269                                     ; preds = %253
  %270 = load i32* %fi, align 4, !dbg !118
  %271 = add nsw i32 %270, 1, !dbg !118
  store i32 %271, i32* %fi, align 4, !dbg !118
  br label %249, !dbg !118

; <label>:272                                     ; preds = %249
  br label %273, !dbg !124

; <label>:273                                     ; preds = %272
  %274 = load i32* %fj, align 4, !dbg !114
  %275 = add nsw i32 %274, 1, !dbg !114
  store i32 %275, i32* %fj, align 4, !dbg !114
  br label %244, !dbg !114

; <label>:276                                     ; preds = %244
  %277 = load i32* %accum, align 4, !dbg !125
  %278 = load i32* %gy, align 4, !dbg !125
  %279 = load i32** %4, align 8, !dbg !125
  %280 = getelementptr inbounds i32* %279, i64 1, !dbg !125
  %281 = load i32* %280, align 4, !dbg !125
  %282 = mul nsw i32 %278, %281, !dbg !125
  %283 = load i32* %gx, align 4, !dbg !125
  %284 = add nsw i32 %282, %283, !dbg !125
  %285 = sext i32 %284 to i64, !dbg !125
  %286 = load i32** %dst, align 8, !dbg !125
  %287 = getelementptr inbounds i32* %286, i64 %285, !dbg !125
  store i32 %277, i32* %287, align 4, !dbg !125
  br label %288, !dbg !126

; <label>:288                                     ; preds = %276, %213, %207, %117
  ret void, !dbg !127
}

declare void @llvm.dbg.declare(metadata, metadata) nounwind readnone

declare void @__syncthreads() section "__device__"

!llvm.dbg.cu = !{!0}

!0 = metadata !{i32 786449, i32 0, i32 4, metadata !"new-func.cpp", metadata !"/home/mingyuanwu/arrayfire-new-bug", metadata !"clang version 3.2 (tags/RELEASE_32/final)", i1 true, i1 false, metadata !"", i32 0, metadata !1, metadata !1, metadata !3, metadata !11} ; [ DW_TAG_compile_unit ] [/home/mingyuanwu/arrayfire-new-bug/new-func.cpp] [DW_LANG_C_plus_plus]
!1 = metadata !{metadata !2}
!2 = metadata !{i32 0}
!3 = metadata !{metadata !4}
!4 = metadata !{metadata !5}
!5 = metadata !{i32 786478, i32 0, metadata !6, metadata !"convolve2", metadata !"convolve2", metadata !"_Z9convolve2PiS_iS_S_S_S_iiiiiiii", metadata !6, i32 5, metadata !7, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, void (i32*, i32*, i32, i32*, i32*, i32*, i32*, i32, i32, i32, i32, i32, i32, i32, i32)* @_Z9convolve2PiS_iS_S_S_S_iiiiiiii, null, null, metadata !1, i32 7} ; [ DW_TAG_subprogram ] [line 5] [def] [scope 7] [convolve2]
!6 = metadata !{i32 786473, metadata !"new-func.cpp", metadata !"/home/mingyuanwu/arrayfire-new-bug", null} ; [ DW_TAG_file_type ]
!7 = metadata !{i32 786453, i32 0, metadata !"", i32 0, i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !8, i32 0, i32 0} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!8 = metadata !{null, metadata !9, metadata !9, metadata !10, metadata !9, metadata !9, metadata !9, metadata !9, metadata !10, metadata !10, metadata !10, metadata !10, metadata !10, metadata !10, metadata !10, metadata !10}
!9 = metadata !{i32 786447, null, metadata !"", null, i32 0, i64 64, i64 64, i64 0, i32 0, metadata !10} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from int]
!10 = metadata !{i32 786468, null, metadata !"int", null, i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!11 = metadata !{metadata !12}
!12 = metadata !{metadata !13}
!13 = metadata !{i32 786484, i32 0, metadata !5, metadata !"shrdMem", metadata !"shrdMem", metadata !"", metadata !6, i32 9, metadata !14, i32 1, i32 1, [512 x i32]* @_ZZ9convolve2PiS_iS_S_S_S_iiiiiiiiE7shrdMem} ; [ DW_TAG_variable ] [shrdMem] [line 9] [local] [def]
!14 = metadata !{i32 786433, null, metadata !"", null, i32 0, i64 16384, i64 32, i32 0, i32 0, metadata !10, metadata !15, i32 0, i32 0} ; [ DW_TAG_array_type ] [line 0, size 16384, align 32, offset 0] [from int]
!15 = metadata !{metadata !16}
!16 = metadata !{i32 786465, i64 0, i64 511}      ; [ DW_TAG_subrange_type ] [0, 511]
!17 = metadata !{i32 786689, metadata !5, metadata !"out_ptr", metadata !6, i32 16777221, metadata !9, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [out_ptr] [line 5]
!18 = metadata !{i32 5, i32 0, metadata !5, null}
!19 = metadata !{i32 786689, metadata !5, metadata !"signal_ptr", metadata !6, i32 33554437, metadata !9, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [signal_ptr] [line 5]
!20 = metadata !{i32 786689, metadata !5, metadata !"nBBS0", metadata !6, i32 50331653, metadata !10, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [nBBS0] [line 5]
!21 = metadata !{i32 786689, metadata !5, metadata !"out_strides", metadata !6, i32 67108869, metadata !9, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [out_strides] [line 5]
!22 = metadata !{i32 786689, metadata !5, metadata !"out_dims", metadata !6, i32 83886085, metadata !9, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [out_dims] [line 5]
!23 = metadata !{i32 786689, metadata !5, metadata !"signal_strides", metadata !6, i32 100663301, metadata !9, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [signal_strides] [line 5]
!24 = metadata !{i32 786689, metadata !5, metadata !"signal_dims", metadata !6, i32 117440517, metadata !9, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [signal_dims] [line 5]
!25 = metadata !{i32 786689, metadata !5, metadata !"nBBS1", metadata !6, i32 134217734, metadata !10, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [nBBS1] [line 6]
!26 = metadata !{i32 6, i32 0, metadata !5, null}
!27 = metadata !{i32 786689, metadata !5, metadata !"o2", metadata !6, i32 150994950, metadata !10, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [o2] [line 6]
!28 = metadata !{i32 786689, metadata !5, metadata !"o3", metadata !6, i32 167772166, metadata !10, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [o3] [line 6]
!29 = metadata !{i32 786689, metadata !5, metadata !"s2", metadata !6, i32 184549382, metadata !10, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [s2] [line 6]
!30 = metadata !{i32 786689, metadata !5, metadata !"s3", metadata !6, i32 201326598, metadata !10, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [s3] [line 6]
!31 = metadata !{i32 786689, metadata !5, metadata !"expand", metadata !6, i32 218103814, metadata !10, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [expand] [line 6]
!32 = metadata !{i32 786689, metadata !5, metadata !"fLen0", metadata !6, i32 234881030, metadata !10, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [fLen0] [line 6]
!33 = metadata !{i32 786689, metadata !5, metadata !"fLen1", metadata !6, i32 251658246, metadata !10, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [fLen1] [line 6]
!34 = metadata !{i32 786688, metadata !35, metadata !"C_SIZE", metadata !6, i32 8, metadata !36, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [C_SIZE] [line 8]
!35 = metadata !{i32 786443, metadata !5, i32 7, i32 0, metadata !6, i32 0} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire-new-bug/new-func.cpp]
!36 = metadata !{i32 786470, null, metadata !"", null, i32 0, i64 0, i64 0, i64 0, i32 0, metadata !37} ; [ DW_TAG_const_type ] [line 0, size 0, align 0, offset 0] [from unsigned int]
!37 = metadata !{i32 786468, null, metadata !"unsigned int", null, i32 0, i64 32, i64 32, i64 0, i32 0, i32 7} ; [ DW_TAG_base_type ] [unsigned int] [line 0, size 32, align 32, offset 0, enc DW_ATE_unsigned]
!38 = metadata !{i32 8, i32 0, metadata !35, null}
!39 = metadata !{i32 786688, metadata !35, metadata !"radius0", metadata !6, i32 11, metadata !40, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [radius0] [line 11]
!40 = metadata !{i32 786470, null, metadata !"", null, i32 0, i64 0, i64 0, i64 0, i32 0, metadata !10} ; [ DW_TAG_const_type ] [line 0, size 0, align 0, offset 0] [from int]
!41 = metadata !{i32 11, i32 0, metadata !35, null}
!42 = metadata !{i32 786688, metadata !35, metadata !"radius1", metadata !6, i32 12, metadata !40, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [radius1] [line 12]
!43 = metadata !{i32 12, i32 0, metadata !35, null}
!44 = metadata !{i32 786688, metadata !35, metadata !"padding0", metadata !6, i32 13, metadata !40, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [padding0] [line 13]
!45 = metadata !{i32 13, i32 0, metadata !35, null}
!46 = metadata !{i32 786688, metadata !35, metadata !"padding1", metadata !6, i32 14, metadata !40, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [padding1] [line 14]
!47 = metadata !{i32 14, i32 0, metadata !35, null}
!48 = metadata !{i32 786688, metadata !35, metadata !"shrdLen0", metadata !6, i32 15, metadata !40, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [shrdLen0] [line 15]
!49 = metadata !{i32 15, i32 0, metadata !35, null}
!50 = metadata !{i32 786688, metadata !35, metadata !"shrdLen1", metadata !6, i32 16, metadata !40, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [shrdLen1] [line 16]
!51 = metadata !{i32 16, i32 0, metadata !35, null}
!52 = metadata !{i32 786688, metadata !35, metadata !"b0", metadata !6, i32 18, metadata !37, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [b0] [line 18]
!53 = metadata !{i32 18, i32 0, metadata !35, null}
!54 = metadata !{i32 786688, metadata !35, metadata !"b1", metadata !6, i32 19, metadata !37, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [b1] [line 19]
!55 = metadata !{i32 19, i32 0, metadata !35, null}
!56 = metadata !{i32 786688, metadata !35, metadata !"dst", metadata !6, i32 20, metadata !9, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [dst] [line 20]
!57 = metadata !{i32 20, i32 0, metadata !35, null}
!58 = metadata !{i32 23, i32 0, metadata !35, null}
!59 = metadata !{i32 786688, metadata !35, metadata !"src", metadata !6, i32 25, metadata !60, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [src] [line 25]
!60 = metadata !{i32 786447, null, metadata !"", null, i32 0, i64 64, i64 64, i64 0, i32 0, metadata !40} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from ]
!61 = metadata !{i32 25, i32 0, metadata !35, null}
!62 = metadata !{i32 28, i32 0, metadata !35, null}
!63 = metadata !{i32 786688, metadata !35, metadata !"lx", metadata !6, i32 32, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [lx] [line 32]
!64 = metadata !{i32 32, i32 0, metadata !35, null}
!65 = metadata !{i32 786688, metadata !35, metadata !"ly", metadata !6, i32 33, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [ly] [line 33]
!66 = metadata !{i32 33, i32 0, metadata !35, null}
!67 = metadata !{i32 786688, metadata !35, metadata !"gx", metadata !6, i32 34, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [gx] [line 34]
!68 = metadata !{i32 34, i32 0, metadata !35, null}
!69 = metadata !{i32 786688, metadata !35, metadata !"gy", metadata !6, i32 35, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [gy] [line 35]
!70 = metadata !{i32 35, i32 0, metadata !35, null}
!71 = metadata !{i32 37, i32 0, metadata !35, null}
!72 = metadata !{i32 38, i32 0, metadata !35, null}
!73 = metadata !{i32 786688, metadata !35, metadata !"s0", metadata !6, i32 40, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [s0] [line 40]
!74 = metadata !{i32 40, i32 0, metadata !35, null}
!75 = metadata !{i32 786688, metadata !35, metadata !"s1", metadata !6, i32 41, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [s1] [line 41]
!76 = metadata !{i32 41, i32 0, metadata !35, null}
!77 = metadata !{i32 786688, metadata !35, metadata !"d0", metadata !6, i32 42, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [d0] [line 42]
!78 = metadata !{i32 42, i32 0, metadata !35, null}
!79 = metadata !{i32 786688, metadata !35, metadata !"d1", metadata !6, i32 43, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [d1] [line 43]
!80 = metadata !{i32 43, i32 0, metadata !35, null}
!81 = metadata !{i32 786688, metadata !82, metadata !"b", metadata !6, i32 46, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [b] [line 46]
!82 = metadata !{i32 786443, metadata !35, i32 46, i32 0, metadata !6, i32 1} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire-new-bug/new-func.cpp]
!83 = metadata !{i32 46, i32 0, metadata !82, null}
!84 = metadata !{i32 786688, metadata !82, metadata !"gy2", metadata !6, i32 46, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [gy2] [line 46]
!85 = metadata !{i32 786688, metadata !86, metadata !"j", metadata !6, i32 47, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [j] [line 47]
!86 = metadata !{i32 786443, metadata !82, i32 46, i32 0, metadata !6, i32 2} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire-new-bug/new-func.cpp]
!87 = metadata !{i32 47, i32 0, metadata !86, null}
!88 = metadata !{i32 786688, metadata !86, metadata !"is_j", metadata !6, i32 48, metadata !89, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [is_j] [line 48]
!89 = metadata !{i32 786468, null, metadata !"bool", null, i32 0, i64 8, i64 8, i64 0, i32 0, i32 2} ; [ DW_TAG_base_type ] [bool] [line 0, size 8, align 8, offset 0, enc DW_ATE_boolean]
!90 = metadata !{i32 48, i32 0, metadata !86, null}
!91 = metadata !{i32 786688, metadata !92, metadata !"a", metadata !6, i32 50, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [a] [line 50]
!92 = metadata !{i32 786443, metadata !86, i32 50, i32 0, metadata !6, i32 3} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire-new-bug/new-func.cpp]
!93 = metadata !{i32 50, i32 0, metadata !92, null}
!94 = metadata !{i32 786688, metadata !92, metadata !"gx2", metadata !6, i32 50, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [gx2] [line 50]
!95 = metadata !{i32 786688, metadata !96, metadata !"i", metadata !6, i32 51, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [i] [line 51]
!96 = metadata !{i32 786443, metadata !92, i32 50, i32 0, metadata !6, i32 4} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire-new-bug/new-func.cpp]
!97 = metadata !{i32 51, i32 0, metadata !96, null}
!98 = metadata !{i32 786688, metadata !96, metadata !"is_i", metadata !6, i32 52, metadata !89, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [is_i] [line 52]
!99 = metadata !{i32 52, i32 0, metadata !96, null}
!100 = metadata !{i32 53, i32 0, metadata !96, null}
!101 = metadata !{i32 54, i32 0, metadata !96, null}
!102 = metadata !{i32 55, i32 0, metadata !86, null}
!103 = metadata !{i32 56, i32 0, metadata !35, null}
!104 = metadata !{i32 58, i32 0, metadata !35, null}
!105 = metadata !{i32 786688, metadata !106, metadata !"ci", metadata !6, i32 59, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [ci] [line 59]
!106 = metadata !{i32 786443, metadata !35, i32 58, i32 0, metadata !6, i32 5} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire-new-bug/new-func.cpp]
!107 = metadata !{i32 59, i32 0, metadata !106, null}
!108 = metadata !{i32 786688, metadata !106, metadata !"cj", metadata !6, i32 60, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [cj] [line 60]
!109 = metadata !{i32 60, i32 0, metadata !106, null}
!110 = metadata !{i32 786688, metadata !106, metadata !"accum", metadata !6, i32 62, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [accum] [line 62]
!111 = metadata !{i32 62, i32 0, metadata !106, null}
!112 = metadata !{i32 786688, metadata !113, metadata !"fj", metadata !6, i32 63, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [fj] [line 63]
!113 = metadata !{i32 786443, metadata !106, i32 63, i32 0, metadata !6, i32 6} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire-new-bug/new-func.cpp]
!114 = metadata !{i32 63, i32 0, metadata !113, null}
!115 = metadata !{i32 786688, metadata !116, metadata !"fi", metadata !6, i32 64, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [fi] [line 64]
!116 = metadata !{i32 786443, metadata !117, i32 64, i32 0, metadata !6, i32 8} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire-new-bug/new-func.cpp]
!117 = metadata !{i32 786443, metadata !113, i32 63, i32 0, metadata !6, i32 7} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire-new-bug/new-func.cpp]
!118 = metadata !{i32 64, i32 0, metadata !116, null}
!119 = metadata !{i32 786688, metadata !120, metadata !"s_val", metadata !6, i32 66, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [s_val] [line 66]
!120 = metadata !{i32 786443, metadata !116, i32 64, i32 0, metadata !6, i32 9} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire-new-bug/new-func.cpp]
!121 = metadata !{i32 66, i32 0, metadata !120, null}
!122 = metadata !{i32 67, i32 0, metadata !120, null}
!123 = metadata !{i32 68, i32 0, metadata !120, null}
!124 = metadata !{i32 69, i32 0, metadata !117, null}
!125 = metadata !{i32 70, i32 0, metadata !106, null}
!126 = metadata !{i32 71, i32 0, metadata !106, null}
!127 = metadata !{i32 72, i32 0, metadata !35, null}
