#define THREADS_X 16
#define THREADS_Y 16

__global__
void convolve2(int *out_ptr, int *signal_ptr, int nBBS0, int *out_strides, int *out_dims, int *signal_strides, int *signal_dims,
               int nBBS1, int o2, int o3, int s2, int s3, int expand, int fLen0, int fLen1)
{
    const unsigned C_SIZE  = 512;
    __shared__ int shrdMem[512];

    const int radius0  = fLen0-1;
    const int radius1  = fLen1-1;
    const int padding0 = 2*radius0;
    const int padding1 = 2*radius1;
    const int shrdLen0 = THREADS_X + padding0;
    const int shrdLen1 = THREADS_Y + padding1;

    unsigned b0  = blockIdx.x / nBBS0;
    unsigned b1  = (blockIdx.y + blockIdx.z * gridDim.y) / nBBS1;
    int *dst = (int *)out_ptr + (b0 * out_strides[2] + /* activated with batched input signal */
                             o2 * out_strides[2] + /* activated with batched input filter */
                             b1 * out_strides[3] + /* activated with batched input signal */
                             o3 * out_strides[3]); /* activated with batched input filter */

    const int *src = (const int *)signal_ptr + (b0 * signal_strides[2] + /* activated with batched input signal */
                                            s2 * signal_strides[2] + /* activated with batched input filter */
                                            b1 * signal_strides[3] + /* activated with batched input signal */
                                            s3 * signal_strides[3]); /* activated with batched input filter */



    int lx  = threadIdx.x;
    int ly  = threadIdx.y;
    int gx  = THREADS_X * (blockIdx.x-b0*nBBS0) + lx;
    int gy  = THREADS_Y * ((blockIdx.y + blockIdx.z * gridDim.y) -b1*nBBS1) + ly;

    if(b1 >= out_dims[3])
        return;

    int s0 = signal_strides[0];
    int s1 = signal_strides[1];
    int d0 = signal_dims[0];
    int d1 = signal_dims[1];
    // below loops are traditional loops, they only run multiple
    // times filter length is more than launch size
    for (int b=ly, gy2=gy; b<shrdLen1; b+=THREADS_Y, gy2+=THREADS_Y) {
        int j = gy2-radius1;
        bool is_j  = j>=0 && j<d1;
        // move row_set THREADS_Y along coloumns
        for (int a=lx, gx2=gx; a<shrdLen0; a+=THREADS_X, gx2+=THREADS_X) {
            int i = gx2-radius0;
            bool is_i  = i>=0 && i<d0;
            shrdMem[b*shrdLen0+a] = (is_i && is_j ? src[i*s0+j*s1] : 0);
        }
    }
    __syncthreads();

    if (gx<out_dims[0] && gy<out_dims[1]) {
        int ci = lx + radius0 + (expand ? 0 : fLen0>>1);
        int cj = ly + radius1 + (expand ? 0 : fLen1>>1);

        int accum = 0;
        for(int fj=0; fj<fLen1; ++fj) {
            for(int fi=0; fi<fLen0; ++fi) {

                int s_val = shrdMem[(cj-fj)*shrdLen0 + (ci-fi)];
                accum   = accum + s_val;
            }
        }
        dst[gy*out_strides[1]+gx] = (int)accum;
    }
}