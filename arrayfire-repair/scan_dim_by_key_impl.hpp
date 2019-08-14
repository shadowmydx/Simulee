#define THREADS_X 32
#define DIMY 5
    __global__
    void scan_dim_nonfinal_kernel(
                                uint blocks_x,
                                uint blocks_y,
                                uint lim)
    {
		
        const int tidx = threadIdx.x;
        const int tidy = threadIdx.y;
        const int tid  = tidy * THREADS_X + tidx;

        const int zid = blockIdx.x / blocks_x;
        const int wid = blockIdx.y / blocks_y;
        const int blockIdx_x = blockIdx.x - (blocks_x) * zid;
        const int blockIdx_y = blockIdx.y - (blocks_y) * wid;
        const int xid = blockIdx_x * blockDim.x + tidx;
        const int yid = blockIdx_y; // yid  of output. updated for input later.

      

        __shared__ char s_flg[THREADS_X * DIMY * 2];
        __shared__ int s_val[THREADS_X * DIMY * 2];
        __shared__ char s_ftmp[THREADS_X];
        __shared__ int s_tmp[THREADS_X];
        __shared__ int boundaryid[THREADS_X];
        int *sptr =  s_val + tid;
        char *sfptr = s_flg + tid;
		int id_dim = 256;

        if (tidy == (DIMY - 1)) {
            s_tmp[tidx] = 0;
            s_ftmp[tidx] = 0;
            boundaryid[tidx] = -1;
        }
        __syncthreads();

        char flag = 0;
		lim = 3;
		int start = 1, val = 0;
        for (int k = 0; k < lim; k++) {

            //Identify segment boundary
            if (tidy == 0) {
                if ((s_ftmp[tidx] == 0) && (sfptr[start * THREADS_X] == 1)) {
                    boundaryid[tidx] = id_dim;
                }
            } else {
                if ((sfptr[(start - 1) * THREADS_X] == 0) && (sfptr[start * THREADS_X] == 1)) {
                    boundaryid[tidx] = id_dim;
                }
            }


            if (tidy == (DIMY - 1)) {
                s_tmp[tidx] = val;
                s_ftmp[tidx] = flag;
            }
            id_dim += blockDim.y;

            __syncthreads();
        }

    }
