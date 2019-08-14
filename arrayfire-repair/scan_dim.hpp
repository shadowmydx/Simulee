// BUGFIX: for accum along non-first dimension
#define DIMY 1 
#define THREADS_X 16

    __global__ static void scan_dim_kernel(
                                uint blocks_x,
                                uint blocks_y,
                                uint blocks_dim,
                                uint lim)
    {
        const uint tidx = threadIdx.x;
        const uint tidy = threadIdx.y;
        const uint tid  = tidy * THREADS_X + tidx;

        const uint zid = blockIdx.x / (blocks_x + 1);
        const uint wid = blockIdx.y / (blocks_y + 1);
        const uint blockIdx_x = blockIdx.x - (blocks_x) * zid;
        const uint blockIdx_y = blockIdx.y - (blocks_y) * wid;
        const uint xid = blockIdx_x * blockDim.x + tidx;
        const uint yid = blockIdx_y; // yid  of output. updated for input later.


        // There is only one element per block for out
        // There are blockDim.y elements per block for in
        // Hence increment ids[dim] just after offseting out and before offsetting in
		const bool isLast = (tidy == (DIMY - 1));

        __shared__ double s_val[256];
        __shared__ double s_tmp[32];
        double *sptr =  s_val + tid;

		double val = 0.0;

        for (int k = 0; k < lim; k++) {

            if (isLast) s_tmp[tidx] = val;
            *sptr = val;
            __syncthreads();

            uint start = 0;
            for (int off = 1; off < DIMY; off *= 2) {

                if (tidy >= off) val = sptr[(start - off) * THREADS_X];
                start = DIMY - start;
                sptr[start * THREADS_X] = val;

                __syncthreads();
            }


            val = val + s_tmp[tidx];
            __syncthreads();

        }

    }