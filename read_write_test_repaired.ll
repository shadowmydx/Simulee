; ModuleID = 'read_write_test'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.dim3 = type { i32, i32, i32 }
%struct._IO_FILE = type { i32, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, %struct._IO_marker*, %struct._IO_FILE*, i32, i32, i64, i16, i8, [1 x i8], i8*, i64, i8*, i8*, i8*, i8*, i64, i32, [20 x i8] }
%struct._IO_marker = type { %struct._IO_marker*, %struct._IO_FILE*, i32 }

@blockIdx = external global %struct.dim3
@blockDim = external global %struct.dim3
@threadIdx = external global %struct.dim3
@.str = private unnamed_addr constant [34 x i8] c"Unable to allocate memory on host\00", align 1
@.str1 = private unnamed_addr constant [36 x i8] c"Unable to allocate memory on device\00", align 1
@.str2 = private unnamed_addr constant [20 x i8] c"read_write_test.cpp\00", align 1
@.str3 = private unnamed_addr constant [7 x i8] c"%03u, \00", align 1
@.str4 = private unnamed_addr constant [3 x i8] c" \0A\00", align 1
@stderr = external global %struct._IO_FILE*
@.str5 = private unnamed_addr constant [21 x i8] c"GPUassert: %s %s %d\0A\00", align 1

define void @_Z13device_globalPji(i32* %input_array, i32 %num_elements) nounwind uwtable noinline {
    %1 = alloca i32*, align 8
    %2 = alloca i32, align 4
    %my_index = alloca i32, align 4
    store i32* %input_array, i32** %1, align 8
    store i32 %num_elements, i32* %2, align 4
    %3 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 0), align 4, !dbg !154
    %4 = load i32* getelementptr inbounds (%struct.dim3* @blockDim, i32 0, i32 0), align 4, !dbg !154
    %5 = mul i32 %3, %4, !dbg !154
    %6 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !154
    %7 = add i32 %5, %6, !dbg !154
    store i32 %7, i32* %my_index, align 4, !dbg !154
    %8 = load i32* %my_index, align 4, !dbg !155
    %9 = load i32* %2, align 4, !dbg !155
    %10 = icmp slt i32 %8, %9, !dbg !155
    %label0 = load i1 %10
    %label0not = icmp sge i32 %8, %9, !dbg !155
    br label %34


    ; <label>:34
    %label34 = load i1 %label0
    br i1 %label34, label %11, label %35


    ; <label>:11                                      ; preds = %0
    %12 = load i32* %my_index, align 4, !dbg !156
    %13 = srem i32 %12, 2, !dbg !156
    %14 = icmp eq i32 %13, 1, !dbg !156
    %label11 = load i1 %14
    %label11not = icmp ne i32 %13, 1, !dbg !156
    br label %35


    ; <label>:35
    %label35 = load i1 %label0
    %label35 = and i1 %label35, %label11not
    br i1 %label35, label %21, label %36


    ; <label>:21                                      ; preds = %11
    %22 = load i32* %my_index, align 4, !dbg !161
    %23 = add nsw i32 %22, 1, !dbg !161
    %24 = sext i32 %23 to i64, !dbg !161
    %25 = load i32** %1, align 8, !dbg !161
    %26 = getelementptr inbounds i32* %25, i64 %24, !dbg !161
    %27 = load i32* %26, align 4, !dbg !161
    %28 = load i32* %my_index, align 4, !dbg !161
    %29 = sext i32 %28 to i64, !dbg !161
    %30 = load i32** %1, align 8, !dbg !161
    %31 = getelementptr inbounds i32* %30, i64 %29, !dbg !161
    store i32 %27, i32* %31, align 4, !dbg !161
    br label %36


    ; <label>:36
    call void @__syncthreads()
    %label36 = load i1 %label0
    %label36 = and i1 %label36, %label11
    br i1 %label36, label %15, label %37


    ; <label>:15                                      ; preds = %11
    %16 = load i32* %my_index, align 4, !dbg !158
    %17 = load i32* %my_index, align 4, !dbg !158
    %18 = sext i32 %17 to i64, !dbg !158
    %19 = load i32** %1, align 8, !dbg !158
    %20 = getelementptr inbounds i32* %19, i64 %18, !dbg !158
    store i32 %16, i32* %20, align 4, !dbg !158
    br label %37


    ; <label>:37
    %label37 = load i1 %label0
    br i1 %label37, label %32, label %38


    ; <label>:32                                      ; preds = %21, %15
    br label %38


    ; <label>:38
    br label %33


    ; <label>:33                                      ; preds = %32, %0
    ret void, !dbg !164
}

declare void @llvm.dbg.declare(metadata, metadata) nounwind readnone

define i32 @main() uwtable {
  %1 = alloca i32, align 4
  %num_elements = alloca i32, align 4
  %num_bytes = alloca i32, align 4
  %host_array = alloca i32*, align 8
  %device_array = alloca i32*, align 8
  %i = alloca i32, align 4
  %block_size = alloca i32, align 4
  %grid_size = alloca i32, align 4
  %2 = alloca %struct.dim3, align 4
  %3 = alloca %struct.dim3, align 4
  %4 = alloca { i64, i32 }
  %5 = alloca { i64, i32 }
  %i1 = alloca i32, align 4
  store i32 0, i32* %1
  call void @llvm.dbg.declare(metadata !{i32* %num_elements}, metadata !165), !dbg !167
  store i32 100, i32* %num_elements, align 4, !dbg !167
  call void @llvm.dbg.declare(metadata !{i32* %num_bytes}, metadata !168), !dbg !169
  %6 = load i32* %num_elements, align 4, !dbg !169
  %7 = sext i32 %6 to i64, !dbg !169
  %8 = mul i64 4, %7, !dbg !169
  %9 = trunc i64 %8 to i32, !dbg !169
  store i32 %9, i32* %num_bytes, align 4, !dbg !169
  call void @llvm.dbg.declare(metadata !{i32** %host_array}, metadata !170), !dbg !171
  store i32* null, i32** %host_array, align 8, !dbg !171
  call void @llvm.dbg.declare(metadata !{i32** %device_array}, metadata !172), !dbg !173
  store i32* null, i32** %device_array, align 8, !dbg !173
  %10 = load i32* %num_bytes, align 4, !dbg !174
  %11 = sext i32 %10 to i64, !dbg !174
  %12 = call noalias i8* @malloc(i64 %11) nounwind, !dbg !174
  %13 = bitcast i8* %12 to i32*, !dbg !174
  store i32* %13, i32** %host_array, align 8, !dbg !174
  %14 = bitcast i32** %device_array to i8**, !dbg !175
  %15 = load i32* %num_bytes, align 4, !dbg !175
  %16 = sext i32 %15 to i64, !dbg !175
  %17 = call i32 @cudaMalloc(i8** %14, i64 %16), !dbg !175
  %18 = load i32** %host_array, align 8, !dbg !176
  %19 = icmp eq i32* %18, null, !dbg !176
  br i1 %19, label %20, label %22, !dbg !176

; <label>:20                                      ; preds = %0
  %21 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([34 x i8]* @.str, i32 0, i32 0)), !dbg !177
  store i32 1, i32* %1, !dbg !179
  br label %105, !dbg !179

; <label>:22                                      ; preds = %0
  %23 = load i32** %device_array, align 8, !dbg !180
  %24 = icmp eq i32* %23, null, !dbg !180
  br i1 %24, label %25, label %27, !dbg !180

; <label>:25                                      ; preds = %22
  %26 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([36 x i8]* @.str1, i32 0, i32 0)), !dbg !181
  store i32 1, i32* %1, !dbg !183
  br label %105, !dbg !183

; <label>:27                                      ; preds = %22
  call void @llvm.dbg.declare(metadata !{i32* %i}, metadata !184), !dbg !186
  store i32 0, i32* %i, align 4, !dbg !186
  br label %28, !dbg !186

; <label>:28                                      ; preds = %37, %27
  %29 = load i32* %i, align 4, !dbg !186
  %30 = load i32* %num_elements, align 4, !dbg !186
  %31 = icmp slt i32 %29, %30, !dbg !186
  br i1 %31, label %32, label %40, !dbg !186

; <label>:32                                      ; preds = %28
  %33 = load i32* %i, align 4, !dbg !187
  %34 = sext i32 %33 to i64, !dbg !187
  %35 = load i32** %host_array, align 8, !dbg !187
  %36 = getelementptr inbounds i32* %35, i64 %34, !dbg !187
  store i32 1, i32* %36, align 4, !dbg !187
  br label %37, !dbg !189

; <label>:37                                      ; preds = %32
  %38 = load i32* %i, align 4, !dbg !186
  %39 = add nsw i32 %38, 1, !dbg !186
  store i32 %39, i32* %i, align 4, !dbg !186
  br label %28, !dbg !186

; <label>:40                                      ; preds = %28
  %41 = load i32** %device_array, align 8, !dbg !190
  %42 = bitcast i32* %41 to i8*, !dbg !190
  %43 = load i32** %host_array, align 8, !dbg !190
  %44 = bitcast i32* %43 to i8*, !dbg !190
  %45 = load i32* %num_bytes, align 4, !dbg !190
  %46 = sext i32 %45 to i64, !dbg !190
  %47 = call i32 @cudaMemcpy(i8* %42, i8* %44, i64 %46, i32 1), !dbg !190
  call void @llvm.dbg.declare(metadata !{i32* %block_size}, metadata !191), !dbg !192
  store i32 128, i32* %block_size, align 4, !dbg !192
  call void @llvm.dbg.declare(metadata !{i32* %grid_size}, metadata !193), !dbg !194
  %48 = load i32* %num_elements, align 4, !dbg !194
  %49 = load i32* %block_size, align 4, !dbg !194
  %50 = add nsw i32 %48, %49, !dbg !194
  %51 = sub nsw i32 %50, 1, !dbg !194
  %52 = load i32* %block_size, align 4, !dbg !194
  %53 = sdiv i32 %51, %52, !dbg !194
  store i32 %53, i32* %grid_size, align 4, !dbg !194
  %54 = load i32* %grid_size, align 4, !dbg !195
  call void @_ZN4dim3C1Ejjj(%struct.dim3* %2, i32 %54, i32 1, i32 1), !dbg !195
  %55 = load i32* %block_size, align 4, !dbg !195
  call void @_ZN4dim3C1Ejjj(%struct.dim3* %3, i32 %55, i32 1, i32 1), !dbg !195
  %56 = bitcast { i64, i32 }* %4 to i8*, !dbg !195
  %57 = bitcast %struct.dim3* %2 to i8*, !dbg !195
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %56, i8* %57, i64 12, i32 0, i1 false), !dbg !195
  %58 = getelementptr { i64, i32 }* %4, i32 0, i32 0, !dbg !195
  %59 = load i64* %58, align 1, !dbg !195
  %60 = getelementptr { i64, i32 }* %4, i32 0, i32 1, !dbg !195
  %61 = load i32* %60, align 1, !dbg !195
  %62 = bitcast { i64, i32 }* %5 to i8*, !dbg !195
  %63 = bitcast %struct.dim3* %3 to i8*, !dbg !195
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %62, i8* %63, i64 12, i32 0, i1 false), !dbg !195
  %64 = getelementptr { i64, i32 }* %5, i32 0, i32 0, !dbg !195
  %65 = load i64* %64, align 1, !dbg !195
  %66 = getelementptr { i64, i32 }* %5, i32 0, i32 1, !dbg !195
  %67 = load i32* %66, align 1, !dbg !195
  call void (i64, i32, i64, i32, ...)* @__set_CUDAConfig(i64 %59, i32 %61, i64 %65, i32 %67), !dbg !195
  %68 = load i32** %device_array, align 8, !dbg !197
  %69 = load i32* %num_elements, align 4, !dbg !197
  call void @_Z13device_globalPji(i32* %68, i32 %69), !dbg !197
  %70 = call i32 @cudaPeekAtLastError(), !dbg !198
  call void @_Z9gpuAssert9cudaErrorPcib(i32 %70, i8* getelementptr inbounds ([20 x i8]* @.str2, i32 0, i32 0), i32 68, i1 zeroext true), !dbg !198
  %71 = call i32 @cudaDeviceSynchronize(), !dbg !200
  call void @_Z9gpuAssert9cudaErrorPcib(i32 %71, i8* getelementptr inbounds ([20 x i8]* @.str2, i32 0, i32 0), i32 69, i1 zeroext true), !dbg !200
  %72 = load i32** %host_array, align 8, !dbg !202
  %73 = bitcast i32* %72 to i8*, !dbg !202
  %74 = load i32** %device_array, align 8, !dbg !202
  %75 = bitcast i32* %74 to i8*, !dbg !202
  %76 = load i32* %num_bytes, align 4, !dbg !202
  %77 = sext i32 %76 to i64, !dbg !202
  %78 = call i32 @cudaMemcpy(i8* %73, i8* %75, i64 %77, i32 2), !dbg !202
  call void @llvm.dbg.declare(metadata !{i32* %i1}, metadata !203), !dbg !205
  store i32 0, i32* %i1, align 4, !dbg !205
  br label %79, !dbg !205

; <label>:79                                      ; preds = %96, %40
  %80 = load i32* %i1, align 4, !dbg !205
  %81 = load i32* %num_elements, align 4, !dbg !205
  %82 = icmp slt i32 %80, %81, !dbg !205
  br i1 %82, label %83, label %99, !dbg !205

; <label>:83                                      ; preds = %79
  %84 = load i32* %i1, align 4, !dbg !206
  %85 = sext i32 %84 to i64, !dbg !206
  %86 = load i32** %host_array, align 8, !dbg !206
  %87 = getelementptr inbounds i32* %86, i64 %85, !dbg !206
  %88 = load i32* %87, align 4, !dbg !206
  %89 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([7 x i8]* @.str3, i32 0, i32 0), i32 %88), !dbg !206
  %90 = load i32* %i1, align 4, !dbg !208
  %91 = srem i32 %90, 10, !dbg !208
  %92 = icmp eq i32 %91, 9, !dbg !208
  br i1 %92, label %93, label %95, !dbg !208

; <label>:93                                      ; preds = %83
  %94 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([3 x i8]* @.str4, i32 0, i32 0)), !dbg !209
  br label %95, !dbg !211

; <label>:95                                      ; preds = %93, %83
  br label %96, !dbg !212

; <label>:96                                      ; preds = %95
  %97 = load i32* %i1, align 4, !dbg !205
  %98 = add nsw i32 %97, 1, !dbg !205
  store i32 %98, i32* %i1, align 4, !dbg !205
  br label %79, !dbg !205

; <label>:99                                      ; preds = %79
  %100 = load i32** %host_array, align 8, !dbg !213
  %101 = bitcast i32* %100 to i8*, !dbg !213
  call void @free(i8* %101) nounwind, !dbg !213
  %102 = load i32** %device_array, align 8, !dbg !214
  %103 = bitcast i32* %102 to i8*, !dbg !214
  %104 = call i32 @cudaFree(i8* %103), !dbg !214
  br label %105, !dbg !215

; <label>:105                                     ; preds = %99, %25, %20
  %106 = load i32* %1, !dbg !215
  ret i32 %106, !dbg !215
}

declare noalias i8* @malloc(i64) nounwind

declare i32 @cudaMalloc(i8**, i64) section "__device__"

declare i32 @printf(i8*, ...)

declare i32 @cudaMemcpy(i8*, i8*, i64, i32)

declare void @__set_CUDAConfig(i64, i32, i64, i32, ...)

define linkonce_odr void @_ZN4dim3C1Ejjj(%struct.dim3* %this, i32 %vx, i32 %vy, i32 %vz) unnamed_addr uwtable section "__device__" align 2 {
  %1 = alloca %struct.dim3*, align 8
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store %struct.dim3* %this, %struct.dim3** %1, align 8
  call void @llvm.dbg.declare(metadata !{%struct.dim3** %1}, metadata !216), !dbg !218
  store i32 %vx, i32* %2, align 4
  call void @llvm.dbg.declare(metadata !{i32* %2}, metadata !219), !dbg !218
  store i32 %vy, i32* %3, align 4
  call void @llvm.dbg.declare(metadata !{i32* %3}, metadata !220), !dbg !218
  store i32 %vz, i32* %4, align 4
  call void @llvm.dbg.declare(metadata !{i32* %4}, metadata !221), !dbg !218
  %5 = load %struct.dim3** %1
  %6 = load i32* %2, align 4, !dbg !218
  %7 = load i32* %3, align 4, !dbg !218
  %8 = load i32* %4, align 4, !dbg !218
  call void @_ZN4dim3C2Ejjj(%struct.dim3* %5, i32 %6, i32 %7, i32 %8), !dbg !218
  ret void, !dbg !218
}

declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture, i8* nocapture, i64, i32, i1) nounwind

define linkonce_odr void @_Z9gpuAssert9cudaErrorPcib(i32 %code, i8* %file, i32 %line, i1 zeroext %abort) uwtable inlinehint {
  %1 = alloca i32, align 4
  %2 = alloca i8*, align 8
  %3 = alloca i32, align 4
  %4 = alloca i8, align 1
  store i32 %code, i32* %1, align 4
  call void @llvm.dbg.declare(metadata !{i32* %1}, metadata !222), !dbg !223
  store i8* %file, i8** %2, align 8
  call void @llvm.dbg.declare(metadata !{i8** %2}, metadata !224), !dbg !223
  store i32 %line, i32* %3, align 4
  call void @llvm.dbg.declare(metadata !{i32* %3}, metadata !225), !dbg !223
  %5 = zext i1 %abort to i8
  store i8 %5, i8* %4, align 1
  call void @llvm.dbg.declare(metadata !{i8* %4}, metadata !226), !dbg !223
  %6 = load i32* %1, align 4, !dbg !227
  %7 = icmp ne i32 %6, 0, !dbg !227
  br i1 %7, label %8, label %20, !dbg !227

; <label>:8                                       ; preds = %0
  %9 = load %struct._IO_FILE** @stderr, align 8, !dbg !229
  %10 = load i32* %1, align 4, !dbg !229
  %11 = call i8* @cudaGetErrorString(i32 %10), !dbg !229
  %12 = load i8** %2, align 8, !dbg !229
  %13 = load i32* %3, align 4, !dbg !229
  %14 = call i32 (%struct._IO_FILE*, i8*, ...)* @fprintf(%struct._IO_FILE* %9, i8* getelementptr inbounds ([21 x i8]* @.str5, i32 0, i32 0), i8* %11, i8* %12, i32 %13), !dbg !229
  %15 = load i8* %4, align 1, !dbg !231
  %16 = trunc i8 %15 to i1, !dbg !231
  br i1 %16, label %17, label %19, !dbg !231

; <label>:17                                      ; preds = %8
  %18 = load i32* %1, align 4, !dbg !231
  call void @exit(i32 %18) noreturn nounwind, !dbg !231
  unreachable, !dbg !231

; <label>:19                                      ; preds = %8
  br label %20, !dbg !232

; <label>:20                                      ; preds = %19, %0
  ret void, !dbg !233
}

declare i32 @cudaPeekAtLastError() section "__device__"

declare i32 @cudaDeviceSynchronize() section "__device__"

declare void @free(i8*) nounwind

declare i32 @cudaFree(i8*) section "__device__"

declare i32 @fprintf(%struct._IO_FILE*, i8*, ...)

declare i8* @cudaGetErrorString(i32) section "__device__"

declare void @exit(i32) noreturn nounwind

define linkonce_odr void @_ZN4dim3C2Ejjj(%struct.dim3* %this, i32 %vx, i32 %vy, i32 %vz) unnamed_addr nounwind uwtable section "__device__" align 2 {
  %1 = alloca %struct.dim3*, align 8
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store %struct.dim3* %this, %struct.dim3** %1, align 8
  call void @llvm.dbg.declare(metadata !{%struct.dim3** %1}, metadata !234), !dbg !235
  store i32 %vx, i32* %2, align 4
  call void @llvm.dbg.declare(metadata !{i32* %2}, metadata !236), !dbg !235
  store i32 %vy, i32* %3, align 4
  call void @llvm.dbg.declare(metadata !{i32* %3}, metadata !237), !dbg !235
  store i32 %vz, i32* %4, align 4
  call void @llvm.dbg.declare(metadata !{i32* %4}, metadata !238), !dbg !235
  %5 = load %struct.dim3** %1
  %6 = getelementptr inbounds %struct.dim3* %5, i32 0, i32 0, !dbg !235
  %7 = load i32* %2, align 4, !dbg !235
  store i32 %7, i32* %6, align 4, !dbg !235
  %8 = getelementptr inbounds %struct.dim3* %5, i32 0, i32 1, !dbg !235
  %9 = load i32* %3, align 4, !dbg !235
  store i32 %9, i32* %8, align 4, !dbg !235
  %10 = getelementptr inbounds %struct.dim3* %5, i32 0, i32 2, !dbg !235
  %11 = load i32* %4, align 4, !dbg !235
  store i32 %11, i32* %10, align 4, !dbg !235
  ret void, !dbg !239
}

!llvm.dbg.cu = !{!0}

!0 = metadata !{i32 786449, i32 0, i32 4, metadata !"read_write_test.cpp", metadata !"/home/mingyuanwu", metadata !"clang version 3.2 (tags/RELEASE_32/final)", i1 true, i1 false, metadata !"", i32 0, metadata !1, metadata !85, metadata !87, metadata !85} ; [ DW_TAG_compile_unit ] [/home/mingyuanwu/read_write_test.cpp] [DW_LANG_C_plus_plus]
!1 = metadata !{metadata !2}
!2 = metadata !{metadata !3, metadata !11}
!3 = metadata !{i32 786436, null, metadata !"cudaMemcpyKind", metadata !4, i32 705, i64 32, i64 32, i32 0, i32 0, null, metadata !5, i32 0, i32 0} ; [ DW_TAG_enumeration_type ] [cudaMemcpyKind] [line 705, size 32, align 32, offset 0] [from ]
!4 = metadata !{i32 786473, metadata !"/home/mingyuanwu/gklee/Gklee/Gklee/include/cuda/driver_types.h", metadata !"/home/mingyuanwu", null} ; [ DW_TAG_file_type ]
!5 = metadata !{metadata !6, metadata !7, metadata !8, metadata !9, metadata !10}
!6 = metadata !{i32 786472, metadata !"cudaMemcpyHostToHost", i64 0} ; [ DW_TAG_enumerator ] [cudaMemcpyHostToHost :: 0]
!7 = metadata !{i32 786472, metadata !"cudaMemcpyHostToDevice", i64 1} ; [ DW_TAG_enumerator ] [cudaMemcpyHostToDevice :: 1]
!8 = metadata !{i32 786472, metadata !"cudaMemcpyDeviceToHost", i64 2} ; [ DW_TAG_enumerator ] [cudaMemcpyDeviceToHost :: 2]
!9 = metadata !{i32 786472, metadata !"cudaMemcpyDeviceToDevice", i64 3} ; [ DW_TAG_enumerator ] [cudaMemcpyDeviceToDevice :: 3]
!10 = metadata !{i32 786472, metadata !"cudaMemcpyDefault", i64 4} ; [ DW_TAG_enumerator ] [cudaMemcpyDefault :: 4]
!11 = metadata !{i32 786436, null, metadata !"cudaError", metadata !4, i32 124, i64 32, i64 32, i32 0, i32 0, null, metadata !12, i32 0, i32 0} ; [ DW_TAG_enumeration_type ] [cudaError] [line 124, size 32, align 32, offset 0] [from ]
!12 = metadata !{metadata !13, metadata !14, metadata !15, metadata !16, metadata !17, metadata !18, metadata !19, metadata !20, metadata !21, metadata !22, metadata !23, metadata !24, metadata !25, metadata !26, metadata !27, metadata !28, metadata !29, metadata !30, metadata !31, metadata !32, metadata !33, metadata !34, metadata !35, metadata !36, metadata !37, metadata !38, metadata !39, metadata !40, metadata !41, metadata !42, metadata !43, metadata !44, metadata !45, metadata !46, metadata !47, metadata !48, metadata !49, metadata !50, metadata !51, metadata !52, metadata !53, metadata !54, metadata !55, metadata !56, metadata !57, metadata !58, metadata !59, metadata !60, metadata !61, metadata !62, metadata !63, metadata !64, metadata !65, metadata !66, metadata !67, metadata !68, metadata !69, metadata !70, metadata !71, metadata !72, metadata !73, metadata !74, metadata !75, metadata !76, metadata !77, metadata !78, metadata !79, metadata !80, metadata !81, metadata !82, metadata !83, metadata !84}
!13 = metadata !{i32 786472, metadata !"cudaSuccess", i64 0} ; [ DW_TAG_enumerator ] [cudaSuccess :: 0]
!14 = metadata !{i32 786472, metadata !"cudaErrorMissingConfiguration", i64 1} ; [ DW_TAG_enumerator ] [cudaErrorMissingConfiguration :: 1]
!15 = metadata !{i32 786472, metadata !"cudaErrorMemoryAllocation", i64 2} ; [ DW_TAG_enumerator ] [cudaErrorMemoryAllocation :: 2]
!16 = metadata !{i32 786472, metadata !"cudaErrorInitializationError", i64 3} ; [ DW_TAG_enumerator ] [cudaErrorInitializationError :: 3]
!17 = metadata !{i32 786472, metadata !"cudaErrorLaunchFailure", i64 4} ; [ DW_TAG_enumerator ] [cudaErrorLaunchFailure :: 4]
!18 = metadata !{i32 786472, metadata !"cudaErrorPriorLaunchFailure", i64 5} ; [ DW_TAG_enumerator ] [cudaErrorPriorLaunchFailure :: 5]
!19 = metadata !{i32 786472, metadata !"cudaErrorLaunchTimeout", i64 6} ; [ DW_TAG_enumerator ] [cudaErrorLaunchTimeout :: 6]
!20 = metadata !{i32 786472, metadata !"cudaErrorLaunchOutOfResources", i64 7} ; [ DW_TAG_enumerator ] [cudaErrorLaunchOutOfResources :: 7]
!21 = metadata !{i32 786472, metadata !"cudaErrorInvalidDeviceFunction", i64 8} ; [ DW_TAG_enumerator ] [cudaErrorInvalidDeviceFunction :: 8]
!22 = metadata !{i32 786472, metadata !"cudaErrorInvalidConfiguration", i64 9} ; [ DW_TAG_enumerator ] [cudaErrorInvalidConfiguration :: 9]
!23 = metadata !{i32 786472, metadata !"cudaErrorInvalidDevice", i64 10} ; [ DW_TAG_enumerator ] [cudaErrorInvalidDevice :: 10]
!24 = metadata !{i32 786472, metadata !"cudaErrorInvalidValue", i64 11} ; [ DW_TAG_enumerator ] [cudaErrorInvalidValue :: 11]
!25 = metadata !{i32 786472, metadata !"cudaErrorInvalidPitchValue", i64 12} ; [ DW_TAG_enumerator ] [cudaErrorInvalidPitchValue :: 12]
!26 = metadata !{i32 786472, metadata !"cudaErrorInvalidSymbol", i64 13} ; [ DW_TAG_enumerator ] [cudaErrorInvalidSymbol :: 13]
!27 = metadata !{i32 786472, metadata !"cudaErrorMapBufferObjectFailed", i64 14} ; [ DW_TAG_enumerator ] [cudaErrorMapBufferObjectFailed :: 14]
!28 = metadata !{i32 786472, metadata !"cudaErrorUnmapBufferObjectFailed", i64 15} ; [ DW_TAG_enumerator ] [cudaErrorUnmapBufferObjectFailed :: 15]
!29 = metadata !{i32 786472, metadata !"cudaErrorInvalidHostPointer", i64 16} ; [ DW_TAG_enumerator ] [cudaErrorInvalidHostPointer :: 16]
!30 = metadata !{i32 786472, metadata !"cudaErrorInvalidDevicePointer", i64 17} ; [ DW_TAG_enumerator ] [cudaErrorInvalidDevicePointer :: 17]
!31 = metadata !{i32 786472, metadata !"cudaErrorInvalidTexture", i64 18} ; [ DW_TAG_enumerator ] [cudaErrorInvalidTexture :: 18]
!32 = metadata !{i32 786472, metadata !"cudaErrorInvalidTextureBinding", i64 19} ; [ DW_TAG_enumerator ] [cudaErrorInvalidTextureBinding :: 19]
!33 = metadata !{i32 786472, metadata !"cudaErrorInvalidChannelDescriptor", i64 20} ; [ DW_TAG_enumerator ] [cudaErrorInvalidChannelDescriptor :: 20]
!34 = metadata !{i32 786472, metadata !"cudaErrorInvalidMemcpyDirection", i64 21} ; [ DW_TAG_enumerator ] [cudaErrorInvalidMemcpyDirection :: 21]
!35 = metadata !{i32 786472, metadata !"cudaErrorAddressOfConstant", i64 22} ; [ DW_TAG_enumerator ] [cudaErrorAddressOfConstant :: 22]
!36 = metadata !{i32 786472, metadata !"cudaErrorTextureFetchFailed", i64 23} ; [ DW_TAG_enumerator ] [cudaErrorTextureFetchFailed :: 23]
!37 = metadata !{i32 786472, metadata !"cudaErrorTextureNotBound", i64 24} ; [ DW_TAG_enumerator ] [cudaErrorTextureNotBound :: 24]
!38 = metadata !{i32 786472, metadata !"cudaErrorSynchronizationError", i64 25} ; [ DW_TAG_enumerator ] [cudaErrorSynchronizationError :: 25]
!39 = metadata !{i32 786472, metadata !"cudaErrorInvalidFilterSetting", i64 26} ; [ DW_TAG_enumerator ] [cudaErrorInvalidFilterSetting :: 26]
!40 = metadata !{i32 786472, metadata !"cudaErrorInvalidNormSetting", i64 27} ; [ DW_TAG_enumerator ] [cudaErrorInvalidNormSetting :: 27]
!41 = metadata !{i32 786472, metadata !"cudaErrorMixedDeviceExecution", i64 28} ; [ DW_TAG_enumerator ] [cudaErrorMixedDeviceExecution :: 28]
!42 = metadata !{i32 786472, metadata !"cudaErrorCudartUnloading", i64 29} ; [ DW_TAG_enumerator ] [cudaErrorCudartUnloading :: 29]
!43 = metadata !{i32 786472, metadata !"cudaErrorUnknown", i64 30} ; [ DW_TAG_enumerator ] [cudaErrorUnknown :: 30]
!44 = metadata !{i32 786472, metadata !"cudaErrorNotYetImplemented", i64 31} ; [ DW_TAG_enumerator ] [cudaErrorNotYetImplemented :: 31]
!45 = metadata !{i32 786472, metadata !"cudaErrorMemoryValueTooLarge", i64 32} ; [ DW_TAG_enumerator ] [cudaErrorMemoryValueTooLarge :: 32]
!46 = metadata !{i32 786472, metadata !"cudaErrorInvalidResourceHandle", i64 33} ; [ DW_TAG_enumerator ] [cudaErrorInvalidResourceHandle :: 33]
!47 = metadata !{i32 786472, metadata !"cudaErrorNotReady", i64 34} ; [ DW_TAG_enumerator ] [cudaErrorNotReady :: 34]
!48 = metadata !{i32 786472, metadata !"cudaErrorInsufficientDriver", i64 35} ; [ DW_TAG_enumerator ] [cudaErrorInsufficientDriver :: 35]
!49 = metadata !{i32 786472, metadata !"cudaErrorSetOnActiveProcess", i64 36} ; [ DW_TAG_enumerator ] [cudaErrorSetOnActiveProcess :: 36]
!50 = metadata !{i32 786472, metadata !"cudaErrorInvalidSurface", i64 37} ; [ DW_TAG_enumerator ] [cudaErrorInvalidSurface :: 37]
!51 = metadata !{i32 786472, metadata !"cudaErrorNoDevice", i64 38} ; [ DW_TAG_enumerator ] [cudaErrorNoDevice :: 38]
!52 = metadata !{i32 786472, metadata !"cudaErrorECCUncorrectable", i64 39} ; [ DW_TAG_enumerator ] [cudaErrorECCUncorrectable :: 39]
!53 = metadata !{i32 786472, metadata !"cudaErrorSharedObjectSymbolNotFound", i64 40} ; [ DW_TAG_enumerator ] [cudaErrorSharedObjectSymbolNotFound :: 40]
!54 = metadata !{i32 786472, metadata !"cudaErrorSharedObjectInitFailed", i64 41} ; [ DW_TAG_enumerator ] [cudaErrorSharedObjectInitFailed :: 41]
!55 = metadata !{i32 786472, metadata !"cudaErrorUnsupportedLimit", i64 42} ; [ DW_TAG_enumerator ] [cudaErrorUnsupportedLimit :: 42]
!56 = metadata !{i32 786472, metadata !"cudaErrorDuplicateVariableName", i64 43} ; [ DW_TAG_enumerator ] [cudaErrorDuplicateVariableName :: 43]
!57 = metadata !{i32 786472, metadata !"cudaErrorDuplicateTextureName", i64 44} ; [ DW_TAG_enumerator ] [cudaErrorDuplicateTextureName :: 44]
!58 = metadata !{i32 786472, metadata !"cudaErrorDuplicateSurfaceName", i64 45} ; [ DW_TAG_enumerator ] [cudaErrorDuplicateSurfaceName :: 45]
!59 = metadata !{i32 786472, metadata !"cudaErrorDevicesUnavailable", i64 46} ; [ DW_TAG_enumerator ] [cudaErrorDevicesUnavailable :: 46]
!60 = metadata !{i32 786472, metadata !"cudaErrorInvalidKernelImage", i64 47} ; [ DW_TAG_enumerator ] [cudaErrorInvalidKernelImage :: 47]
!61 = metadata !{i32 786472, metadata !"cudaErrorNoKernelImageForDevice", i64 48} ; [ DW_TAG_enumerator ] [cudaErrorNoKernelImageForDevice :: 48]
!62 = metadata !{i32 786472, metadata !"cudaErrorIncompatibleDriverContext", i64 49} ; [ DW_TAG_enumerator ] [cudaErrorIncompatibleDriverContext :: 49]
!63 = metadata !{i32 786472, metadata !"cudaErrorPeerAccessAlreadyEnabled", i64 50} ; [ DW_TAG_enumerator ] [cudaErrorPeerAccessAlreadyEnabled :: 50]
!64 = metadata !{i32 786472, metadata !"cudaErrorPeerAccessNotEnabled", i64 51} ; [ DW_TAG_enumerator ] [cudaErrorPeerAccessNotEnabled :: 51]
!65 = metadata !{i32 786472, metadata !"cudaErrorDeviceAlreadyInUse", i64 54} ; [ DW_TAG_enumerator ] [cudaErrorDeviceAlreadyInUse :: 54]
!66 = metadata !{i32 786472, metadata !"cudaErrorProfilerDisabled", i64 55} ; [ DW_TAG_enumerator ] [cudaErrorProfilerDisabled :: 55]
!67 = metadata !{i32 786472, metadata !"cudaErrorProfilerNotInitialized", i64 56} ; [ DW_TAG_enumerator ] [cudaErrorProfilerNotInitialized :: 56]
!68 = metadata !{i32 786472, metadata !"cudaErrorProfilerAlreadyStarted", i64 57} ; [ DW_TAG_enumerator ] [cudaErrorProfilerAlreadyStarted :: 57]
!69 = metadata !{i32 786472, metadata !"cudaErrorProfilerAlreadyStopped", i64 58} ; [ DW_TAG_enumerator ] [cudaErrorProfilerAlreadyStopped :: 58]
!70 = metadata !{i32 786472, metadata !"cudaErrorAssert", i64 59} ; [ DW_TAG_enumerator ] [cudaErrorAssert :: 59]
!71 = metadata !{i32 786472, metadata !"cudaErrorTooManyPeers", i64 60} ; [ DW_TAG_enumerator ] [cudaErrorTooManyPeers :: 60]
!72 = metadata !{i32 786472, metadata !"cudaErrorHostMemoryAlreadyRegistered", i64 61} ; [ DW_TAG_enumerator ] [cudaErrorHostMemoryAlreadyRegistered :: 61]
!73 = metadata !{i32 786472, metadata !"cudaErrorHostMemoryNotRegistered", i64 62} ; [ DW_TAG_enumerator ] [cudaErrorHostMemoryNotRegistered :: 62]
!74 = metadata !{i32 786472, metadata !"cudaErrorOperatingSystem", i64 63} ; [ DW_TAG_enumerator ] [cudaErrorOperatingSystem :: 63]
!75 = metadata !{i32 786472, metadata !"cudaErrorPeerAccessUnsupported", i64 64} ; [ DW_TAG_enumerator ] [cudaErrorPeerAccessUnsupported :: 64]
!76 = metadata !{i32 786472, metadata !"cudaErrorLaunchMaxDepthExceeded", i64 65} ; [ DW_TAG_enumerator ] [cudaErrorLaunchMaxDepthExceeded :: 65]
!77 = metadata !{i32 786472, metadata !"cudaErrorLaunchFileScopedTex", i64 66} ; [ DW_TAG_enumerator ] [cudaErrorLaunchFileScopedTex :: 66]
!78 = metadata !{i32 786472, metadata !"cudaErrorLaunchFileScopedSurf", i64 67} ; [ DW_TAG_enumerator ] [cudaErrorLaunchFileScopedSurf :: 67]
!79 = metadata !{i32 786472, metadata !"cudaErrorSyncDepthExceeded", i64 68} ; [ DW_TAG_enumerator ] [cudaErrorSyncDepthExceeded :: 68]
!80 = metadata !{i32 786472, metadata !"cudaErrorLaunchPendingCountExceeded", i64 69} ; [ DW_TAG_enumerator ] [cudaErrorLaunchPendingCountExceeded :: 69]
!81 = metadata !{i32 786472, metadata !"cudaErrorNotPermitted", i64 70} ; [ DW_TAG_enumerator ] [cudaErrorNotPermitted :: 70]
!82 = metadata !{i32 786472, metadata !"cudaErrorNotSupported", i64 71} ; [ DW_TAG_enumerator ] [cudaErrorNotSupported :: 71]
!83 = metadata !{i32 786472, metadata !"cudaErrorStartupFailure", i64 127} ; [ DW_TAG_enumerator ] [cudaErrorStartupFailure :: 127]
!84 = metadata !{i32 786472, metadata !"cudaErrorApiFailureBase", i64 10000} ; [ DW_TAG_enumerator ] [cudaErrorApiFailureBase :: 10000]
!85 = metadata !{metadata !86}
!86 = metadata !{i32 0}
!87 = metadata !{metadata !88}
!88 = metadata !{metadata !89, metadata !96, metadata !99, metadata !106, metadata !148}
!89 = metadata !{i32 786478, i32 0, metadata !90, metadata !"device_global", metadata !"device_global", metadata !"_Z13device_globalPji", metadata !90, i32 14, metadata !91, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, void (i32*, i32)* @_Z13device_globalPji, null, null, metadata !85, i32 14} ; [ DW_TAG_subprogram ] [line 14] [def] [device_global]
!90 = metadata !{i32 786473, metadata !"read_write_test.cpp", metadata !"/home/mingyuanwu", null} ; [ DW_TAG_file_type ]
!91 = metadata !{i32 786453, i32 0, metadata !"", i32 0, i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !92, i32 0, i32 0} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!92 = metadata !{null, metadata !93, metadata !95}
!93 = metadata !{i32 786447, null, metadata !"", null, i32 0, i64 64, i64 64, i64 0, i32 0, metadata !94} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from unsigned int]
!94 = metadata !{i32 786468, null, metadata !"unsigned int", null, i32 0, i64 32, i64 32, i64 0, i32 0, i32 7} ; [ DW_TAG_base_type ] [unsigned int] [line 0, size 32, align 32, offset 0, enc DW_ATE_unsigned]
!95 = metadata !{i32 786468, null, metadata !"int", null, i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!96 = metadata !{i32 786478, i32 0, metadata !90, metadata !"main", metadata !"main", metadata !"", metadata !90, i32 29, metadata !97, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, i32 ()* @main, null, null, metadata !85, i32 29} ; [ DW_TAG_subprogram ] [line 29] [def] [main]
!97 = metadata !{i32 786453, i32 0, metadata !"", i32 0, i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !98, i32 0, i32 0} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!98 = metadata !{metadata !95}
!99 = metadata !{i32 786478, i32 0, metadata !90, metadata !"gpuAssert", metadata !"gpuAssert", metadata !"_Z9gpuAssert9cudaErrorPcib", metadata !90, i32 5, metadata !100, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, void (i32, i8*, i32, i1)* @_Z9gpuAssert9cudaErrorPcib, null, null, metadata !85, i32 6} ; [ DW_TAG_subprogram ] [line 5] [def] [scope 6] [gpuAssert]
!100 = metadata !{i32 786453, i32 0, metadata !"", i32 0, i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !101, i32 0, i32 0} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!101 = metadata !{null, metadata !102, metadata !103, metadata !95, metadata !105}
!102 = metadata !{i32 786454, null, metadata !"cudaError_t", metadata !90, i32 1293, i64 0, i64 0, i64 0, i32 0, metadata !11} ; [ DW_TAG_typedef ] [cudaError_t] [line 1293, size 0, align 0, offset 0] [from cudaError]
!103 = metadata !{i32 786447, null, metadata !"", null, i32 0, i64 64, i64 64, i64 0, i32 0, metadata !104} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from char]
!104 = metadata !{i32 786468, null, metadata !"char", null, i32 0, i64 8, i64 8, i64 0, i32 0, i32 6} ; [ DW_TAG_base_type ] [char] [line 0, size 8, align 8, offset 0, enc DW_ATE_signed_char]
!105 = metadata !{i32 786468, null, metadata !"bool", null, i32 0, i64 8, i64 8, i64 0, i32 0, i32 2} ; [ DW_TAG_base_type ] [bool] [line 0, size 8, align 8, offset 0, enc DW_ATE_boolean]
!106 = metadata !{i32 786478, i32 0, null, metadata !"dim3", metadata !"dim3", metadata !"_ZN4dim3C1Ejjj", metadata !107, i32 419, metadata !108, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, void (%struct.dim3*, i32, i32, i32)* @_ZN4dim3C1Ejjj, null, metadata !116, metadata !85, i32 419} ; [ DW_TAG_subprogram ] [line 419] [def] [dim3]
!107 = metadata !{i32 786473, metadata !"/home/mingyuanwu/gklee/Gklee/Gklee/include/cuda/vector_types.h", metadata !"/home/mingyuanwu", null} ; [ DW_TAG_file_type ]
!108 = metadata !{i32 786453, i32 0, metadata !"", i32 0, i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !109, i32 0, i32 0} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!109 = metadata !{null, metadata !110, metadata !94, metadata !94, metadata !94}
!110 = metadata !{i32 786447, i32 0, metadata !"", i32 0, i32 0, i64 64, i64 64, i64 0, i32 1088, metadata !111} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from dim3]
!111 = metadata !{i32 786451, null, metadata !"dim3", metadata !107, i32 415, i64 96, i64 32, i32 0, i32 0, null, metadata !112, i32 0, null, null} ; [ DW_TAG_structure_type ] [dim3] [line 415, size 96, align 32, offset 0] [from ]
!112 = metadata !{metadata !113, metadata !114, metadata !115, metadata !116, metadata !119, metadata !137, metadata !140, metadata !145}
!113 = metadata !{i32 786445, metadata !111, metadata !"x", metadata !107, i32 417, i64 32, i64 32, i64 0, i32 0, metadata !94} ; [ DW_TAG_member ] [x] [line 417, size 32, align 32, offset 0] [from unsigned int]
!114 = metadata !{i32 786445, metadata !111, metadata !"y", metadata !107, i32 417, i64 32, i64 32, i64 32, i32 0, metadata !94} ; [ DW_TAG_member ] [y] [line 417, size 32, align 32, offset 32] [from unsigned int]
!115 = metadata !{i32 786445, metadata !111, metadata !"z", metadata !107, i32 417, i64 32, i64 32, i64 64, i32 0, metadata !94} ; [ DW_TAG_member ] [z] [line 417, size 32, align 32, offset 64] [from unsigned int]
!116 = metadata !{i32 786478, i32 0, metadata !111, metadata !"dim3", metadata !"dim3", metadata !"", metadata !107, i32 419, metadata !108, i1 false, i1 false, i32 0, i32 0, null, i32 256, i1 false, null, null, i32 0, metadata !117, i32 419} ; [ DW_TAG_subprogram ] [line 419] [dim3]
!117 = metadata !{metadata !118}
!118 = metadata !{i32 786468}                     ; [ DW_TAG_base_type ] [line 0, size 0, align 0, offset 0]
!119 = metadata !{i32 786478, i32 0, metadata !111, metadata !"dim3", metadata !"dim3", metadata !"", metadata !107, i32 420, metadata !120, i1 false, i1 false, i32 0, i32 0, null, i32 256, i1 false, null, null, i32 0, metadata !117, i32 420} ; [ DW_TAG_subprogram ] [line 420] [dim3]
!120 = metadata !{i32 786453, i32 0, metadata !"", i32 0, i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !121, i32 0, i32 0} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!121 = metadata !{null, metadata !110, metadata !122}
!122 = metadata !{i32 786454, null, metadata !"uint3", metadata !107, i32 381, i64 0, i64 0, i64 0, i32 0, metadata !123} ; [ DW_TAG_typedef ] [uint3] [line 381, size 0, align 0, offset 0] [from uint3]
!123 = metadata !{i32 786451, null, metadata !"uint3", metadata !107, i32 188, i64 96, i64 32, i32 0, i32 0, null, metadata !124, i32 0, null, null} ; [ DW_TAG_structure_type ] [uint3] [line 188, size 96, align 32, offset 0] [from ]
!124 = metadata !{metadata !125, metadata !126, metadata !127, metadata !128, metadata !132}
!125 = metadata !{i32 786445, metadata !123, metadata !"x", metadata !107, i32 190, i64 32, i64 32, i64 0, i32 0, metadata !94} ; [ DW_TAG_member ] [x] [line 190, size 32, align 32, offset 0] [from unsigned int]
!126 = metadata !{i32 786445, metadata !123, metadata !"y", metadata !107, i32 190, i64 32, i64 32, i64 32, i32 0, metadata !94} ; [ DW_TAG_member ] [y] [line 190, size 32, align 32, offset 32] [from unsigned int]
!127 = metadata !{i32 786445, metadata !123, metadata !"z", metadata !107, i32 190, i64 32, i64 32, i64 64, i32 0, metadata !94} ; [ DW_TAG_member ] [z] [line 190, size 32, align 32, offset 64] [from unsigned int]
!128 = metadata !{i32 786478, i32 0, metadata !123, metadata !"uint3", metadata !"uint3", metadata !"", metadata !107, i32 188, metadata !129, i1 false, i1 false, i32 0, i32 0, null, i32 320, i1 false, null, null, i32 0, metadata !117, i32 188} ; [ DW_TAG_subprogram ] [line 188] [uint3]
!129 = metadata !{i32 786453, i32 0, metadata !"", i32 0, i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !130, i32 0, i32 0} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!130 = metadata !{null, metadata !131}
!131 = metadata !{i32 786447, i32 0, metadata !"", i32 0, i32 0, i64 64, i64 64, i64 0, i32 1088, metadata !123} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from uint3]
!132 = metadata !{i32 786478, i32 0, metadata !123, metadata !"uint3", metadata !"uint3", metadata !"", metadata !107, i32 188, metadata !133, i1 false, i1 false, i32 0, i32 0, null, i32 320, i1 false, null, null, i32 0, metadata !117, i32 188} ; [ DW_TAG_subprogram ] [line 188] [uint3]
!133 = metadata !{i32 786453, i32 0, metadata !"", i32 0, i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !134, i32 0, i32 0} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!134 = metadata !{null, metadata !131, metadata !135}
!135 = metadata !{i32 786448, null, null, null, i32 0, i64 0, i64 0, i64 0, i32 0, metadata !136} ; [ DW_TAG_reference_type ] [line 0, size 0, align 0, offset 0] [from ]
!136 = metadata !{i32 786470, null, metadata !"", null, i32 0, i64 0, i64 0, i64 0, i32 0, metadata !123} ; [ DW_TAG_const_type ] [line 0, size 0, align 0, offset 0] [from uint3]
!137 = metadata !{i32 786478, i32 0, metadata !111, metadata !"operator uint3", metadata !"operator uint3", metadata !"_ZN4dim3cv5uint3Ev", metadata !107, i32 421, metadata !138, i1 false, i1 false, i32 0, i32 0, null, i32 256, i1 false, null, null, i32 0, metadata !117, i32 421} ; [ DW_TAG_subprogram ] [line 421] [operator uint3]
!138 = metadata !{i32 786453, i32 0, metadata !"", i32 0, i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !139, i32 0, i32 0} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!139 = metadata !{metadata !122, metadata !110}
!140 = metadata !{i32 786478, i32 0, metadata !111, metadata !"dim3", metadata !"dim3", metadata !"", metadata !107, i32 415, metadata !141, i1 false, i1 false, i32 0, i32 0, null, i32 320, i1 false, null, null, i32 0, metadata !117, i32 415} ; [ DW_TAG_subprogram ] [line 415] [dim3]
!141 = metadata !{i32 786453, i32 0, metadata !"", i32 0, i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !142, i32 0, i32 0} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!142 = metadata !{null, metadata !110, metadata !143}
!143 = metadata !{i32 786448, null, null, null, i32 0, i64 0, i64 0, i64 0, i32 0, metadata !144} ; [ DW_TAG_reference_type ] [line 0, size 0, align 0, offset 0] [from ]
!144 = metadata !{i32 786470, null, metadata !"", null, i32 0, i64 0, i64 0, i64 0, i32 0, metadata !111} ; [ DW_TAG_const_type ] [line 0, size 0, align 0, offset 0] [from dim3]
!145 = metadata !{i32 786478, i32 0, metadata !111, metadata !"~dim3", metadata !"~dim3", metadata !"", metadata !107, i32 415, metadata !146, i1 false, i1 false, i32 0, i32 0, null, i32 320, i1 false, null, null, i32 0, metadata !117, i32 415} ; [ DW_TAG_subprogram ] [line 415] [~dim3]
!146 = metadata !{i32 786453, i32 0, metadata !"", i32 0, i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !147, i32 0, i32 0} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!147 = metadata !{null, metadata !110}
!148 = metadata !{i32 786478, i32 0, null, metadata !"dim3", metadata !"dim3", metadata !"_ZN4dim3C2Ejjj", metadata !107, i32 419, metadata !108, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, void (%struct.dim3*, i32, i32, i32)* @_ZN4dim3C2Ejjj, null, metadata !116, metadata !85, i32 419} ; [ DW_TAG_subprogram ] [line 419] [def] [dim3]
!149 = metadata !{i32 786689, metadata !89, metadata !"input_array", metadata !90, i32 16777230, metadata !93, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [input_array] [line 14]
!150 = metadata !{i32 14, i32 0, metadata !89, null}
!151 = metadata !{i32 786689, metadata !89, metadata !"num_elements", metadata !90, i32 33554446, metadata !95, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [num_elements] [line 14]
!152 = metadata !{i32 786688, metadata !153, metadata !"my_index", metadata !90, i32 15, metadata !95, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [my_index] [line 15]
!153 = metadata !{i32 786443, metadata !89, i32 14, i32 0, metadata !90, i32 0} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/read_write_test.cpp]
!154 = metadata !{i32 15, i32 0, metadata !153, null}
!155 = metadata !{i32 17, i32 0, metadata !153, null}
!156 = metadata !{i32 19, i32 0, metadata !157, null}
!157 = metadata !{i32 786443, metadata !153, i32 17, i32 0, metadata !90, i32 1} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/read_write_test.cpp]
!158 = metadata !{i32 21, i32 0, metadata !159, null}
!159 = metadata !{i32 786443, metadata !157, i32 19, i32 0, metadata !90, i32 2} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/read_write_test.cpp]
!160 = metadata !{i32 22, i32 0, metadata !159, null}
!161 = metadata !{i32 24, i32 0, metadata !162, null}
!162 = metadata !{i32 786443, metadata !157, i32 22, i32 0, metadata !90, i32 3} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/read_write_test.cpp]
!163 = metadata !{i32 26, i32 0, metadata !157, null}
!164 = metadata !{i32 27, i32 0, metadata !153, null}
!165 = metadata !{i32 786688, metadata !166, metadata !"num_elements", metadata !90, i32 31, metadata !95, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [num_elements] [line 31]
!166 = metadata !{i32 786443, metadata !96, i32 29, i32 0, metadata !90, i32 4} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/read_write_test.cpp]
!167 = metadata !{i32 31, i32 0, metadata !166, null}
!168 = metadata !{i32 786688, metadata !166, metadata !"num_bytes", metadata !90, i32 32, metadata !95, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [num_bytes] [line 32]
!169 = metadata !{i32 32, i32 0, metadata !166, null}
!170 = metadata !{i32 786688, metadata !166, metadata !"host_array", metadata !90, i32 35, metadata !93, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [host_array] [line 35]
!171 = metadata !{i32 35, i32 0, metadata !166, null}
!172 = metadata !{i32 786688, metadata !166, metadata !"device_array", metadata !90, i32 36, metadata !93, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [device_array] [line 36]
!173 = metadata !{i32 36, i32 0, metadata !166, null}
!174 = metadata !{i32 39, i32 0, metadata !166, null}
!175 = metadata !{i32 40, i32 0, metadata !166, null}
!176 = metadata !{i32 43, i32 0, metadata !166, null}
!177 = metadata !{i32 44, i32 0, metadata !178, null}
!178 = metadata !{i32 786443, metadata !166, i32 43, i32 0, metadata !90, i32 5} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/read_write_test.cpp]
!179 = metadata !{i32 45, i32 0, metadata !178, null}
!180 = metadata !{i32 48, i32 0, metadata !166, null}
!181 = metadata !{i32 49, i32 0, metadata !182, null}
!182 = metadata !{i32 786443, metadata !166, i32 48, i32 0, metadata !90, i32 6} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/read_write_test.cpp]
!183 = metadata !{i32 50, i32 0, metadata !182, null}
!184 = metadata !{i32 786688, metadata !185, metadata !"i", metadata !90, i32 54, metadata !95, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [i] [line 54]
!185 = metadata !{i32 786443, metadata !166, i32 54, i32 0, metadata !90, i32 7} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/read_write_test.cpp]
!186 = metadata !{i32 54, i32 0, metadata !185, null}
!187 = metadata !{i32 55, i32 0, metadata !188, null}
!188 = metadata !{i32 786443, metadata !185, i32 54, i32 0, metadata !90, i32 8} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/read_write_test.cpp]
!189 = metadata !{i32 56, i32 0, metadata !188, null}
!190 = metadata !{i32 59, i32 0, metadata !166, null}
!191 = metadata !{i32 786688, metadata !166, metadata !"block_size", metadata !90, i32 62, metadata !95, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [block_size] [line 62]
!192 = metadata !{i32 62, i32 0, metadata !166, null}
!193 = metadata !{i32 786688, metadata !166, metadata !"grid_size", metadata !90, i32 63, metadata !95, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [grid_size] [line 63]
!194 = metadata !{i32 63, i32 0, metadata !166, null}
!195 = metadata !{i32 64, i32 0, metadata !196, null}
!196 = metadata !{i32 786443, metadata !166, i32 64, i32 0, metadata !90, i32 9} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/read_write_test.cpp]
!197 = metadata !{i32 66, i32 0, metadata !196, null}
!198 = metadata !{i32 68, i32 0, metadata !199, null}
!199 = metadata !{i32 786443, metadata !166, i32 68, i32 0, metadata !90, i32 10} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/read_write_test.cpp]
!200 = metadata !{i32 69, i32 0, metadata !201, null}
!201 = metadata !{i32 786443, metadata !166, i32 69, i32 0, metadata !90, i32 11} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/read_write_test.cpp]
!202 = metadata !{i32 72, i32 0, metadata !166, null}
!203 = metadata !{i32 786688, metadata !204, metadata !"i", metadata !90, i32 75, metadata !95, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [i] [line 75]
!204 = metadata !{i32 786443, metadata !166, i32 75, i32 0, metadata !90, i32 12} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/read_write_test.cpp]
!205 = metadata !{i32 75, i32 0, metadata !204, null}
!206 = metadata !{i32 76, i32 0, metadata !207, null}
!207 = metadata !{i32 786443, metadata !204, i32 75, i32 0, metadata !90, i32 13} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/read_write_test.cpp]
!208 = metadata !{i32 77, i32 0, metadata !207, null}
!209 = metadata !{i32 78, i32 0, metadata !210, null}
!210 = metadata !{i32 786443, metadata !207, i32 77, i32 0, metadata !90, i32 14} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/read_write_test.cpp]
!211 = metadata !{i32 79, i32 0, metadata !210, null}
!212 = metadata !{i32 80, i32 0, metadata !207, null}
!213 = metadata !{i32 83, i32 0, metadata !166, null}
!214 = metadata !{i32 84, i32 0, metadata !166, null}
!215 = metadata !{i32 85, i32 0, metadata !166, null}
!216 = metadata !{i32 786689, metadata !106, metadata !"this", metadata !107, i32 16777635, metadata !217, i32 1088, i32 0} ; [ DW_TAG_arg_variable ] [this] [line 419]
!217 = metadata !{i32 786447, null, metadata !"", null, i32 0, i64 64, i64 64, i64 0, i32 0, metadata !111} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from dim3]
!218 = metadata !{i32 419, i32 0, metadata !106, null}
!219 = metadata !{i32 786689, metadata !106, metadata !"vx", metadata !107, i32 33554851, metadata !94, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [vx] [line 419]
!220 = metadata !{i32 786689, metadata !106, metadata !"vy", metadata !107, i32 50332067, metadata !94, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [vy] [line 419]
!221 = metadata !{i32 786689, metadata !106, metadata !"vz", metadata !107, i32 67109283, metadata !94, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [vz] [line 419]
!222 = metadata !{i32 786689, metadata !99, metadata !"code", metadata !90, i32 16777221, metadata !102, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [code] [line 5]
!223 = metadata !{i32 5, i32 0, metadata !99, null}
!224 = metadata !{i32 786689, metadata !99, metadata !"file", metadata !90, i32 33554437, metadata !103, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [file] [line 5]
!225 = metadata !{i32 786689, metadata !99, metadata !"line", metadata !90, i32 50331653, metadata !95, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [line] [line 5]
!226 = metadata !{i32 786689, metadata !99, metadata !"abort", metadata !90, i32 67108869, metadata !105, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [abort] [line 5]
!227 = metadata !{i32 7, i32 0, metadata !228, null}
!228 = metadata !{i32 786443, metadata !99, i32 6, i32 0, metadata !90, i32 15} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/read_write_test.cpp]
!229 = metadata !{i32 9, i32 0, metadata !230, null}
!230 = metadata !{i32 786443, metadata !228, i32 8, i32 0, metadata !90, i32 16} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/read_write_test.cpp]
!231 = metadata !{i32 10, i32 0, metadata !230, null}
!232 = metadata !{i32 11, i32 0, metadata !230, null}
!233 = metadata !{i32 12, i32 0, metadata !228, null}
!234 = metadata !{i32 786689, metadata !148, metadata !"this", metadata !107, i32 16777635, metadata !217, i32 1088, i32 0} ; [ DW_TAG_arg_variable ] [this] [line 419]
!235 = metadata !{i32 419, i32 0, metadata !148, null}
!236 = metadata !{i32 786689, metadata !148, metadata !"vx", metadata !107, i32 33554851, metadata !94, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [vx] [line 419]
!237 = metadata !{i32 786689, metadata !148, metadata !"vy", metadata !107, i32 50332067, metadata !94, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [vy] [line 419]
!238 = metadata !{i32 786689, metadata !148, metadata !"vz", metadata !107, i32 67109283, metadata !94, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [vz] [line 419]
!239 = metadata !{i32 419, i32 0, metadata !240, null}
!240 = metadata !{i32 786443, metadata !148, i32 419, i32 0, metadata !107, i32 17} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu//home/mingyuanwu/gklee/Gklee/Gklee/include/cuda/vector_types.h]
