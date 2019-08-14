; ModuleID = 'JacobiSVD'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.dim3 = type { i32, i32, i32 }

@threadIdx = external global %struct.dim3
@blockDim = external global %struct.dim3
@blockIdx = external global %struct.dim3
@_ZZ9JacobiSVDPiS_iiE3acc = internal global [512 x i32] zeroinitializer, section "__shared__", align 16
@_ZZ9JacobiSVDPiS_iiE3s_S = internal global [1296 x i32] zeroinitializer, section "__shared__", align 16
@_ZZ9JacobiSVDPiS_iiE3s_V = internal global [1296 x i32] zeroinitializer, section "__shared__", align 16
@_ZZ9JacobiSVDPiS_iiE1d = internal global [144 x i32] zeroinitializer, section "__shared__", align 16

define void @_Z9JacobiSVDPiS_ii(i32* %S, i32* %V, i32 %m, i32 %n) uwtable noinline {
  %1 = alloca i32*, align 8
  %2 = alloca i32*, align 8
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %iterations = alloca i32, align 4
  %tid_x = alloca i32, align 4
  %bsz_x = alloca i32, align 4
  %tid_y = alloca i32, align 4
  %gid_y = alloca i32, align 4
  %acc1 = alloca i32*, align 8
  %acc2 = alloca i32*, align 8
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  %Si = alloca i32*, align 8
  %Sj = alloca i32*, align 8
  %p = alloca i32, align 4
  %k = alloca i32, align 4
  %y = alloca i32, align 4
  %r = alloca i32, align 4
  %r2 = alloca i32, align 4
  %c = alloca i32, align 4
  %s = alloca i32, align 4
  %t0 = alloca i32, align 4
  %t1 = alloca i32, align 4
  %i1 = alloca i32, align 4
  store i32* %S, i32** %1, align 8
  call void @llvm.dbg.declare(metadata !{i32** %1}, metadata !26), !dbg !27
  store i32* %V, i32** %2, align 8
  call void @llvm.dbg.declare(metadata !{i32** %2}, metadata !28), !dbg !27
  store i32 %m, i32* %3, align 4
  call void @llvm.dbg.declare(metadata !{i32* %3}, metadata !29), !dbg !27
  store i32 %n, i32* %4, align 4
  call void @llvm.dbg.declare(metadata !{i32* %4}, metadata !30), !dbg !27
  call void @llvm.dbg.declare(metadata !{i32* %iterations}, metadata !31), !dbg !34
  store i32 30, i32* %iterations, align 4, !dbg !34
  call void @llvm.dbg.declare(metadata !{i32* %tid_x}, metadata !35), !dbg !36
  %5 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !36
  store i32 %5, i32* %tid_x, align 4, !dbg !36
  call void @llvm.dbg.declare(metadata !{i32* %bsz_x}, metadata !37), !dbg !38
  %6 = load i32* getelementptr inbounds (%struct.dim3* @blockDim, i32 0, i32 0), align 4, !dbg !38
  store i32 %6, i32* %bsz_x, align 4, !dbg !38
  call void @llvm.dbg.declare(metadata !{i32* %tid_y}, metadata !39), !dbg !40
  %7 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 1), align 4, !dbg !40
  store i32 %7, i32* %tid_y, align 4, !dbg !40
  call void @llvm.dbg.declare(metadata !{i32* %gid_y}, metadata !41), !dbg !42
  %8 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 1), align 4, !dbg !42
  %9 = load i32* getelementptr inbounds (%struct.dim3* @blockDim, i32 0, i32 1), align 4, !dbg !42
  %10 = mul i32 %8, %9, !dbg !42
  %11 = load i32* %tid_y, align 4, !dbg !42
  %12 = add i32 %10, %11, !dbg !42
  store i32 %12, i32* %gid_y, align 4, !dbg !42
  call void @llvm.dbg.declare(metadata !{i32** %acc1}, metadata !43), !dbg !44
  store i32* getelementptr inbounds ([512 x i32]* @_ZZ9JacobiSVDPiS_iiE3acc, i32 0, i32 0), i32** %acc1, align 8, !dbg !44
  call void @llvm.dbg.declare(metadata !{i32** %acc2}, metadata !45), !dbg !46
  store i32* getelementptr inbounds ([512 x i32]* @_ZZ9JacobiSVDPiS_iiE3acc, i32 0, i64 256), i32** %acc2, align 8, !dbg !46
  store i32 10, i32* %4, align 4, !dbg !47
  store i32 3, i32* %3, align 4, !dbg !47
  call void @llvm.dbg.declare(metadata !{i32* %i}, metadata !48), !dbg !50
  store i32 0, i32* %i, align 4, !dbg !50
  br label %13, !dbg !50

; <label>:13                                      ; preds = %175, %0
  %14 = load i32* %i, align 4, !dbg !50
  %15 = load i32* %4, align 4, !dbg !50
  %16 = sub nsw i32 %15, 1, !dbg !50
  %17 = icmp slt i32 %14, %16, !dbg !50
  br i1 %17, label %18, label %178, !dbg !50

; <label>:18                                      ; preds = %13
  call void @llvm.dbg.declare(metadata !{i32* %j}, metadata !51), !dbg !54
  %19 = load i32* %i, align 4, !dbg !54
  %20 = add nsw i32 %19, 1, !dbg !54
  store i32 %20, i32* %j, align 4, !dbg !54
  br label %21, !dbg !54

; <label>:21                                      ; preds = %171, %18
  %22 = load i32* %j, align 4, !dbg !54
  %23 = load i32* %4, align 4, !dbg !54
  %24 = icmp slt i32 %22, %23, !dbg !54
  br i1 %24, label %25, label %174, !dbg !54

; <label>:25                                      ; preds = %21
  call void @llvm.dbg.declare(metadata !{i32** %Si}, metadata !55), !dbg !57
  %26 = load i32* %tid_y, align 4, !dbg !57
  %27 = mul nsw i32 %26, 81, !dbg !57
  %28 = sext i32 %27 to i64, !dbg !57
  %29 = getelementptr inbounds i32* getelementptr inbounds ([1296 x i32]* @_ZZ9JacobiSVDPiS_iiE3s_S, i32 0, i32 0), i64 %28, !dbg !57
  %30 = load i32* %i, align 4, !dbg !57
  %31 = load i32* %3, align 4, !dbg !57
  %32 = mul nsw i32 %30, %31, !dbg !57
  %33 = sext i32 %32 to i64, !dbg !57
  %34 = getelementptr inbounds i32* %29, i64 %33, !dbg !57
  store i32* %34, i32** %Si, align 8, !dbg !57
  call void @llvm.dbg.declare(metadata !{i32** %Sj}, metadata !58), !dbg !59
  %35 = load i32* %tid_y, align 4, !dbg !59
  %36 = mul nsw i32 %35, 81, !dbg !59
  %37 = sext i32 %36 to i64, !dbg !59
  %38 = getelementptr inbounds i32* getelementptr inbounds ([1296 x i32]* @_ZZ9JacobiSVDPiS_iiE3s_S, i32 0, i32 0), i64 %37, !dbg !59
  %39 = load i32* %j, align 4, !dbg !59
  %40 = load i32* %3, align 4, !dbg !59
  %41 = mul nsw i32 %39, %40, !dbg !59
  %42 = sext i32 %41 to i64, !dbg !59
  %43 = getelementptr inbounds i32* %38, i64 %42, !dbg !59
  store i32* %43, i32** %Sj, align 8, !dbg !59
  call void @llvm.dbg.declare(metadata !{i32* %p}, metadata !60), !dbg !61
  store i32 0, i32* %p, align 4, !dbg !61
  call void @llvm.dbg.declare(metadata !{i32* %k}, metadata !62), !dbg !64
  store i32 0, i32* %k, align 4, !dbg !64
  br label %44, !dbg !64

; <label>:44                                      ; preds = %62, %25
  %45 = load i32* %k, align 4, !dbg !64
  %46 = load i32* %3, align 4, !dbg !64
  %47 = icmp slt i32 %45, %46, !dbg !64
  br i1 %47, label %48, label %65, !dbg !64

; <label>:48                                      ; preds = %44
  %49 = load i32* %k, align 4, !dbg !65
  %50 = sext i32 %49 to i64, !dbg !65
  %51 = load i32** %Si, align 8, !dbg !65
  %52 = getelementptr inbounds i32* %51, i64 %50, !dbg !65
  %53 = load i32* %52, align 4, !dbg !65
  %54 = load i32* %k, align 4, !dbg !65
  %55 = sext i32 %54 to i64, !dbg !65
  %56 = load i32** %Sj, align 8, !dbg !65
  %57 = getelementptr inbounds i32* %56, i64 %55, !dbg !65
  %58 = load i32* %57, align 4, !dbg !65
  %59 = mul nsw i32 %53, %58, !dbg !65
  %60 = load i32* %p, align 4, !dbg !65
  %61 = add nsw i32 %60, %59, !dbg !65
  store i32 %61, i32* %p, align 4, !dbg !65
  br label %62, !dbg !65

; <label>:62                                      ; preds = %48
  %63 = load i32* %k, align 4, !dbg !64
  %64 = add nsw i32 %63, 1, !dbg !64
  store i32 %64, i32* %k, align 4, !dbg !64
  br label %44, !dbg !64

; <label>:65                                      ; preds = %44
  call void @llvm.dbg.declare(metadata !{i32* %y}, metadata !66), !dbg !67
  %66 = load i32* %tid_y, align 4, !dbg !67
  %67 = mul nsw i32 %66, 9, !dbg !67
  %68 = load i32* %i, align 4, !dbg !67
  %69 = add nsw i32 %67, %68, !dbg !67
  %70 = sext i32 %69 to i64, !dbg !67
  %71 = getelementptr inbounds [144 x i32]* @_ZZ9JacobiSVDPiS_iiE1d, i32 0, i64 %70, !dbg !67
  %72 = load i32* %71, align 4, !dbg !67
  %73 = load i32* %tid_y, align 4, !dbg !67
  %74 = mul nsw i32 %73, 9, !dbg !67
  %75 = load i32* %j, align 4, !dbg !67
  %76 = add nsw i32 %74, %75, !dbg !67
  %77 = sext i32 %76 to i64, !dbg !67
  %78 = getelementptr inbounds [144 x i32]* @_ZZ9JacobiSVDPiS_iiE1d, i32 0, i64 %77, !dbg !67
  %79 = load i32* %78, align 4, !dbg !67
  %80 = sub nsw i32 %72, %79, !dbg !67
  store i32 %80, i32* %y, align 4, !dbg !67
  call void @llvm.dbg.declare(metadata !{i32* %r}, metadata !68), !dbg !69
  %81 = load i32* %p, align 4, !dbg !69
  %82 = mul nsw i32 %81, 2, !dbg !69
  store i32 %82, i32* %r, align 4, !dbg !69
  call void @llvm.dbg.declare(metadata !{i32* %r2}, metadata !70), !dbg !71
  %83 = load i32* %r, align 4, !dbg !71
  %84 = mul nsw i32 %83, 2, !dbg !71
  store i32 %84, i32* %r2, align 4, !dbg !71
  call void @llvm.dbg.declare(metadata !{i32* %c}, metadata !72), !dbg !73
  call void @llvm.dbg.declare(metadata !{i32* %s}, metadata !74), !dbg !73
  %85 = load i32* %y, align 4, !dbg !75
  %86 = icmp sge i32 %85, 0, !dbg !75
  br i1 %86, label %87, label %96, !dbg !75

; <label>:87                                      ; preds = %65
  %88 = load i32* %r, align 4, !dbg !76
  %89 = load i32* %y, align 4, !dbg !76
  %90 = add nsw i32 %88, %89, !dbg !76
  %91 = load i32* %r2, align 4, !dbg !76
  %92 = sdiv i32 %90, %91, !dbg !76
  store i32 %92, i32* %c, align 4, !dbg !76
  %93 = load i32* %r2, align 4, !dbg !78
  %94 = load i32* %c, align 4, !dbg !78
  %95 = mul nsw i32 %93, %94, !dbg !78
  store i32 %95, i32* %s, align 4, !dbg !78
  br label %105, !dbg !79

; <label>:96                                      ; preds = %65
  %97 = load i32* %r, align 4, !dbg !80
  %98 = load i32* %y, align 4, !dbg !80
  %99 = sub nsw i32 %97, %98, !dbg !80
  %100 = load i32* %r2, align 4, !dbg !80
  %101 = sdiv i32 %99, %100, !dbg !80
  store i32 %101, i32* %s, align 4, !dbg !80
  %102 = load i32* %r2, align 4, !dbg !82
  %103 = load i32* %s, align 4, !dbg !82
  %104 = mul nsw i32 %102, %103, !dbg !82
  store i32 %104, i32* %c, align 4, !dbg !82
  br label %105

; <label>:105                                     ; preds = %96, %87
  %106 = load i32* %tid_x, align 4, !dbg !83
  %107 = load i32* %3, align 4, !dbg !83
  %108 = icmp slt i32 %106, %107, !dbg !83
  br i1 %108, label %109, label %170, !dbg !83

; <label>:109                                     ; preds = %105
  call void @llvm.dbg.declare(metadata !{i32* %t0}, metadata !84), !dbg !86
  %110 = load i32* %c, align 4, !dbg !86
  %111 = load i32* %tid_x, align 4, !dbg !86
  %112 = sext i32 %111 to i64, !dbg !86
  %113 = load i32** %Si, align 8, !dbg !86
  %114 = getelementptr inbounds i32* %113, i64 %112, !dbg !86
  %115 = load i32* %114, align 4, !dbg !86
  %116 = mul nsw i32 %110, %115, !dbg !86
  %117 = load i32* %s, align 4, !dbg !86
  %118 = load i32* %tid_x, align 4, !dbg !86
  %119 = sext i32 %118 to i64, !dbg !86
  %120 = load i32** %Sj, align 8, !dbg !86
  %121 = getelementptr inbounds i32* %120, i64 %119, !dbg !86
  %122 = load i32* %121, align 4, !dbg !86
  %123 = mul nsw i32 %117, %122, !dbg !86
  %124 = add nsw i32 %116, %123, !dbg !86
  store i32 %124, i32* %t0, align 4, !dbg !86
  call void @llvm.dbg.declare(metadata !{i32* %t1}, metadata !87), !dbg !88
  %125 = load i32* %c, align 4, !dbg !88
  %126 = load i32* %tid_x, align 4, !dbg !88
  %127 = sext i32 %126 to i64, !dbg !88
  %128 = load i32** %Sj, align 8, !dbg !88
  %129 = getelementptr inbounds i32* %128, i64 %127, !dbg !88
  %130 = load i32* %129, align 4, !dbg !88
  %131 = mul nsw i32 %125, %130, !dbg !88
  %132 = load i32* %s, align 4, !dbg !88
  %133 = load i32* %tid_x, align 4, !dbg !88
  %134 = sext i32 %133 to i64, !dbg !88
  %135 = load i32** %Si, align 8, !dbg !88
  %136 = getelementptr inbounds i32* %135, i64 %134, !dbg !88
  %137 = load i32* %136, align 4, !dbg !88
  %138 = mul nsw i32 %132, %137, !dbg !88
  %139 = sub nsw i32 %131, %138, !dbg !88
  store i32 %139, i32* %t1, align 4, !dbg !88
  %140 = load i32* %t0, align 4, !dbg !89
  %141 = load i32* %tid_x, align 4, !dbg !89
  %142 = sext i32 %141 to i64, !dbg !89
  %143 = load i32** %Si, align 8, !dbg !89
  %144 = getelementptr inbounds i32* %143, i64 %142, !dbg !89
  store i32 %140, i32* %144, align 4, !dbg !89
  %145 = load i32* %t1, align 4, !dbg !90
  %146 = load i32* %tid_x, align 4, !dbg !90
  %147 = sext i32 %146 to i64, !dbg !90
  %148 = load i32** %Sj, align 8, !dbg !90
  %149 = getelementptr inbounds i32* %148, i64 %147, !dbg !90
  store i32 %145, i32* %149, align 4, !dbg !90
  %150 = load i32* %t0, align 4, !dbg !91
  %151 = load i32* %t0, align 4, !dbg !91
  %152 = mul nsw i32 %150, %151, !dbg !91
  %153 = load i32* %tid_y, align 4, !dbg !91
  %154 = mul nsw i32 %153, 16, !dbg !91
  %155 = load i32* %tid_x, align 4, !dbg !91
  %156 = add nsw i32 %154, %155, !dbg !91
  %157 = sext i32 %156 to i64, !dbg !91
  %158 = load i32** %acc1, align 8, !dbg !91
  %159 = getelementptr inbounds i32* %158, i64 %157, !dbg !91
  store i32 %152, i32* %159, align 4, !dbg !91
  %160 = load i32* %t1, align 4, !dbg !92
  %161 = load i32* %t1, align 4, !dbg !92
  %162 = mul nsw i32 %160, %161, !dbg !92
  %163 = load i32* %tid_y, align 4, !dbg !92
  %164 = mul nsw i32 %163, 16, !dbg !92
  %165 = load i32* %tid_x, align 4, !dbg !92
  %166 = add nsw i32 %164, %165, !dbg !92
  %167 = sext i32 %166 to i64, !dbg !92
  %168 = load i32** %acc2, align 8, !dbg !92
  %169 = getelementptr inbounds i32* %168, i64 %167, !dbg !92
  store i32 %162, i32* %169, align 4, !dbg !92
  br label %170, !dbg !93

; <label>:170                                     ; preds = %109, %105
  br label %171, !dbg !94

; <label>:171                                     ; preds = %170
  %172 = load i32* %j, align 4, !dbg !54
  %173 = add nsw i32 %172, 1, !dbg !54
  store i32 %173, i32* %j, align 4, !dbg !54
  br label %21, !dbg !54

; <label>:174                                     ; preds = %21
  call void @__syncthreads(), !dbg !95
  br label %175, !dbg !96

; <label>:175                                     ; preds = %174
  %176 = load i32* %i, align 4, !dbg !50
  %177 = add nsw i32 %176, 1, !dbg !50
  store i32 %177, i32* %i, align 4, !dbg !50
  br label %13, !dbg !50

; <label>:178                                     ; preds = %13
  call void @__syncthreads(), !dbg !97
  call void @llvm.dbg.declare(metadata !{i32* %i1}, metadata !98), !dbg !100
  store i32 0, i32* %i1, align 4, !dbg !100
  br label %179, !dbg !100

; <label>:179                                     ; preds = %205, %178
  %180 = load i32* %i1, align 4, !dbg !100
  %181 = icmp sle i32 %180, 4, !dbg !100
  br i1 %181, label %182, label %208, !dbg !100

; <label>:182                                     ; preds = %179
  %183 = load i32* %tid_y, align 4, !dbg !101
  %184 = mul nsw i32 %183, 81, !dbg !101
  %185 = load i32* %tid_x, align 4, !dbg !101
  %186 = add nsw i32 %184, %185, !dbg !101
  %187 = load i32* %i1, align 4, !dbg !101
  %188 = load i32* %bsz_x, align 4, !dbg !101
  %189 = mul nsw i32 %187, %188, !dbg !101
  %190 = add nsw i32 %186, %189, !dbg !101
  %191 = sext i32 %190 to i64, !dbg !101
  %192 = getelementptr inbounds [1296 x i32]* @_ZZ9JacobiSVDPiS_iiE3s_V, i32 0, i64 %191, !dbg !101
  %193 = load i32* %192, align 4, !dbg !101
  %194 = load i32* %gid_y, align 4, !dbg !101
  %195 = mul nsw i32 %194, 81, !dbg !101
  %196 = load i32* %tid_x, align 4, !dbg !101
  %197 = add nsw i32 %195, %196, !dbg !101
  %198 = load i32* %i1, align 4, !dbg !101
  %199 = load i32* %bsz_x, align 4, !dbg !101
  %200 = mul nsw i32 %198, %199, !dbg !101
  %201 = add nsw i32 %197, %200, !dbg !101
  %202 = sext i32 %201 to i64, !dbg !101
  %203 = load i32** %2, align 8, !dbg !101
  %204 = getelementptr inbounds i32* %203, i64 %202, !dbg !101
  store i32 %193, i32* %204, align 4, !dbg !101
  br label %205, !dbg !101

; <label>:205                                     ; preds = %182
  %206 = load i32* %i1, align 4, !dbg !100
  %207 = add nsw i32 %206, 1, !dbg !100
  store i32 %207, i32* %i1, align 4, !dbg !100
  br label %179, !dbg !100

; <label>:208                                     ; preds = %179
  %209 = load i32* %tid_x, align 4, !dbg !102
  %210 = icmp eq i32 %209, 0, !dbg !102
  br i1 %210, label %211, label %224, !dbg !102

; <label>:211                                     ; preds = %208
  %212 = load i32* %tid_y, align 4, !dbg !103
  %213 = mul nsw i32 %212, 81, !dbg !103
  %214 = add nsw i32 %213, 80, !dbg !103
  %215 = sext i32 %214 to i64, !dbg !103
  %216 = getelementptr inbounds [1296 x i32]* @_ZZ9JacobiSVDPiS_iiE3s_V, i32 0, i64 %215, !dbg !103
  %217 = load i32* %216, align 4, !dbg !103
  %218 = load i32* %gid_y, align 4, !dbg !103
  %219 = mul nsw i32 %218, 81, !dbg !103
  %220 = add nsw i32 %219, 80, !dbg !103
  %221 = sext i32 %220 to i64, !dbg !103
  %222 = load i32** %2, align 8, !dbg !103
  %223 = getelementptr inbounds i32* %222, i64 %221, !dbg !103
  store i32 %217, i32* %223, align 4, !dbg !103
  br label %224, !dbg !103

; <label>:224                                     ; preds = %211, %208
  call void @__syncthreads(), !dbg !104
  ret void, !dbg !105
}

declare void @llvm.dbg.declare(metadata, metadata) nounwind readnone

declare void @__syncthreads() section "__device__"

!llvm.dbg.cu = !{!0}

!0 = metadata !{i32 786449, i32 0, i32 4, metadata !"JacobiSVD.cpp", metadata !"/home/mingyuanwu/arrayfire-repair", metadata !"clang version 3.2 (tags/RELEASE_32/final)", i1 true, i1 false, metadata !"", i32 0, metadata !1, metadata !1, metadata !3, metadata !11} ; [ DW_TAG_compile_unit ] [/home/mingyuanwu/arrayfire-repair/JacobiSVD.cpp] [DW_LANG_C_plus_plus]
!1 = metadata !{metadata !2}
!2 = metadata !{i32 0}
!3 = metadata !{metadata !4}
!4 = metadata !{metadata !5}
!5 = metadata !{i32 786478, i32 0, metadata !6, metadata !"JacobiSVD", metadata !"JacobiSVD", metadata !"_Z9JacobiSVDPiS_ii", metadata !6, i32 1, metadata !7, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, void (i32*, i32*, i32, i32)* @_Z9JacobiSVDPiS_ii, null, null, metadata !1, i32 2} ; [ DW_TAG_subprogram ] [line 1] [def] [scope 2] [JacobiSVD]
!6 = metadata !{i32 786473, metadata !"JacobiSVD.cpp", metadata !"/home/mingyuanwu/arrayfire-repair", null} ; [ DW_TAG_file_type ]
!7 = metadata !{i32 786453, i32 0, metadata !"", i32 0, i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !8, i32 0, i32 0} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!8 = metadata !{null, metadata !9, metadata !9, metadata !10, metadata !10}
!9 = metadata !{i32 786447, null, metadata !"", null, i32 0, i64 64, i64 64, i64 0, i32 0, metadata !10} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from int]
!10 = metadata !{i32 786468, null, metadata !"int", null, i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!11 = metadata !{metadata !12}
!12 = metadata !{metadata !13, metadata !17, metadata !21, metadata !22}
!13 = metadata !{i32 786484, i32 0, metadata !5, metadata !"acc", metadata !"acc", metadata !"", metadata !6, i32 10, metadata !14, i32 1, i32 1, [512 x i32]* @_ZZ9JacobiSVDPiS_iiE3acc} ; [ DW_TAG_variable ] [acc] [line 10] [local] [def]
!14 = metadata !{i32 786433, null, metadata !"", null, i32 0, i64 16384, i64 32, i32 0, i32 0, metadata !10, metadata !15, i32 0, i32 0} ; [ DW_TAG_array_type ] [line 0, size 16384, align 32, offset 0] [from int]
!15 = metadata !{metadata !16}
!16 = metadata !{i32 786465, i64 0, i64 511}      ; [ DW_TAG_subrange_type ] [0, 511]
!17 = metadata !{i32 786484, i32 0, metadata !5, metadata !"s_S", metadata !"s_S", metadata !"", metadata !6, i32 14, metadata !18, i32 1, i32 1, [1296 x i32]* @_ZZ9JacobiSVDPiS_iiE3s_S} ; [ DW_TAG_variable ] [s_S] [line 14] [local] [def]
!18 = metadata !{i32 786433, null, metadata !"", null, i32 0, i64 41472, i64 32, i32 0, i32 0, metadata !10, metadata !19, i32 0, i32 0} ; [ DW_TAG_array_type ] [line 0, size 41472, align 32, offset 0] [from int]
!19 = metadata !{metadata !20}
!20 = metadata !{i32 786465, i64 0, i64 1295}     ; [ DW_TAG_subrange_type ] [0, 1295]
!21 = metadata !{i32 786484, i32 0, metadata !5, metadata !"s_V", metadata !"s_V", metadata !"", metadata !6, i32 15, metadata !18, i32 1, i32 1, [1296 x i32]* @_ZZ9JacobiSVDPiS_iiE3s_V} ; [ DW_TAG_variable ] [s_V] [line 15] [local] [def]
!22 = metadata !{i32 786484, i32 0, metadata !5, metadata !"d", metadata !"d", metadata !"", metadata !6, i32 16, metadata !23, i32 1, i32 1, [144 x i32]* @_ZZ9JacobiSVDPiS_iiE1d} ; [ DW_TAG_variable ] [d] [line 16] [local] [def]
!23 = metadata !{i32 786433, null, metadata !"", null, i32 0, i64 4608, i64 32, i32 0, i32 0, metadata !10, metadata !24, i32 0, i32 0} ; [ DW_TAG_array_type ] [line 0, size 4608, align 32, offset 0] [from int]
!24 = metadata !{metadata !25}
!25 = metadata !{i32 786465, i64 0, i64 143}      ; [ DW_TAG_subrange_type ] [0, 143]
!26 = metadata !{i32 786689, metadata !5, metadata !"S", metadata !6, i32 16777217, metadata !9, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [S] [line 1]
!27 = metadata !{i32 1, i32 0, metadata !5, null}
!28 = metadata !{i32 786689, metadata !5, metadata !"V", metadata !6, i32 33554433, metadata !9, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [V] [line 1]
!29 = metadata !{i32 786689, metadata !5, metadata !"m", metadata !6, i32 50331649, metadata !10, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [m] [line 1]
!30 = metadata !{i32 786689, metadata !5, metadata !"n", metadata !6, i32 67108865, metadata !10, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [n] [line 1]
!31 = metadata !{i32 786688, metadata !32, metadata !"iterations", metadata !6, i32 3, metadata !33, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [iterations] [line 3]
!32 = metadata !{i32 786443, metadata !5, i32 2, i32 0, metadata !6, i32 0} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire-repair/JacobiSVD.cpp]
!33 = metadata !{i32 786470, null, metadata !"", null, i32 0, i64 0, i64 0, i64 0, i32 0, metadata !10} ; [ DW_TAG_const_type ] [line 0, size 0, align 0, offset 0] [from int]
!34 = metadata !{i32 3, i32 0, metadata !32, null}
!35 = metadata !{i32 786688, metadata !32, metadata !"tid_x", metadata !6, i32 5, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [tid_x] [line 5]
!36 = metadata !{i32 5, i32 0, metadata !32, null}
!37 = metadata !{i32 786688, metadata !32, metadata !"bsz_x", metadata !6, i32 6, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [bsz_x] [line 6]
!38 = metadata !{i32 6, i32 0, metadata !32, null}
!39 = metadata !{i32 786688, metadata !32, metadata !"tid_y", metadata !6, i32 7, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [tid_y] [line 7]
!40 = metadata !{i32 7, i32 0, metadata !32, null}
!41 = metadata !{i32 786688, metadata !32, metadata !"gid_y", metadata !6, i32 8, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [gid_y] [line 8]
!42 = metadata !{i32 8, i32 0, metadata !32, null}
!43 = metadata !{i32 786688, metadata !32, metadata !"acc1", metadata !6, i32 11, metadata !9, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [acc1] [line 11]
!44 = metadata !{i32 11, i32 0, metadata !32, null}
!45 = metadata !{i32 786688, metadata !32, metadata !"acc2", metadata !6, i32 12, metadata !9, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [acc2] [line 12]
!46 = metadata !{i32 12, i32 0, metadata !32, null}
!47 = metadata !{i32 17, i32 0, metadata !32, null}
!48 = metadata !{i32 786688, metadata !49, metadata !"i", metadata !6, i32 22, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [i] [line 22]
!49 = metadata !{i32 786443, metadata !32, i32 22, i32 0, metadata !6, i32 1} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire-repair/JacobiSVD.cpp]
!50 = metadata !{i32 22, i32 0, metadata !49, null}
!51 = metadata !{i32 786688, metadata !52, metadata !"j", metadata !6, i32 23, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [j] [line 23]
!52 = metadata !{i32 786443, metadata !53, i32 23, i32 0, metadata !6, i32 3} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire-repair/JacobiSVD.cpp]
!53 = metadata !{i32 786443, metadata !49, i32 22, i32 0, metadata !6, i32 2} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire-repair/JacobiSVD.cpp]
!54 = metadata !{i32 23, i32 0, metadata !52, null}
!55 = metadata !{i32 786688, metadata !56, metadata !"Si", metadata !6, i32 24, metadata !9, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [Si] [line 24]
!56 = metadata !{i32 786443, metadata !52, i32 23, i32 0, metadata !6, i32 4} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire-repair/JacobiSVD.cpp]
!57 = metadata !{i32 24, i32 0, metadata !56, null}
!58 = metadata !{i32 786688, metadata !56, metadata !"Sj", metadata !6, i32 25, metadata !9, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [Sj] [line 25]
!59 = metadata !{i32 25, i32 0, metadata !56, null}
!60 = metadata !{i32 786688, metadata !56, metadata !"p", metadata !6, i32 27, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [p] [line 27]
!61 = metadata !{i32 27, i32 0, metadata !56, null}
!62 = metadata !{i32 786688, metadata !63, metadata !"k", metadata !6, i32 28, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [k] [line 28]
!63 = metadata !{i32 786443, metadata !56, i32 28, i32 0, metadata !6, i32 5} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire-repair/JacobiSVD.cpp]
!64 = metadata !{i32 28, i32 0, metadata !63, null}
!65 = metadata !{i32 29, i32 0, metadata !63, null}
!66 = metadata !{i32 786688, metadata !56, metadata !"y", metadata !6, i32 32, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [y] [line 32]
!67 = metadata !{i32 32, i32 0, metadata !56, null}
!68 = metadata !{i32 786688, metadata !56, metadata !"r", metadata !6, i32 33, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [r] [line 33]
!69 = metadata !{i32 33, i32 0, metadata !56, null}
!70 = metadata !{i32 786688, metadata !56, metadata !"r2", metadata !6, i32 34, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [r2] [line 34]
!71 = metadata !{i32 34, i32 0, metadata !56, null}
!72 = metadata !{i32 786688, metadata !56, metadata !"c", metadata !6, i32 35, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [c] [line 35]
!73 = metadata !{i32 35, i32 0, metadata !56, null}
!74 = metadata !{i32 786688, metadata !56, metadata !"s", metadata !6, i32 35, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [s] [line 35]
!75 = metadata !{i32 36, i32 0, metadata !56, null}
!76 = metadata !{i32 37, i32 0, metadata !77, null}
!77 = metadata !{i32 786443, metadata !56, i32 36, i32 0, metadata !6, i32 6} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire-repair/JacobiSVD.cpp]
!78 = metadata !{i32 38, i32 0, metadata !77, null}
!79 = metadata !{i32 39, i32 0, metadata !77, null}
!80 = metadata !{i32 41, i32 0, metadata !81, null}
!81 = metadata !{i32 786443, metadata !56, i32 40, i32 0, metadata !6, i32 7} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire-repair/JacobiSVD.cpp]
!82 = metadata !{i32 42, i32 0, metadata !81, null}
!83 = metadata !{i32 45, i32 0, metadata !56, null}
!84 = metadata !{i32 786688, metadata !85, metadata !"t0", metadata !6, i32 46, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [t0] [line 46]
!85 = metadata !{i32 786443, metadata !56, i32 45, i32 0, metadata !6, i32 8} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire-repair/JacobiSVD.cpp]
!86 = metadata !{i32 46, i32 0, metadata !85, null}
!87 = metadata !{i32 786688, metadata !85, metadata !"t1", metadata !6, i32 47, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [t1] [line 47]
!88 = metadata !{i32 47, i32 0, metadata !85, null}
!89 = metadata !{i32 48, i32 0, metadata !85, null}
!90 = metadata !{i32 49, i32 0, metadata !85, null}
!91 = metadata !{i32 51, i32 0, metadata !85, null}
!92 = metadata !{i32 52, i32 0, metadata !85, null}
!93 = metadata !{i32 53, i32 0, metadata !85, null}
!94 = metadata !{i32 54, i32 0, metadata !56, null}
!95 = metadata !{i32 55, i32 0, metadata !53, null}
!96 = metadata !{i32 56, i32 0, metadata !53, null}
!97 = metadata !{i32 57, i32 0, metadata !32, null}
!98 = metadata !{i32 786688, metadata !99, metadata !"i", metadata !6, i32 59, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [i] [line 59]
!99 = metadata !{i32 786443, metadata !32, i32 59, i32 0, metadata !6, i32 9} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire-repair/JacobiSVD.cpp]
!100 = metadata !{i32 59, i32 0, metadata !99, null}
!101 = metadata !{i32 60, i32 0, metadata !99, null}
!102 = metadata !{i32 61, i32 0, metadata !32, null}
!103 = metadata !{i32 62, i32 0, metadata !32, null}
!104 = metadata !{i32 63, i32 0, metadata !32, null}
!105 = metadata !{i32 64, i32 0, metadata !32, null}
