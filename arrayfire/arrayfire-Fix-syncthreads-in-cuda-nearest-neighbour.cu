#define THREADS 256

__global__ void select_matches(
    unsigned* idx_ptr,
    int* dist_ptr,
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

    s_dist[sid] = max_dist;
    if (f < nfeat) {
        for (unsigned i = threadIdx.y; i < nelem; i += blockDim.y) {
            int dist = in_dist[f * nelem + i];

            // Copy all best matches previously found in nearest_neighbour() to
            // shared memory
            if (dist < s_dist[sid]) {
                s_dist[sid] = dist;
                s_idx[sid]  = in_idx[f * nelem + i];
            }
        }
    }
    __syncthreads();

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

    // Store best matches and indexes to training dataset
    if (threadIdx.y == 0 && f < nfeat) {
        dist_ptr[f] = s_dist[threadIdx.x * blockDim.y];
        idx_ptr[f]  = s_idx[threadIdx.x * blockDim.y];
    }
}