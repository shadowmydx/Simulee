#define CU1DBLOCK 256

__global__
void _copy_low_upp(float* A, int rows, int stride) {
  int i = blockIdx.x * blockDim.x + threadIdx.x;
  int j = blockIdx.y * blockDim.y + threadIdx.y;
  if (i <= j || i >= rows)
    return;
  int index_1 = i * stride + j;
  int index_2 = j * stride + i;
  A[index_2] = A[index_1];
}
// rows = 5, stride = 0, block = (2, 1, 1), thread = (3, 2, 2)
// (0, 0, 0) (1, 0, 1) with (0, 0, 0) (1, 0, 0)
// i = 1, j = 0, index_1 = 0, index_2 = 1; i = 1, j = 0, index_1 = 0, index_2 = 1
// (2, 1, 0) read, (1, 0, 1) write. (1 0 1) write to 1, (2 1 0) read from 1 



__global__
void _copy_upp_low(float* A, int rows, int stride) {
  int i = blockIdx.x * blockDim.x + threadIdx.x;
  int j = blockIdx.y * blockDim.y + threadIdx.y;
  if (j <= i || j >= rows)
    return;
  int index_1 = i * stride + j;
  int index_2 = j * stride + i;
  A[index_2] = A[index_1];
}


__global__
void _add_diag_vec_mat(float alpha, float *mat, int stride, int rows, int cols,
                              const float *vec, const float *mat2,
                              int mat2_row_stride, int mat2_col_stride,
                              float beta) {
  int i = blockIdx.x * blockDim.x + threadIdx.x;  
  int j = blockIdx.y * blockDim.y + threadIdx.y;  

  int index = j * stride + i, index2 = j * mat2_row_stride
      + i * mat2_col_stride;

  if (i < cols && j < rows) {
    mat[index] = alpha * vec[j] * mat2[index2] + beta * mat[index];
  }
}

__global__
void _copy_from_tp(float* A, const float* B, int dmat_cols, int dmat_rows, int dmat_stride) {
  int i = blockIdx.x * blockDim.x + threadIdx.x;  // col index
  int j = blockIdx.y * blockDim.y + threadIdx.y;  // row index
  if (i < dmat_cols && j < dmat_rows) {
    int index_B = (j * (j + 1) / 2) + i;
    int index_A = j * dmat_stride + i;
    if (i <= j) {
      A[index_A] = B[index_B];
    } else {
      A[index_A] = 0.0;
    }
  }
}


__global__
void _copy_from_mat(float* mat_out, const float* mat_in,
                           int d_out_stride, int d_out_rows, int d_out_cols, int d_in_stride) {
  int i = blockIdx.x * blockDim.x + threadIdx.x;  // col-index
  int j = blockIdx.y * blockDim.y + threadIdx.y;  // row-index.
  int index_out = i + j * d_out_stride;
  int index_in = i + j * d_in_stride;
  if (i < d_out_cols && j < d_out_rows)
    mat_out[index_out] = mat_in[index_in];
}


__global__
void _trace_mat_mat_trans(const float* A, const float* B, int dA_rows, int dA_cols, int dA_stride,
                                 int B_stride, float* value) {
  __shared__ float ssum[CU1DBLOCK];
  // linear thread id;
  const int tid = threadIdx.y * blockDim.x + threadIdx.x;
  const int j = blockIdx.x * blockDim.x + threadIdx.x;
  const int grid_height = gridDim.y * blockDim.y;
  int i = blockIdx.y * blockDim.y + threadIdx.y;

  // Grid reduce
  float tsum = 0.0;
  if (j < dA_cols) {
    while (i < dA_rows) {
      tsum += A[i * dA_stride + j] * B[i * B_stride + j];
      i += grid_height;
    }
  }
  ssum[tid] = tsum;
  __syncthreads();

  // Block reduce
  for (int shift = CU1DBLOCK / 2; shift > warpSize; shift >>= 1) {
    if (tid < shift)
      ssum[tid] += ssum[tid + shift];
    __syncthreads();
  }

  // Warp reduce. Implicitly synchronized within a warp.
  if (tid < warpSize) {
    for (int shift = warpSize; shift > 0; shift >>= 1) {
      ssum[tid] += ssum[tid + shift];
    }
  }

  // output 1 sum per thread block
  if (tid == 0) {
    value[blockIdx.y * gridDim.x + blockIdx.x] = ssum[0];
  }
}


__global__
void _splice(float* y, const float* x, const int* off,
                    int d_out_cols, int d_out_rows, int d_out_stride, 
					int d_in_cols, int d_in_rows, int d_in_stride) {
  int i = blockIdx.x * blockDim.x + threadIdx.x;
  int j = blockIdx.y * blockDim.y + threadIdx.y;
  int index = i + j * d_out_stride;
  if (i < d_out_cols && j < d_out_rows) {
    int src_col = i % d_in_cols;
    int src_row = j + off[i / d_in_cols];
    if (src_row < 0)
      src_row = 0;
    if (src_row >= d_in_rows)
      src_row = d_in_rows - 1;
    y[index] = x[src_col + src_row * d_in_stride];
  }
}