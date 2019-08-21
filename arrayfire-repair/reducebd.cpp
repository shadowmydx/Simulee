 
    __global__ void warp_reduce(double *s_ptr)
    {
        int tidx = threadIdx.x;
        double *s_ptr_vol = s_ptr + tidx;
        double tmp = *s_ptr;

        for (int n = 16; n >= 1; n >>= 1) {
            if (tidx < n) {
                double val1, val2;
                val1 = s_ptr_vol[0];
                val2 = s_ptr_vol[n];
				__syncthreads();
                tmp = val1 + val2;
                s_ptr_vol[0] = tmp;
            }
        }
    }

