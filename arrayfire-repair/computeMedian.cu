__global__ void computeMedian(
    const unsigned iterations)
{
    const unsigned tid = threadIdx.x;
    const unsigned bid = blockIdx.x;
    const unsigned i = bid * blockDim.x + threadIdx.x;

    __shared__ float s_median[256];
    __shared__ unsigned s_idx[256];

    s_median[tid] = FLT_MAX;
    s_idx[tid] = 0;
    __syncthreads();

    if (i < iterations) {

        s_idx[tid] = i;
        s_median[tid] = m;
    }
}