#define THREADS 256

__global__ void hamming_matcher_unroll(
    unsigned* out_idx,
    unsigned* out_dist,
    const unsigned max_dist)
{


    unsigned f = blockDim.x * blockIdx.x + threadIdx.x;
    unsigned tid = threadIdx.x;
	unsigned feat_len = 6, nquery = 6;

    __shared__ unsigned s_dist[THREADS];
    __shared__ unsigned s_idx[THREADS];

    s_dist[tid] = max_dist;
    s_idx[tid]  = 0xffffffff;
	unsigned ntrain = 64;
    bool valid_feat = (f < ntrain);
	

    for (unsigned j = 0; j < nquery; j++) {
        s_dist[tid] = max_dist;

        // Load one query feature that will be tested against all training
        // features in current block
        if (tid < feat_len && f < ntrain) {
            out_idx[tid] = tid * nquery + j;
        }
        __syncthreads();


        // Find best match in training features from block to the current
        // query feature
        if (tid < 32) {
            if (s_dist[tid + 128] < s_dist[tid]) {
                s_dist[tid] = s_dist[tid + 128];
                s_idx[tid]  = s_idx[tid + 128];
            }
        }
        __syncthreads();
        if (tid < 16) {
            if (s_dist[tid + 64] < s_dist[tid]) {
                s_dist[tid] = s_dist[tid + 64];
                s_idx[tid]  = s_idx[tid + 64];
            }
        }
        __syncthreads();
		if (tid < 8) {
            if (s_dist[tid + 32] < s_dist[tid]) {
                s_dist[tid] = s_dist[tid + 32];
                s_idx[tid]  = s_idx[tid + 32];
            }
        }
        __syncthreads();

        // Store best match in training features from block to the current
        // query feature
        if (f < ntrain) {
            out_idx[j * gridDim.x + blockIdx.x] = s_dist[0];
            out_dist[j * gridDim.x + blockIdx.x]  = s_idx[0];
        }
    }
}


