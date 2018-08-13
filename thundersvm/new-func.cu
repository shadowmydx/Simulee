#define KERNEL_LOOP(i, n) \
  for (int i = blockIdx.x * blockDim.x + threadIdx.x; \
       i < (n); \
       i += blockDim.x * gridDim.x)


    __global__ void
    update_f_kernel(float_type *f, int ws_size, const float_type *alpha_diff, const kernel_type *k_mat_rows,
                    int n_instances) {
        //"n_instances" equals to the number of rows of the whole kernel matrix for both SVC and SVR.
        KERNEL_LOOP(idx, n_instances) {//one thread to update multiple fvalues.
            double sum_diff = 0;
            for (int i = 0; i < ws_size; ++i) {
                double d = alpha_diff[i];
                if (d != 0) {
                    sum_diff += d * k_mat_rows[i * n_instances + idx];
                }
            }
            f[idx] -= sum_diff;
        }
    }

