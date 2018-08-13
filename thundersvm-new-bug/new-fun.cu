    __host__ __device__ inline bool is_I_up(float a, float y, float Cp, float Cn) {
        return (y > 0 && a < Cp) || (y < 0 && a > 0);
    }

    __host__ __device__ inline bool is_I_low(float a, float y, float Cp, float Cn) {
        return (y > 0 && a > 0) || (y < 0 && a < Cn);
    }

    __host__ __device__ inline bool is_free(float a, float y, float Cp, float Cn) {
        return a > 0 && (y > 0 ? a < Cp : a < Cn);
    }
	
	__host__ __device__ inline bool min_t(float a, float y) {
        return a > y ? y : a;
    }

	__host__ __device__ inline bool max_t(float a, float y) {
        return a > y ? a : y;
    }
	
    __device__ int get_block_min_t(const float *values, int *index) {
        int tid = threadIdx.x;
        index[tid] = tid;
        __syncthreads();
        //block size is always the power of 2
        for (int offset = blockDim.x / 2; offset > 0; offset >>= 1) {
            if (tid < offset) {
                if (values[index[tid + offset]] < values[index[tid]]) {
                    index[tid] = index[tid + offset];
                }
            }
            __syncthreads();
        }
        return index[0];
    }


    __global__ void
    c_smo_solve_kernel(const int *label, float *f_val, float *alpha, float *alpha_diff,
                       const int *working_set, int ws_size,
                       float Cp, float Cn, const float *k_mat_rows, const float *k_mat_diag, int row_len,
                       float eps,
                       float *diff, int max_t_iter) {
        //"row_len" equals to the number of instances in the original training dataset.
        //allocate shared memory
        __shared__ int shared_mem[256];
        int *f_idx2reduce = shared_mem; //temporary memory for reduction
        float *f_val2reduce = (float *) &shared_mem[ws_size]; //f values used for reduction.
        float *alpha_i_diff = (float *) &shared_mem[ws_size + ws_size * sizeof(float) / sizeof(int)]; //delta alpha_i
        float *alpha_j_diff = &alpha_i_diff[1];
        float *kd = (float *) &alpha_j_diff[1]; // diagonal elements for kernel matrix

        //index, f value and alpha for each instance
        int tid = threadIdx.x;
        int wsi = working_set[tid];
        kd[tid] = k_mat_diag[wsi];
        float y = label[wsi];
        float f = f_val[wsi];
        float a = alpha[wsi];
        float aold = a;
        __syncthreads();
        float local_eps;
        int numOfIter = 0;
        while (1) {
            //select fUp and fLow
            if (is_I_up(a, y, Cp, Cn))
                f_val2reduce[tid] = f;
            else
                f_val2reduce[tid] = INFINITY;
            int i = get_block_min_t(f_val2reduce, f_idx2reduce);
            float up_value = f_val2reduce[i];
            float kIwsI = k_mat_rows[row_len * i + wsi];//K[i, wsi]
            __syncthreads();

            if (is_I_low(a, y, Cp, Cn))
                f_val2reduce[tid] = -f;
            else
                f_val2reduce[tid] = INFINITY;
            int j1 = get_block_min_t(f_val2reduce, f_idx2reduce);
            float low_value = -f_val2reduce[j1];

            float local_diff = low_value - up_value;
            if (numOfIter == 0) {
                local_eps = max_t(eps, 0.1f * local_diff);
                if (tid == 0) {
                    diff[0] = local_diff;
                }
            }

            if (numOfIter > max_t_iter || local_diff < local_eps) {
                alpha[wsi] = a;
                alpha_diff[tid] = -(a - aold) * y;
                diff[1] = numOfIter;
                break;
            }
            __syncthreads();

            //select j2 using second order heuristic
            if (-up_value > -f && (is_I_low(a, y, Cp, Cn))) {
                float aIJ = kd[i] + kd[tid] - 2 * kIwsI;
                float bIJ = -up_value + f;
                f_val2reduce[tid] = (-bIJ * bIJ / aIJ);
            } else
                f_val2reduce[tid] = INFINITY;
            int j2 = get_block_min_t(f_val2reduce, f_idx2reduce);

            //update alpha
            if (tid == i)
                *alpha_i_diff = y > 0 ? Cp - a : a;
            if (tid == j2)
                *alpha_j_diff = min_t(y > 0 ? a : Cn - a, (-up_value + f) / (kd[i] + kd[j2] - 2 * kIwsI));
            __syncthreads();
            float l = min_t(*alpha_i_diff, *alpha_j_diff);

            if (tid == i)
                a += l * y;
            if (tid == j2)
                a -= l * y;

            //update f
            float kJ2wsI = k_mat_rows[row_len * j2 + wsi];//K[J2, wsi]
            f -= l * (kJ2wsI - kIwsI);
            numOfIter++;
        }
    }