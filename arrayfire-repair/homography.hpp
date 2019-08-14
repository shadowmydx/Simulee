__global__ void computeEvalHomography(
	unsigned inliers_count,
    const unsigned iterations,
    const unsigned nsamples,
    const float inlier_thr)
{
    unsigned bid_x = blockIdx.x;
    unsigned tid_x = threadIdx.x;
    unsigned i = bid_x * blockDim.x + tid_x;

    __shared__ unsigned s_inliers[256];
    __shared__ unsigned s_idx[256];

    s_inliers[tid_x] = 0;
    s_idx[tid_x]     = 0;
    __syncthreads();

    if (i < 110) {
        s_inliers[tid_x] = inliers_count;
        s_idx[tid_x]     = i;   
    }
 

        // Find sample with most inliers
    for (unsigned tx = 64; tx > 0; tx >>= 1) {
        if (tid_x < tx) {
            if (s_inliers[tid_x + tx] > s_inliers[tid_x]) {
				s_inliers[tid_x] = s_inliers[tid_x + tx];
                s_idx[tid_x]     = s_idx[tid_x + tx];
            }
        }
            __syncthreads();
    } 
}
