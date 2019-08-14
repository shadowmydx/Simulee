#define DIMX 5
#define THREADS_PER_BLOCK 25

    __global__
    void scan_nonfinal_kernel(
                                  uint blocks_x,
                                  uint blocks_y,
                                  uint lim)
    {
        const int DIMY = THREADS_PER_BLOCK / DIMX;
        const int SHARED_MEM_SIZE = (2 * DIMX + 1) * (DIMY);
        __shared__ char s_flg[SHARED_MEM_SIZE];
        __shared__ int s_val[SHARED_MEM_SIZE];
        __shared__ char s_ftmp[DIMY];
        __shared__ int s_tmp[DIMY];
        __shared__ int boundaryid[DIMY];

        const int tidx = threadIdx.x;
        const int tidy = threadIdx.y;
        const int zid = blockIdx.x / blocks_x;
        const int wid = blockIdx.y / blocks_y;
        const int blockIdx_x = blockIdx.x - (blocks_x) * zid;
        const int blockIdx_y = blockIdx.y - (blocks_y) * wid;
        const int xid = blockIdx_x * blockDim.x * lim + tidx;
        const int yid = blockIdx_y * blockDim.y + tidy;


        int *sptr = s_val + tidy * (2 * DIMX + 1);
        char *sfptr = s_flg + tidy * (2 * DIMX + 1);
        int id = xid;

        const bool isLast = (tidx == (DIMX - 1));
        if (tidx == (DIMX - 1)) {
            s_tmp[tidy] = 0;
            s_ftmp[tidy] = 0;
            boundaryid[tidy] = -1;
        }
        __syncthreads();



        char flag = 0;
		int val = 0;
		lim = 6;
        for (int k = 0; k < lim; k++) {
          
            //Write to shared memory
            sptr[tidx] = val;
            sfptr[tidx] = flag;
            __syncthreads();

            //Segmented Scan
            int start = 0;

            //Identify segment boundary
            if (tidx == 0) {
                if ((s_ftmp[tidy] == 0) && (sfptr[tidx] == 1)) {
                    boundaryid[tidy] = id;
                }
            } else {
                if ((sfptr[tidx-1] == 0) && (sfptr[tidx] == 1)) {
                    boundaryid[tidy] = id;
                }
            }

            if (tidx == (DIMX - 1)) {
                s_tmp[tidy] = val;
                s_ftmp[tidy] = flag;
            }
            id += blockDim.x;
            __syncthreads();
        }

    }
