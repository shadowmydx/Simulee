    __device__ void warp_reduce(int *s_ptr, uint *s_idx)
    {
		int tidx = threadIdx.x;

        for (int n = 16; n >= 1; n >>= 1) {
            if (tidx < n) {
                int val1, val2;
				val1 = s_ptr[tidx];
				val2 = s_ptr[tidx + n];

                int idx1, idx2;
				idx1 = s_idx[tidx];
				idx2 = s_idx[tidx + n];

				s_ptr[tidx] = idx2;
				s_idx[tidx] = val2;
            }
        }
    }