#define NUM_RND_BLOCKS                      96
#define NUM_RND_THREADS_PER_BLOCK           128
#define NUM_RND_STREAMS                     (NUM_RND_BLOCKS * NUM_RND_THREADS_PER_BLOCK)

/*
 * Defines for getting the values at the lower and upper 32 bits
 * of a 64-bit number.
 */
#define LOW_BITS(x)                         ((x) & 0xffffffff)
#define HIGH_BITS(x)                        ((x) >> 32)

/*
 * Number of iterations to run random number generator upon initialization.
 */
#define NUM_RND_BURNIN                      100

/*
 * CUDA grid dimensions for different types of kernels
 */
#define COPY_BLOCK_SIZE                     16
#
// element-wise kernels use min(ceil(N / 512), 4096) blocks of 512 threads
#define MAX_VECTOR_OP_BLOCKS                4096
#define MAX_VECTOR_OP_THREADS_PER_BLOCK     512
#define NUM_VECTOR_OP_BLOCKS(N)             (min(((N) + MAX_VECTOR_OP_THREADS_PER_BLOCK - 1)/MAX_VECTOR_OP_THREADS_PER_BLOCK, MAX_VECTOR_OP_BLOCKS))
#define NUM_VECTOR_OP_THREADS_PER_BLOCK(N)  (min((N), MAX_VECTOR_OP_THREADS_PER_BLOCK))

#define PI 3.1415926535897932f

__global__ void kRandomGaussian(unsigned int* rndMults, unsigned long long* rndWords, float* gData, unsigned int numElements) {
    const unsigned int idx = blockIdx.x * blockDim.x + threadIdx.x;
    unsigned long long rndWord = rndWords[idx];
    const unsigned int rndMult = rndMults[idx];

    float rnd1, rnd2, R, T;
    for(unsigned int i = idx; i < numElements; i += 2*NUM_RND_STREAMS) {
        rndWord = rndMult * LOW_BITS(rndWord) + HIGH_BITS(rndWord);
        rnd1 = ((LOW_BITS(rndWord)) + 1.0f) / 4294967296.0f;
        rndWord = rndMult * LOW_BITS(rndWord) + HIGH_BITS(rndWord);
        rnd2 = ((LOW_BITS(rndWord)) + 1.0f) / 4294967296.0f;
        T = 2 * PI * rnd2;
        R = (-2 * (rnd1));
        gData[i] = R * (T);
        if (i + NUM_RND_STREAMS < numElements)
            gData[i + NUM_RND_STREAMS] = R * __sinf(T);
    }
    rndWords[idx] = rndWord;
}

__global__ void kMinColumnwise(float* mat, float* target, unsigned int width, unsigned int height) {
    __shared__ float min_vals[32];
    float cur_min = 1.0f;
    float val = 0;
 
    for (unsigned int i = threadIdx.x; i < height; i += 32) {
        val = mat[blockIdx.x * height + i];

        if (val < cur_min)
            cur_min = val;
    }

    min_vals[threadIdx.x] = cur_min;

    __syncthreads();

    if (threadIdx.x == 0) {
        cur_min = 1.0f;

        for (unsigned int i = 0; i < 32; i++)
            if (min_vals[i] < cur_min)
                cur_min = min_vals[i];

        target[blockIdx.x] = cur_min;
    }
}
