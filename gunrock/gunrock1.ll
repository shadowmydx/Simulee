; ModuleID = 'gunrock1'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.dim3 = type { i32, i32, i32 }

@blockIdx = external global %struct.dim3
@blockDim = external global %struct.dim3
@threadIdx = external global %struct.dim3

define void @_Z7CollectiiPKiS0_S0_PiS1_S1_S1_(i32 %edges, i32 %iter, i32* %flag, i32* %froms_data, i32* %tos_data, i32* %froms, i32* %tos, i32* %pos, i32* %counts) uwtable noinline {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32*, align 8
  %4 = alloca i32*, align 8
  %5 = alloca i32*, align 8
  %6 = alloca i32*, align 8
  %7 = alloca i32*, align 8
  %8 = alloca i32*, align 8
  %9 = alloca i32*, align 8
  %x = alloca i32, align 4
  %size = alloca i32, align 4
  %a = alloca i32, align 4
  %b = alloca i32, align 4
  %from = alloca i32, align 4
  %to = alloca i32, align 4
  store i32 %edges, i32* %1, align 4
  call void @llvm.dbg.declare(metadata !{i32* %1}, metadata !14), !dbg !15
  store i32 %iter, i32* %2, align 4
  call void @llvm.dbg.declare(metadata !{i32* %2}, metadata !16), !dbg !17
  store i32* %flag, i32** %3, align 8
  call void @llvm.dbg.declare(metadata !{i32** %3}, metadata !18), !dbg !19
  store i32* %froms_data, i32** %4, align 8
  call void @llvm.dbg.declare(metadata !{i32** %4}, metadata !20), !dbg !21
  store i32* %tos_data, i32** %5, align 8
  call void @llvm.dbg.declare(metadata !{i32** %5}, metadata !22), !dbg !23
  store i32* %froms, i32** %6, align 8
  call void @llvm.dbg.declare(metadata !{i32** %6}, metadata !24), !dbg !25
  store i32* %tos, i32** %7, align 8
  call void @llvm.dbg.declare(metadata !{i32** %7}, metadata !26), !dbg !27
  store i32* %pos, i32** %8, align 8
  call void @llvm.dbg.declare(metadata !{i32** %8}, metadata !28), !dbg !29
  store i32* %counts, i32** %9, align 8
  call void @llvm.dbg.declare(metadata !{i32** %9}, metadata !30), !dbg !31
  call void @llvm.dbg.declare(metadata !{i32* %x}, metadata !32), !dbg !34
  %10 = load i32* getelementptr inbounds (%struct.dim3* @blockIdx, i32 0, i32 0), align 4, !dbg !34
  %11 = load i32* getelementptr inbounds (%struct.dim3* @blockDim, i32 0, i32 0), align 4, !dbg !34
  %12 = mul i32 %10, %11, !dbg !34
  %13 = load i32* getelementptr inbounds (%struct.dim3* @threadIdx, i32 0, i32 0), align 4, !dbg !34
  %14 = add i32 %12, %13, !dbg !34
  store i32 %14, i32* %x, align 4, !dbg !34
  call void @llvm.dbg.declare(metadata !{i32* %size}, metadata !35), !dbg !36
  %15 = load i32* %2, align 4, !dbg !36
  %16 = icmp eq i32 %15, 0, !dbg !36
  br i1 %16, label %17, label %23, !dbg !36

; <label>:17                                      ; preds = %0
  %18 = load i32* %2, align 4, !dbg !36
  %19 = sext i32 %18 to i64, !dbg !36
  %20 = load i32** %8, align 8, !dbg !36
  %21 = getelementptr inbounds i32* %20, i64 %19, !dbg !36
  %22 = load i32* %21, align 4, !dbg !36
  br label %27, !dbg !36

; <label>:23                                      ; preds = %0
  %24 = load i32** %9, align 8, !dbg !36
  %25 = getelementptr inbounds i32* %24, i64 0, !dbg !36
  %26 = load i32* %25, align 4, !dbg !36
  br label %27, !dbg !36

; <label>:27                                      ; preds = %23, %17
  %28 = phi i32 [ %22, %17 ], [ %26, %23 ], !dbg !36
  %29 = load i32* %2, align 4, !dbg !36
  %30 = add nsw i32 %29, 1, !dbg !36
  %31 = sext i32 %30 to i64, !dbg !36
  %32 = load i32** %8, align 8, !dbg !36
  %33 = getelementptr inbounds i32* %32, i64 %31, !dbg !36
  %34 = load i32* %33, align 4, !dbg !36
  %35 = load i32* %2, align 4, !dbg !36
  %36 = sext i32 %35 to i64, !dbg !36
  %37 = load i32** %8, align 8, !dbg !36
  %38 = getelementptr inbounds i32* %37, i64 %36, !dbg !36
  %39 = load i32* %38, align 4, !dbg !36
  %40 = sub nsw i32 %34, %39, !dbg !36
  %41 = mul nsw i32 %28, %40, !dbg !36
  store i32 %41, i32* %size, align 4, !dbg !36
  %42 = load i32* %x, align 4, !dbg !37
  %43 = icmp sge i32 %42, 0, !dbg !37
  br i1 %43, label %44, label %236, !dbg !37

; <label>:44                                      ; preds = %27
  %45 = load i32* %x, align 4, !dbg !37
  %46 = load i32* %size, align 4, !dbg !37
  %47 = load i32* %1, align 4, !dbg !37
  %48 = mul nsw i32 %46, %47, !dbg !37
  %49 = icmp slt i32 %45, %48, !dbg !37
  br i1 %49, label %50, label %236, !dbg !37

; <label>:50                                      ; preds = %44
  call void @llvm.dbg.declare(metadata !{i32* %a}, metadata !38), !dbg !40
  %51 = load i32* %x, align 4, !dbg !40
  %52 = load i32* %1, align 4, !dbg !40
  %53 = sdiv i32 %51, %52, !dbg !40
  %54 = load i32* %2, align 4, !dbg !40
  %55 = icmp eq i32 %54, 0, !dbg !40
  br i1 %55, label %56, label %62, !dbg !40

; <label>:56                                      ; preds = %50
  %57 = load i32* %2, align 4, !dbg !40
  %58 = sext i32 %57 to i64, !dbg !40
  %59 = load i32** %8, align 8, !dbg !40
  %60 = getelementptr inbounds i32* %59, i64 %58, !dbg !40
  %61 = load i32* %60, align 4, !dbg !40
  br label %66, !dbg !40

; <label>:62                                      ; preds = %50
  %63 = load i32** %9, align 8, !dbg !40
  %64 = getelementptr inbounds i32* %63, i64 0, !dbg !40
  %65 = load i32* %64, align 4, !dbg !40
  br label %66, !dbg !40

; <label>:66                                      ; preds = %62, %56
  %67 = phi i32 [ %61, %56 ], [ %65, %62 ], !dbg !40
  %68 = srem i32 %53, %67, !dbg !40
  %69 = load i32* %1, align 4, !dbg !40
  %70 = mul nsw i32 %68, %69, !dbg !40
  %71 = load i32* %x, align 4, !dbg !40
  %72 = load i32* %1, align 4, !dbg !40
  %73 = srem i32 %71, %72, !dbg !40
  %74 = add nsw i32 %70, %73, !dbg !40
  store i32 %74, i32* %a, align 4, !dbg !40
  call void @llvm.dbg.declare(metadata !{i32* %b}, metadata !41), !dbg !42
  %75 = load i32* %2, align 4, !dbg !42
  %76 = sext i32 %75 to i64, !dbg !42
  %77 = load i32** %8, align 8, !dbg !42
  %78 = getelementptr inbounds i32* %77, i64 %76, !dbg !42
  %79 = load i32* %78, align 4, !dbg !42
  %80 = load i32* %x, align 4, !dbg !42
  %81 = load i32* %1, align 4, !dbg !42
  %82 = load i32* %2, align 4, !dbg !42
  %83 = icmp eq i32 %82, 0, !dbg !42
  br i1 %83, label %84, label %90, !dbg !42

; <label>:84                                      ; preds = %66
  %85 = load i32* %2, align 4, !dbg !42
  %86 = sext i32 %85 to i64, !dbg !42
  %87 = load i32** %8, align 8, !dbg !42
  %88 = getelementptr inbounds i32* %87, i64 %86, !dbg !42
  %89 = load i32* %88, align 4, !dbg !42
  br label %94, !dbg !42

; <label>:90                                      ; preds = %66
  %91 = load i32** %9, align 8, !dbg !42
  %92 = getelementptr inbounds i32* %91, i64 0, !dbg !42
  %93 = load i32* %92, align 4, !dbg !42
  br label %94, !dbg !42

; <label>:94                                      ; preds = %90, %84
  %95 = phi i32 [ %89, %84 ], [ %93, %90 ], !dbg !42
  %96 = mul nsw i32 %81, %95, !dbg !42
  %97 = sdiv i32 %80, %96, !dbg !42
  %98 = add nsw i32 %79, %97, !dbg !42
  store i32 %98, i32* %b, align 4, !dbg !42
  %99 = load i32* %x, align 4, !dbg !43
  %100 = load i32* %1, align 4, !dbg !43
  %101 = sdiv i32 %99, %100, !dbg !43
  %102 = sext i32 %101 to i64, !dbg !43
  %103 = load i32** %3, align 8, !dbg !43
  %104 = getelementptr inbounds i32* %103, i64 %102, !dbg !43
  %105 = load i32* %104, align 4, !dbg !43
  %106 = icmp sge i32 %105, 1, !dbg !43
  br i1 %106, label %107, label %235, !dbg !43

; <label>:107                                     ; preds = %94
  %108 = load i32* %x, align 4, !dbg !43
  %109 = load i32* %1, align 4, !dbg !43
  %110 = sdiv i32 %108, %109, !dbg !43
  %111 = icmp eq i32 %110, 0, !dbg !43
  br i1 %111, label %129, label %112, !dbg !43

; <label>:112                                     ; preds = %107
  %113 = load i32* %x, align 4, !dbg !43
  %114 = load i32* %1, align 4, !dbg !43
  %115 = sdiv i32 %113, %114, !dbg !43
  %116 = sext i32 %115 to i64, !dbg !43
  %117 = load i32** %3, align 8, !dbg !43
  %118 = getelementptr inbounds i32* %117, i64 %116, !dbg !43
  %119 = load i32* %118, align 4, !dbg !43
  %120 = load i32* %x, align 4, !dbg !43
  %121 = load i32* %1, align 4, !dbg !43
  %122 = sdiv i32 %120, %121, !dbg !43
  %123 = sub nsw i32 %122, 1, !dbg !43
  %124 = sext i32 %123 to i64, !dbg !43
  %125 = load i32** %3, align 8, !dbg !43
  %126 = getelementptr inbounds i32* %125, i64 %124, !dbg !43
  %127 = load i32* %126, align 4, !dbg !43
  %128 = icmp sgt i32 %119, %127, !dbg !43
  br i1 %128, label %129, label %235, !dbg !43

; <label>:129                                     ; preds = %112, %107
  call void @llvm.dbg.declare(metadata !{i32* %from}, metadata !44), !dbg !46
  %130 = load i32* %a, align 4, !dbg !46
  %131 = sext i32 %130 to i64, !dbg !46
  %132 = load i32** %6, align 8, !dbg !46
  %133 = getelementptr inbounds i32* %132, i64 %131, !dbg !46
  %134 = load i32* %133, align 4, !dbg !46
  store i32 %134, i32* %from, align 4, !dbg !46
  call void @llvm.dbg.declare(metadata !{i32* %to}, metadata !47), !dbg !48
  %135 = load i32* %a, align 4, !dbg !48
  %136 = sext i32 %135 to i64, !dbg !48
  %137 = load i32** %7, align 8, !dbg !48
  %138 = getelementptr inbounds i32* %137, i64 %136, !dbg !48
  %139 = load i32* %138, align 4, !dbg !48
  store i32 %139, i32* %to, align 4, !dbg !48
  call void @__syncthreads(), !dbg !49
  %140 = load i32* %x, align 4, !dbg !50
  %141 = load i32* %1, align 4, !dbg !50
  %142 = srem i32 %140, %141, !dbg !50
  %143 = load i32* %2, align 4, !dbg !50
  %144 = add nsw i32 %143, 1, !dbg !50
  %145 = icmp ne i32 %142, %144, !dbg !50
  br i1 %145, label %146, label %183, !dbg !50

; <label>:146                                     ; preds = %129
  %147 = load i32* %from, align 4, !dbg !51
  %148 = load i32* %x, align 4, !dbg !51
  %149 = load i32* %1, align 4, !dbg !51
  %150 = sdiv i32 %148, %149, !dbg !51
  %151 = sext i32 %150 to i64, !dbg !51
  %152 = load i32** %3, align 8, !dbg !51
  %153 = getelementptr inbounds i32* %152, i64 %151, !dbg !51
  %154 = load i32* %153, align 4, !dbg !51
  %155 = sub nsw i32 %154, 1, !dbg !51
  %156 = load i32* %1, align 4, !dbg !51
  %157 = mul nsw i32 %155, %156, !dbg !51
  %158 = load i32* %x, align 4, !dbg !51
  %159 = load i32* %1, align 4, !dbg !51
  %160 = srem i32 %158, %159, !dbg !51
  %161 = add nsw i32 %157, %160, !dbg !51
  %162 = sext i32 %161 to i64, !dbg !51
  %163 = load i32** %6, align 8, !dbg !51
  %164 = getelementptr inbounds i32* %163, i64 %162, !dbg !51
  store i32 %147, i32* %164, align 4, !dbg !51
  %165 = load i32* %to, align 4, !dbg !53
  %166 = load i32* %x, align 4, !dbg !53
  %167 = load i32* %1, align 4, !dbg !53
  %168 = sdiv i32 %166, %167, !dbg !53
  %169 = sext i32 %168 to i64, !dbg !53
  %170 = load i32** %3, align 8, !dbg !53
  %171 = getelementptr inbounds i32* %170, i64 %169, !dbg !53
  %172 = load i32* %171, align 4, !dbg !53
  %173 = sub nsw i32 %172, 1, !dbg !53
  %174 = load i32* %1, align 4, !dbg !53
  %175 = mul nsw i32 %173, %174, !dbg !53
  %176 = load i32* %x, align 4, !dbg !53
  %177 = load i32* %1, align 4, !dbg !53
  %178 = srem i32 %176, %177, !dbg !53
  %179 = add nsw i32 %175, %178, !dbg !53
  %180 = sext i32 %179 to i64, !dbg !53
  %181 = load i32** %7, align 8, !dbg !53
  %182 = getelementptr inbounds i32* %181, i64 %180, !dbg !53
  store i32 %165, i32* %182, align 4, !dbg !53
  br label %226, !dbg !53

; <label>:183                                     ; preds = %129
  %184 = load i32* %b, align 4, !dbg !54
  %185 = sext i32 %184 to i64, !dbg !54
  %186 = load i32** %4, align 8, !dbg !54
  %187 = getelementptr inbounds i32* %186, i64 %185, !dbg !54
  %188 = load i32* %187, align 4, !dbg !54
  %189 = load i32* %x, align 4, !dbg !54
  %190 = load i32* %1, align 4, !dbg !54
  %191 = sdiv i32 %189, %190, !dbg !54
  %192 = sext i32 %191 to i64, !dbg !54
  %193 = load i32** %3, align 8, !dbg !54
  %194 = getelementptr inbounds i32* %193, i64 %192, !dbg !54
  %195 = load i32* %194, align 4, !dbg !54
  %196 = sub nsw i32 %195, 1, !dbg !54
  %197 = load i32* %1, align 4, !dbg !54
  %198 = mul nsw i32 %196, %197, !dbg !54
  %199 = load i32* %2, align 4, !dbg !54
  %200 = add nsw i32 %198, %199, !dbg !54
  %201 = add nsw i32 %200, 1, !dbg !54
  %202 = sext i32 %201 to i64, !dbg !54
  %203 = load i32** %6, align 8, !dbg !54
  %204 = getelementptr inbounds i32* %203, i64 %202, !dbg !54
  store i32 %188, i32* %204, align 4, !dbg !54
  %205 = load i32* %b, align 4, !dbg !56
  %206 = sext i32 %205 to i64, !dbg !56
  %207 = load i32** %5, align 8, !dbg !56
  %208 = getelementptr inbounds i32* %207, i64 %206, !dbg !56
  %209 = load i32* %208, align 4, !dbg !56
  %210 = load i32* %x, align 4, !dbg !56
  %211 = load i32* %1, align 4, !dbg !56
  %212 = sdiv i32 %210, %211, !dbg !56
  %213 = sext i32 %212 to i64, !dbg !56
  %214 = load i32** %3, align 8, !dbg !56
  %215 = getelementptr inbounds i32* %214, i64 %213, !dbg !56
  %216 = load i32* %215, align 4, !dbg !56
  %217 = sub nsw i32 %216, 1, !dbg !56
  %218 = load i32* %1, align 4, !dbg !56
  %219 = mul nsw i32 %217, %218, !dbg !56
  %220 = load i32* %2, align 4, !dbg !56
  %221 = add nsw i32 %219, %220, !dbg !56
  %222 = add nsw i32 %221, 1, !dbg !56
  %223 = sext i32 %222 to i64, !dbg !56
  %224 = load i32** %7, align 8, !dbg !56
  %225 = getelementptr inbounds i32* %224, i64 %223, !dbg !56
  store i32 %209, i32* %225, align 4, !dbg !56
  br label %226

; <label>:226                                     ; preds = %183, %146
  %227 = load i32* %size, align 4, !dbg !57
  %228 = sub nsw i32 %227, 1, !dbg !57
  %229 = sext i32 %228 to i64, !dbg !57
  %230 = load i32** %3, align 8, !dbg !57
  %231 = getelementptr inbounds i32* %230, i64 %229, !dbg !57
  %232 = load i32* %231, align 4, !dbg !57
  %233 = load i32** %9, align 8, !dbg !57
  %234 = getelementptr inbounds i32* %233, i64 0, !dbg !57
  store i32 %232, i32* %234, align 4, !dbg !57
  br label %235, !dbg !58

; <label>:235                                     ; preds = %226, %112, %94
  br label %236, !dbg !59

; <label>:236                                     ; preds = %235, %44, %27
  ret void, !dbg !60
}

declare void @llvm.dbg.declare(metadata, metadata) nounwind readnone

declare void @__syncthreads() section "__device__"

!llvm.dbg.cu = !{!0}

!0 = metadata !{i32 786449, i32 0, i32 4, metadata !"gunrock1.cpp", metadata !"/home/mingyuanwu/Zhengsx", metadata !"clang version 3.2 (tags/RELEASE_32/final)", i1 true, i1 false, metadata !"", i32 0, metadata !1, metadata !1, metadata !3, metadata !1} ; [ DW_TAG_compile_unit ] [/home/mingyuanwu/Zhengsx/gunrock1.cpp] [DW_LANG_C_plus_plus]
!1 = metadata !{metadata !2}
!2 = metadata !{i32 0}
!3 = metadata !{metadata !4}
!4 = metadata !{metadata !5}
!5 = metadata !{i32 786478, i32 0, metadata !6, metadata !"Collect", metadata !"Collect", metadata !"_Z7CollectiiPKiS0_S0_PiS1_S1_S1_", metadata !6, i32 4, metadata !7, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 false, void (i32, i32, i32*, i32*, i32*, i32*, i32*, i32*, i32*)* @_Z7CollectiiPKiS0_S0_PiS1_S1_S1_, null, null, metadata !1, i32 14} ; [ DW_TAG_subprogram ] [line 4] [def] [scope 14] [Collect]
!6 = metadata !{i32 786473, metadata !"gunrock1.cpp", metadata !"/home/mingyuanwu/Zhengsx", null} ; [ DW_TAG_file_type ]
!7 = metadata !{i32 786453, i32 0, metadata !"", i32 0, i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !8, i32 0, i32 0} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!8 = metadata !{null, metadata !9, metadata !9, metadata !11, metadata !11, metadata !11, metadata !13, metadata !13, metadata !13, metadata !13}
!9 = metadata !{i32 786470, null, metadata !"", null, i32 0, i64 0, i64 0, i64 0, i32 0, metadata !10} ; [ DW_TAG_const_type ] [line 0, size 0, align 0, offset 0] [from int]
!10 = metadata !{i32 786468, null, metadata !"int", null, i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!11 = metadata !{i32 786470, null, metadata !"", null, i32 0, i64 0, i64 0, i64 0, i32 0, metadata !12} ; [ DW_TAG_const_type ] [line 0, size 0, align 0, offset 0] [from ]
!12 = metadata !{i32 786447, null, metadata !"", null, i32 0, i64 64, i64 64, i64 0, i32 0, metadata !9} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from ]
!13 = metadata !{i32 786447, null, metadata !"", null, i32 0, i64 64, i64 64, i64 0, i32 0, metadata !10} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from int]
!14 = metadata !{i32 786689, metadata !5, metadata !"edges", metadata !6, i32 16777221, metadata !9, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [edges] [line 5]
!15 = metadata !{i32 5, i32 0, metadata !5, null}
!16 = metadata !{i32 786689, metadata !5, metadata !"iter", metadata !6, i32 33554438, metadata !9, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [iter] [line 6]
!17 = metadata !{i32 6, i32 0, metadata !5, null}
!18 = metadata !{i32 786689, metadata !5, metadata !"flag", metadata !6, i32 50331655, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [flag] [line 7]
!19 = metadata !{i32 7, i32 0, metadata !5, null}
!20 = metadata !{i32 786689, metadata !5, metadata !"froms_data", metadata !6, i32 67108872, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [froms_data] [line 8]
!21 = metadata !{i32 8, i32 0, metadata !5, null}
!22 = metadata !{i32 786689, metadata !5, metadata !"tos_data", metadata !6, i32 83886089, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [tos_data] [line 9]
!23 = metadata !{i32 9, i32 0, metadata !5, null}
!24 = metadata !{i32 786689, metadata !5, metadata !"froms", metadata !6, i32 100663306, metadata !13, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [froms] [line 10]
!25 = metadata !{i32 10, i32 0, metadata !5, null}
!26 = metadata !{i32 786689, metadata !5, metadata !"tos", metadata !6, i32 117440523, metadata !13, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [tos] [line 11]
!27 = metadata !{i32 11, i32 0, metadata !5, null}
!28 = metadata !{i32 786689, metadata !5, metadata !"pos", metadata !6, i32 134217740, metadata !13, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [pos] [line 12]
!29 = metadata !{i32 12, i32 0, metadata !5, null}
!30 = metadata !{i32 786689, metadata !5, metadata !"counts", metadata !6, i32 150994957, metadata !13, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [counts] [line 13]
!31 = metadata !{i32 13, i32 0, metadata !5, null}
!32 = metadata !{i32 786688, metadata !33, metadata !"x", metadata !6, i32 15, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [x] [line 15]
!33 = metadata !{i32 786443, metadata !5, i32 14, i32 0, metadata !6, i32 0} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/Zhengsx/gunrock1.cpp]
!34 = metadata !{i32 15, i32 0, metadata !33, null}
!35 = metadata !{i32 786688, metadata !33, metadata !"size", metadata !6, i32 16, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [size] [line 16]
!36 = metadata !{i32 16, i32 0, metadata !33, null}
!37 = metadata !{i32 17, i32 0, metadata !33, null}
!38 = metadata !{i32 786688, metadata !39, metadata !"a", metadata !6, i32 20, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [a] [line 20]
!39 = metadata !{i32 786443, metadata !33, i32 18, i32 0, metadata !6, i32 1} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/Zhengsx/gunrock1.cpp]
!40 = metadata !{i32 20, i32 0, metadata !39, null}
!41 = metadata !{i32 786688, metadata !39, metadata !"b", metadata !6, i32 21, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [b] [line 21]
!42 = metadata !{i32 21, i32 0, metadata !39, null}
!43 = metadata !{i32 23, i32 0, metadata !39, null}
!44 = metadata !{i32 786688, metadata !45, metadata !"from", metadata !6, i32 26, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [from] [line 26]
!45 = metadata !{i32 786443, metadata !39, i32 24, i32 0, metadata !6, i32 2} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/Zhengsx/gunrock1.cpp]
!46 = metadata !{i32 26, i32 0, metadata !45, null}
!47 = metadata !{i32 786688, metadata !45, metadata !"to", metadata !6, i32 27, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [to] [line 27]
!48 = metadata !{i32 27, i32 0, metadata !45, null}
!49 = metadata !{i32 30, i32 0, metadata !45, null}
!50 = metadata !{i32 31, i32 0, metadata !45, null}
!51 = metadata !{i32 32, i32 0, metadata !52, null}
!52 = metadata !{i32 786443, metadata !45, i32 31, i32 0, metadata !6, i32 3} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/Zhengsx/gunrock1.cpp]
!53 = metadata !{i32 33, i32 0, metadata !52, null}
!54 = metadata !{i32 35, i32 0, metadata !55, null}
!55 = metadata !{i32 786443, metadata !45, i32 34, i32 0, metadata !6, i32 4} ; [ DW_TAG_lexical_block ] [/home/mingyuanwu/Zhengsx/gunrock1.cpp]
!56 = metadata !{i32 36, i32 0, metadata !55, null}
!57 = metadata !{i32 39, i32 0, metadata !45, null}
!58 = metadata !{i32 40, i32 0, metadata !45, null}
!59 = metadata !{i32 41, i32 0, metadata !39, null}
!60 = metadata !{i32 43, i32 0, metadata !33, null}
