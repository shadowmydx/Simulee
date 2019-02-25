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
  store i32 5, i32* %tmp, align 4, !dbg !38
  call void @llvm.dbg.declare(metadata !{i32* %size}, metadata !39), !dbg !40
  store i32 20, i32* %size, align 4, !dbg !40
  %14 = load i32* %x, align 4, !dbg !41
  %15 = icmp sge i32 %14, 0, !dbg !41
  br i1 %15, label %16, label %275, !dbg !41

; <label>:16                                      ; preds = %0
  %17 = load i32* %x, align 4, !dbg !41
  %18 = load i32* %size, align 4, !dbg !41
  %19 = load i32* %edges, align 4, !dbg !41
  %20 = mul nsw i32 %18, %19, !dbg !41
  %21 = icmp slt i32 %17, %20, !dbg !41
  br i1 %21, label %22, label %275, !dbg !41

; <label>:22                                      ; preds = %16
  call void @llvm.dbg.declare(metadata !{i32* %a}, metadata !42), !dbg !44
  %23 = load i32* %x, align 4, !dbg !44
  %24 = load i32* %edges, align 4, !dbg !44
  %25 = sdiv i32 %23, %24, !dbg !44
  %26 = load i32* %tmp, align 4, !dbg !44
  %27 = srem i32 %25, %26, !dbg !44
  %28 = load i32* %edges, align 4, !dbg !44
  %29 = mul nsw i32 %27, %28, !dbg !44
  store i32 %29, i32* %a, align 4, !dbg !44
  call void @llvm.dbg.declare(metadata !{i32* %b}, metadata !45), !dbg !46
  %30 = load i32* %tmp, align 4, !dbg !46
  %31 = load i32* %x, align 4, !dbg !46
  %32 = load i32* %edges, align 4, !dbg !46
  %33 = load i32* %tmp, align 4, !dbg !46
  %34 = mul nsw i32 %32, %33, !dbg !46
  %35 = sdiv i32 %31, %34, !dbg !46
  %36 = add nsw i32 %30, %35, !dbg !46
  store i32 %36, i32* %b, align 4, !dbg !46
  %37 = load i32* %iter, align 4, !dbg !47
  %38 = icmp eq i32 %37, 0, !dbg !47
  br i1 %38, label %39, label %66, !dbg !47

; <label>:39                                      ; preds = %22
  %40 = load i32* %x, align 4, !dbg !48
  %41 = load i32* %edges, align 4, !dbg !48
  %42 = sdiv i32 %40, %41, !dbg !48
  %43 = load i32* %tmp, align 4, !dbg !48
  %44 = srem i32 %42, %43, !dbg !48
  %45 = sext i32 %44 to i64, !dbg !48
  %46 = load i32** %5, align 8, !dbg !48
  %47 = getelementptr inbounds i32* %46, i64 %45, !dbg !48
  %48 = load i32* %47, align 4, !dbg !48
  %49 = load i32* %a, align 4, !dbg !48
  %50 = sext i32 %49 to i64, !dbg !48
  %51 = load i32** %7, align 8, !dbg !48
  %52 = getelementptr inbounds i32* %51, i64 %50, !dbg !48
  store i32 %48, i32* %52, align 4, !dbg !48
  %53 = load i32* %x, align 4, !dbg !50
  %54 = load i32* %edges, align 4, !dbg !50
  %55 = sdiv i32 %53, %54, !dbg !50
  %56 = load i32* %tmp, align 4, !dbg !50
  %57 = srem i32 %55, %56, !dbg !50
  %58 = sext i32 %57 to i64, !dbg !50
  %59 = load i32** %6, align 8, !dbg !50
  %60 = getelementptr inbounds i32* %59, i64 %58, !dbg !50
  %61 = load i32* %60, align 4, !dbg !50
  %62 = load i32* %a, align 4, !dbg !50
  %63 = sext i32 %62 to i64, !dbg !50
  %64 = load i32** %8, align 8, !dbg !50
  %65 = getelementptr inbounds i32* %64, i64 %63, !dbg !50
  store i32 %61, i32* %65, align 4, !dbg !50
  br label %66, !dbg !51

; <label>:66                                      ; preds = %39, %22
  call void @__syncthreads(), !dbg !52
  call void @llvm.dbg.declare(metadata !{i32* %c}, metadata !53), !dbg !54
  store i32 69, i32* %c, align 4, !dbg !54
  call void @llvm.dbg.declare(metadata !{i32* %d}, metadata !55), !dbg !56
  store i32 11, i32* %d, align 4, !dbg !56
  %67 = load i32* %c, align 4, !dbg !57
  %68 = icmp ne i32 %67, 0, !dbg !57
  br i1 %68, label %69, label %121, !dbg !57

; <label>:69                                      ; preds = %66
  call void @llvm.dbg.declare(metadata !{i32* %edge}, metadata !59), !dbg !61
  %70 = load i32* %c, align 4, !dbg !61
  %71 = sdiv i32 %70, 2, !dbg !61
  store i32 %71, i32* %edge, align 4, !dbg !61
  %72 = load i32* %c, align 4, !dbg !62
  %73 = srem i32 %72, 2, !dbg !62
  %74 = icmp eq i32 %73, 1, !dbg !62
  br i1 %74, label %75, label %97, !dbg !62

; <label>:75                                      ; preds = %69
  %76 = load i32* %a, align 4, !dbg !63
  %77 = load i32* %edge, align 4, !dbg !63
  %78 = add nsw i32 %76, %77, !dbg !63
  %79 = sext i32 %78 to i64, !dbg !63
  %80 = load i32** %7, align 8, !dbg !63
  %81 = getelementptr inbounds i32* %80, i64 %79, !dbg !63
  %82 = load i32* %81, align 4, !dbg !63
  %83 = load i32* %b, align 4, !dbg !63
  %84 = sext i32 %83 to i64, !dbg !63
  %85 = load i32** %5, align 8, !dbg !63
  %86 = getelementptr inbounds i32* %85, i64 %84, !dbg !63
  %87 = load i32* %86, align 4, !dbg !63
  %88 = icmp ne i32 %82, %87, !dbg !63
  br i1 %88, label %89, label %96, !dbg !63

; <label>:89                                      ; preds = %75
  %90 = load i32* %x, align 4, !dbg !65
  %91 = load i32* %edges, align 4, !dbg !65
  %92 = sdiv i32 %90, %91, !dbg !65
  %93 = sext i32 %92 to i64, !dbg !65
  %94 = load i32** %3, align 8, !dbg !65
  %95 = getelementptr inbounds i32* %94, i64 %93, !dbg !65
  store i32 0, i32* %95, align 4, !dbg !65
  br label %275, !dbg !67

; <label>:96                                      ; preds = %75
  br label %120, !dbg !68

; <label>:97                                      ; preds = %69
  %98 = load i32* %a, align 4, !dbg !69
  %99 = load i32* %edge, align 4, !dbg !69
  %100 = add nsw i32 %98, %99, !dbg !69
  %101 = sub nsw i32 %100, 1, !dbg !69
  %102 = sext i32 %101 to i64, !dbg !69
  %103 = load i32** %8, align 8, !dbg !69
  %104 = getelementptr inbounds i32* %103, i64 %102, !dbg !69
  %105 = load i32* %104, align 4, !dbg !69
  %106 = load i32* %b, align 4, !dbg !69
  %107 = sext i32 %106 to i64, !dbg !69
  %108 = load i32** %5, align 8, !dbg !69
  %109 = getelementptr inbounds i32* %108, i64 %107, !dbg !69
  %110 = load i32* %109, align 4, !dbg !69
  %111 = icmp ne i32 %105, %110, !dbg !69
  br i1 %111, label %112, label %119, !dbg !69

; <label>:112                                     ; preds = %97
  %113 = load i32* %x, align 4, !dbg !71
  %114 = load i32* %edges, align 4, !dbg !71
  %115 = sdiv i32 %113, %114, !dbg !71
  %116 = sext i32 %115 to i64, !dbg !71
  %117 = load i32** %3, align 8, !dbg !71
  %118 = getelementptr inbounds i32* %117, i64 %116, !dbg !71
  store i32 0, i32* %118, align 4, !dbg !71
  br label %275, !dbg !73

; <label>:119                                     ; preds = %97
  br label %120

; <label>:120                                     ; preds = %119, %96
  br label %167, !dbg !74

; <label>:121                                     ; preds = %66
  call void @llvm.dbg.declare(metadata !{i32* %edge1}, metadata !75), !dbg !78
  store i32 0, i32* %edge1, align 4, !dbg !78
  br label %122, !dbg !78

; <label>:122                                     ; preds = %163, %121
  %123 = load i32* %edge1, align 4, !dbg !78
  %124 = load i32* %iter, align 4, !dbg !78
  %125 = add nsw i32 %124, 1, !dbg !78
  %126 = icmp slt i32 %123, %125, !dbg !78
  br i1 %126, label %127, label %166, !dbg !78

; <label>:127                                     ; preds = %122
  %128 = load i32* %b, align 4, !dbg !79
  %129 = sext i32 %128 to i64, !dbg !79
  %130 = load i32** %5, align 8, !dbg !79
  %131 = getelementptr inbounds i32* %130, i64 %129, !dbg !79
  %132 = load i32* %131, align 4, !dbg !79
  %133 = load i32* %a, align 4, !dbg !79
  %134 = load i32* %edge1, align 4, !dbg !79
  %135 = add nsw i32 %133, %134, !dbg !79
  %136 = sext i32 %135 to i64, !dbg !79
  %137 = load i32** %7, align 8, !dbg !79
  %138 = getelementptr inbounds i32* %137, i64 %136, !dbg !79
  %139 = load i32* %138, align 4, !dbg !79
  %140 = icmp eq i32 %132, %139, !dbg !79
  br i1 %140, label %155, label %141, !dbg !79

; <label>:141                                     ; preds = %127
  %142 = load i32* %b, align 4, !dbg !79
  %143 = sext i32 %142 to i64, !dbg !79
  %144 = load i32** %5, align 8, !dbg !79
  %145 = getelementptr inbounds i32* %144, i64 %143, !dbg !79
  %146 = load i32* %145, align 4, !dbg !79
  %147 = load i32* %a, align 4, !dbg !79
  %148 = load i32* %edge1, align 4, !dbg !79
  %149 = add nsw i32 %147, %148, !dbg !79
  %150 = sext i32 %149 to i64, !dbg !79
  %151 = load i32** %8, align 8, !dbg !79
  %152 = getelementptr inbounds i32* %151, i64 %150, !dbg !79
  %153 = load i32* %152, align 4, !dbg !79
  %154 = icmp eq i32 %146, %153, !dbg !79
  br i1 %154, label %155, label %162, !dbg !79

; <label>:155                                     ; preds = %141, %127
  %156 = load i32* %x, align 4, !dbg !81
  %157 = load i32* %edges, align 4, !dbg !81
  %158 = sdiv i32 %156, %157, !dbg !81
  %159 = sext i32 %158 to i64, !dbg !81
  %160 = load i32** %3, align 8, !dbg !81
  %161 = getelementptr inbounds i32* %160, i64 %159, !dbg !81
  store i32 0, i32* %161, align 4, !dbg !81
  br label %275, !dbg !83

; <label>:162                                     ; preds = %141
  br label %163, !dbg !84

; <label>:163                                     ; preds = %162
  %164 = load i32* %edge1, align 4, !dbg !78
  %165 = add nsw i32 %164, 1, !dbg !78
  store i32 %165, i32* %edge1, align 4, !dbg !78
  br label %122, !dbg !78

; <label>:166                                     ; preds = %122
  br label %167

; <label>:167                                     ; preds = %166, %120
  %168 = load i32* %d, align 4, !dbg !85
  %169 = icmp ne i32 %168, 0, !dbg !85
  br i1 %169, label %170, label %222, !dbg !85

; <label>:170                                     ; preds = %167
  call void @llvm.dbg.declare(metadata !{i32* %edge2}, metadata !87), !dbg !89
  %171 = load i32* %d, align 4, !dbg !89
  %172 = sdiv i32 %171, 2, !dbg !89
  store i32 %172, i32* %edge2, align 4, !dbg !89
  %173 = load i32* %d, align 4, !dbg !90
  %174 = srem i32 %173, 2, !dbg !90
  %175 = icmp eq i32 %174, 1, !dbg !90
  br i1 %175, label %176, label %198, !dbg !90

; <label>:176                                     ; preds = %170
  %177 = load i32* %a, align 4, !dbg !91
  %178 = load i32* %edge2, align 4, !dbg !91
  %179 = add nsw i32 %177, %178, !dbg !91
  %180 = sext i32 %179 to i64, !dbg !91
  %181 = load i32** %7, align 8, !dbg !91
  %182 = getelementptr inbounds i32* %181, i64 %180, !dbg !91
  %183 = load i32* %182, align 4, !dbg !91
  %184 = load i32* %b, align 4, !dbg !91
  %185 = sext i32 %184 to i64, !dbg !91
  %186 = load i32** %6, align 8, !dbg !91
  %187 = getelementptr inbounds i32* %186, i64 %185, !dbg !91
  %188 = load i32* %187, align 4, !dbg !91
  %189 = icmp ne i32 %183, %188, !dbg !91
  br i1 %189, label %190, label %197, !dbg !91

; <label>:190                                     ; preds = %176
  %191 = load i32* %x, align 4, !dbg !93
  %192 = load i32* %edges, align 4, !dbg !93
  %193 = sdiv i32 %191, %192, !dbg !93
  %194 = sext i32 %193 to i64, !dbg !93
  %195 = load i32** %3, align 8, !dbg !93
  %196 = getelementptr inbounds i32* %195, i64 %194, !dbg !93
  store i32 0, i32* %196, align 4, !dbg !93
  br label %275, !dbg !95

; <label>:197                                     ; preds = %176
  br label %221, !dbg !96

; <label>:198                                     ; preds = %170
  %199 = load i32* %a, align 4, !dbg !97
  %200 = load i32* %edge2, align 4, !dbg !97
  %201 = add nsw i32 %199, %200, !dbg !97
  %202 = sub nsw i32 %201, 1, !dbg !97
  %203 = sext i32 %202 to i64, !dbg !97
  %204 = load i32** %8, align 8, !dbg !97
  %205 = getelementptr inbounds i32* %204, i64 %203, !dbg !97
  %206 = load i32* %205, align 4, !dbg !97
  %207 = load i32* %b, align 4, !dbg !97
  %208 = sext i32 %207 to i64, !dbg !97
  %209 = load i32** %6, align 8, !dbg !97
  %210 = getelementptr inbounds i32* %209, i64 %208, !dbg !97
  %211 = load i32* %210, align 4, !dbg !97
  %212 = icmp ne i32 %206, %211, !dbg !97
  br i1 %212, label %213, label %220, !dbg !97

; <label>:213                                     ; preds = %198
  %214 = load i32* %x, align 4, !dbg !99
  %215 = load i32* %edges, align 4, !dbg !99
  %216 = sdiv i32 %214, %215, !dbg !99
  %217 = sext i32 %216 to i64, !dbg !99
  %218 = load i32** %3, align 8, !dbg !99
  %219 = getelementptr inbounds i32* %218, i64 %217, !dbg !99
  store i32 0, i32* %219, align 4, !dbg !99
  br label %275, !dbg !101

; <label>:220                                     ; preds = %198
  br label %221

; <label>:221                                     ; preds = %220, %197
  br label %268, !dbg !102

; <label>:222                                     ; preds = %167
  call void @llvm.dbg.declare(metadata !{i32* %edge3}, metadata !103), !dbg !106
  store i32 0, i32* %edge3, align 4, !dbg !106
  br label %223, !dbg !106

; <label>:223                                     ; preds = %264, %222
  %224 = load i32* %edge3, align 4, !dbg !106
  %225 = load i32* %iter, align 4, !dbg !106
  %226 = add nsw i32 %225, 1, !dbg !106
  %227 = icmp slt i32 %224, %226, !dbg !106
  br i1 %227, label %228, label %267, !dbg !106

; <label>:228                                     ; preds = %223
  %229 = load i32* %b, align 4, !dbg !107
  %230 = sext i32 %229 to i64, !dbg !107
  %231 = load i32** %6, align 8, !dbg !107
  %232 = getelementptr inbounds i32* %231, i64 %230, !dbg !107
  %233 = load i32* %232, align 4, !dbg !107
  %234 = load i32* %a, align 4, !dbg !107
  %235 = load i32* %edge3, align 4, !dbg !107
  %236 = add nsw i32 %234, %235, !dbg !107
  %237 = sext i32 %236 to i64, !dbg !107
  %238 = load i32** %7, align 8, !dbg !107
  %239 = getelementptr inbounds i32* %238, i64 %237, !dbg !107
  %240 = load i32* %239, align 4, !dbg !107
  %241 = icmp eq i32 %233, %240, !dbg !107
  br i1 %241, label %256, label %242, !dbg !107

; <label>:242                                     ; preds = %228
  %243 = load i32* %b, align 4, !dbg !107
  %244 = sext i32 %243 to i64, !dbg !107
  %245 = load i32** %6, align 8, !dbg !107
  %246 = getelementptr inbounds i32* %245, i64 %244, !dbg !107
  %247 = load i32* %246, align 4, !dbg !107
  %248 = load i32* %a, align 4, !dbg !107
  %249 = load i32* %edge3, align 4, !dbg !107
  %250 = add nsw i32 %248, %249, !dbg !107
  %251 = sext i32 %250 to i64, !dbg !107
  %252 = load i32** %8, align 8, !dbg !107
  %253 = getelementptr inbounds i32* %252, i64 %251, !dbg !107
  %254 = load i32* %253, align 4, !dbg !107
  %255 = icmp eq i32 %247, %254, !dbg !107
  br i1 %255, label %256, label %263, !dbg !107

; <label>:256                                     ; preds = %242, %228
  %257 = load i32* %x, align 4, !dbg !109
  %258 = load i32* %edges, align 4, !dbg !109
  %259 = sdiv i32 %257, %258, !dbg !109
  %260 = sext i32 %259 to i64, !dbg !109
  %261 = load i32** %3, align 8, !dbg !109
  %262 = getelementptr inbounds i32* %261, i64 %260, !dbg !109
  store i32 0, i32* %262, align 4, !dbg !109
  br label %275, !dbg !111

; <label>:263                                     ; preds = %242
  br label %264, !dbg !112

; <label>:264                                     ; preds = %263
  %265 = load i32* %edge3, align 4, !dbg !106
  %266 = add nsw i32 %265, 1, !dbg !106
  store i32 %266, i32* %edge3, align 4, !dbg !106
  br label %223, !dbg !106

; <label>:267                                     ; preds = %223
  br label %268

; <label>:268                                     ; preds = %267, %221
  %269 = load i32* %x, align 4, !dbg !113
  %270 = load i32* %edges, align 4, !dbg !113
  %271 = sdiv i32 %269, %270, !dbg !113
  %272 = sext i32 %271 to i64, !dbg !113
  %273 = load i32** %3, align 8, !dbg !113
  %274 = getelementptr inbounds i32* %273, i64 %272, !dbg !113
  store i32 1, i32* %274, align 4, !dbg !113
  br label %275, !dbg !114

; <label>:275                                     ; preds = %268, %256, %213, %190, %155, %112, %89, %16, %0
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
