#define DP_BLOCKSIZE 512


__global__ void kReflectH(float * imgs, float * targets,
                          const int imgSize, const int numCases, int numColors, int imgsPerThread, bool checkCaseBounds) {
    const int pxIdx = blockIdx.y * 4 + threadIdx.y;
    const int imgPixels = imgSize * imgSize;

    if (pxIdx < imgPixels) {
        const int caseIdx = blockIdx.x * 32 * imgsPerThread + threadIdx.x;
        const int pxIdxY = pxIdx / imgSize;
        const int pxIdxX = pxIdx % imgSize;

        const int pxIdxXR = imgSize - 1 - pxIdxX; // reflected coordinate
        const int pxIdxR = pxIdxY * imgSize + pxIdxXR;

        imgs += pxIdx * numCases + caseIdx;
        targets += pxIdxR * numCases + caseIdx;

#pragma unroll
        for (int i = 0; i < imgsPerThread; ++i) {
            if (!checkCaseBounds || caseIdx + i * 32 < numCases) {
#pragma unroll
                for (int c = 0; c < numColors; ++c) {
                    targets[c * imgPixels * numCases + i * 32] = imgs[c * imgPixels * numCases + i * 32];
                }
            }
        }
    }
}


__global__ void kTile(const float* src, float* tgt, const uint srcWidth, const uint srcHeight, const uint tgtWidth, const uint tgtHeight) {
    const int idx = blockIdx.x * blockDim.x + threadIdx.x;
    const int numThreads = blockDim.x * gridDim.x;
    //    const unsigned int numEls = tgtWidth * tgtHeight;
    for (uint i = idx; i < tgtWidth * tgtHeight; i += numThreads) {
        const uint y = i / tgtWidth;
        const uint x = i % tgtWidth;
        const uint srcY = y % srcHeight;
        const uint srcX = x % srcWidth;
        tgt[i] = src[srcY * srcWidth + srcX];
    }
}

__global__ void kDotProduct_r(float* a, float* b, float* target,  const uint numElements) {
    __shared__ float shmem[DP_BLOCKSIZE];

    uint eidx = DP_BLOCKSIZE * blockIdx.x + threadIdx.x;
    shmem[threadIdx.x] = 0;
    if (eidx < gridDim.x * DP_BLOCKSIZE) {
        for (; eidx < numElements; eidx += gridDim.x * DP_BLOCKSIZE) {
            shmem[threadIdx.x] += a[eidx] * b[eidx];
        }
    }
    __syncthreads();
    if (threadIdx.x < 256) {
        shmem[threadIdx.x] += shmem[threadIdx.x + 256];
    }
    __syncthreads();
    if (threadIdx.x < 128) {
        shmem[threadIdx.x] += shmem[threadIdx.x + 128];
    }
    __syncthreads();
    if (threadIdx.x < 64) {
        shmem[threadIdx.x] += shmem[threadIdx.x + 64];
    }
    __syncthreads();
    if (threadIdx.x < 32) {
        volatile float* mysh = &shmem[threadIdx.x];
        *mysh += mysh[32];
        *mysh += mysh[16];
        *mysh += mysh[8];
        *mysh += mysh[4];
        *mysh += mysh[2];
        *mysh += mysh[1];
        if (threadIdx.x == 0) {
            target[blockIdx.x] = *mysh;
        }
    }
}