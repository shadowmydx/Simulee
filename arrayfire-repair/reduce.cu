/* arrayfire: Fix race condition in reduce_first_kernel.*/
    __global__ void warp_reduce(double *s_ptr)
    {
        int tidx = threadIdx.x;
        int tidy = threadIdx.y;
        double *s_ptr_vol = s_ptr + tidx;
        double tmp = *s_ptr;

        for (int n = 16; n >= 1; n >>= 1) {
            if (tidx < n) {
                double val1, val2;
                val1 = s_ptr_vol[0];
                val2 = s_ptr_vol[n];

                tmp = val1 + val2;
                s_ptr_vol[0] = tmp;
            }
        }
    }

