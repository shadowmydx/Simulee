// nu-svc fix bugs
__device__ int get_block_min(const float *values, int *index) {
    int tid = threadIdx.x;
    index[tid] = tid;
    __syncthreads();
    //block size is always the power of 2
    for (int offset = blockDim.x / 2; offset > 0; offset >>= 1) {
        if (tid < offset) {
            if (values[index[tid + offset]] <= values[index[tid]]) {
                index[tid] = index[tid + offset];
            }
        }
        __syncthreads();
    }
    return index[0];
}

__host__ __device__ bool is_I_up(float a, float y, float C) {
    return (y > 0 && a < C) || (y < 0 && a > 0);
}

__host__ __device__ bool is_I_low(float a, float y, float C) {
    return (y > 0 && a > 0) || (y < 0 && a < C);
}

__global__ void
nu_smo_solve_kernel(const int *label, float *f_values, float *alpha, float *alpha_diff, const int *working_set,
                    int ws_size, float C, const float *k_mat_rows, const float *k_mat_diag, int row_len, float eps,
                    float *diff_and_bias) {
    //"row_len" equals to the number of instances in the original training dataset.
    //allocate shared memory
    __shared__ int shared_mem[256];
    int *f_idx2reduce = shared_mem; //temporary memory for reduction
    float *f_val2reduce = (float *) &f_idx2reduce[ws_size]; //f values used for reduction.
    float *alpha_i_diff = &f_val2reduce[ws_size]; //delta alpha_i
    float *alpha_j_diff = &alpha_i_diff[1];
    float *kd = &alpha_j_diff[1]; // diagonal elements for kernel matrix

    //index, f value and alpha for each instance
    int tid = threadIdx.x;
    int wsi = working_set[tid];
    kd[tid] = k_mat_diag[wsi];
    float y = label[wsi];
    float f = f_values[wsi];
    float a = alpha[wsi];
    float aold = a;
    __syncthreads();
    float local_eps = 0.0;
    int numOfIter = 0;
    while (1) {
        //select I_up (y=+1)
        if (y > 0 && a < C)
            f_val2reduce[tid] = f;
        else
            f_val2reduce[tid] = INFINITY;
       // __syncthreads();
        int ip = get_block_min(f_val2reduce, f_idx2reduce);
        float up_value_p = f_val2reduce[ip];
        float kIpwsI = k_mat_rows[row_len * ip + wsi];//K[i, wsi]
       // __syncthreads();


        float local_diff = up_value_p;

        if (numOfIter == 0) {
            local_eps = 0.1f * local_diff;
        }

        if (local_diff < local_eps) {
            alpha[wsi] = a;
            alpha_diff[tid] = -(a - aold) * y;
            if (tid == 0) {
                diff_and_bias[0] = local_diff;
            }
            break;
        }
    }
}

