#define THREADS 256

__global__ void select_matches(
    const unsigned* in_idx,
    const int* in_dist,
    const unsigned nfeat,
    const unsigned nelem,
    const int max_dist)
{
    unsigned f = blockIdx.x * blockDim.x + threadIdx.x;
    unsigned sid = threadIdx.x * blockDim.y + threadIdx.y;

    __shared__ int s_dist[THREADS];
    __shared__ unsigned s_idx[THREADS];


    // Reduce best matches and find the best of them all
    for (unsigned i = blockDim.y / 2; i > 0; i >>= 1) {
        if (threadIdx.y < i) {
            int dist = s_dist[sid + i];
            if (dist < s_dist[sid]) {
                s_dist[sid] = dist;
                s_idx[sid]  = s_idx[sid + i];
            }
            __syncthreads();
        }
    }

}