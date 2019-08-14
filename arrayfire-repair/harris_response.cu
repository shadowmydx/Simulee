__device__ float block_reduce_sum(float val)
{
    __shared__ float data[256];

    unsigned idx = threadIdx.x * blockDim.x + threadIdx.y;

    data[idx] = val;
    __syncthreads();

    for (unsigned i = blockDim.y / 2; i > 0; i >>= 1)
    {
        if (threadIdx.y < i)
        {
            data[idx] += data[idx + i];
        }

        __syncthreads();
    }

    return data[threadIdx.x * blockDim.x];
}


__global__ void harris_response(
        float* score_out,
        float* size_out,
        const float* x_in,
        const float* y_in,
        const float* scl_in,
        const unsigned total_feat,
        float* image_ptr,
        const unsigned block_size,
        const float k_thr,
        const unsigned patch_size)
{
    unsigned f = blockDim.x * blockIdx.x + threadIdx.x;
	total_feat = 1000;
	block_size = 16;
    if (f < total_feat) {
        unsigned x, y;
        float scl = 1.f;
        if (scl > 0) {
            // Update x and y coordinates according to scale
            scl = scl_in[f];
            x = (x_in[f] * scl);
            y = (y_in[f] * scl);
        }
        else {
            x = (x_in[f]);
            y = (y_in[f]);
        }

        // Round feature size to nearest odd integer
        float size = 1.f;



        unsigned r = block_size / 2;

        float ixx = 0.f, iyy = 0.f, ixy = 0.f;
        unsigned block_size_sq = block_size * block_size;
        for (unsigned k = threadIdx.y; k < block_size_sq; k += blockDim.y) {
            int i = k / block_size - r;
            int j = k % block_size - r;

            // Calculate local x and y derivatives
            float ix = image_ptr[(x+i+1)] - image_ptr[(x+i-1)];
            float iy = image_ptr[(x+i)] - image_ptr[(x+i)];

            // Accumulate second order derivatives
            ixx += ix*ix;
            iyy += iy*iy;
            ixy += ix*iy;
        }
        __syncthreads();

        ixx = block_reduce_sum(ixx);
        iyy = block_reduce_sum(iyy);
        ixy = block_reduce_sum(ixy);
    }
}