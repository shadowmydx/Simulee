; ModuleID = 'data_race'
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

define void @_Z9JacobiSVDPiS_ii(i32* %S, i32* %V, i32 %m, i32 %n) uwtable section "__device__" {
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
  %i1 = alloca i32, align 4
  %t = alloca i32, align 4
  %t2 = alloca i32, align 4
  %i3 = alloca i32, align 4
  %it = alloca i32, align 4
  %converged = alloca i8, align 1
  %i4 = alloca i32, align 4
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
  %Vi = alloca i32*, align 8
  %Vj = alloca i32*, align 8
  %t05 = alloca i32, align 4
  %t16 = alloca i32, align 4
  %i7 = alloca i32, align 4
  store i32* %S, i32** %1, align 8
  call void @llvm.dbg.declare(metadata !{i32** %1}, metadata !42), !dbg !43
  store i32* %V, i32** %2, align 8
  call void @llvm.dbg.declare(metadata !{i32** %2}, metadata !44), !dbg !43
  store i32 %m, i32* %3, align 4
  call void @llvm.dbg.declare(metadata !{i32* %3}, metadata !45), !dbg !43
  store i32 %n, i32* %4, align 4
  call void @llvm.dbg.declare(metadata !{i32* %4}, metadata !46), !dbg !43
  call void @llvm.dbg.declare(metadata !{i32* %iterations}, metadata !47), !dbg !49
  store i32 30, i32* %iterations, align 4, !dbg !49
  call void @llvm.dbg.declare(metadata !{i32* %tid_x}, metadata !50), !dbg !51
  %5 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !51
  store i32 %5, i32* %tid_x, align 4, !dbg !51
  call void @llvm.dbg.declare(metadata !{i32* %bsz_x}, metadata !52), !dbg !53
  %6 = load i32* getelementptr inbounds (%struct.dim3* @blockDim, i32 0, i32 0), align 4, !dbg !53
  store i32 %6, i32* %bsz_x, align 4, !dbg !53
  call void @llvm.dbg.declare(metadata !{i32* %tid_y}, metadata !54), !dbg !55
  %7 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 1), align 4, !dbg !55
  store i32 %7, i32* %tid_y, align 4, !dbg !55
  call void @llvm.dbg.declare(metadata !{i32* %gid_y}, metadata !56), !dbg !57
  %8 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 1), align 4, !dbg !57
  %9 = load i32* getelementptr inbounds (%struct.dim3* @blockDim, i32 0, i32 1), align 4, !dbg !57
  %10 = mul i32 %8, %9, !dbg !57
  %11 = load i32* %tid_y, align 4, !dbg !57
  %12 = add i32 %10, %11, !dbg !57
  store i32 %12, i32* %gid_y, align 4, !dbg !57
  call void @llvm.dbg.declare(metadata !{i32** %acc1}, metadata !58), !dbg !59
  store i32* getelementptr inbounds ([512 x i32]* @_ZZ9JacobiSVDPiS_iiE3acc, i32 0, i32 0), i32** %acc1, align 8, !dbg !59
  call void @llvm.dbg.declare(metadata !{i32** %acc2}, metadata !60), !dbg !61
  store i32* getelementptr inbounds ([512 x i32]* @_ZZ9JacobiSVDPiS_iiE3acc, i32 0, i64 256), i32** %acc2, align 8, !dbg !61
  call void @llvm.dbg.declare(metadata !{i32* %i}, metadata !62), !dbg !64
  store i32 0, i32* %i, align 4, !dbg !64
  br label %13, !dbg !64

; <label>:13                                      ; preds = %39, %0
  %14 = load i32* %i, align 4, !dbg !64
  %15 = icmp sle i32 %14, 4, !dbg !64
  br i1 %15, label %16, label %42, !dbg !64

; <label>:16                                      ; preds = %13
  %17 = load i32* %gid_y, align 4, !dbg !65
  %18 = mul nsw i32 %17, 81, !dbg !65
  %19 = load i32* %i, align 4, !dbg !65
  %20 = load i32* %bsz_x, align 4, !dbg !65
  %21 = mul nsw i32 %19, %20, !dbg !65
  %22 = add nsw i32 %18, %21, !dbg !65
  %23 = load i32* %tid_x, align 4, !dbg !65
  %24 = add nsw i32 %22, %23, !dbg !65
  %25 = sext i32 %24 to i64, !dbg !65
  %26 = load i32** %1, align 8, !dbg !65
  %27 = getelementptr inbounds i32* %26, i64 %25, !dbg !65
  %28 = load i32* %27, align 4, !dbg !65
  %29 = load i32* %tid_y, align 4, !dbg !65
  %30 = mul nsw i32 %29, 81, !dbg !65
  %31 = load i32* %i, align 4, !dbg !65
  %32 = load i32* %bsz_x, align 4, !dbg !65
  %33 = mul nsw i32 %31, %32, !dbg !65
  %34 = add nsw i32 %30, %33, !dbg !65
  %35 = load i32* %tid_x, align 4, !dbg !65
  %36 = add nsw i32 %34, %35, !dbg !65
  %37 = sext i32 %36 to i64, !dbg !65
  %38 = getelementptr inbounds [1296 x i32]* @_ZZ9JacobiSVDPiS_iiE3s_S, i32 0, i64 %37, !dbg !65
  store i32 %28, i32* %38, align 4, !dbg !65
  br label %39, !dbg !65

; <label>:39                                      ; preds = %16
  %40 = load i32* %i, align 4, !dbg !64
  %41 = add nsw i32 %40, 1, !dbg !64
  store i32 %41, i32* %i, align 4, !dbg !64
  br label %13, !dbg !64

; <label>:42                                      ; preds = %13
  %43 = load i32* %tid_x, align 4, !dbg !66
  %44 = icmp eq i32 %43, 0, !dbg !66
  br i1 %44, label %45, label %58, !dbg !66

; <label>:45                                      ; preds = %42
  %46 = load i32* %gid_y, align 4, !dbg !67
  %47 = mul nsw i32 %46, 81, !dbg !67
  %48 = add nsw i32 %47, 80, !dbg !67
  %49 = sext i32 %48 to i64, !dbg !67
  %50 = load i32** %1, align 8, !dbg !67
  %51 = getelementptr inbounds i32* %50, i64 %49, !dbg !67
  %52 = load i32* %51, align 4, !dbg !67
  %53 = load i32* %tid_y, align 4, !dbg !67
  %54 = mul nsw i32 %53, 81, !dbg !67
  %55 = add nsw i32 %54, 80, !dbg !67
  %56 = sext i32 %55 to i64, !dbg !67
  %57 = getelementptr inbounds [1296 x i32]* @_ZZ9JacobiSVDPiS_iiE3s_S, i32 0, i64 %56, !dbg !67
  store i32 %52, i32* %57, align 4, !dbg !67
  br label %58, !dbg !67

; <label>:58                                      ; preds = %45, %42
  call void @__syncthreads(), !dbg !68
  call void @llvm.dbg.declare(metadata !{i32* %i1}, metadata !69), !dbg !71
  store i32 0, i32* %i1, align 4, !dbg !71
  br label %59, !dbg !71

; <label>:59                                      ; preds = %87, %58
  %60 = load i32* %i1, align 4, !dbg !71
  %61 = icmp sle i32 %60, 4, !dbg !71
  br i1 %61, label %62, label %90, !dbg !71

; <label>:62                                      ; preds = %59
  call void @llvm.dbg.declare(metadata !{i32* %t}, metadata !72), !dbg !74
  %63 = load i32* %tid_y, align 4, !dbg !74
  %64 = mul nsw i32 %63, 81, !dbg !74
  %65 = load i32* %tid_x, align 4, !dbg !74
  %66 = add nsw i32 %64, %65, !dbg !74
  %67 = load i32* %i1, align 4, !dbg !74
  %68 = load i32* %bsz_x, align 4, !dbg !74
  %69 = mul nsw i32 %67, %68, !dbg !74
  %70 = add nsw i32 %66, %69, !dbg !74
  %71 = sext i32 %70 to i64, !dbg !74
  %72 = getelementptr inbounds [1296 x i32]* @_ZZ9JacobiSVDPiS_iiE3s_S, i32 0, i64 %71, !dbg !74
  %73 = load i32* %72, align 4, !dbg !74
  store i32 %73, i32* %t, align 4, !dbg !74
  %74 = load i32* %t, align 4, !dbg !75
  %75 = load i32* %t, align 4, !dbg !75
  %76 = mul nsw i32 %74, %75, !dbg !75
  %77 = load i32* %tid_y, align 4, !dbg !75
  %78 = load i32* %bsz_x, align 4, !dbg !75
  %79 = mul nsw i32 %77, %78, !dbg !75
  %80 = load i32* %tid_x, align 4, !dbg !75
  %81 = add nsw i32 %79, %80, !dbg !75
  %82 = sext i32 %81 to i64, !dbg !75
  %83 = load i32** %acc1, align 8, !dbg !75
  %84 = getelementptr inbounds i32* %83, i64 %82, !dbg !75
  %85 = load i32* %84, align 4, !dbg !75
  %86 = add nsw i32 %85, %76, !dbg !75
  store i32 %86, i32* %84, align 4, !dbg !75
  br label %87, !dbg !76

; <label>:87                                      ; preds = %62
  %88 = load i32* %i1, align 4, !dbg !71
  %89 = add nsw i32 %88, 1, !dbg !71
  store i32 %89, i32* %i1, align 4, !dbg !71
  br label %59, !dbg !71

; <label>:90                                      ; preds = %59
  %91 = load i32* %tid_x, align 4, !dbg !77
  %92 = icmp slt i32 %91, 8, !dbg !77
  br i1 %92, label %93, label %112, !dbg !77

; <label>:93                                      ; preds = %90
  %94 = load i32* %tid_y, align 4, !dbg !78
  %95 = mul nsw i32 %94, 16, !dbg !78
  %96 = load i32* %tid_x, align 4, !dbg !78
  %97 = add nsw i32 %95, %96, !dbg !78
  %98 = add nsw i32 %97, 8, !dbg !78
  %99 = sext i32 %98 to i64, !dbg !78
  %100 = load i32** %acc1, align 8, !dbg !78
  %101 = getelementptr inbounds i32* %100, i64 %99, !dbg !78
  %102 = load i32* %101, align 4, !dbg !78
  %103 = load i32* %tid_y, align 4, !dbg !78
  %104 = mul nsw i32 %103, 16, !dbg !78
  %105 = load i32* %tid_x, align 4, !dbg !78
  %106 = add nsw i32 %104, %105, !dbg !78
  %107 = sext i32 %106 to i64, !dbg !78
  %108 = load i32** %acc1, align 8, !dbg !78
  %109 = getelementptr inbounds i32* %108, i64 %107, !dbg !78
  %110 = load i32* %109, align 4, !dbg !78
  %111 = add nsw i32 %110, %102, !dbg !78
  store i32 %111, i32* %109, align 4, !dbg !78
  br label %112, !dbg !78

; <label>:112                                     ; preds = %93, %90
  call void @__syncthreads(), !dbg !79
  %113 = load i32* %tid_x, align 4, !dbg !80
  %114 = icmp slt i32 %113, 4, !dbg !80
  br i1 %114, label %115, label %134, !dbg !80

; <label>:115                                     ; preds = %112
  %116 = load i32* %tid_y, align 4, !dbg !81
  %117 = mul nsw i32 %116, 16, !dbg !81
  %118 = load i32* %tid_x, align 4, !dbg !81
  %119 = add nsw i32 %117, %118, !dbg !81
  %120 = add nsw i32 %119, 4, !dbg !81
  %121 = sext i32 %120 to i64, !dbg !81
  %122 = load i32** %acc1, align 8, !dbg !81
  %123 = getelementptr inbounds i32* %122, i64 %121, !dbg !81
  %124 = load i32* %123, align 4, !dbg !81
  %125 = load i32* %tid_y, align 4, !dbg !81
  %126 = mul nsw i32 %125, 16, !dbg !81
  %127 = load i32* %tid_x, align 4, !dbg !81
  %128 = add nsw i32 %126, %127, !dbg !81
  %129 = sext i32 %128 to i64, !dbg !81
  %130 = load i32** %acc1, align 8, !dbg !81
  %131 = getelementptr inbounds i32* %130, i64 %129, !dbg !81
  %132 = load i32* %131, align 4, !dbg !81
  %133 = add nsw i32 %132, %124, !dbg !81
  store i32 %133, i32* %131, align 4, !dbg !81
  br label %134, !dbg !81

; <label>:134                                     ; preds = %115, %112
  call void @__syncthreads(), !dbg !82
  %135 = load i32* %tid_x, align 4, !dbg !83
  %136 = icmp slt i32 %135, 2, !dbg !83
  br i1 %136, label %137, label %156, !dbg !83

; <label>:137                                     ; preds = %134
  %138 = load i32* %tid_y, align 4, !dbg !84
  %139 = mul nsw i32 %138, 16, !dbg !84
  %140 = load i32* %tid_x, align 4, !dbg !84
  %141 = add nsw i32 %139, %140, !dbg !84
  %142 = add nsw i32 %141, 2, !dbg !84
  %143 = sext i32 %142 to i64, !dbg !84
  %144 = load i32** %acc1, align 8, !dbg !84
  %145 = getelementptr inbounds i32* %144, i64 %143, !dbg !84
  %146 = load i32* %145, align 4, !dbg !84
  %147 = load i32* %tid_y, align 4, !dbg !84
  %148 = mul nsw i32 %147, 16, !dbg !84
  %149 = load i32* %tid_x, align 4, !dbg !84
  %150 = add nsw i32 %148, %149, !dbg !84
  %151 = sext i32 %150 to i64, !dbg !84
  %152 = load i32** %acc1, align 8, !dbg !84
  %153 = getelementptr inbounds i32* %152, i64 %151, !dbg !84
  %154 = load i32* %153, align 4, !dbg !84
  %155 = add nsw i32 %154, %146, !dbg !84
  store i32 %155, i32* %153, align 4, !dbg !84
  br label %156, !dbg !84

; <label>:156                                     ; preds = %137, %134
  call void @__syncthreads(), !dbg !85
  %157 = load i32* %tid_x, align 4, !dbg !86
  %158 = icmp slt i32 %157, 1, !dbg !86
  br i1 %158, label %159, label %191, !dbg !86

; <label>:159                                     ; preds = %156
  call void @llvm.dbg.declare(metadata !{i32* %t2}, metadata !87), !dbg !89
  %160 = load i32* %tid_y, align 4, !dbg !89
  %161 = load i32* %bsz_x, align 4, !dbg !89
  %162 = mul nsw i32 %160, %161, !dbg !89
  %163 = load i32* %tid_x, align 4, !dbg !89
  %164 = add nsw i32 %162, %163, !dbg !89
  %165 = add nsw i32 %164, 80, !dbg !89
  %166 = sext i32 %165 to i64, !dbg !89
  %167 = getelementptr inbounds [1296 x i32]* @_ZZ9JacobiSVDPiS_iiE3s_S, i32 0, i64 %166, !dbg !89
  %168 = load i32* %167, align 4, !dbg !89
  store i32 %168, i32* %t2, align 4, !dbg !89
  %169 = load i32* %tid_y, align 4, !dbg !90
  %170 = mul nsw i32 %169, 16, !dbg !90
  %171 = load i32* %tid_x, align 4, !dbg !90
  %172 = add nsw i32 %170, %171, !dbg !90
  %173 = add nsw i32 %172, 1, !dbg !90
  %174 = sext i32 %173 to i64, !dbg !90
  %175 = load i32** %acc1, align 8, !dbg !90
  %176 = getelementptr inbounds i32* %175, i64 %174, !dbg !90
  %177 = load i32* %176, align 4, !dbg !90
  %178 = load i32* %t2, align 4, !dbg !90
  %179 = load i32* %t2, align 4, !dbg !90
  %180 = mul nsw i32 %178, %179, !dbg !90
  %181 = add nsw i32 %177, %180, !dbg !90
  %182 = load i32* %tid_y, align 4, !dbg !90
  %183 = mul nsw i32 %182, 16, !dbg !90
  %184 = load i32* %tid_x, align 4, !dbg !90
  %185 = add nsw i32 %183, %184, !dbg !90
  %186 = sext i32 %185 to i64, !dbg !90
  %187 = load i32** %acc1, align 8, !dbg !90
  %188 = getelementptr inbounds i32* %187, i64 %186, !dbg !90
  %189 = load i32* %188, align 4, !dbg !90
  %190 = add nsw i32 %189, %181, !dbg !90
  store i32 %190, i32* %188, align 4, !dbg !90
  br label %191, !dbg !91

; <label>:191                                     ; preds = %159, %156
  call void @__syncthreads(), !dbg !92
  %192 = load i32* %tid_x, align 4, !dbg !93
  %193 = load i32* %4, align 4, !dbg !93
  %194 = icmp slt i32 %192, %193, !dbg !93
  br i1 %194, label %195, label %211, !dbg !93

; <label>:195                                     ; preds = %191
  %196 = load i32* %tid_y, align 4, !dbg !94
  %197 = load i32* %bsz_x, align 4, !dbg !94
  %198 = mul nsw i32 %196, %197, !dbg !94
  %199 = load i32* %tid_x, align 4, !dbg !94
  %200 = add nsw i32 %198, %199, !dbg !94
  %201 = sext i32 %200 to i64, !dbg !94
  %202 = load i32** %acc1, align 8, !dbg !94
  %203 = getelementptr inbounds i32* %202, i64 %201, !dbg !94
  %204 = load i32* %203, align 4, !dbg !94
  %205 = load i32* %tid_y, align 4, !dbg !94
  %206 = mul nsw i32 %205, 9, !dbg !94
  %207 = load i32* %tid_x, align 4, !dbg !94
  %208 = add nsw i32 %206, %207, !dbg !94
  %209 = sext i32 %208 to i64, !dbg !94
  %210 = getelementptr inbounds [144 x i32]* @_ZZ9JacobiSVDPiS_iiE1d, i32 0, i64 %209, !dbg !94
  store i32 %204, i32* %210, align 4, !dbg !94
  br label %211, !dbg !94

; <label>:211                                     ; preds = %195, %191
  call void @llvm.dbg.declare(metadata !{i32* %i3}, metadata !95), !dbg !97
  store i32 0, i32* %i3, align 4, !dbg !97
  br label %212, !dbg !97

; <label>:212                                     ; preds = %226, %211
  %213 = load i32* %i3, align 4, !dbg !97
  %214 = icmp sle i32 %213, 4, !dbg !97
  br i1 %214, label %215, label %229, !dbg !97

; <label>:215                                     ; preds = %212
  %216 = load i32* %tid_y, align 4, !dbg !98
  %217 = mul nsw i32 %216, 81, !dbg !98
  %218 = load i32* %i3, align 4, !dbg !98
  %219 = load i32* %bsz_x, align 4, !dbg !98
  %220 = mul nsw i32 %218, %219, !dbg !98
  %221 = add nsw i32 %217, %220, !dbg !98
  %222 = load i32* %tid_x, align 4, !dbg !98
  %223 = add nsw i32 %221, %222, !dbg !98
  %224 = sext i32 %223 to i64, !dbg !98
  %225 = getelementptr inbounds [1296 x i32]* @_ZZ9JacobiSVDPiS_iiE3s_V, i32 0, i64 %224, !dbg !98
  store i32 0, i32* %225, align 4, !dbg !98
  br label %226, !dbg !100

; <label>:226                                     ; preds = %215
  %227 = load i32* %i3, align 4, !dbg !97
  %228 = add nsw i32 %227, 1, !dbg !97
  store i32 %228, i32* %i3, align 4, !dbg !97
  br label %212, !dbg !97

; <label>:229                                     ; preds = %212
  call void @__syncthreads(), !dbg !101
  %230 = load i32* %tid_x, align 4, !dbg !102
  %231 = load i32* %3, align 4, !dbg !102
  %232 = icmp slt i32 %230, %231, !dbg !102
  br i1 %232, label %233, label %244, !dbg !102

; <label>:233                                     ; preds = %229
  %234 = load i32* %tid_y, align 4, !dbg !103
  %235 = mul nsw i32 %234, 81, !dbg !103
  %236 = load i32* %tid_x, align 4, !dbg !103
  %237 = load i32* %3, align 4, !dbg !103
  %238 = mul nsw i32 %236, %237, !dbg !103
  %239 = add nsw i32 %235, %238, !dbg !103
  %240 = load i32* %tid_x, align 4, !dbg !103
  %241 = add nsw i32 %239, %240, !dbg !103
  %242 = sext i32 %241 to i64, !dbg !103
  %243 = getelementptr inbounds [1296 x i32]* @_ZZ9JacobiSVDPiS_iiE3s_V, i32 0, i64 %242, !dbg !103
  store i32 1, i32* %243, align 4, !dbg !103
  br label %244, !dbg !103

; <label>:244                                     ; preds = %233, %229
  call void @__syncthreads(), !dbg !104
  call void @llvm.dbg.declare(metadata !{i32* %it}, metadata !105), !dbg !107
  store i32 0, i32* %it, align 4, !dbg !107
  br label %245, !dbg !107

; <label>:245                                     ; preds = %658, %244
  %246 = load i32* %it, align 4, !dbg !107
  %247 = icmp slt i32 %246, 30, !dbg !107
  br i1 %247, label %248, label %661, !dbg !107

; <label>:248                                     ; preds = %245
  call void @llvm.dbg.declare(metadata !{i8* %converged}, metadata !108), !dbg !111
  store i8 0, i8* %converged, align 1, !dbg !111
  call void @llvm.dbg.declare(metadata !{i32* %i4}, metadata !112), !dbg !114
  store i32 0, i32* %i4, align 4, !dbg !114
  br label %249, !dbg !114

; <label>:249                                     ; preds = %654, %248
  %250 = load i32* %i4, align 4, !dbg !114
  %251 = load i32* %4, align 4, !dbg !114
  %252 = sub nsw i32 %251, 1, !dbg !114
  %253 = icmp slt i32 %250, %252, !dbg !114
  br i1 %253, label %254, label %657, !dbg !114

; <label>:254                                     ; preds = %249
  call void @llvm.dbg.declare(metadata !{i32* %j}, metadata !115), !dbg !118
  %255 = load i32* %i4, align 4, !dbg !118
  %256 = add nsw i32 %255, 1, !dbg !118
  store i32 %256, i32* %j, align 4, !dbg !118
  br label %257, !dbg !118

; <label>:257                                     ; preds = %646, %254
  %258 = load i32* %j, align 4, !dbg !118
  %259 = load i32* %4, align 4, !dbg !118
  %260 = icmp slt i32 %258, %259, !dbg !118
  br i1 %260, label %261, label %649, !dbg !118

; <label>:261                                     ; preds = %257
  call void @llvm.dbg.declare(metadata !{i32** %Si}, metadata !119), !dbg !121
  %262 = load i32* %tid_y, align 4, !dbg !121
  %263 = mul nsw i32 %262, 81, !dbg !121
  %264 = sext i32 %263 to i64, !dbg !121
  %265 = getelementptr inbounds i32* getelementptr inbounds ([1296 x i32]* @_ZZ9JacobiSVDPiS_iiE3s_S, i32 0, i32 0), i64 %264, !dbg !121
  %266 = load i32* %i4, align 4, !dbg !121
  %267 = load i32* %3, align 4, !dbg !121
  %268 = mul nsw i32 %266, %267, !dbg !121
  %269 = sext i32 %268 to i64, !dbg !121
  %270 = getelementptr inbounds i32* %265, i64 %269, !dbg !121
  store i32* %270, i32** %Si, align 8, !dbg !121
  call void @llvm.dbg.declare(metadata !{i32** %Sj}, metadata !122), !dbg !123
  %271 = load i32* %tid_y, align 4, !dbg !123
  %272 = mul nsw i32 %271, 81, !dbg !123
  %273 = sext i32 %272 to i64, !dbg !123
  %274 = getelementptr inbounds i32* getelementptr inbounds ([1296 x i32]* @_ZZ9JacobiSVDPiS_iiE3s_S, i32 0, i32 0), i64 %273, !dbg !123
  %275 = load i32* %j, align 4, !dbg !123
  %276 = load i32* %3, align 4, !dbg !123
  %277 = mul nsw i32 %275, %276, !dbg !123
  %278 = sext i32 %277 to i64, !dbg !123
  %279 = getelementptr inbounds i32* %274, i64 %278, !dbg !123
  store i32* %279, i32** %Sj, align 8, !dbg !123
  call void @llvm.dbg.declare(metadata !{i32* %p}, metadata !124), !dbg !125
  store i32 0, i32* %p, align 4, !dbg !125
  call void @llvm.dbg.declare(metadata !{i32* %k}, metadata !126), !dbg !128
  store i32 0, i32* %k, align 4, !dbg !128
  br label %280, !dbg !128

; <label>:280                                     ; preds = %298, %261
  %281 = load i32* %k, align 4, !dbg !128
  %282 = load i32* %3, align 4, !dbg !128
  %283 = icmp slt i32 %281, %282, !dbg !128
  br i1 %283, label %284, label %301, !dbg !128

; <label>:284                                     ; preds = %280
  %285 = load i32* %k, align 4, !dbg !129
  %286 = sext i32 %285 to i64, !dbg !129
  %287 = load i32** %Si, align 8, !dbg !129
  %288 = getelementptr inbounds i32* %287, i64 %286, !dbg !129
  %289 = load i32* %288, align 4, !dbg !129
  %290 = load i32* %k, align 4, !dbg !129
  %291 = sext i32 %290 to i64, !dbg !129
  %292 = load i32** %Sj, align 8, !dbg !129
  %293 = getelementptr inbounds i32* %292, i64 %291, !dbg !129
  %294 = load i32* %293, align 4, !dbg !129
  %295 = mul nsw i32 %289, %294, !dbg !129
  %296 = load i32* %p, align 4, !dbg !129
  %297 = add nsw i32 %296, %295, !dbg !129
  store i32 %297, i32* %p, align 4, !dbg !129
  br label %298, !dbg !129

; <label>:298                                     ; preds = %284
  %299 = load i32* %k, align 4, !dbg !128
  %300 = add nsw i32 %299, 1, !dbg !128
  store i32 %300, i32* %k, align 4, !dbg !128
  br label %280, !dbg !128

; <label>:301                                     ; preds = %280
  call void @llvm.dbg.declare(metadata !{i32* %y}, metadata !130), !dbg !131
  %302 = load i32* %tid_y, align 4, !dbg !131
  %303 = mul nsw i32 %302, 9, !dbg !131
  %304 = load i32* %i4, align 4, !dbg !131
  %305 = add nsw i32 %303, %304, !dbg !131
  %306 = sext i32 %305 to i64, !dbg !131
  %307 = getelementptr inbounds [144 x i32]* @_ZZ9JacobiSVDPiS_iiE1d, i32 0, i64 %306, !dbg !131
  %308 = load i32* %307, align 4, !dbg !131
  %309 = load i32* %tid_y, align 4, !dbg !131
  %310 = mul nsw i32 %309, 9, !dbg !131
  %311 = load i32* %j, align 4, !dbg !131
  %312 = add nsw i32 %310, %311, !dbg !131
  %313 = sext i32 %312 to i64, !dbg !131
  %314 = getelementptr inbounds [144 x i32]* @_ZZ9JacobiSVDPiS_iiE1d, i32 0, i64 %313, !dbg !131
  %315 = load i32* %314, align 4, !dbg !131
  %316 = sub nsw i32 %308, %315, !dbg !131
  store i32 %316, i32* %y, align 4, !dbg !131
  call void @llvm.dbg.declare(metadata !{i32* %r}, metadata !132), !dbg !133
  %317 = load i32* %p, align 4, !dbg !133
  %318 = mul nsw i32 %317, 2, !dbg !133
  %319 = load i32* %y, align 4, !dbg !133
  %320 = add nsw i32 %318, %319, !dbg !133
  store i32 %320, i32* %r, align 4, !dbg !133
  call void @llvm.dbg.declare(metadata !{i32* %r2}, metadata !134), !dbg !135
  %321 = load i32* %r, align 4, !dbg !135
  %322 = mul nsw i32 %321, 2, !dbg !135
  store i32 %322, i32* %r2, align 4, !dbg !135
  call void @llvm.dbg.declare(metadata !{i32* %c}, metadata !136), !dbg !137
  call void @llvm.dbg.declare(metadata !{i32* %s}, metadata !138), !dbg !137
  %323 = load i32* %y, align 4, !dbg !139
  %324 = icmp sge i32 %323, 0, !dbg !139
  br i1 %324, label %325, label %336, !dbg !139

; <label>:325                                     ; preds = %301
  %326 = load i32* %r, align 4, !dbg !140
  %327 = load i32* %y, align 4, !dbg !140
  %328 = add nsw i32 %326, %327, !dbg !140
  %329 = load i32* %r2, align 4, !dbg !140
  %330 = sdiv i32 %328, %329, !dbg !140
  store i32 %330, i32* %c, align 4, !dbg !140
  %331 = load i32* %p, align 4, !dbg !142
  %332 = load i32* %r2, align 4, !dbg !142
  %333 = load i32* %c, align 4, !dbg !142
  %334 = mul nsw i32 %332, %333, !dbg !142
  %335 = sdiv i32 %331, %334, !dbg !142
  store i32 %335, i32* %s, align 4, !dbg !142
  br label %349, !dbg !143

; <label>:336                                     ; preds = %301
  %337 = load i32* %r, align 4, !dbg !144
  %338 = load i32* %y, align 4, !dbg !144
  %339 = sub nsw i32 %337, %338, !dbg !144
  %340 = load i32* %r2, align 4, !dbg !144
  %341 = sdiv i32 %339, %340, !dbg !144
  %342 = call double @_ZSt4sqrtIiEN9__gnu_cxx11__enable_ifIXsr12__is_integerIT_EE7__valueEdE6__typeES2_(i32 %341), !dbg !144
  %343 = fptosi double %342 to i32, !dbg !144
  store i32 %343, i32* %s, align 4, !dbg !144
  %344 = load i32* %p, align 4, !dbg !146
  %345 = load i32* %r2, align 4, !dbg !146
  %346 = load i32* %s, align 4, !dbg !146
  %347 = mul nsw i32 %345, %346, !dbg !146
  %348 = sdiv i32 %344, %347, !dbg !146
  store i32 %348, i32* %c, align 4, !dbg !146
  br label %349

; <label>:349                                     ; preds = %336, %325
  %350 = load i32* %tid_x, align 4, !dbg !147
  %351 = load i32* %3, align 4, !dbg !147
  %352 = icmp slt i32 %350, %351, !dbg !147
  br i1 %352, label %353, label %414, !dbg !147

; <label>:353                                     ; preds = %349
  call void @llvm.dbg.declare(metadata !{i32* %t0}, metadata !148), !dbg !150
  %354 = load i32* %c, align 4, !dbg !150
  %355 = load i32* %tid_x, align 4, !dbg !150
  %356 = sext i32 %355 to i64, !dbg !150
  %357 = load i32** %Si, align 8, !dbg !150
  %358 = getelementptr inbounds i32* %357, i64 %356, !dbg !150
  %359 = load i32* %358, align 4, !dbg !150
  %360 = mul nsw i32 %354, %359, !dbg !150
  %361 = load i32* %s, align 4, !dbg !150
  %362 = load i32* %tid_x, align 4, !dbg !150
  %363 = sext i32 %362 to i64, !dbg !150
  %364 = load i32** %Sj, align 8, !dbg !150
  %365 = getelementptr inbounds i32* %364, i64 %363, !dbg !150
  %366 = load i32* %365, align 4, !dbg !150
  %367 = mul nsw i32 %361, %366, !dbg !150
  %368 = add nsw i32 %360, %367, !dbg !150
  store i32 %368, i32* %t0, align 4, !dbg !150
  call void @llvm.dbg.declare(metadata !{i32* %t1}, metadata !151), !dbg !152
  %369 = load i32* %c, align 4, !dbg !152
  %370 = load i32* %tid_x, align 4, !dbg !152
  %371 = sext i32 %370 to i64, !dbg !152
  %372 = load i32** %Sj, align 8, !dbg !152
  %373 = getelementptr inbounds i32* %372, i64 %371, !dbg !152
  %374 = load i32* %373, align 4, !dbg !152
  %375 = mul nsw i32 %369, %374, !dbg !152
  %376 = load i32* %s, align 4, !dbg !152
  %377 = load i32* %tid_x, align 4, !dbg !152
  %378 = sext i32 %377 to i64, !dbg !152
  %379 = load i32** %Si, align 8, !dbg !152
  %380 = getelementptr inbounds i32* %379, i64 %378, !dbg !152
  %381 = load i32* %380, align 4, !dbg !152
  %382 = mul nsw i32 %376, %381, !dbg !152
  %383 = sub nsw i32 %375, %382, !dbg !152
  store i32 %383, i32* %t1, align 4, !dbg !152
  %384 = load i32* %t0, align 4, !dbg !153
  %385 = load i32* %tid_x, align 4, !dbg !153
  %386 = sext i32 %385 to i64, !dbg !153
  %387 = load i32** %Si, align 8, !dbg !153
  %388 = getelementptr inbounds i32* %387, i64 %386, !dbg !153
  store i32 %384, i32* %388, align 4, !dbg !153
  %389 = load i32* %t1, align 4, !dbg !154
  %390 = load i32* %tid_x, align 4, !dbg !154
  %391 = sext i32 %390 to i64, !dbg !154
  %392 = load i32** %Sj, align 8, !dbg !154
  %393 = getelementptr inbounds i32* %392, i64 %391, !dbg !154
  store i32 %389, i32* %393, align 4, !dbg !154
  %394 = load i32* %t0, align 4, !dbg !155
  %395 = load i32* %t0, align 4, !dbg !155
  %396 = mul nsw i32 %394, %395, !dbg !155
  %397 = load i32* %tid_y, align 4, !dbg !155
  %398 = mul nsw i32 %397, 16, !dbg !155
  %399 = load i32* %tid_x, align 4, !dbg !155
  %400 = add nsw i32 %398, %399, !dbg !155
  %401 = sext i32 %400 to i64, !dbg !155
  %402 = load i32** %acc1, align 8, !dbg !155
  %403 = getelementptr inbounds i32* %402, i64 %401, !dbg !155
  store i32 %396, i32* %403, align 4, !dbg !155
  %404 = load i32* %t1, align 4, !dbg !156
  %405 = load i32* %t1, align 4, !dbg !156
  %406 = mul nsw i32 %404, %405, !dbg !156
  %407 = load i32* %tid_y, align 4, !dbg !156
  %408 = mul nsw i32 %407, 16, !dbg !156
  %409 = load i32* %tid_x, align 4, !dbg !156
  %410 = add nsw i32 %408, %409, !dbg !156
  %411 = sext i32 %410 to i64, !dbg !156
  %412 = load i32** %acc2, align 8, !dbg !156
  %413 = getelementptr inbounds i32* %412, i64 %411, !dbg !156
  store i32 %406, i32* %413, align 4, !dbg !156
  br label %414, !dbg !157

; <label>:414                                     ; preds = %353, %349
  call void @__syncthreads(), !dbg !158
  %415 = load i32* %tid_x, align 4, !dbg !159
  %416 = icmp slt i32 %415, 4, !dbg !159
  br i1 %416, label %417, label %454, !dbg !159

; <label>:417                                     ; preds = %414
  %418 = load i32* %tid_y, align 4, !dbg !160
  %419 = mul nsw i32 %418, 16, !dbg !160
  %420 = load i32* %tid_x, align 4, !dbg !160
  %421 = add nsw i32 %419, %420, !dbg !160
  %422 = add nsw i32 %421, 4, !dbg !160
  %423 = sext i32 %422 to i64, !dbg !160
  %424 = load i32** %acc1, align 8, !dbg !160
  %425 = getelementptr inbounds i32* %424, i64 %423, !dbg !160
  %426 = load i32* %425, align 4, !dbg !160
  %427 = load i32* %tid_y, align 4, !dbg !160
  %428 = mul nsw i32 %427, 16, !dbg !160
  %429 = load i32* %tid_x, align 4, !dbg !160
  %430 = add nsw i32 %428, %429, !dbg !160
  %431 = sext i32 %430 to i64, !dbg !160
  %432 = load i32** %acc1, align 8, !dbg !160
  %433 = getelementptr inbounds i32* %432, i64 %431, !dbg !160
  %434 = load i32* %433, align 4, !dbg !160
  %435 = add nsw i32 %434, %426, !dbg !160
  store i32 %435, i32* %433, align 4, !dbg !160
  %436 = load i32* %tid_y, align 4, !dbg !162
  %437 = mul nsw i32 %436, 16, !dbg !162
  %438 = load i32* %tid_x, align 4, !dbg !162
  %439 = add nsw i32 %437, %438, !dbg !162
  %440 = add nsw i32 %439, 4, !dbg !162
  %441 = sext i32 %440 to i64, !dbg !162
  %442 = load i32** %acc2, align 8, !dbg !162
  %443 = getelementptr inbounds i32* %442, i64 %441, !dbg !162
  %444 = load i32* %443, align 4, !dbg !162
  %445 = load i32* %tid_y, align 4, !dbg !162
  %446 = mul nsw i32 %445, 16, !dbg !162
  %447 = load i32* %tid_x, align 4, !dbg !162
  %448 = add nsw i32 %446, %447, !dbg !162
  %449 = sext i32 %448 to i64, !dbg !162
  %450 = load i32** %acc2, align 8, !dbg !162
  %451 = getelementptr inbounds i32* %450, i64 %449, !dbg !162
  %452 = load i32* %451, align 4, !dbg !162
  %453 = add nsw i32 %452, %444, !dbg !162
  store i32 %453, i32* %451, align 4, !dbg !162
  br label %454, !dbg !163

; <label>:454                                     ; preds = %417, %414
  call void @__syncthreads(), !dbg !164
  %455 = load i32* %tid_x, align 4, !dbg !165
  %456 = icmp slt i32 %455, 2, !dbg !165
  br i1 %456, label %457, label %494, !dbg !165

; <label>:457                                     ; preds = %454
  %458 = load i32* %tid_y, align 4, !dbg !166
  %459 = mul nsw i32 %458, 16, !dbg !166
  %460 = load i32* %tid_x, align 4, !dbg !166
  %461 = add nsw i32 %459, %460, !dbg !166
  %462 = add nsw i32 %461, 2, !dbg !166
  %463 = sext i32 %462 to i64, !dbg !166
  %464 = load i32** %acc1, align 8, !dbg !166
  %465 = getelementptr inbounds i32* %464, i64 %463, !dbg !166
  %466 = load i32* %465, align 4, !dbg !166
  %467 = load i32* %tid_y, align 4, !dbg !166
  %468 = mul nsw i32 %467, 16, !dbg !166
  %469 = load i32* %tid_x, align 4, !dbg !166
  %470 = add nsw i32 %468, %469, !dbg !166
  %471 = sext i32 %470 to i64, !dbg !166
  %472 = load i32** %acc1, align 8, !dbg !166
  %473 = getelementptr inbounds i32* %472, i64 %471, !dbg !166
  %474 = load i32* %473, align 4, !dbg !166
  %475 = add nsw i32 %474, %466, !dbg !166
  store i32 %475, i32* %473, align 4, !dbg !166
  %476 = load i32* %tid_y, align 4, !dbg !168
  %477 = mul nsw i32 %476, 16, !dbg !168
  %478 = load i32* %tid_x, align 4, !dbg !168
  %479 = add nsw i32 %477, %478, !dbg !168
  %480 = add nsw i32 %479, 2, !dbg !168
  %481 = sext i32 %480 to i64, !dbg !168
  %482 = load i32** %acc2, align 8, !dbg !168
  %483 = getelementptr inbounds i32* %482, i64 %481, !dbg !168
  %484 = load i32* %483, align 4, !dbg !168
  %485 = load i32* %tid_y, align 4, !dbg !168
  %486 = mul nsw i32 %485, 16, !dbg !168
  %487 = load i32* %tid_x, align 4, !dbg !168
  %488 = add nsw i32 %486, %487, !dbg !168
  %489 = sext i32 %488 to i64, !dbg !168
  %490 = load i32** %acc2, align 8, !dbg !168
  %491 = getelementptr inbounds i32* %490, i64 %489, !dbg !168
  %492 = load i32* %491, align 4, !dbg !168
  %493 = add nsw i32 %492, %484, !dbg !168
  store i32 %493, i32* %491, align 4, !dbg !168
  br label %494, !dbg !169

; <label>:494                                     ; preds = %457, %454
  call void @__syncthreads(), !dbg !170
  %495 = load i32* %tid_x, align 4, !dbg !171
  %496 = icmp slt i32 %495, 1, !dbg !171
  br i1 %496, label %497, label %554, !dbg !171

; <label>:497                                     ; preds = %494
  %498 = load i32* %tid_y, align 4, !dbg !172
  %499 = mul nsw i32 %498, 16, !dbg !172
  %500 = load i32* %tid_x, align 4, !dbg !172
  %501 = add nsw i32 %499, %500, !dbg !172
  %502 = add nsw i32 %501, 1, !dbg !172
  %503 = sext i32 %502 to i64, !dbg !172
  %504 = load i32** %acc1, align 8, !dbg !172
  %505 = getelementptr inbounds i32* %504, i64 %503, !dbg !172
  %506 = load i32* %505, align 4, !dbg !172
  %507 = load i32* %tid_y, align 4, !dbg !172
  %508 = mul nsw i32 %507, 16, !dbg !172
  %509 = load i32* %tid_x, align 4, !dbg !172
  %510 = add nsw i32 %508, %509, !dbg !172
  %511 = add nsw i32 %510, 8, !dbg !172
  %512 = sext i32 %511 to i64, !dbg !172
  %513 = load i32** %acc1, align 8, !dbg !172
  %514 = getelementptr inbounds i32* %513, i64 %512, !dbg !172
  %515 = load i32* %514, align 4, !dbg !172
  %516 = add nsw i32 %506, %515, !dbg !172
  %517 = load i32* %tid_y, align 4, !dbg !172
  %518 = mul nsw i32 %517, 16, !dbg !172
  %519 = load i32* %tid_x, align 4, !dbg !172
  %520 = add nsw i32 %518, %519, !dbg !172
  %521 = sext i32 %520 to i64, !dbg !172
  %522 = load i32** %acc1, align 8, !dbg !172
  %523 = getelementptr inbounds i32* %522, i64 %521, !dbg !172
  %524 = load i32* %523, align 4, !dbg !172
  %525 = add nsw i32 %524, %516, !dbg !172
  store i32 %525, i32* %523, align 4, !dbg !172
  %526 = load i32* %tid_y, align 4, !dbg !174
  %527 = mul nsw i32 %526, 16, !dbg !174
  %528 = load i32* %tid_x, align 4, !dbg !174
  %529 = add nsw i32 %527, %528, !dbg !174
  %530 = add nsw i32 %529, 1, !dbg !174
  %531 = sext i32 %530 to i64, !dbg !174
  %532 = load i32** %acc2, align 8, !dbg !174
  %533 = getelementptr inbounds i32* %532, i64 %531, !dbg !174
  %534 = load i32* %533, align 4, !dbg !174
  %535 = load i32* %tid_y, align 4, !dbg !174
  %536 = mul nsw i32 %535, 16, !dbg !174
  %537 = load i32* %tid_x, align 4, !dbg !174
  %538 = add nsw i32 %536, %537, !dbg !174
  %539 = add nsw i32 %538, 8, !dbg !174
  %540 = sext i32 %539 to i64, !dbg !174
  %541 = load i32** %acc2, align 8, !dbg !174
  %542 = getelementptr inbounds i32* %541, i64 %540, !dbg !174
  %543 = load i32* %542, align 4, !dbg !174
  %544 = add nsw i32 %534, %543, !dbg !174
  %545 = load i32* %tid_y, align 4, !dbg !174
  %546 = mul nsw i32 %545, 16, !dbg !174
  %547 = load i32* %tid_x, align 4, !dbg !174
  %548 = add nsw i32 %546, %547, !dbg !174
  %549 = sext i32 %548 to i64, !dbg !174
  %550 = load i32** %acc2, align 8, !dbg !174
  %551 = getelementptr inbounds i32* %550, i64 %549, !dbg !174
  %552 = load i32* %551, align 4, !dbg !174
  %553 = add nsw i32 %552, %544, !dbg !174
  store i32 %553, i32* %551, align 4, !dbg !174
  br label %554, !dbg !175

; <label>:554                                     ; preds = %497, %494
  call void @__syncthreads(), !dbg !176
  %555 = load i32* %tid_x, align 4, !dbg !177
  %556 = icmp eq i32 %555, 0, !dbg !177
  br i1 %556, label %557, label %582, !dbg !177

; <label>:557                                     ; preds = %554
  %558 = load i32* %tid_y, align 4, !dbg !178
  %559 = mul nsw i32 %558, 16, !dbg !178
  %560 = sext i32 %559 to i64, !dbg !178
  %561 = load i32** %acc1, align 8, !dbg !178
  %562 = getelementptr inbounds i32* %561, i64 %560, !dbg !178
  %563 = load i32* %562, align 4, !dbg !178
  %564 = load i32* %tid_y, align 4, !dbg !178
  %565 = mul nsw i32 %564, 9, !dbg !178
  %566 = load i32* %i4, align 4, !dbg !178
  %567 = add nsw i32 %565, %566, !dbg !178
  %568 = sext i32 %567 to i64, !dbg !178
  %569 = getelementptr inbounds [144 x i32]* @_ZZ9JacobiSVDPiS_iiE1d, i32 0, i64 %568, !dbg !178
  store i32 %563, i32* %569, align 4, !dbg !178
  %570 = load i32* %tid_y, align 4, !dbg !180
  %571 = mul nsw i32 %570, 16, !dbg !180
  %572 = sext i32 %571 to i64, !dbg !180
  %573 = load i32** %acc2, align 8, !dbg !180
  %574 = getelementptr inbounds i32* %573, i64 %572, !dbg !180
  %575 = load i32* %574, align 4, !dbg !180
  %576 = load i32* %tid_y, align 4, !dbg !180
  %577 = mul nsw i32 %576, 9, !dbg !180
  %578 = load i32* %j, align 4, !dbg !180
  %579 = add nsw i32 %577, %578, !dbg !180
  %580 = sext i32 %579 to i64, !dbg !180
  %581 = getelementptr inbounds [144 x i32]* @_ZZ9JacobiSVDPiS_iiE1d, i32 0, i64 %580, !dbg !180
  store i32 %575, i32* %581, align 4, !dbg !180
  br label %582, !dbg !181

; <label>:582                                     ; preds = %557, %554
  call void @__syncthreads(), !dbg !182
  call void @llvm.dbg.declare(metadata !{i32** %Vi}, metadata !183), !dbg !184
  %583 = load i32* %tid_y, align 4, !dbg !184
  %584 = mul nsw i32 %583, 81, !dbg !184
  %585 = sext i32 %584 to i64, !dbg !184
  %586 = getelementptr inbounds i32* getelementptr inbounds ([1296 x i32]* @_ZZ9JacobiSVDPiS_iiE3s_V, i32 0, i32 0), i64 %585, !dbg !184
  %587 = load i32* %i4, align 4, !dbg !184
  %588 = load i32* %4, align 4, !dbg !184
  %589 = mul nsw i32 %587, %588, !dbg !184
  %590 = sext i32 %589 to i64, !dbg !184
  %591 = getelementptr inbounds i32* %586, i64 %590, !dbg !184
  store i32* %591, i32** %Vi, align 8, !dbg !184
  call void @llvm.dbg.declare(metadata !{i32** %Vj}, metadata !185), !dbg !186
  %592 = load i32* %tid_y, align 4, !dbg !186
  %593 = mul nsw i32 %592, 81, !dbg !186
  %594 = sext i32 %593 to i64, !dbg !186
  %595 = getelementptr inbounds i32* getelementptr inbounds ([1296 x i32]* @_ZZ9JacobiSVDPiS_iiE3s_V, i32 0, i32 0), i64 %594, !dbg !186
  %596 = load i32* %j, align 4, !dbg !186
  %597 = load i32* %4, align 4, !dbg !186
  %598 = mul nsw i32 %596, %597, !dbg !186
  %599 = sext i32 %598 to i64, !dbg !186
  %600 = getelementptr inbounds i32* %595, i64 %599, !dbg !186
  store i32* %600, i32** %Vj, align 8, !dbg !186
  %601 = load i32* %tid_x, align 4, !dbg !187
  %602 = load i32* %4, align 4, !dbg !187
  %603 = icmp slt i32 %601, %602, !dbg !187
  br i1 %603, label %604, label %645, !dbg !187

; <label>:604                                     ; preds = %582
  call void @llvm.dbg.declare(metadata !{i32* %t05}, metadata !188), !dbg !190
  %605 = load i32* %tid_x, align 4, !dbg !190
  %606 = sext i32 %605 to i64, !dbg !190
  %607 = load i32** %Vi, align 8, !dbg !190
  %608 = getelementptr inbounds i32* %607, i64 %606, !dbg !190
  %609 = load i32* %608, align 4, !dbg !190
  %610 = load i32* %c, align 4, !dbg !190
  %611 = mul nsw i32 %609, %610, !dbg !190
  %612 = load i32* %tid_x, align 4, !dbg !190
  %613 = sext i32 %612 to i64, !dbg !190
  %614 = load i32** %Vj, align 8, !dbg !190
  %615 = getelementptr inbounds i32* %614, i64 %613, !dbg !190
  %616 = load i32* %615, align 4, !dbg !190
  %617 = load i32* %s, align 4, !dbg !190
  %618 = mul nsw i32 %616, %617, !dbg !190
  %619 = add nsw i32 %611, %618, !dbg !190
  store i32 %619, i32* %t05, align 4, !dbg !190
  call void @llvm.dbg.declare(metadata !{i32* %t16}, metadata !191), !dbg !192
  %620 = load i32* %tid_x, align 4, !dbg !192
  %621 = sext i32 %620 to i64, !dbg !192
  %622 = load i32** %Vj, align 8, !dbg !192
  %623 = getelementptr inbounds i32* %622, i64 %621, !dbg !192
  %624 = load i32* %623, align 4, !dbg !192
  %625 = load i32* %c, align 4, !dbg !192
  %626 = mul nsw i32 %624, %625, !dbg !192
  %627 = load i32* %tid_x, align 4, !dbg !192
  %628 = sext i32 %627 to i64, !dbg !192
  %629 = load i32** %Vi, align 8, !dbg !192
  %630 = getelementptr inbounds i32* %629, i64 %628, !dbg !192
  %631 = load i32* %630, align 4, !dbg !192
  %632 = load i32* %s, align 4, !dbg !192
  %633 = mul nsw i32 %631, %632, !dbg !192
  %634 = sub nsw i32 %626, %633, !dbg !192
  store i32 %634, i32* %t16, align 4, !dbg !192
  %635 = load i32* %t05, align 4, !dbg !193
  %636 = load i32* %tid_x, align 4, !dbg !193
  %637 = sext i32 %636 to i64, !dbg !193
  %638 = load i32** %Vi, align 8, !dbg !193
  %639 = getelementptr inbounds i32* %638, i64 %637, !dbg !193
  store i32 %635, i32* %639, align 4, !dbg !193
  %640 = load i32* %t16, align 4, !dbg !194
  %641 = load i32* %tid_x, align 4, !dbg !194
  %642 = sext i32 %641 to i64, !dbg !194
  %643 = load i32** %Vj, align 8, !dbg !194
  %644 = getelementptr inbounds i32* %643, i64 %642, !dbg !194
  store i32 %640, i32* %644, align 4, !dbg !194
  br label %645, !dbg !195

; <label>:645                                     ; preds = %604, %582
  call void @__syncthreads(), !dbg !196
  store i8 1, i8* %converged, align 1, !dbg !197
  br label %646, !dbg !198

; <label>:646                                     ; preds = %645
  %647 = load i32* %j, align 4, !dbg !118
  %648 = add nsw i32 %647, 1, !dbg !118
  store i32 %648, i32* %j, align 4, !dbg !118
  br label %257, !dbg !118

; <label>:649                                     ; preds = %257
  %650 = load i8* %converged, align 1, !dbg !199
  %651 = trunc i8 %650 to i1, !dbg !199
  br i1 %651, label %653, label %652, !dbg !199

; <label>:652                                     ; preds = %649
  br label %657, !dbg !200

; <label>:653                                     ; preds = %649
  br label %654, !dbg !201

; <label>:654                                     ; preds = %653
  %655 = load i32* %i4, align 4, !dbg !114
  %656 = add nsw i32 %655, 1, !dbg !114
  store i32 %656, i32* %i4, align 4, !dbg !114
  br label %249, !dbg !114

; <label>:657                                     ; preds = %652, %249
  br label %658, !dbg !202

; <label>:658                                     ; preds = %657
  %659 = load i32* %it, align 4, !dbg !107
  %660 = add nsw i32 %659, 1, !dbg !107
  store i32 %660, i32* %it, align 4, !dbg !107
  br label %245, !dbg !107

; <label>:661                                     ; preds = %245
  call void @__syncthreads(), !dbg !203
  call void @llvm.dbg.declare(metadata !{i32* %i7}, metadata !204), !dbg !206
  store i32 0, i32* %i7, align 4, !dbg !206
  br label %662, !dbg !206

; <label>:662                                     ; preds = %688, %661
  %663 = load i32* %i7, align 4, !dbg !206
  %664 = icmp sle i32 %663, 4, !dbg !206
  br i1 %664, label %665, label %691, !dbg !206

; <label>:665                                     ; preds = %662
  %666 = load i32* %tid_y, align 4, !dbg !207
  %667 = mul nsw i32 %666, 81, !dbg !207
  %668 = load i32* %tid_x, align 4, !dbg !207
  %669 = add nsw i32 %667, %668, !dbg !207
  %670 = load i32* %i7, align 4, !dbg !207
  %671 = load i32* %bsz_x, align 4, !dbg !207
  %672 = mul nsw i32 %670, %671, !dbg !207
  %673 = add nsw i32 %669, %672, !dbg !207
  %674 = sext i32 %673 to i64, !dbg !207
  %675 = getelementptr inbounds [1296 x i32]* @_ZZ9JacobiSVDPiS_iiE3s_V, i32 0, i64 %674, !dbg !207
  %676 = load i32* %675, align 4, !dbg !207
  %677 = load i32* %gid_y, align 4, !dbg !207
  %678 = mul nsw i32 %677, 81, !dbg !207
  %679 = load i32* %tid_x, align 4, !dbg !207
  %680 = add nsw i32 %678, %679, !dbg !207
  %681 = load i32* %i7, align 4, !dbg !207
  %682 = load i32* %bsz_x, align 4, !dbg !207
  %683 = mul nsw i32 %681, %682, !dbg !207
  %684 = add nsw i32 %680, %683, !dbg !207
  %685 = sext i32 %684 to i64, !dbg !207
  %686 = load i32** %2, align 8, !dbg !207
  %687 = getelementptr inbounds i32* %686, i64 %685, !dbg !207
  store i32 %676, i32* %687, align 4, !dbg !207
  br label %688, !dbg !207

; <label>:688                                     ; preds = %665
  %689 = load i32* %i7, align 4, !dbg !206
  %690 = add nsw i32 %689, 1, !dbg !206
  store i32 %690, i32* %i7, align 4, !dbg !206
  br label %662, !dbg !206

; <label>:691                                     ; preds = %662
  %692 = load i32* %tid_x, align 4, !dbg !208
  %693 = icmp eq i32 %692, 0, !dbg !208
  br i1 %693, label %694, label %707, !dbg !208

; <label>:694                                     ; preds = %691
  %695 = load i32* %tid_y, align 4, !dbg !209
  %696 = mul nsw i32 %695, 81, !dbg !209
  %697 = add nsw i32 %696, 80, !dbg !209
  %698 = sext i32 %697 to i64, !dbg !209
  %699 = getelementptr inbounds [1296 x i32]* @_ZZ9JacobiSVDPiS_iiE3s_V, i32 0, i64 %698, !dbg !209
  %700 = load i32* %699, align 4, !dbg !209
  %701 = load i32* %gid_y, align 4, !dbg !209
  %702 = mul nsw i32 %701, 81, !dbg !209
  %703 = add nsw i32 %702, 80, !dbg !209
  %704 = sext i32 %703 to i64, !dbg !209
  %705 = load i32** %2, align 8, !dbg !209
  %706 = getelementptr inbounds i32* %705, i64 %704, !dbg !209
  store i32 %700, i32* %706, align 4, !dbg !209
  br label %707, !dbg !209

; <label>:707                                     ; preds = %694, %691
  call void @__syncthreads(), !dbg !210
  ret void, !dbg !211
}

declare void @llvm.dbg.declare(metadata, metadata) nounwind readnone

declare void @__syncthreads() section "__device__"

define linkonce_odr double @_ZSt4sqrtIiEN9__gnu_cxx11__enable_ifIXsr12__is_integerIT_EE7__valueEdE6__typeES2_(i32 %__x) nounwind uwtable inlinehint {
  %1 = alloca i32, align 4
  store i32 %__x, i32* %1, align 4
  call void @llvm.dbg.declare(metadata !{i32* %1}, metadata !212), !dbg !213
  %2 = load i32* %1, align 4, !dbg !214
  %3 = sitofp i32 %2 to double, !dbg !214
  %4 = call double @sqrt(double %3) nounwind readnone, !dbg !214
  ret double %4, !dbg !214
}

define double @sqrt(double %value) {
  ret double %value
}

!llvm.dbg.cu = !{!0}

!0 = metadata !{i32 786449, i32 0, i32 4, metadata !"data_race.cpp", metadata !"/home/mingyuanwu/arrayfire", metadata !"clang version 3.2 (tags/RELEASE_32/final)", i1 true, i1 false, metadata !"", i32 0, metadata !1, metadata !1, metadata !3, metadata !25} ; [ DW_TAG_compile_unit ] [/home/mingyuanwu/arrayfire/data_race.cpp] [DW_LANG_C_plus_plus]
!1 = metadata !{metadata !2}
!2 = metadata !{i32 0}
!3 = metadata !{metadata !4}
!4 = metadata !{metadata !5, metadata !11}
!5 = metadata !{i32 786478, i32 0, metadata !6, metadata !"JacobiSVD", metadata !"JacobiSVD", metadata !"_Z9JacobiSVDPiS_ii", metadata !6, i32 3, metadata !7, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, void (i32*, i32*, i32, i32)* @_Z9JacobiSVDPiS_ii, null, null, metadata !1, i32 4} ; [ DW_TAG_subprogram ] [line 3] [def] [scope 4] [JacobiSVD]
!6 = metadata !{i32 786473, metadata !"data_race.cpp", metadata !"/home/mingyuanwu/arrayfire", null} ; [ DW_TAG_file_type ]
!7 = metadata !{i32 786453, i32 0, metadata !"", i32 0, i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !8, i32 0, i32 0} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!8 = metadata !{null, metadata !9, metadata !9, metadata !10, metadata !10}
!9 = metadata !{i32 786447, null, metadata !"", null, i32 0, i64 64, i64 64, i64 0, i32 0, metadata !10} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from int]
!10 = metadata !{i32 786468, null, metadata !"int", null, i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!11 = metadata !{i32 786478, i32 0, metadata !12, metadata !"sqrt<int>", metadata !"sqrt<int>", metadata !"_ZSt4sqrtIiEN9__gnu_cxx11__enable_ifIXsr12__is_integerIT_EE7__valueEdE6__typeES2_", metadata !13, i32 493, metadata !14, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, double (i32)* @_ZSt4sqrtIiEN9__gnu_cxx11__enable_ifIXsr12__is_integerIT_EE7__valueEdE6__typeES2_, metadata !23, null, metadata !1, i32 494} ; [ DW_TAG_subprogram ] [line 493] [def] [scope 494] [sqrt<int>]
!12 = metadata !{i32 786489, null, metadata !"std", metadata !13, i32 74} ; [ DW_TAG_namespace ] [/home/mingyuanwu/arrayfire//usr/lib/gcc/x86_64-linux-gnu/5.4.0/../../../../include/c++/5.4.0/cmath]
!13 = metadata !{i32 786473, metadata !"/usr/lib/gcc/x86_64-linux-gnu/5.4.0/../../../../include/c++/5.4.0/cmath", metadata !"/home/mingyuanwu/arrayfire", null} ; [ DW_TAG_file_type ]
!14 = metadata !{i32 786453, i32 0, metadata !"", i32 0, i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !15, i32 0, i32 0} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!15 = metadata !{metadata !16, metadata !10}
!16 = metadata !{i32 786454, metadata !17, metadata !"__type", metadata !13, i32 47, i64 0, i64 0, i64 0, i32 0, metadata !22} ; [ DW_TAG_typedef ] [__type] [line 47, size 0, align 0, offset 0] [from double]
!17 = metadata !{i32 786451, metadata !18, metadata !"__enable_if<true, double>", metadata !19, i32 46, i64 8, i64 8, i32 0, i32 0, null, metadata !2, i32 0, null, metadata !20} ; [ DW_TAG_structure_type ] [__enable_if<true, double>] [line 46, size 8, align 8, offset 0] [from ]
!18 = metadata !{i32 786489, null, metadata !"__gnu_cxx", metadata !19, i32 36} ; [ DW_TAG_namespace ] [/home/mingyuanwu/arrayfire//usr/lib/gcc/x86_64-linux-gnu/5.4.0/../../../../include/c++/5.4.0/ext/type_traits.h]
!19 = metadata !{i32 786473, metadata !"/usr/lib/gcc/x86_64-linux-gnu/5.4.0/../../../../include/c++/5.4.0/ext/type_traits.h", metadata !"/home/mingyuanwu/arrayfire", null} ; [ DW_TAG_file_type ]
!20 = metadata !{metadata !21}
!21 = metadata !{i32 786479, null, metadata !"_Tp", metadata !22, null, i32 0, i32 0} ; [ DW_TAG_template_type_parameter ]
!22 = metadata !{i32 786468, null, metadata !"double", null, i32 0, i64 64, i64 64, i64 0, i32 0, i32 4} ; [ DW_TAG_base_type ] [double] [line 0, size 64, align 64, offset 0, enc DW_ATE_float]
!23 = metadata !{metadata !24}
!24 = metadata !{i32 786479, null, metadata !"_Tp", metadata !10, null, i32 0, i32 0} ; [ DW_TAG_template_type_parameter ]
!25 = metadata !{metadata !26}
!26 = metadata !{metadata !27, metadata !31, metadata !35, metadata !36, metadata !40}
!27 = metadata !{i32 786484, i32 0, metadata !5, metadata !"acc", metadata !"acc", metadata !"", metadata !6, i32 12, metadata !28, i32 1, i32 1, [512 x i32]* @_ZZ9JacobiSVDPiS_iiE3acc} ; [ DW_TAG_variable ] [acc] [line 12] [local] [def]
!28 = metadata !{i32 786433, null, metadata !"", null, i32 0, i64 16384, i64 32, i32 0, i32 0, metadata !10, metadata !29, i32 0, i32 0} ; [ DW_TAG_array_type ] [line 0, size 16384, align 32, offset 0] [from int]
!29 = metadata !{metadata !30}
!30 = metadata !{i32 786465, i64 0, i64 511}      ; [ DW_TAG_subrange_type ] [0, 511]
!31 = metadata !{i32 786484, i32 0, metadata !5, metadata !"s_S", metadata !"s_S", metadata !"", metadata !6, i32 16, metadata !32, i32 1, i32 1, [1296 x i32]* @_ZZ9JacobiSVDPiS_iiE3s_S} ; [ DW_TAG_variable ] [s_S] [line 16] [local] [def]
!32 = metadata !{i32 786433, null, metadata !"", null, i32 0, i64 41472, i64 32, i32 0, i32 0, metadata !10, metadata !33, i32 0, i32 0} ; [ DW_TAG_array_type ] [line 0, size 41472, align 32, offset 0] [from int]
!33 = metadata !{metadata !34}
!34 = metadata !{i32 786465, i64 0, i64 1295}     ; [ DW_TAG_subrange_type ] [0, 1295]
!35 = metadata !{i32 786484, i32 0, metadata !5, metadata !"s_V", metadata !"s_V", metadata !"", metadata !6, i32 17, metadata !32, i32 1, i32 1, [1296 x i32]* @_ZZ9JacobiSVDPiS_iiE3s_V} ; [ DW_TAG_variable ] [s_V] [line 17] [local] [def]
!36 = metadata !{i32 786484, i32 0, metadata !5, metadata !"d", metadata !"d", metadata !"", metadata !6, i32 18, metadata !37, i32 1, i32 1, [144 x i32]* @_ZZ9JacobiSVDPiS_iiE1d} ; [ DW_TAG_variable ] [d] [line 18] [local] [def]
!37 = metadata !{i32 786433, null, metadata !"", null, i32 0, i64 4608, i64 32, i32 0, i32 0, metadata !10, metadata !38, i32 0, i32 0} ; [ DW_TAG_array_type ] [line 0, size 4608, align 32, offset 0] [from int]
!38 = metadata !{metadata !39}
!39 = metadata !{i32 786465, i64 0, i64 143}      ; [ DW_TAG_subrange_type ] [0, 143]
!40 = metadata !{i32 786484, i32 0, metadata !6, metadata !"iterations", metadata !"iterations", metadata !"iterations", metadata !6, i32 5, metadata !41, i32 1, i32 1, i32 30} ; [ DW_TAG_variable ] [iterations] [line 5] [local] [def]
!41 = metadata !{i32 786470, null, metadata !"", null, i32 0, i64 0, i64 0, i64 0, i32 0, metadata !10} ; [ DW_TAG_const_type ] [line 0, size 0, align 0, offset 0] [from int]
!42 = metadata !{i32 786689, metadata !5, metadata !"S", metadata !6, i32 16777219, metadata !9, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [S] [line 3]
!43 = metadata !{i32 3, i32 0, metadata !5, null}
!44 = metadata !{i32 786689, metadata !5, metadata !"V", metadata !6, i32 33554435, metadata !9, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [V] [line 3]
!45 = metadata !{i32 786689, metadata !5, metadata !"m", metadata !6, i32 50331651, metadata !10, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [m] [line 3]
!46 = metadata !{i32 786689, metadata !5, metadata !"n", metadata !6, i32 67108867, metadata !10, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [n] [line 3]
!47 = metadata !{i32 786688, metadata !48, metadata !"iterations", metadata !6, i32 5, metadata !41, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [iterations] [line 5]
!48 = metadata !{i32 786443, metadata !5, i32 4, i32 0, metadata !6, i32 0} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire/data_race.cpp]
!49 = metadata !{i32 5, i32 0, metadata !48, null}
!50 = metadata !{i32 786688, metadata !48, metadata !"tid_x", metadata !6, i32 7, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [tid_x] [line 7]
!51 = metadata !{i32 7, i32 0, metadata !48, null}
!52 = metadata !{i32 786688, metadata !48, metadata !"bsz_x", metadata !6, i32 8, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [bsz_x] [line 8]
!53 = metadata !{i32 8, i32 0, metadata !48, null}
!54 = metadata !{i32 786688, metadata !48, metadata !"tid_y", metadata !6, i32 9, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [tid_y] [line 9]
!55 = metadata !{i32 9, i32 0, metadata !48, null}
!56 = metadata !{i32 786688, metadata !48, metadata !"gid_y", metadata !6, i32 10, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [gid_y] [line 10]
!57 = metadata !{i32 10, i32 0, metadata !48, null}
!58 = metadata !{i32 786688, metadata !48, metadata !"acc1", metadata !6, i32 13, metadata !9, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [acc1] [line 13]
!59 = metadata !{i32 13, i32 0, metadata !48, null}
!60 = metadata !{i32 786688, metadata !48, metadata !"acc2", metadata !6, i32 14, metadata !9, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [acc2] [line 14]
!61 = metadata !{i32 14, i32 0, metadata !48, null}
!62 = metadata !{i32 786688, metadata !63, metadata !"i", metadata !6, i32 20, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [i] [line 20]
!63 = metadata !{i32 786443, metadata !48, i32 20, i32 0, metadata !6, i32 1} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire/data_race.cpp]
!64 = metadata !{i32 20, i32 0, metadata !63, null}
!65 = metadata !{i32 21, i32 0, metadata !63, null}
!66 = metadata !{i32 22, i32 0, metadata !48, null}
!67 = metadata !{i32 23, i32 0, metadata !48, null}
!68 = metadata !{i32 24, i32 0, metadata !48, null}
!69 = metadata !{i32 786688, metadata !70, metadata !"i", metadata !6, i32 27, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [i] [line 27]
!70 = metadata !{i32 786443, metadata !48, i32 27, i32 0, metadata !6, i32 2} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire/data_race.cpp]
!71 = metadata !{i32 27, i32 0, metadata !70, null}
!72 = metadata !{i32 786688, metadata !73, metadata !"t", metadata !6, i32 28, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [t] [line 28]
!73 = metadata !{i32 786443, metadata !70, i32 27, i32 0, metadata !6, i32 3} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire/data_race.cpp]
!74 = metadata !{i32 28, i32 0, metadata !73, null}
!75 = metadata !{i32 29, i32 0, metadata !73, null}
!76 = metadata !{i32 30, i32 0, metadata !73, null}
!77 = metadata !{i32 31, i32 0, metadata !48, null}
!78 = metadata !{i32 32, i32 0, metadata !48, null}
!79 = metadata !{i32 33, i32 0, metadata !48, null}
!80 = metadata !{i32 34, i32 0, metadata !48, null}
!81 = metadata !{i32 35, i32 0, metadata !48, null}
!82 = metadata !{i32 36, i32 0, metadata !48, null}
!83 = metadata !{i32 37, i32 0, metadata !48, null}
!84 = metadata !{i32 38, i32 0, metadata !48, null}
!85 = metadata !{i32 39, i32 0, metadata !48, null}
!86 = metadata !{i32 40, i32 0, metadata !48, null}
!87 = metadata !{i32 786688, metadata !88, metadata !"t", metadata !6, i32 42, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [t] [line 42]
!88 = metadata !{i32 786443, metadata !48, i32 40, i32 0, metadata !6, i32 4} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire/data_race.cpp]
!89 = metadata !{i32 42, i32 0, metadata !88, null}
!90 = metadata !{i32 43, i32 0, metadata !88, null}
!91 = metadata !{i32 44, i32 0, metadata !88, null}
!92 = metadata !{i32 45, i32 0, metadata !48, null}
!93 = metadata !{i32 47, i32 0, metadata !48, null}
!94 = metadata !{i32 48, i32 0, metadata !48, null}
!95 = metadata !{i32 786688, metadata !96, metadata !"i", metadata !6, i32 51, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [i] [line 51]
!96 = metadata !{i32 786443, metadata !48, i32 51, i32 0, metadata !6, i32 5} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire/data_race.cpp]
!97 = metadata !{i32 51, i32 0, metadata !96, null}
!98 = metadata !{i32 52, i32 0, metadata !99, null}
!99 = metadata !{i32 786443, metadata !96, i32 51, i32 0, metadata !6, i32 6} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire/data_race.cpp]
!100 = metadata !{i32 53, i32 0, metadata !99, null}
!101 = metadata !{i32 54, i32 0, metadata !48, null}
!102 = metadata !{i32 55, i32 0, metadata !48, null}
!103 = metadata !{i32 56, i32 0, metadata !48, null}
!104 = metadata !{i32 57, i32 0, metadata !48, null}
!105 = metadata !{i32 786688, metadata !106, metadata !"it", metadata !6, i32 59, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [it] [line 59]
!106 = metadata !{i32 786443, metadata !48, i32 59, i32 0, metadata !6, i32 7} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire/data_race.cpp]
!107 = metadata !{i32 59, i32 0, metadata !106, null}
!108 = metadata !{i32 786688, metadata !109, metadata !"converged", metadata !6, i32 60, metadata !110, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [converged] [line 60]
!109 = metadata !{i32 786443, metadata !106, i32 59, i32 0, metadata !6, i32 8} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire/data_race.cpp]
!110 = metadata !{i32 786468, null, metadata !"bool", null, i32 0, i64 8, i64 8, i64 0, i32 0, i32 2} ; [ DW_TAG_base_type ] [bool] [line 0, size 8, align 8, offset 0, enc DW_ATE_boolean]
!111 = metadata !{i32 60, i32 0, metadata !109, null}
!112 = metadata !{i32 786688, metadata !113, metadata !"i", metadata !6, i32 62, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [i] [line 62]
!113 = metadata !{i32 786443, metadata !109, i32 62, i32 0, metadata !6, i32 9} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire/data_race.cpp]
!114 = metadata !{i32 62, i32 0, metadata !113, null}
!115 = metadata !{i32 786688, metadata !116, metadata !"j", metadata !6, i32 63, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [j] [line 63]
!116 = metadata !{i32 786443, metadata !117, i32 63, i32 0, metadata !6, i32 11} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire/data_race.cpp]
!117 = metadata !{i32 786443, metadata !113, i32 62, i32 0, metadata !6, i32 10} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire/data_race.cpp]
!118 = metadata !{i32 63, i32 0, metadata !116, null}
!119 = metadata !{i32 786688, metadata !120, metadata !"Si", metadata !6, i32 64, metadata !9, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [Si] [line 64]
!120 = metadata !{i32 786443, metadata !116, i32 63, i32 0, metadata !6, i32 12} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire/data_race.cpp]
!121 = metadata !{i32 64, i32 0, metadata !120, null}
!122 = metadata !{i32 786688, metadata !120, metadata !"Sj", metadata !6, i32 65, metadata !9, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [Sj] [line 65]
!123 = metadata !{i32 65, i32 0, metadata !120, null}
!124 = metadata !{i32 786688, metadata !120, metadata !"p", metadata !6, i32 67, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [p] [line 67]
!125 = metadata !{i32 67, i32 0, metadata !120, null}
!126 = metadata !{i32 786688, metadata !127, metadata !"k", metadata !6, i32 68, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [k] [line 68]
!127 = metadata !{i32 786443, metadata !120, i32 68, i32 0, metadata !6, i32 13} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire/data_race.cpp]
!128 = metadata !{i32 68, i32 0, metadata !127, null}
!129 = metadata !{i32 69, i32 0, metadata !127, null}
!130 = metadata !{i32 786688, metadata !120, metadata !"y", metadata !6, i32 72, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [y] [line 72]
!131 = metadata !{i32 72, i32 0, metadata !120, null}
!132 = metadata !{i32 786688, metadata !120, metadata !"r", metadata !6, i32 73, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [r] [line 73]
!133 = metadata !{i32 73, i32 0, metadata !120, null}
!134 = metadata !{i32 786688, metadata !120, metadata !"r2", metadata !6, i32 74, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [r2] [line 74]
!135 = metadata !{i32 74, i32 0, metadata !120, null}
!136 = metadata !{i32 786688, metadata !120, metadata !"c", metadata !6, i32 75, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [c] [line 75]
!137 = metadata !{i32 75, i32 0, metadata !120, null}
!138 = metadata !{i32 786688, metadata !120, metadata !"s", metadata !6, i32 75, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [s] [line 75]
!139 = metadata !{i32 76, i32 0, metadata !120, null}
!140 = metadata !{i32 77, i32 0, metadata !141, null}
!141 = metadata !{i32 786443, metadata !120, i32 76, i32 0, metadata !6, i32 14} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire/data_race.cpp]
!142 = metadata !{i32 78, i32 0, metadata !141, null}
!143 = metadata !{i32 79, i32 0, metadata !141, null}
!144 = metadata !{i32 81, i32 0, metadata !145, null}
!145 = metadata !{i32 786443, metadata !120, i32 80, i32 0, metadata !6, i32 15} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire/data_race.cpp]
!146 = metadata !{i32 82, i32 0, metadata !145, null}
!147 = metadata !{i32 85, i32 0, metadata !120, null}
!148 = metadata !{i32 786688, metadata !149, metadata !"t0", metadata !6, i32 86, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [t0] [line 86]
!149 = metadata !{i32 786443, metadata !120, i32 85, i32 0, metadata !6, i32 16} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire/data_race.cpp]
!150 = metadata !{i32 86, i32 0, metadata !149, null}
!151 = metadata !{i32 786688, metadata !149, metadata !"t1", metadata !6, i32 87, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [t1] [line 87]
!152 = metadata !{i32 87, i32 0, metadata !149, null}
!153 = metadata !{i32 88, i32 0, metadata !149, null}
!154 = metadata !{i32 89, i32 0, metadata !149, null}
!155 = metadata !{i32 91, i32 0, metadata !149, null}
!156 = metadata !{i32 92, i32 0, metadata !149, null}
!157 = metadata !{i32 93, i32 0, metadata !149, null}
!158 = metadata !{i32 94, i32 0, metadata !120, null}
!159 = metadata !{i32 96, i32 0, metadata !120, null}
!160 = metadata !{i32 97, i32 0, metadata !161, null}
!161 = metadata !{i32 786443, metadata !120, i32 96, i32 0, metadata !6, i32 17} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire/data_race.cpp]
!162 = metadata !{i32 98, i32 0, metadata !161, null}
!163 = metadata !{i32 99, i32 0, metadata !161, null}
!164 = metadata !{i32 100, i32 0, metadata !120, null}
!165 = metadata !{i32 101, i32 0, metadata !120, null}
!166 = metadata !{i32 102, i32 0, metadata !167, null}
!167 = metadata !{i32 786443, metadata !120, i32 101, i32 0, metadata !6, i32 18} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire/data_race.cpp]
!168 = metadata !{i32 103, i32 0, metadata !167, null}
!169 = metadata !{i32 104, i32 0, metadata !167, null}
!170 = metadata !{i32 105, i32 0, metadata !120, null}
!171 = metadata !{i32 106, i32 0, metadata !120, null}
!172 = metadata !{i32 107, i32 0, metadata !173, null}
!173 = metadata !{i32 786443, metadata !120, i32 106, i32 0, metadata !6, i32 19} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire/data_race.cpp]
!174 = metadata !{i32 108, i32 0, metadata !173, null}
!175 = metadata !{i32 109, i32 0, metadata !173, null}
!176 = metadata !{i32 110, i32 0, metadata !120, null}
!177 = metadata !{i32 112, i32 0, metadata !120, null}
!178 = metadata !{i32 113, i32 0, metadata !179, null}
!179 = metadata !{i32 786443, metadata !120, i32 112, i32 0, metadata !6, i32 20} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire/data_race.cpp]
!180 = metadata !{i32 114, i32 0, metadata !179, null}
!181 = metadata !{i32 115, i32 0, metadata !179, null}
!182 = metadata !{i32 116, i32 0, metadata !120, null}
!183 = metadata !{i32 786688, metadata !120, metadata !"Vi", metadata !6, i32 118, metadata !9, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [Vi] [line 118]
!184 = metadata !{i32 118, i32 0, metadata !120, null}
!185 = metadata !{i32 786688, metadata !120, metadata !"Vj", metadata !6, i32 119, metadata !9, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [Vj] [line 119]
!186 = metadata !{i32 119, i32 0, metadata !120, null}
!187 = metadata !{i32 121, i32 0, metadata !120, null}
!188 = metadata !{i32 786688, metadata !189, metadata !"t0", metadata !6, i32 122, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [t0] [line 122]
!189 = metadata !{i32 786443, metadata !120, i32 121, i32 0, metadata !6, i32 21} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire/data_race.cpp]
!190 = metadata !{i32 122, i32 0, metadata !189, null}
!191 = metadata !{i32 786688, metadata !189, metadata !"t1", metadata !6, i32 123, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [t1] [line 123]
!192 = metadata !{i32 123, i32 0, metadata !189, null}
!193 = metadata !{i32 125, i32 0, metadata !189, null}
!194 = metadata !{i32 126, i32 0, metadata !189, null}
!195 = metadata !{i32 127, i32 0, metadata !189, null}
!196 = metadata !{i32 128, i32 0, metadata !120, null}
!197 = metadata !{i32 130, i32 0, metadata !120, null}
!198 = metadata !{i32 131, i32 0, metadata !120, null}
!199 = metadata !{i32 132, i32 0, metadata !117, null}
!200 = metadata !{i32 133, i32 0, metadata !117, null}
!201 = metadata !{i32 134, i32 0, metadata !117, null}
!202 = metadata !{i32 135, i32 0, metadata !109, null}
!203 = metadata !{i32 136, i32 0, metadata !48, null}
!204 = metadata !{i32 786688, metadata !205, metadata !"i", metadata !6, i32 138, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [i] [line 138]
!205 = metadata !{i32 786443, metadata !48, i32 138, i32 0, metadata !6, i32 22} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire/data_race.cpp]
!206 = metadata !{i32 138, i32 0, metadata !205, null}
!207 = metadata !{i32 139, i32 0, metadata !205, null}
!208 = metadata !{i32 140, i32 0, metadata !48, null}
!209 = metadata !{i32 141, i32 0, metadata !48, null}
!210 = metadata !{i32 142, i32 0, metadata !48, null}
!211 = metadata !{i32 143, i32 0, metadata !48, null}
!212 = metadata !{i32 786689, metadata !11, metadata !"__x", metadata !13, i32 16777709, metadata !10, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [__x] [line 493]
!213 = metadata !{i32 493, i32 0, metadata !11, null}
!214 = metadata !{i32 494, i32 0, metadata !215, null}
!215 = metadata !{i32 786443, metadata !11, i32 494, i32 0, metadata !13, i32 23} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/arrayfire//usr/lib/gcc/x86_64-linux-gnu/5.4.0/../../../../include/c++/5.4.0/cmath]
