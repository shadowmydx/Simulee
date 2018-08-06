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
  int i = blockIdx.x * blockDim.x + threadIdx.x;   
  int j = blockIdx.y * blockDim.y + threadIdx.y;   
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
// (2 0 1) (1 1 0) w&w
/*
(2 0 1):
i = 2, j = 0, index_B = 2, index_A = 2
(1 1 0):
i = 1, j = 1, index_B = 1, index_A = 2
*/

__global__
void _copy_from_mat(float* mat_out, const float* mat_in,
                           int d_out_stride, int d_out_rows, int d_out_cols, int d_in_stride) {
  int i = blockIdx.x * blockDim.x + threadIdx.x;
  int j = blockIdx.y * blockDim.y + threadIdx.y;
  int index_out = i + j * d_out_stride;
  int index_in = i + j * d_in_stride;
  if (i < d_out_cols && j < d_out_rows)
    mat_out[index_out] = mat_in[index_in];
}