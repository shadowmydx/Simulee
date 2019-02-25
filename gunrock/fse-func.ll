; ModuleID = 'fse-func'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.dim3 = type { i32, i32, i32 }

@blockIdx = external global %struct.dim3
@blockDim = external global %struct.dim3
@threadIdx = external global %struct.dim3

define void @_Z4JoinPKiS0_PiS0_S0_S0_S1_S1_(i32* %pos, i32* %counts, i32* %flag, i32* %intersect, i32* %froms, i32* %tos, i32* %froms_out, i32* %tos_out) uwtable noinline {
  %1 = alloca i32*, align 8
  %2 = alloca i32*, align 8
  %3 = alloca i32*, align 8
  %4 = alloca i32*, align 8
  %5 = alloca i32*, align 8
  %6 = alloca i32*, align 8
  %7 = alloca i32*, align 8
  %8 = alloca i32*, align 8
  %edges = alloca i32, align 4
  %iter = alloca i32, align 4
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
  store i32* %pos, i32** %1, align 8
  call void @llvm.dbg.declare(metadata !{i32** %1}, metadata !14), !dbg !15
  store i32* %counts, i32** %2, align 8
  call void @llvm.dbg.declare(metadata !{i32** %2}, metadata !16), !dbg !17
  store i32* %flag, i32** %3, align 8
  call void @llvm.dbg.declare(metadata !{i32** %3}, metadata !18), !dbg !19
  store i32* %intersect, i32** %4, align 8
  call void @llvm.dbg.declare(metadata !{i32** %4}, metadata !20), !dbg !21
  store i32* %froms, i32** %5, align 8
  call void @llvm.dbg.declare(metadata !{i32** %5}, metadata !22), !dbg !23
  store i32* %tos, i32** %6, align 8
  call void @llvm.dbg.declare(metadata !{i32** %6}, metadata !24), !dbg !25
  store i32* %froms_out, i32** %7, align 8
  call void @llvm.dbg.declare(metadata !{i32** %7}, metadata !26), !dbg !27
  store i32* %tos_out, i32** %8, align 8
  call void @llvm.dbg.declare(metadata !{i32** %8}, metadata !28), !dbg !29
  call void @llvm.dbg.declare(metadata !{i32* %edges}, metadata !30), !dbg !32
  store i32 1, i32* %edges, align 4, !dbg !32
  call void @llvm.dbg.declare(metadata !{i32* %iter}, metadata !33), !dbg !34
  store i32 0, i32* %iter, align 4, !dbg !34
  call void @llvm.dbg.declare(metadata !{i32* %x}, metadata !35), !dbg !36
  %9 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 0), align 4, !dbg !36
  %10 = load i32* getelementptr inbounds (%struct.dim3* @blockDim, i32 0, i32 0), align 4, !dbg !36
  %11 = mul i32 %9, %10, !dbg !36
  %12 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !36
  %13 = add i32 %11, %12, !dbg !36
  store i32 %13, i32* %x, align 4, !dbg !36
  call void @llvm.dbg.declare(metadata !{i32* %tmp}, metadata !37), !dbg !38
  store i32 50, i32* %tmp, align 4, !dbg !38
  call void @llvm.dbg.declare(metadata !{i32* %size}, metadata !39), !dbg !40
  %14 = load i32* %iter, align 4, !dbg !40
  %15 = icmp eq i32 %14, 0, !dbg !40
  br i1 %15, label %16, label %17, !dbg !40

; <label>:16                                      ; preds = %0
  br label %21, !dbg !40

; <label>:17                                      ; preds = %0
  %18 = load i32** %2, align 8, !dbg !40
  %19 = getelementptr inbounds i32* %18, i64 0, !dbg !40
  %20 = load i32* %19, align 4, !dbg !40
  br label %21, !dbg !40

; <label>:21                                      ; preds = %17, %16
  %22 = phi i32 [ 50, %16 ], [ %20, %17 ], !dbg !40
  %23 = mul nsw i32 %22, 40, !dbg !40
  store i32 %23, i32* %size, align 4, !dbg !40
  %24 = load i32* %x, align 4, !dbg !41
  %25 = icmp sge i32 %24, 0, !dbg !41
  br i1 %25, label %26, label %285, !dbg !41

; <label>:26                                      ; preds = %21
  %27 = load i32* %x, align 4, !dbg !41
  %28 = load i32* %size, align 4, !dbg !41
  %29 = load i32* %edges, align 4, !dbg !41
  %30 = mul nsw i32 %28, %29, !dbg !41
  %31 = icmp slt i32 %27, %30, !dbg !41
  br i1 %31, label %32, label %285, !dbg !41

; <label>:32                                      ; preds = %26
  call void @llvm.dbg.declare(metadata !{i32* %a}, metadata !42), !dbg !44
  %33 = load i32* %x, align 4, !dbg !44
  %34 = load i32* %edges, align 4, !dbg !44
  %35 = sdiv i32 %33, %34, !dbg !44
  %36 = load i32* %tmp, align 4, !dbg !44
  %37 = srem i32 %35, %36, !dbg !44
  %38 = load i32* %edges, align 4, !dbg !44
  %39 = mul nsw i32 %37, %38, !dbg !44
  store i32 %39, i32* %a, align 4, !dbg !44
  call void @llvm.dbg.declare(metadata !{i32* %b}, metadata !45), !dbg !46
  %40 = load i32* %tmp, align 4, !dbg !46
  %41 = load i32* %x, align 4, !dbg !46
  %42 = load i32* %edges, align 4, !dbg !46
  %43 = load i32* %tmp, align 4, !dbg !46
  %44 = mul nsw i32 %42, %43, !dbg !46
  %45 = sdiv i32 %41, %44, !dbg !46
  %46 = add nsw i32 %40, %45, !dbg !46
  store i32 %46, i32* %b, align 4, !dbg !46
  %47 = load i32* %iter, align 4, !dbg !47
  %48 = icmp eq i32 %47, 0, !dbg !47
  br i1 %48, label %49, label %76, !dbg !47

; <label>:49                                      ; preds = %32
  %50 = load i32* %x, align 4, !dbg !48
  %51 = load i32* %edges, align 4, !dbg !48
  %52 = sdiv i32 %50, %51, !dbg !48
  %53 = load i32* %tmp, align 4, !dbg !48
  %54 = srem i32 %52, %53, !dbg !48
  %55 = sext i32 %54 to i64, !dbg !48
  %56 = load i32** %5, align 8, !dbg !48
  %57 = getelementptr inbounds i32* %56, i64 %55, !dbg !48
  %58 = load i32* %57, align 4, !dbg !48
  %59 = load i32* %a, align 4, !dbg !48
  %60 = sext i32 %59 to i64, !dbg !48
  %61 = load i32** %7, align 8, !dbg !48
  %62 = getelementptr inbounds i32* %61, i64 %60, !dbg !48
  store i32 %58, i32* %62, align 4, !dbg !48
  %63 = load i32* %x, align 4, !dbg !50
  %64 = load i32* %edges, align 4, !dbg !50
  %65 = sdiv i32 %63, %64, !dbg !50
  %66 = load i32* %tmp, align 4, !dbg !50
  %67 = srem i32 %65, %66, !dbg !50
  %68 = sext i32 %67 to i64, !dbg !50
  %69 = load i32** %6, align 8, !dbg !50
  %70 = getelementptr inbounds i32* %69, i64 %68, !dbg !50
  %71 = load i32* %70, align 4, !dbg !50
  %72 = load i32* %a, align 4, !dbg !50
  %73 = sext i32 %72 to i64, !dbg !50
  %74 = load i32** %8, align 8, !dbg !50
  %75 = getelementptr inbounds i32* %74, i64 %73, !dbg !50
  store i32 %71, i32* %75, align 4, !dbg !50
  br label %76, !dbg !51

; <label>:76                                      ; preds = %49, %32
  call void @__syncthreads(), !dbg !52
  call void @llvm.dbg.declare(metadata !{i32* %c}, metadata !53), !dbg !54
  store i32 69, i32* %c, align 4, !dbg !54
  call void @llvm.dbg.declare(metadata !{i32* %d}, metadata !55), !dbg !56
  store i32 11, i32* %d, align 4, !dbg !56
  %77 = load i32* %c, align 4, !dbg !57
  %78 = icmp ne i32 %77, 0, !dbg !57
  br i1 %78, label %79, label %131, !dbg !57

; <label>:79                                      ; preds = %76
  call void @llvm.dbg.declare(metadata !{i32* %edge}, metadata !59), !dbg !61
  %80 = load i32* %c, align 4, !dbg !61
  %81 = sdiv i32 %80, 2, !dbg !61
  store i32 %81, i32* %edge, align 4, !dbg !61
  %82 = load i32* %c, align 4, !dbg !62
  %83 = srem i32 %82, 2, !dbg !62
  %84 = icmp eq i32 %83, 1, !dbg !62
  br i1 %84, label %85, label %107, !dbg !62

; <label>:85                                      ; preds = %79
  %86 = load i32* %a, align 4, !dbg !63
  %87 = load i32* %edge, align 4, !dbg !63
  %88 = add nsw i32 %86, %87, !dbg !63
  %89 = sext i32 %88 to i64, !dbg !63
  %90 = load i32** %7, align 8, !dbg !63
  %91 = getelementptr inbounds i32* %90, i64 %89, !dbg !63
  %92 = load i32* %91, align 4, !dbg !63
  %93 = load i32* %b, align 4, !dbg !63
  %94 = sext i32 %93 to i64, !dbg !63
  %95 = load i32** %5, align 8, !dbg !63
  %96 = getelementptr inbounds i32* %95, i64 %94, !dbg !63
  %97 = load i32* %96, align 4, !dbg !63
  %98 = icmp ne i32 %92, %97, !dbg !63
  br i1 %98, label %99, label %106, !dbg !63

; <label>:99                                      ; preds = %85
  %100 = load i32* %x, align 4, !dbg !65
  %101 = load i32* %edges, align 4, !dbg !65
  %102 = sdiv i32 %100, %101, !dbg !65
  %103 = sext i32 %102 to i64, !dbg !65
  %104 = load i32** %3, align 8, !dbg !65
  %105 = getelementptr inbounds i32* %104, i64 %103, !dbg !65
  store i32 0, i32* %105, align 4, !dbg !65
  br label %285, !dbg !67

; <label>:106                                     ; preds = %85
  br label %130, !dbg !68

; <label>:107                                     ; preds = %79
  %108 = load i32* %a, align 4, !dbg !69
  %109 = load i32* %edge, align 4, !dbg !69
  %110 = add nsw i32 %108, %109, !dbg !69
  %111 = sub nsw i32 %110, 1, !dbg !69
  %112 = sext i32 %111 to i64, !dbg !69
  %113 = load i32** %8, align 8, !dbg !69
  %114 = getelementptr inbounds i32* %113, i64 %112, !dbg !69
  %115 = load i32* %114, align 4, !dbg !69
  %116 = load i32* %b, align 4, !dbg !69
  %117 = sext i32 %116 to i64, !dbg !69
  %118 = load i32** %5, align 8, !dbg !69
  %119 = getelementptr inbounds i32* %118, i64 %117, !dbg !69
  %120 = load i32* %119, align 4, !dbg !69
  %121 = icmp ne i32 %115, %120, !dbg !69
  br i1 %121, label %122, label %129, !dbg !69

; <label>:122                                     ; preds = %107
  %123 = load i32* %x, align 4, !dbg !71
  %124 = load i32* %edges, align 4, !dbg !71
  %125 = sdiv i32 %123, %124, !dbg !71
  %126 = sext i32 %125 to i64, !dbg !71
  %127 = load i32** %3, align 8, !dbg !71
  %128 = getelementptr inbounds i32* %127, i64 %126, !dbg !71
  store i32 0, i32* %128, align 4, !dbg !71
  br label %285, !dbg !73

; <label>:129                                     ; preds = %107
  br label %130

; <label>:130                                     ; preds = %129, %106
  br label %177, !dbg !74

; <label>:131                                     ; preds = %76
  call void @llvm.dbg.declare(metadata !{i32* %edge1}, metadata !75), !dbg !78
  store i32 0, i32* %edge1, align 4, !dbg !78
  br label %132, !dbg !78

; <label>:132                                     ; preds = %173, %131
  %133 = load i32* %edge1, align 4, !dbg !78
  %134 = load i32* %iter, align 4, !dbg !78
  %135 = add nsw i32 %134, 1, !dbg !78
  %136 = icmp slt i32 %133, %135, !dbg !78
  br i1 %136, label %137, label %176, !dbg !78

; <label>:137                                     ; preds = %132
  %138 = load i32* %b, align 4, !dbg !79
  %139 = sext i32 %138 to i64, !dbg !79
  %140 = load i32** %5, align 8, !dbg !79
  %141 = getelementptr inbounds i32* %140, i64 %139, !dbg !79
  %142 = load i32* %141, align 4, !dbg !79
  %143 = load i32* %a, align 4, !dbg !79
  %144 = load i32* %edge1, align 4, !dbg !79
  %145 = add nsw i32 %143, %144, !dbg !79
  %146 = sext i32 %145 to i64, !dbg !79
  %147 = load i32** %7, align 8, !dbg !79
  %148 = getelementptr inbounds i32* %147, i64 %146, !dbg !79
  %149 = load i32* %148, align 4, !dbg !79
  %150 = icmp eq i32 %142, %149, !dbg !79
  br i1 %150, label %165, label %151, !dbg !79

; <label>:151                                     ; preds = %137
  %152 = load i32* %b, align 4, !dbg !79
  %153 = sext i32 %152 to i64, !dbg !79
  %154 = load i32** %5, align 8, !dbg !79
  %155 = getelementptr inbounds i32* %154, i64 %153, !dbg !79
  %156 = load i32* %155, align 4, !dbg !79
  %157 = load i32* %a, align 4, !dbg !79
  %158 = load i32* %edge1, align 4, !dbg !79
  %159 = add nsw i32 %157, %158, !dbg !79
  %160 = sext i32 %159 to i64, !dbg !79
  %161 = load i32** %8, align 8, !dbg !79
  %162 = getelementptr inbounds i32* %161, i64 %160, !dbg !79
  %163 = load i32* %162, align 4, !dbg !79
  %164 = icmp eq i32 %156, %163, !dbg !79
  br i1 %164, label %165, label %172, !dbg !79

; <label>:165                                     ; preds = %151, %137
  %166 = load i32* %x, align 4, !dbg !81
  %167 = load i32* %edges, align 4, !dbg !81
  %168 = sdiv i32 %166, %167, !dbg !81
  %169 = sext i32 %168 to i64, !dbg !81
  %170 = load i32** %3, align 8, !dbg !81
  %171 = getelementptr inbounds i32* %170, i64 %169, !dbg !81
  store i32 0, i32* %171, align 4, !dbg !81
  br label %285, !dbg !83

; <label>:172                                     ; preds = %151
  br label %173, !dbg !84

; <label>:173                                     ; preds = %172
  %174 = load i32* %edge1, align 4, !dbg !78
  %175 = add nsw i32 %174, 1, !dbg !78
  store i32 %175, i32* %edge1, align 4, !dbg !78
  br label %132, !dbg !78

; <label>:176                                     ; preds = %132
  br label %177

; <label>:177                                     ; preds = %176, %130
  %178 = load i32* %d, align 4, !dbg !85
  %179 = icmp ne i32 %178, 0, !dbg !85
  br i1 %179, label %180, label %232, !dbg !85

; <label>:180                                     ; preds = %177
  call void @llvm.dbg.declare(metadata !{i32* %edge2}, metadata !87), !dbg !89
  %181 = load i32* %d, align 4, !dbg !89
  %182 = sdiv i32 %181, 2, !dbg !89
  store i32 %182, i32* %edge2, align 4, !dbg !89
  %183 = load i32* %d, align 4, !dbg !90
  %184 = srem i32 %183, 2, !dbg !90
  %185 = icmp eq i32 %184, 1, !dbg !90
  br i1 %185, label %186, label %208, !dbg !90

; <label>:186                                     ; preds = %180
  %187 = load i32* %a, align 4, !dbg !91
  %188 = load i32* %edge2, align 4, !dbg !91
  %189 = add nsw i32 %187, %188, !dbg !91
  %190 = sext i32 %189 to i64, !dbg !91
  %191 = load i32** %7, align 8, !dbg !91
  %192 = getelementptr inbounds i32* %191, i64 %190, !dbg !91
  %193 = load i32* %192, align 4, !dbg !91
  %194 = load i32* %b, align 4, !dbg !91
  %195 = sext i32 %194 to i64, !dbg !91
  %196 = load i32** %6, align 8, !dbg !91
  %197 = getelementptr inbounds i32* %196, i64 %195, !dbg !91
  %198 = load i32* %197, align 4, !dbg !91
  %199 = icmp ne i32 %193, %198, !dbg !91
  br i1 %199, label %200, label %207, !dbg !91

; <label>:200                                     ; preds = %186
  %201 = load i32* %x, align 4, !dbg !93
  %202 = load i32* %edges, align 4, !dbg !93
  %203 = sdiv i32 %201, %202, !dbg !93
  %204 = sext i32 %203 to i64, !dbg !93
  %205 = load i32** %3, align 8, !dbg !93
  %206 = getelementptr inbounds i32* %205, i64 %204, !dbg !93
  store i32 0, i32* %206, align 4, !dbg !93
  br label %285, !dbg !95

; <label>:207                                     ; preds = %186
  br label %231, !dbg !96

; <label>:208                                     ; preds = %180
  %209 = load i32* %a, align 4, !dbg !97
  %210 = load i32* %edge2, align 4, !dbg !97
  %211 = add nsw i32 %209, %210, !dbg !97
  %212 = sub nsw i32 %211, 1, !dbg !97
  %213 = sext i32 %212 to i64, !dbg !97
  %214 = load i32** %8, align 8, !dbg !97
  %215 = getelementptr inbounds i32* %214, i64 %213, !dbg !97
  %216 = load i32* %215, align 4, !dbg !97
  %217 = load i32* %b, align 4, !dbg !97
  %218 = sext i32 %217 to i64, !dbg !97
  %219 = load i32** %6, align 8, !dbg !97
  %220 = getelementptr inbounds i32* %219, i64 %218, !dbg !97
  %221 = load i32* %220, align 4, !dbg !97
  %222 = icmp ne i32 %216, %221, !dbg !97
  br i1 %222, label %223, label %230, !dbg !97

; <label>:223                                     ; preds = %208
  %224 = load i32* %x, align 4, !dbg !99
  %225 = load i32* %edges, align 4, !dbg !99
  %226 = sdiv i32 %224, %225, !dbg !99
  %227 = sext i32 %226 to i64, !dbg !99
  %228 = load i32** %3, align 8, !dbg !99
  %229 = getelementptr inbounds i32* %228, i64 %227, !dbg !99
  store i32 0, i32* %229, align 4, !dbg !99
  br label %285, !dbg !101

; <label>:230                                     ; preds = %208
  br label %231

; <label>:231                                     ; preds = %230, %207
  br label %278, !dbg !102

; <label>:232                                     ; preds = %177
  call void @llvm.dbg.declare(metadata !{i32* %edge3}, metadata !103), !dbg !106
  store i32 0, i32* %edge3, align 4, !dbg !106
  br label %233, !dbg !106

; <label>:233                                     ; preds = %274, %232
  %234 = load i32* %edge3, align 4, !dbg !106
  %235 = load i32* %iter, align 4, !dbg !106
  %236 = add nsw i32 %235, 1, !dbg !106
  %237 = icmp slt i32 %234, %236, !dbg !106
  br i1 %237, label %238, label %277, !dbg !106

; <label>:238                                     ; preds = %233
  %239 = load i32* %b, align 4, !dbg !107
  %240 = sext i32 %239 to i64, !dbg !107
  %241 = load i32** %6, align 8, !dbg !107
  %242 = getelementptr inbounds i32* %241, i64 %240, !dbg !107
  %243 = load i32* %242, align 4, !dbg !107
  %244 = load i32* %a, align 4, !dbg !107
  %245 = load i32* %edge3, align 4, !dbg !107
  %246 = add nsw i32 %244, %245, !dbg !107
  %247 = sext i32 %246 to i64, !dbg !107
  %248 = load i32** %7, align 8, !dbg !107
  %249 = getelementptr inbounds i32* %248, i64 %247, !dbg !107
  %250 = load i32* %249, align 4, !dbg !107
  %251 = icmp eq i32 %243, %250, !dbg !107
  br i1 %251, label %266, label %252, !dbg !107

; <label>:252                                     ; preds = %238
  %253 = load i32* %b, align 4, !dbg !107
  %254 = sext i32 %253 to i64, !dbg !107
  %255 = load i32** %6, align 8, !dbg !107
  %256 = getelementptr inbounds i32* %255, i64 %254, !dbg !107
  %257 = load i32* %256, align 4, !dbg !107
  %258 = load i32* %a, align 4, !dbg !107
  %259 = load i32* %edge3, align 4, !dbg !107
  %260 = add nsw i32 %258, %259, !dbg !107
  %261 = sext i32 %260 to i64, !dbg !107
  %262 = load i32** %8, align 8, !dbg !107
  %263 = getelementptr inbounds i32* %262, i64 %261, !dbg !107
  %264 = load i32* %263, align 4, !dbg !107
  %265 = icmp eq i32 %257, %264, !dbg !107
  br i1 %265, label %266, label %273, !dbg !107

; <label>:266                                     ; preds = %252, %238
  %267 = load i32* %x, align 4, !dbg !109
  %268 = load i32* %edges, align 4, !dbg !109
  %269 = sdiv i32 %267, %268, !dbg !109
  %270 = sext i32 %269 to i64, !dbg !109
  %271 = load i32** %3, align 8, !dbg !109
  %272 = getelementptr inbounds i32* %271, i64 %270, !dbg !109
  store i32 0, i32* %272, align 4, !dbg !109
  br label %285, !dbg !111

; <label>:273                                     ; preds = %252
  br label %274, !dbg !112

; <label>:274                                     ; preds = %273
  %275 = load i32* %edge3, align 4, !dbg !106
  %276 = add nsw i32 %275, 1, !dbg !106
  store i32 %276, i32* %edge3, align 4, !dbg !106
  br label %233, !dbg !106

; <label>:277                                     ; preds = %233
  br label %278

; <label>:278                                     ; preds = %277, %231
  %279 = load i32* %x, align 4, !dbg !113
  %280 = load i32* %edges, align 4, !dbg !113
  %281 = sdiv i32 %279, %280, !dbg !113
  %282 = sext i32 %281 to i64, !dbg !113
  %283 = load i32** %3, align 8, !dbg !113
  %284 = getelementptr inbounds i32* %283, i64 %282, !dbg !113
  store i32 1, i32* %284, align 4, !dbg !113
  br label %285, !dbg !114

; <label>:285                                     ; preds = %278, %266, %223, %200, %165, %122, %99, %26, %21
  ret void, !dbg !115
}

declare void @llvm.dbg.declare(metadata, metadata) nounwind readnone

declare void @__syncthreads() section "__device__"

!llvm.dbg.cu = !{!0}

!0 = metadata !{i32 786449, i32 0, i32 4, metadata !"fse-func.cpp", metadata !"/home/mingyuanwu/Liuyy", metadata !"clang version 3.2 (tags/RELEASE_32/final)", i1 true, i1 false, metadata !"", i32 0, metadata !1, metadata !1, metadata !3, metadata !1} ; [ DW_TAG_compile_unit ] [/home/mingyuanwu/Liuyy/fse-func.cpp] [DW_LANG_C_plus_plus]
!1 = metadata !{metadata !2}
!2 = metadata !{i32 0}
!3 = metadata !{metadata !4}
!4 = metadata !{metadata !5}
!5 = metadata !{i32 786478, i32 0, metadata !6, metadata !"Join", metadata !"Join", metadata !"_Z4JoinPKiS0_PiS0_S0_S0_S1_S1_", metadata !6, i32 4, metadata !7, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, void (i32*, i32*, i32*, i32*, i32*, i32*, i32*, i32*)* @_Z4JoinPKiS0_PiS0_S0_S0_S1_S1_, null, null, metadata !1, i32 13} ; [ DW_TAG_subprogram ] [line 4] [def] [scope 13] [Join]
!6 = metadata !{i32 786473, metadata !"fse-func.cpp", metadata !"/home/mingyuanwu/Liuyy", null} ; [ DW_TAG_file_type ]
!7 = metadata !{i32 786453, i32 0, metadata !"", i32 0, i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !8, i32 0, i32 0} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!8 = metadata !{null, metadata !9, metadata !9, metadata !13, metadata !9, metadata !9, metadata !9, metadata !13, metadata !13}
!9 = metadata !{i32 786470, null, metadata !"", null, i32 0, i64 0, i64 0, i64 0, i32 0, metadata !10} ; [ DW_TAG_const_type ] [line 0, size 0, align 0, offset 0] [from ]
!10 = metadata !{i32 786447, null, metadata !"", null, i32 0, i64 64, i64 64, i64 0, i32 0, metadata !11} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from ]
!11 = metadata !{i32 786470, null, metadata !"", null, i32 0, i64 0, i64 0, i64 0, i32 0, metadata !12} ; [ DW_TAG_const_type ] [line 0, size 0, align 0, offset 0] [from int]
!12 = metadata !{i32 786468, null, metadata !"int", null, i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!13 = metadata !{i32 786447, null, metadata !"", null, i32 0, i64 64, i64 64, i64 0, i32 0, metadata !12} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from int]
!14 = metadata !{i32 786689, metadata !5, metadata !"pos", metadata !6, i32 16777221, metadata !9, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [pos] [line 5]
!15 = metadata !{i32 5, i32 0, metadata !5, null}
!16 = metadata !{i32 786689, metadata !5, metadata !"counts", metadata !6, i32 33554438, metadata !9, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [counts] [line 6]
!17 = metadata !{i32 6, i32 0, metadata !5, null}
!18 = metadata !{i32 786689, metadata !5, metadata !"flag", metadata !6, i32 50331655, metadata !13, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [flag] [line 7]
!19 = metadata !{i32 7, i32 0, metadata !5, null}
!20 = metadata !{i32 786689, metadata !5, metadata !"intersect", metadata !6, i32 67108872, metadata !9, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [intersect] [line 8]
!21 = metadata !{i32 8, i32 0, metadata !5, null}
!22 = metadata !{i32 786689, metadata !5, metadata !"froms", metadata !6, i32 83886089, metadata !9, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [froms] [line 9]
!23 = metadata !{i32 9, i32 0, metadata !5, null}
!24 = metadata !{i32 786689, metadata !5, metadata !"tos", metadata !6, i32 100663306, metadata !9, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [tos] [line 10]
!25 = metadata !{i32 10, i32 0, metadata !5, null}
!26 = metadata !{i32 786689, metadata !5, metadata !"froms_out", metadata !6, i32 117440523, metadata !13, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [froms_out] [line 11]
!27 = metadata !{i32 11, i32 0, metadata !5, null}
!28 = metadata !{i32 786689, metadata !5, metadata !"tos_out", metadata !6, i32 134217740, metadata !13, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [tos_out] [line 12]
!29 = metadata !{i32 12, i32 0, metadata !5, null}
!30 = metadata !{i32 786688, metadata !31, metadata !"edges", metadata !6, i32 14, metadata !12, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [edges] [line 14]
!31 = metadata !{i32 786443, metadata !5, i32 13, i32 0, metadata !6, i32 0} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/Liuyy/fse-func.cpp]
!32 = metadata !{i32 14, i32 0, metadata !31, null}
!33 = metadata !{i32 786688, metadata !31, metadata !"iter", metadata !6, i32 15, metadata !12, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [iter] [line 15]
!34 = metadata !{i32 15, i32 0, metadata !31, null}
!35 = metadata !{i32 786688, metadata !31, metadata !"x", metadata !6, i32 16, metadata !12, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [x] [line 16]
!36 = metadata !{i32 16, i32 0, metadata !31, null}
!37 = metadata !{i32 786688, metadata !31, metadata !"tmp", metadata !6, i32 17, metadata !12, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [tmp] [line 17]
!38 = metadata !{i32 17, i32 0, metadata !31, null}
!39 = metadata !{i32 786688, metadata !31, metadata !"size", metadata !6, i32 18, metadata !12, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [size] [line 18]
!40 = metadata !{i32 18, i32 0, metadata !31, null}
!41 = metadata !{i32 19, i32 0, metadata !31, null}
!42 = metadata !{i32 786688, metadata !43, metadata !"a", metadata !6, i32 21, metadata !12, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [a] [line 21]
!43 = metadata !{i32 786443, metadata !31, i32 20, i32 0, metadata !6, i32 1} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/Liuyy/fse-func.cpp]
!44 = metadata !{i32 21, i32 0, metadata !43, null}
!45 = metadata !{i32 786688, metadata !43, metadata !"b", metadata !6, i32 22, metadata !12, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [b] [line 22]
!46 = metadata !{i32 22, i32 0, metadata !43, null}
!47 = metadata !{i32 24, i32 0, metadata !43, null}
!48 = metadata !{i32 25, i32 0, metadata !49, null}
!49 = metadata !{i32 786443, metadata !43, i32 24, i32 0, metadata !6, i32 2} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/Liuyy/fse-func.cpp]
!50 = metadata !{i32 26, i32 0, metadata !49, null}
!51 = metadata !{i32 27, i32 0, metadata !49, null}
!52 = metadata !{i32 28, i32 0, metadata !43, null}
!53 = metadata !{i32 786688, metadata !43, metadata !"c", metadata !6, i32 30, metadata !12, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [c] [line 30]
!54 = metadata !{i32 30, i32 0, metadata !43, null}
!55 = metadata !{i32 786688, metadata !43, metadata !"d", metadata !6, i32 31, metadata !12, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [d] [line 31]
!56 = metadata !{i32 31, i32 0, metadata !43, null}
!57 = metadata !{i32 33, i32 0, metadata !58, null}
!58 = metadata !{i32 786443, metadata !43, i32 32, i32 0, metadata !6, i32 3} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/Liuyy/fse-func.cpp]
!59 = metadata !{i32 786688, metadata !60, metadata !"edge", metadata !6, i32 35, metadata !12, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [edge] [line 35]
!60 = metadata !{i32 786443, metadata !58, i32 34, i32 0, metadata !6, i32 4} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/Liuyy/fse-func.cpp]
!61 = metadata !{i32 35, i32 0, metadata !60, null}
!62 = metadata !{i32 36, i32 0, metadata !60, null}
!63 = metadata !{i32 38, i32 0, metadata !64, null}
!64 = metadata !{i32 786443, metadata !60, i32 37, i32 0, metadata !6, i32 5} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/Liuyy/fse-func.cpp]
!65 = metadata !{i32 39, i32 0, metadata !66, null}
!66 = metadata !{i32 786443, metadata !64, i32 38, i32 0, metadata !6, i32 6} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/Liuyy/fse-func.cpp]
!67 = metadata !{i32 40, i32 0, metadata !66, null}
!68 = metadata !{i32 42, i32 0, metadata !64, null}
!69 = metadata !{i32 43, i32 0, metadata !70, null}
!70 = metadata !{i32 786443, metadata !60, i32 42, i32 0, metadata !6, i32 7} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/Liuyy/fse-func.cpp]
!71 = metadata !{i32 44, i32 0, metadata !72, null}
!72 = metadata !{i32 786443, metadata !70, i32 43, i32 0, metadata !6, i32 8} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/Liuyy/fse-func.cpp]
!73 = metadata !{i32 45, i32 0, metadata !72, null}
!74 = metadata !{i32 48, i32 0, metadata !60, null}
!75 = metadata !{i32 786688, metadata !76, metadata !"edge", metadata !6, i32 49, metadata !12, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [edge] [line 49]
!76 = metadata !{i32 786443, metadata !77, i32 49, i32 0, metadata !6, i32 10} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/Liuyy/fse-func.cpp]
!77 = metadata !{i32 786443, metadata !58, i32 48, i32 0, metadata !6, i32 9} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/Liuyy/fse-func.cpp]
!78 = metadata !{i32 49, i32 0, metadata !76, null}
!79 = metadata !{i32 50, i32 0, metadata !80, null}
!80 = metadata !{i32 786443, metadata !76, i32 49, i32 0, metadata !6, i32 11} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/Liuyy/fse-func.cpp]
!81 = metadata !{i32 52, i32 0, metadata !82, null}
!82 = metadata !{i32 786443, metadata !80, i32 51, i32 0, metadata !6, i32 12} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/Liuyy/fse-func.cpp]
!83 = metadata !{i32 53, i32 0, metadata !82, null}
!84 = metadata !{i32 55, i32 0, metadata !80, null}
!85 = metadata !{i32 60, i32 0, metadata !86, null}
!86 = metadata !{i32 786443, metadata !43, i32 59, i32 0, metadata !6, i32 13} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/Liuyy/fse-func.cpp]
!87 = metadata !{i32 786688, metadata !88, metadata !"edge", metadata !6, i32 61, metadata !12, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [edge] [line 61]
!88 = metadata !{i32 786443, metadata !86, i32 60, i32 0, metadata !6, i32 14} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/Liuyy/fse-func.cpp]
!89 = metadata !{i32 61, i32 0, metadata !88, null}
!90 = metadata !{i32 62, i32 0, metadata !88, null}
!91 = metadata !{i32 63, i32 0, metadata !92, null}
!92 = metadata !{i32 786443, metadata !88, i32 62, i32 0, metadata !6, i32 15} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/Liuyy/fse-func.cpp]
!93 = metadata !{i32 64, i32 0, metadata !94, null}
!94 = metadata !{i32 786443, metadata !92, i32 63, i32 0, metadata !6, i32 16} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/Liuyy/fse-func.cpp]
!95 = metadata !{i32 65, i32 0, metadata !94, null}
!96 = metadata !{i32 67, i32 0, metadata !92, null}
!97 = metadata !{i32 68, i32 0, metadata !98, null}
!98 = metadata !{i32 786443, metadata !88, i32 67, i32 0, metadata !6, i32 17} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/Liuyy/fse-func.cpp]
!99 = metadata !{i32 69, i32 0, metadata !100, null}
!100 = metadata !{i32 786443, metadata !98, i32 68, i32 0, metadata !6, i32 18} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/Liuyy/fse-func.cpp]
!101 = metadata !{i32 70, i32 0, metadata !100, null}
!102 = metadata !{i32 73, i32 0, metadata !88, null}
!103 = metadata !{i32 786688, metadata !104, metadata !"edge", metadata !6, i32 74, metadata !12, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [edge] [line 74]
!104 = metadata !{i32 786443, metadata !105, i32 74, i32 0, metadata !6, i32 20} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/Liuyy/fse-func.cpp]
!105 = metadata !{i32 786443, metadata !86, i32 73, i32 0, metadata !6, i32 19} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/Liuyy/fse-func.cpp]
!106 = metadata !{i32 74, i32 0, metadata !104, null}
!107 = metadata !{i32 75, i32 0, metadata !108, null}
!108 = metadata !{i32 786443, metadata !104, i32 74, i32 0, metadata !6, i32 21} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/Liuyy/fse-func.cpp]
!109 = metadata !{i32 76, i32 0, metadata !110, null}
!110 = metadata !{i32 786443, metadata !108, i32 75, i32 0, metadata !6, i32 22} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/Liuyy/fse-func.cpp]
!111 = metadata !{i32 77, i32 0, metadata !110, null}
!112 = metadata !{i32 79, i32 0, metadata !108, null}
!113 = metadata !{i32 82, i32 0, metadata !43, null}
!114 = metadata !{i32 83, i32 0, metadata !43, null}
!115 = metadata !{i32 84, i32 0, metadata !31, null}
