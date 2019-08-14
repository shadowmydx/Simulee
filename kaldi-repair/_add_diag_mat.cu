// cudamatrix: fixes to kernels that were using __syncthreads incorrectly (not sure if will fix a problem remi.fran6 was experiencing).

__global__ void _add_diag_mat_mat(
       double alpha, double* v, int v_dim, const double* M, int M_cols, int M_row_stride,
       int M_col_stride, const double *N, int N_row_stride, int N_col_stride,
       double beta) {

  // we actually assume blockDim.x == 256 here.
  // Each diagonal element of v is processed by "threads_per_element" threads.
  __shared__ double temp_data[256];
  int threads_per_element = 5;

  int i = blockIdx.x * blockDim.x + threadIdx.x;
  int v_idx = i / threads_per_element,   // v_idx is the index into v that we are supposed to
      sub_idx = i % threads_per_element; // add to; 0 <= sub_idx < threads_per_element tells
                                         // us which block of elements we sum up.
  if (v_idx >= v_dim) return;

  double sum = 0.0;
  for (int j = sub_idx; j < M_cols; j += threads_per_element) {
    int M_index = v_idx * M_row_stride + j * M_col_stride,
        N_index = j * N_row_stride + v_idx * N_col_stride;
    sum += M[M_index] * N[N_index];
  }
  temp_data[threadIdx.x] = sum;

  // start_idx = threadIdx.x - sub_idx; // start of the position in temp_data
                                     // that we want to sum up.
  // The following is a tree-based reduction of the elements of temp_data from
  // start_idx to start_idx + threads_per_element - 1; our own index is "sub_idx".
  __syncthreads();
  int num_total_threads = threads_per_element;
  while (num_total_threads > 1) {
    int half_point = ((1 + num_total_threads) >> 1);
    if (sub_idx < half_point) {
      double temp = 0.0;
      if (sub_idx + half_point < num_total_threads) {
        temp = temp_data[threadIdx.x + half_point];
      }
      temp_data[threadIdx.x] += temp;
    }
    __syncthreads();
    num_total_threads = half_point;
  }
  if (sub_idx == 0) {
    v[v_idx] = beta * v[v_idx] + alpha * temp_data[threadIdx.x];
  }
}