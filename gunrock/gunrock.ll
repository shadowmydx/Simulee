; ModuleID = 'gunrock'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.dim3 = type { i32, i32, i32 }

@blockIdx = external global %struct.dim3
@blockDim = external global %struct.dim3
@threadIdx = external global %struct.dim3

define void @_Z4JoiniiPKiS0_PiS0_S0_S0_S1_S1_(i32 %edges, i32 %iter, i32* %pos, i32* %counts, i32* %flag, i32* %intersect, i32* %froms, i32* %tos, i32* %froms_out, i32* %tos_out) uwtable noinline {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32*, align 8
  %4 = alloca i32*, align 8
  %5 = alloca i32*, align 8
  %6 = alloca i32*, align 8
  %7 = alloca i32*, align 8
  %8 = alloca i32*, align 8
  %9 = alloca i32*, align 8
  %10 = alloca i32*, align 8
  %x = alloca i32, align 4
  %tmp = alloca i32, align 4
  %size = alloca i32, align 4
  %a = alloca i32, align 4
  %b = alloca i32, align 4
  %c = alloca i32, align 4
  %d = alloca i32, align 4
  %edge = alloca i32, align 4
  %edge1 = alloca i32, align 4
  %edge2 = alloca i32, align 4
  %edge3 = alloca i32, align 4
  store i32 %edges, i32* %1, align 4
  call void @llvm.dbg.declare(metadata !{i32* %1}, metadata !14), !dbg !15
  store i32 %iter, i32* %2, align 4
  call void @llvm.dbg.declare(metadata !{i32* %2}, metadata !16), !dbg !17
  store i32* %pos, i32** %3, align 8
  call void @llvm.dbg.declare(metadata !{i32** %3}, metadata !18), !dbg !19
  store i32* %counts, i32** %4, align 8
  call void @llvm.dbg.declare(metadata !{i32** %4}, metadata !20), !dbg !21
  store i32* %flag, i32** %5, align 8
  call void @llvm.dbg.declare(metadata !{i32** %5}, metadata !22), !dbg !23
  store i32* %intersect, i32** %6, align 8
  call void @llvm.dbg.declare(metadata !{i32** %6}, metadata !24), !dbg !25
  store i32* %froms, i32** %7, align 8
  call void @llvm.dbg.declare(metadata !{i32** %7}, metadata !26), !dbg !27
  store i32* %tos, i32** %8, align 8
  call void @llvm.dbg.declare(metadata !{i32** %8}, metadata !28), !dbg !29
  store i32* %froms_out, i32** %9, align 8
  call void @llvm.dbg.declare(metadata !{i32** %9}, metadata !30), !dbg !31
  store i32* %tos_out, i32** %10, align 8
  call void @llvm.dbg.declare(metadata !{i32** %10}, metadata !32), !dbg !33
  call void @llvm.dbg.declare(metadata !{i32* %x}, metadata !34), !dbg !36
  %11 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 0), align 4, !dbg !36
  %12 = load i32* getelementptr inbounds (%struct.dim3* @blockDim, i32 0, i32 0), align 4, !dbg !36
  %13 = mul i32 %11, %12, !dbg !36
  %14 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !36
  %15 = add i32 %13, %14, !dbg !36
  store i32 %15, i32* %x, align 4, !dbg !36
  call void @llvm.dbg.declare(metadata !{i32* %tmp}, metadata !37), !dbg !38
  %16 = load i32* %2, align 4, !dbg !38
  %17 = sext i32 %16 to i64, !dbg !38
  %18 = load i32** %3, align 8, !dbg !38
  %19 = getelementptr inbounds i32* %18, i64 %17, !dbg !38
  %20 = load i32* %19, align 4, !dbg !38
  store i32 %20, i32* %tmp, align 4, !dbg !38
  call void @llvm.dbg.declare(metadata !{i32* %size}, metadata !39), !dbg !40
  %21 = load i32* %2, align 4, !dbg !40
  %22 = icmp eq i32 %21, 0, !dbg !40
  br i1 %22, label %23, label %25, !dbg !40

; <label>:23                                      ; preds = %0
  %24 = load i32* %tmp, align 4, !dbg !40
  br label %29, !dbg !40

; <label>:25                                      ; preds = %0
  %26 = load i32** %4, align 8, !dbg !40
  %27 = getelementptr inbounds i32* %26, i64 0, !dbg !40
  %28 = load i32* %27, align 4, !dbg !40
  br label %29, !dbg !40

; <label>:29                                      ; preds = %25, %23
  %30 = phi i32 [ %24, %23 ], [ %28, %25 ], !dbg !40
  %31 = load i32* %2, align 4, !dbg !40
  %32 = add nsw i32 %31, 1, !dbg !40
  %33 = sext i32 %32 to i64, !dbg !40
  %34 = load i32** %3, align 8, !dbg !40
  %35 = getelementptr inbounds i32* %34, i64 %33, !dbg !40
  %36 = load i32* %35, align 4, !dbg !40
  %37 = load i32* %tmp, align 4, !dbg !40
  %38 = sub nsw i32 %36, %37, !dbg !40
  %39 = mul nsw i32 %30, %38, !dbg !40
  store i32 %39, i32* %size, align 4, !dbg !40
  %40 = load i32* %x, align 4, !dbg !41
  %41 = icmp sge i32 %40, 0, !dbg !41
  br i1 %41, label %42, label %332, !dbg !41

; <label>:42                                      ; preds = %29
  %43 = load i32* %x, align 4, !dbg !41
  %44 = load i32* %size, align 4, !dbg !41
  %45 = load i32* %1, align 4, !dbg !41
  %46 = mul nsw i32 %44, %45, !dbg !41
  %47 = icmp slt i32 %43, %46, !dbg !41
  br i1 %47, label %48, label %332, !dbg !41

; <label>:48                                      ; preds = %42
  call void @llvm.dbg.declare(metadata !{i32* %a}, metadata !42), !dbg !44
  %49 = load i32* %x, align 4, !dbg !44
  %50 = load i32* %1, align 4, !dbg !44
  %51 = sdiv i32 %49, %50, !dbg !44
  %52 = load i32* %2, align 4, !dbg !44
  %53 = icmp eq i32 %52, 0, !dbg !44
  br i1 %53, label %54, label %56, !dbg !44

; <label>:54                                      ; preds = %48
  %55 = load i32* %tmp, align 4, !dbg !44
  br label %60, !dbg !44

; <label>:56                                      ; preds = %48
  %57 = load i32** %4, align 8, !dbg !44
  %58 = getelementptr inbounds i32* %57, i64 0, !dbg !44
  %59 = load i32* %58, align 4, !dbg !44
  br label %60, !dbg !44

; <label>:60                                      ; preds = %56, %54
  %61 = phi i32 [ %55, %54 ], [ %59, %56 ], !dbg !44
  %62 = srem i32 %51, %61, !dbg !44
  %63 = load i32* %1, align 4, !dbg !44
  %64 = mul nsw i32 %62, %63, !dbg !44
  store i32 %64, i32* %a, align 4, !dbg !44
  call void @llvm.dbg.declare(metadata !{i32* %b}, metadata !45), !dbg !46
  %65 = load i32* %tmp, align 4, !dbg !46
  %66 = load i32* %x, align 4, !dbg !46
  %67 = load i32* %1, align 4, !dbg !46
  %68 = load i32* %2, align 4, !dbg !46
  %69 = icmp eq i32 %68, 0, !dbg !46
  br i1 %69, label %70, label %72, !dbg !46

; <label>:70                                      ; preds = %60
  %71 = load i32* %tmp, align 4, !dbg !46
  br label %76, !dbg !46

; <label>:72                                      ; preds = %60
  %73 = load i32** %4, align 8, !dbg !46
  %74 = getelementptr inbounds i32* %73, i64 0, !dbg !46
  %75 = load i32* %74, align 4, !dbg !46
  br label %76, !dbg !46

; <label>:76                                      ; preds = %72, %70
  %77 = phi i32 [ %71, %70 ], [ %75, %72 ], !dbg !46
  %78 = mul nsw i32 %67, %77, !dbg !46
  %79 = sdiv i32 %66, %78, !dbg !46
  %80 = add nsw i32 %65, %79, !dbg !46
  store i32 %80, i32* %b, align 4, !dbg !46
  %81 = load i32* %2, align 4, !dbg !47
  %82 = icmp eq i32 %81, 0, !dbg !47
  br i1 %82, label %83, label %110, !dbg !47

; <label>:83                                      ; preds = %76
  %84 = load i32* %x, align 4, !dbg !48
  %85 = load i32* %1, align 4, !dbg !48
  %86 = sdiv i32 %84, %85, !dbg !48
  %87 = load i32* %tmp, align 4, !dbg !48
  %88 = srem i32 %86, %87, !dbg !48
  %89 = sext i32 %88 to i64, !dbg !48
  %90 = load i32** %7, align 8, !dbg !48
  %91 = getelementptr inbounds i32* %90, i64 %89, !dbg !48
  %92 = load i32* %91, align 4, !dbg !48
  %93 = load i32* %a, align 4, !dbg !48
  %94 = sext i32 %93 to i64, !dbg !48
  %95 = load i32** %9, align 8, !dbg !48
  %96 = getelementptr inbounds i32* %95, i64 %94, !dbg !48
  store i32 %92, i32* %96, align 4, !dbg !48
  %97 = load i32* %x, align 4, !dbg !50
  %98 = load i32* %1, align 4, !dbg !50
  %99 = sdiv i32 %97, %98, !dbg !50
  %100 = load i32* %tmp, align 4, !dbg !50
  %101 = srem i32 %99, %100, !dbg !50
  %102 = sext i32 %101 to i64, !dbg !50
  %103 = load i32** %8, align 8, !dbg !50
  %104 = getelementptr inbounds i32* %103, i64 %102, !dbg !50
  %105 = load i32* %104, align 4, !dbg !50
  %106 = load i32* %a, align 4, !dbg !50
  %107 = sext i32 %106 to i64, !dbg !50
  %108 = load i32** %10, align 8, !dbg !50
  %109 = getelementptr inbounds i32* %108, i64 %107, !dbg !50
  store i32 %105, i32* %109, align 4, !dbg !50
  br label %110, !dbg !51

; <label>:110                                     ; preds = %83, %76
  call void @__syncthreads(), !dbg !52
  call void @llvm.dbg.declare(metadata !{i32* %c}, metadata !53), !dbg !54
  %111 = load i32* %2, align 4, !dbg !54
  %112 = mul nsw i32 %111, 2, !dbg !54
  %113 = sext i32 %112 to i64, !dbg !54
  %114 = load i32** %6, align 8, !dbg !54
  %115 = getelementptr inbounds i32* %114, i64 %113, !dbg !54
  %116 = load i32* %115, align 4, !dbg !54
  store i32 %116, i32* %c, align 4, !dbg !54
  call void @llvm.dbg.declare(metadata !{i32* %d}, metadata !55), !dbg !56
  %117 = load i32* %2, align 4, !dbg !56
  %118 = mul nsw i32 %117, 2, !dbg !56
  %119 = add nsw i32 %118, 1, !dbg !56
  %120 = sext i32 %119 to i64, !dbg !56
  %121 = load i32** %6, align 8, !dbg !56
  %122 = getelementptr inbounds i32* %121, i64 %120, !dbg !56
  %123 = load i32* %122, align 4, !dbg !56
  store i32 %123, i32* %d, align 4, !dbg !56
  %124 = load i32* %c, align 4, !dbg !57
  %125 = icmp ne i32 %124, 0, !dbg !57
  br i1 %125, label %126, label %178, !dbg !57

; <label>:126                                     ; preds = %110
  call void @llvm.dbg.declare(metadata !{i32* %edge}, metadata !59), !dbg !61
  %127 = load i32* %c, align 4, !dbg !61
  %128 = sdiv i32 %127, 2, !dbg !61
  store i32 %128, i32* %edge, align 4, !dbg !61
  %129 = load i32* %c, align 4, !dbg !62
  %130 = srem i32 %129, 2, !dbg !62
  %131 = icmp eq i32 %130, 1, !dbg !62
  br i1 %131, label %132, label %154, !dbg !62

; <label>:132                                     ; preds = %126
  %133 = load i32* %a, align 4, !dbg !63
  %134 = load i32* %edge, align 4, !dbg !63
  %135 = add nsw i32 %133, %134, !dbg !63
  %136 = sext i32 %135 to i64, !dbg !63
  %137 = load i32** %9, align 8, !dbg !63
  %138 = getelementptr inbounds i32* %137, i64 %136, !dbg !63
  %139 = load i32* %138, align 4, !dbg !63
  %140 = load i32* %b, align 4, !dbg !63
  %141 = sext i32 %140 to i64, !dbg !63
  %142 = load i32** %7, align 8, !dbg !63
  %143 = getelementptr inbounds i32* %142, i64 %141, !dbg !63
  %144 = load i32* %143, align 4, !dbg !63
  %145 = icmp ne i32 %139, %144, !dbg !63
  br i1 %145, label %146, label %153, !dbg !63

; <label>:146                                     ; preds = %132
  %147 = load i32* %x, align 4, !dbg !65
  %148 = load i32* %1, align 4, !dbg !65
  %149 = sdiv i32 %147, %148, !dbg !65
  %150 = sext i32 %149 to i64, !dbg !65
  %151 = load i32** %5, align 8, !dbg !65
  %152 = getelementptr inbounds i32* %151, i64 %150, !dbg !65
  store i32 0, i32* %152, align 4, !dbg !65
  br label %332, !dbg !67

; <label>:153                                     ; preds = %132
  br label %177, !dbg !68

; <label>:154                                     ; preds = %126
  %155 = load i32* %a, align 4, !dbg !69
  %156 = load i32* %edge, align 4, !dbg !69
  %157 = add nsw i32 %155, %156, !dbg !69
  %158 = sub nsw i32 %157, 1, !dbg !69
  %159 = sext i32 %158 to i64, !dbg !69
  %160 = load i32** %10, align 8, !dbg !69
  %161 = getelementptr inbounds i32* %160, i64 %159, !dbg !69
  %162 = load i32* %161, align 4, !dbg !69
  %163 = load i32* %b, align 4, !dbg !69
  %164 = sext i32 %163 to i64, !dbg !69
  %165 = load i32** %7, align 8, !dbg !69
  %166 = getelementptr inbounds i32* %165, i64 %164, !dbg !69
  %167 = load i32* %166, align 4, !dbg !69
  %168 = icmp ne i32 %162, %167, !dbg !69
  br i1 %168, label %169, label %176, !dbg !69

; <label>:169                                     ; preds = %154
  %170 = load i32* %x, align 4, !dbg !71
  %171 = load i32* %1, align 4, !dbg !71
  %172 = sdiv i32 %170, %171, !dbg !71
  %173 = sext i32 %172 to i64, !dbg !71
  %174 = load i32** %5, align 8, !dbg !71
  %175 = getelementptr inbounds i32* %174, i64 %173, !dbg !71
  store i32 0, i32* %175, align 4, !dbg !71
  br label %332, !dbg !73

; <label>:176                                     ; preds = %154
  br label %177

; <label>:177                                     ; preds = %176, %153
  br label %224, !dbg !74

; <label>:178                                     ; preds = %110
  call void @llvm.dbg.declare(metadata !{i32* %edge1}, metadata !75), !dbg !78
  store i32 0, i32* %edge1, align 4, !dbg !78
  br label %179, !dbg !78

; <label>:179                                     ; preds = %220, %178
  %180 = load i32* %edge1, align 4, !dbg !78
  %181 = load i32* %2, align 4, !dbg !78
  %182 = add nsw i32 %181, 1, !dbg !78
  %183 = icmp slt i32 %180, %182, !dbg !78
  br i1 %183, label %184, label %223, !dbg !78

; <label>:184                                     ; preds = %179
  %185 = load i32* %b, align 4, !dbg !79
  %186 = sext i32 %185 to i64, !dbg !79
  %187 = load i32** %7, align 8, !dbg !79
  %188 = getelementptr inbounds i32* %187, i64 %186, !dbg !79
  %189 = load i32* %188, align 4, !dbg !79
  %190 = load i32* %a, align 4, !dbg !79
  %191 = load i32* %edge1, align 4, !dbg !79
  %192 = add nsw i32 %190, %191, !dbg !79
  %193 = sext i32 %192 to i64, !dbg !79
  %194 = load i32** %9, align 8, !dbg !79
  %195 = getelementptr inbounds i32* %194, i64 %193, !dbg !79
  %196 = load i32* %195, align 4, !dbg !79
  %197 = icmp eq i32 %189, %196, !dbg !79
  br i1 %197, label %212, label %198, !dbg !79

; <label>:198                                     ; preds = %184
  %199 = load i32* %b, align 4, !dbg !79
  %200 = sext i32 %199 to i64, !dbg !79
  %201 = load i32** %7, align 8, !dbg !79
  %202 = getelementptr inbounds i32* %201, i64 %200, !dbg !79
  %203 = load i32* %202, align 4, !dbg !79
  %204 = load i32* %a, align 4, !dbg !79
  %205 = load i32* %edge1, align 4, !dbg !79
  %206 = add nsw i32 %204, %205, !dbg !79
  %207 = sext i32 %206 to i64, !dbg !79
  %208 = load i32** %10, align 8, !dbg !79
  %209 = getelementptr inbounds i32* %208, i64 %207, !dbg !79
  %210 = load i32* %209, align 4, !dbg !79
  %211 = icmp eq i32 %203, %210, !dbg !79
  br i1 %211, label %212, label %219, !dbg !79

; <label>:212                                     ; preds = %198, %184
  %213 = load i32* %x, align 4, !dbg !81
  %214 = load i32* %1, align 4, !dbg !81
  %215 = sdiv i32 %213, %214, !dbg !81
  %216 = sext i32 %215 to i64, !dbg !81
  %217 = load i32** %5, align 8, !dbg !81
  %218 = getelementptr inbounds i32* %217, i64 %216, !dbg !81
  store i32 0, i32* %218, align 4, !dbg !81
  br label %332, !dbg !83

; <label>:219                                     ; preds = %198
  br label %220, !dbg !84

; <label>:220                                     ; preds = %219
  %221 = load i32* %edge1, align 4, !dbg !78
  %222 = add nsw i32 %221, 1, !dbg !78
  store i32 %222, i32* %edge1, align 4, !dbg !78
  br label %179, !dbg !78

; <label>:223                                     ; preds = %179
  br label %224

; <label>:224                                     ; preds = %223, %177
  %225 = load i32* %d, align 4, !dbg !85
  %226 = icmp ne i32 %225, 0, !dbg !85
  br i1 %226, label %227, label %279, !dbg !85

; <label>:227                                     ; preds = %224
  call void @llvm.dbg.declare(metadata !{i32* %edge2}, metadata !87), !dbg !89
  %228 = load i32* %d, align 4, !dbg !89
  %229 = sdiv i32 %228, 2, !dbg !89
  store i32 %229, i32* %edge2, align 4, !dbg !89
  %230 = load i32* %d, align 4, !dbg !90
  %231 = srem i32 %230, 2, !dbg !90
  %232 = icmp eq i32 %231, 1, !dbg !90
  br i1 %232, label %233, label %255, !dbg !90

; <label>:233                                     ; preds = %227
  %234 = load i32* %a, align 4, !dbg !91
  %235 = load i32* %edge2, align 4, !dbg !91
  %236 = add nsw i32 %234, %235, !dbg !91
  %237 = sext i32 %236 to i64, !dbg !91
  %238 = load i32** %9, align 8, !dbg !91
  %239 = getelementptr inbounds i32* %238, i64 %237, !dbg !91
  %240 = load i32* %239, align 4, !dbg !91
  %241 = load i32* %b, align 4, !dbg !91
  %242 = sext i32 %241 to i64, !dbg !91
  %243 = load i32** %8, align 8, !dbg !91
  %244 = getelementptr inbounds i32* %243, i64 %242, !dbg !91
  %245 = load i32* %244, align 4, !dbg !91
  %246 = icmp ne i32 %240, %245, !dbg !91
  br i1 %246, label %247, label %254, !dbg !91

; <label>:247                                     ; preds = %233
  %248 = load i32* %x, align 4, !dbg !93
  %249 = load i32* %1, align 4, !dbg !93
  %250 = sdiv i32 %248, %249, !dbg !93
  %251 = sext i32 %250 to i64, !dbg !93
  %252 = load i32** %5, align 8, !dbg !93
  %253 = getelementptr inbounds i32* %252, i64 %251, !dbg !93
  store i32 0, i32* %253, align 4, !dbg !93
  br label %332, !dbg !95

; <label>:254                                     ; preds = %233
  br label %278, !dbg !96

; <label>:255                                     ; preds = %227
  %256 = load i32* %a, align 4, !dbg !97
  %257 = load i32* %edge2, align 4, !dbg !97
  %258 = add nsw i32 %256, %257, !dbg !97
  %259 = sub nsw i32 %258, 1, !dbg !97
  %260 = sext i32 %259 to i64, !dbg !97
  %261 = load i32** %10, align 8, !dbg !97
  %262 = getelementptr inbounds i32* %261, i64 %260, !dbg !97
  %263 = load i32* %262, align 4, !dbg !97
  %264 = load i32* %b, align 4, !dbg !97
  %265 = sext i32 %264 to i64, !dbg !97
  %266 = load i32** %8, align 8, !dbg !97
  %267 = getelementptr inbounds i32* %266, i64 %265, !dbg !97
  %268 = load i32* %267, align 4, !dbg !97
  %269 = icmp ne i32 %263, %268, !dbg !97
  br i1 %269, label %270, label %277, !dbg !97

; <label>:270                                     ; preds = %255
  %271 = load i32* %x, align 4, !dbg !99
  %272 = load i32* %1, align 4, !dbg !99
  %273 = sdiv i32 %271, %272, !dbg !99
  %274 = sext i32 %273 to i64, !dbg !99
  %275 = load i32** %5, align 8, !dbg !99
  %276 = getelementptr inbounds i32* %275, i64 %274, !dbg !99
  store i32 0, i32* %276, align 4, !dbg !99
  br label %332, !dbg !101

; <label>:277                                     ; preds = %255
  br label %278

; <label>:278                                     ; preds = %277, %254
  br label %325, !dbg !102

; <label>:279                                     ; preds = %224
  call void @llvm.dbg.declare(metadata !{i32* %edge3}, metadata !103), !dbg !106
  store i32 0, i32* %edge3, align 4, !dbg !106
  br label %280, !dbg !106

; <label>:280                                     ; preds = %321, %279
  %281 = load i32* %edge3, align 4, !dbg !106
  %282 = load i32* %2, align 4, !dbg !106
  %283 = add nsw i32 %282, 1, !dbg !106
  %284 = icmp slt i32 %281, %283, !dbg !106
  br i1 %284, label %285, label %324, !dbg !106

; <label>:285                                     ; preds = %280
  %286 = load i32* %b, align 4, !dbg !107
  %287 = sext i32 %286 to i64, !dbg !107
  %288 = load i32** %8, align 8, !dbg !107
  %289 = getelementptr inbounds i32* %288, i64 %287, !dbg !107
  %290 = load i32* %289, align 4, !dbg !107
  %291 = load i32* %a, align 4, !dbg !107
  %292 = load i32* %edge3, align 4, !dbg !107
  %293 = add nsw i32 %291, %292, !dbg !107
  %294 = sext i32 %293 to i64, !dbg !107
  %295 = load i32** %9, align 8, !dbg !107
  %296 = getelementptr inbounds i32* %295, i64 %294, !dbg !107
  %297 = load i32* %296, align 4, !dbg !107
  %298 = icmp eq i32 %290, %297, !dbg !107
  br i1 %298, label %313, label %299, !dbg !107

; <label>:299                                     ; preds = %285
  %300 = load i32* %b, align 4, !dbg !107
  %301 = sext i32 %300 to i64, !dbg !107
  %302 = load i32** %8, align 8, !dbg !107
  %303 = getelementptr inbounds i32* %302, i64 %301, !dbg !107
  %304 = load i32* %303, align 4, !dbg !107
  %305 = load i32* %a, align 4, !dbg !107
  %306 = load i32* %edge3, align 4, !dbg !107
  %307 = add nsw i32 %305, %306, !dbg !107
  %308 = sext i32 %307 to i64, !dbg !107
  %309 = load i32** %10, align 8, !dbg !107
  %310 = getelementptr inbounds i32* %309, i64 %308, !dbg !107
  %311 = load i32* %310, align 4, !dbg !107
  %312 = icmp eq i32 %304, %311, !dbg !107
  br i1 %312, label %313, label %320, !dbg !107

; <label>:313                                     ; preds = %299, %285
  %314 = load i32* %x, align 4, !dbg !109
  %315 = load i32* %1, align 4, !dbg !109
  %316 = sdiv i32 %314, %315, !dbg !109
  %317 = sext i32 %316 to i64, !dbg !109
  %318 = load i32** %5, align 8, !dbg !109
  %319 = getelementptr inbounds i32* %318, i64 %317, !dbg !109
  store i32 0, i32* %319, align 4, !dbg !109
  br label %332, !dbg !111

; <label>:320                                     ; preds = %299
  br label %321, !dbg !112

; <label>:321                                     ; preds = %320
  %322 = load i32* %edge3, align 4, !dbg !106
  %323 = add nsw i32 %322, 1, !dbg !106
  store i32 %323, i32* %edge3, align 4, !dbg !106
  br label %280, !dbg !106

; <label>:324                                     ; preds = %280
  br label %325

; <label>:325                                     ; preds = %324, %278
  %326 = load i32* %x, align 4, !dbg !113
  %327 = load i32* %1, align 4, !dbg !113
  %328 = sdiv i32 %326, %327, !dbg !113
  %329 = sext i32 %328 to i64, !dbg !113
  %330 = load i32** %5, align 8, !dbg !113
  %331 = getelementptr inbounds i32* %330, i64 %329, !dbg !113
  store i32 1, i32* %331, align 4, !dbg !113
  br label %332, !dbg !114

; <label>:332                                     ; preds = %325, %313, %270, %247, %212, %169, %146, %42, %29
  ret void, !dbg !115
}

declare void @llvm.dbg.declare(metadata, metadata) nounwind readnone

declare void @__syncthreads() section "__device__"

!llvm.dbg.cu = !{!0}

!0 = metadata !{i32 786449, i32 0, i32 4, metadata !"gunrock.cpp", metadata !"/home/mingyuanwu/Zhengsx", metadata !"clang version 3.2 (tags/RELEASE_32/final)", i1 true, i1 false, metadata !"", i32 0, metadata !1, metadata !1, metadata !3, metadata !1} ; [ DW_TAG_compile_unit ] [/home/mingyuanwu/Zhengsx/gunrock.cpp] [DW_LANG_C_plus_plus]
!1 = metadata !{metadata !2}
!2 = metadata !{i32 0}
!3 = metadata !{metadata !4}
!4 = metadata !{metadata !5}
!5 = metadata !{i32 786478, i32 0, metadata !6, metadata !"Join", metadata !"Join", metadata !"_Z4JoiniiPKiS0_PiS0_S0_S0_S1_S1_", metadata !6, i32 4, metadata !7, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, void (i32, i32, i32*, i32*, i32*, i32*, i32*, i32*, i32*, i32*)* @_Z4JoiniiPKiS0_PiS0_S0_S0_S1_S1_, null, null, metadata !1, i32 15} ; [ DW_TAG_subprogram ] [line 4] [def] [scope 15] [Join]
!6 = metadata !{i32 786473, metadata !"gunrock.cpp", metadata !"/home/mingyuanwu/Zhengsx", null} ; [ DW_TAG_file_type ]
!7 = metadata !{i32 786453, i32 0, metadata !"", i32 0, i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !8, i32 0, i32 0} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!8 = metadata !{null, metadata !9, metadata !9, metadata !11, metadata !11, metadata !13, metadata !11, metadata !11, metadata !11, metadata !13, metadata !13}
!9 = metadata !{i32 786470, null, metadata !"", null, i32 0, i64 0, i64 0, i64 0, i32 0, metadata !10} ; [ DW_TAG_const_type ] [line 0, size 0, align 0, offset 0] [from int]
!10 = metadata !{i32 786468, null, metadata !"int", null, i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!11 = metadata !{i32 786470, null, metadata !"", null, i32 0, i64 0, i64 0, i64 0, i32 0, metadata !12} ; [ DW_TAG_const_type ] [line 0, size 0, align 0, offset 0] [from ]
!12 = metadata !{i32 786447, null, metadata !"", null, i32 0, i64 64, i64 64, i64 0, i32 0, metadata !9} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from ]
!13 = metadata !{i32 786447, null, metadata !"", null, i32 0, i64 64, i64 64, i64 0, i32 0, metadata !10} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from int]
!14 = metadata !{i32 786689, metadata !5, metadata !"edges", metadata !6, i32 16777221, metadata !9, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [edges] [line 5]
!15 = metadata !{i32 5, i32 0, metadata !5, null}
!16 = metadata !{i32 786689, metadata !5, metadata !"iter", metadata !6, i32 33554438, metadata !9, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [iter] [line 6]
!17 = metadata !{i32 6, i32 0, metadata !5, null}
!18 = metadata !{i32 786689, metadata !5, metadata !"pos", metadata !6, i32 50331655, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [pos] [line 7]
!19 = metadata !{i32 7, i32 0, metadata !5, null}
!20 = metadata !{i32 786689, metadata !5, metadata !"counts", metadata !6, i32 67108872, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [counts] [line 8]
!21 = metadata !{i32 8, i32 0, metadata !5, null}
!22 = metadata !{i32 786689, metadata !5, metadata !"flag", metadata !6, i32 83886089, metadata !13, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [flag] [line 9]
!23 = metadata !{i32 9, i32 0, metadata !5, null}
!24 = metadata !{i32 786689, metadata !5, metadata !"intersect", metadata !6, i32 100663306, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [intersect] [line 10]
!25 = metadata !{i32 10, i32 0, metadata !5, null}
!26 = metadata !{i32 786689, metadata !5, metadata !"froms", metadata !6, i32 117440523, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [froms] [line 11]
!27 = metadata !{i32 11, i32 0, metadata !5, null}
!28 = metadata !{i32 786689, metadata !5, metadata !"tos", metadata !6, i32 134217740, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [tos] [line 12]
!29 = metadata !{i32 12, i32 0, metadata !5, null}
!30 = metadata !{i32 786689, metadata !5, metadata !"froms_out", metadata !6, i32 150994957, metadata !13, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [froms_out] [line 13]
!31 = metadata !{i32 13, i32 0, metadata !5, null}
!32 = metadata !{i32 786689, metadata !5, metadata !"tos_out", metadata !6, i32 167772174, metadata !13, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [tos_out] [line 14]
!33 = metadata !{i32 14, i32 0, metadata !5, null}
!34 = metadata !{i32 786688, metadata !35, metadata !"x", metadata !6, i32 16, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [x] [line 16]
!35 = metadata !{i32 786443, metadata !5, i32 15, i32 0, metadata !6, i32 0} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/Zhengsx/gunrock.cpp]
!36 = metadata !{i32 16, i32 0, metadata !35, null}
!37 = metadata !{i32 786688, metadata !35, metadata !"tmp", metadata !6, i32 17, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [tmp] [line 17]
!38 = metadata !{i32 17, i32 0, metadata !35, null}
!39 = metadata !{i32 786688, metadata !35, metadata !"size", metadata !6, i32 18, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [size] [line 18]
!40 = metadata !{i32 18, i32 0, metadata !35, null}
!41 = metadata !{i32 19, i32 0, metadata !35, null}
!42 = metadata !{i32 786688, metadata !43, metadata !"a", metadata !6, i32 21, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [a] [line 21]
!43 = metadata !{i32 786443, metadata !35, i32 20, i32 0, metadata !6, i32 1} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/Zhengsx/gunrock.cpp]
!44 = metadata !{i32 21, i32 0, metadata !43, null}
!45 = metadata !{i32 786688, metadata !43, metadata !"b", metadata !6, i32 22, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [b] [line 22]
!46 = metadata !{i32 22, i32 0, metadata !43, null}
!47 = metadata !{i32 24, i32 0, metadata !43, null}
!48 = metadata !{i32 25, i32 0, metadata !49, null}
!49 = metadata !{i32 786443, metadata !43, i32 24, i32 0, metadata !6, i32 2} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/Zhengsx/gunrock.cpp]
!50 = metadata !{i32 26, i32 0, metadata !49, null}
!51 = metadata !{i32 27, i32 0, metadata !49, null}
!52 = metadata !{i32 28, i32 0, metadata !43, null}
!53 = metadata !{i32 786688, metadata !43, metadata !"c", metadata !6, i32 30, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [c] [line 30]
!54 = metadata !{i32 30, i32 0, metadata !43, null}
!55 = metadata !{i32 786688, metadata !43, metadata !"d", metadata !6, i32 31, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [d] [line 31]
!56 = metadata !{i32 31, i32 0, metadata !43, null}
!57 = metadata !{i32 33, i32 0, metadata !58, null}
!58 = metadata !{i32 786443, metadata !43, i32 32, i32 0, metadata !6, i32 3} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/Zhengsx/gunrock.cpp]
!59 = metadata !{i32 786688, metadata !60, metadata !"edge", metadata !6, i32 35, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [edge] [line 35]
!60 = metadata !{i32 786443, metadata !58, i32 34, i32 0, metadata !6, i32 4} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/Zhengsx/gunrock.cpp]
!61 = metadata !{i32 35, i32 0, metadata !60, null}
!62 = metadata !{i32 36, i32 0, metadata !60, null}
!63 = metadata !{i32 38, i32 0, metadata !64, null}
!64 = metadata !{i32 786443, metadata !60, i32 37, i32 0, metadata !6, i32 5} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/Zhengsx/gunrock.cpp]
!65 = metadata !{i32 39, i32 0, metadata !66, null}
!66 = metadata !{i32 786443, metadata !64, i32 38, i32 0, metadata !6, i32 6} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/Zhengsx/gunrock.cpp]
!67 = metadata !{i32 40, i32 0, metadata !66, null}
!68 = metadata !{i32 42, i32 0, metadata !64, null}
!69 = metadata !{i32 43, i32 0, metadata !70, null}
!70 = metadata !{i32 786443, metadata !60, i32 42, i32 0, metadata !6, i32 7} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/Zhengsx/gunrock.cpp]
!71 = metadata !{i32 44, i32 0, metadata !72, null}
!72 = metadata !{i32 786443, metadata !70, i32 43, i32 0, metadata !6, i32 8} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/Zhengsx/gunrock.cpp]
!73 = metadata !{i32 45, i32 0, metadata !72, null}
!74 = metadata !{i32 48, i32 0, metadata !60, null}
!75 = metadata !{i32 786688, metadata !76, metadata !"edge", metadata !6, i32 49, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [edge] [line 49]
!76 = metadata !{i32 786443, metadata !77, i32 49, i32 0, metadata !6, i32 10} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/Zhengsx/gunrock.cpp]
!77 = metadata !{i32 786443, metadata !58, i32 48, i32 0, metadata !6, i32 9} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/Zhengsx/gunrock.cpp]
!78 = metadata !{i32 49, i32 0, metadata !76, null}
!79 = metadata !{i32 50, i32 0, metadata !80, null}
!80 = metadata !{i32 786443, metadata !76, i32 49, i32 0, metadata !6, i32 11} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/Zhengsx/gunrock.cpp]
!81 = metadata !{i32 52, i32 0, metadata !82, null}
!82 = metadata !{i32 786443, metadata !80, i32 51, i32 0, metadata !6, i32 12} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/Zhengsx/gunrock.cpp]
!83 = metadata !{i32 53, i32 0, metadata !82, null}
!84 = metadata !{i32 55, i32 0, metadata !80, null}
!85 = metadata !{i32 60, i32 0, metadata !86, null}
!86 = metadata !{i32 786443, metadata !43, i32 59, i32 0, metadata !6, i32 13} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/Zhengsx/gunrock.cpp]
!87 = metadata !{i32 786688, metadata !88, metadata !"edge", metadata !6, i32 61, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [edge] [line 61]
!88 = metadata !{i32 786443, metadata !86, i32 60, i32 0, metadata !6, i32 14} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/Zhengsx/gunrock.cpp]
!89 = metadata !{i32 61, i32 0, metadata !88, null}
!90 = metadata !{i32 62, i32 0, metadata !88, null}
!91 = metadata !{i32 63, i32 0, metadata !92, null}
!92 = metadata !{i32 786443, metadata !88, i32 62, i32 0, metadata !6, i32 15} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/Zhengsx/gunrock.cpp]
!93 = metadata !{i32 64, i32 0, metadata !94, null}
!94 = metadata !{i32 786443, metadata !92, i32 63, i32 0, metadata !6, i32 16} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/Zhengsx/gunrock.cpp]
!95 = metadata !{i32 65, i32 0, metadata !94, null}
!96 = metadata !{i32 67, i32 0, metadata !92, null}
!97 = metadata !{i32 68, i32 0, metadata !98, null}
!98 = metadata !{i32 786443, metadata !88, i32 67, i32 0, metadata !6, i32 17} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/Zhengsx/gunrock.cpp]
!99 = metadata !{i32 69, i32 0, metadata !100, null}
!100 = metadata !{i32 786443, metadata !98, i32 68, i32 0, metadata !6, i32 18} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/Zhengsx/gunrock.cpp]
!101 = metadata !{i32 70, i32 0, metadata !100, null}
!102 = metadata !{i32 73, i32 0, metadata !88, null}
!103 = metadata !{i32 786688, metadata !104, metadata !"edge", metadata !6, i32 74, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [edge] [line 74]
!104 = metadata !{i32 786443, metadata !105, i32 74, i32 0, metadata !6, i32 20} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/Zhengsx/gunrock.cpp]
!105 = metadata !{i32 786443, metadata !86, i32 73, i32 0, metadata !6, i32 19} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/Zhengsx/gunrock.cpp]
!106 = metadata !{i32 74, i32 0, metadata !104, null}
!107 = metadata !{i32 75, i32 0, metadata !108, null}
!108 = metadata !{i32 786443, metadata !104, i32 74, i32 0, metadata !6, i32 21} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/Zhengsx/gunrock.cpp]
!109 = metadata !{i32 76, i32 0, metadata !110, null}
!110 = metadata !{i32 786443, metadata !108, i32 75, i32 0, metadata !6, i32 22} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/Zhengsx/gunrock.cpp]
!111 = metadata !{i32 77, i32 0, metadata !110, null}
!112 = metadata !{i32 79, i32 0, metadata !108, null}
!113 = metadata !{i32 82, i32 0, metadata !43, null}
!114 = metadata !{i32 83, i32 0, metadata !43, null}
!115 = metadata !{i32 84, i32 0, metadata !35, null}
