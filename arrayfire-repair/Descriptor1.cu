__global__ void computeDescriptor(
    float* desc_out,
    unsigned desc_len,
    unsigned histsz,
    const float* x_in,
    const float* y_in,
    const unsigned* layer_in,
    const float* response_in,
    const float* size_in,
    const float* ori_in,
    unsigned total_feat,
    const int d,
    const int n,
    const float scale,
    const float sigma,
    const int n_layers)
{
    const int tid_x = threadIdx.x;
    const int tid_y = threadIdx.y;
    const int bsz_x = blockDim.x;
    const int bsz_y = blockDim.y;

    const int f = blockIdx.y * bsz_y + tid_y;
	desc_len = 6;
	total_feat = 8;

    __shared__ float shrdMem[512];
    float* desc = shrdMem;
    float* accum = shrdMem + desc_len * histsz;
	histsz = 1;

    if (f < total_feat) {
		const int histlen = 16;
        const int hist_off = (tid_x % histsz) * desc_len;
		
		int i = tid_x;
		while (i < histlen*histsz) {
			desc[tid_y*histlen+i] = 0.f;
			i += bsz_x;
		}
		
        __syncthreads();
		int l = tid_x;
		while (l < desc_len*2) {
			desc[l    ] += desc[l+2*desc_len];
			l += bsz_x;
		}
		__syncthreads();
		l = tid_x;
		while (l < desc_len) {
			desc[l    ] += desc[l+desc_len];
			l += bsz_x;
		}

    }
}