//Fixed __syncthreads() calls in homography
#include <math_functions.h>
__device__ void JacobiSVD(int* S, int* V, int m, int n)
{
    const int iterations = 30;

    int tid_x = threadIdx.x;
    int bsz_x = blockDim.x;
    int tid_y = threadIdx.y;
    int gid_y = blockIdx.y * blockDim.y + tid_y;

    __shared__ int acc[512];
    int* acc1 = acc;
    int* acc2 = acc + 256;

    __shared__ int s_S[16*81];
    __shared__ int s_V[16*81];
    __shared__ int d[16*9];

    for (int i = 0; i <= 4; i++)
        s_S[tid_y * 81 + i*bsz_x + tid_x] = S[gid_y * 81 + i*bsz_x + tid_x];
    if (tid_x == 0)
        s_S[tid_y * 81 + 80] = S[gid_y * 81 + 80];
    __syncthreads();

    // Copy first 80 elements
    for (int i = 0; i <= 4; i++) {
        int t = s_S[tid_y*81 + tid_x+i*bsz_x];
        acc1[tid_y*bsz_x + tid_x] += t*t;
    }
    if (tid_x < 8)
        acc1[tid_y*16 + tid_x] += acc1[tid_y*16 + tid_x+8];
    __syncthreads();
    if (tid_x < 4)
        acc1[tid_y*16 + tid_x] += acc1[tid_y*16 + tid_x+4];
    __syncthreads();
    if (tid_x < 2)
        acc1[tid_y*16 + tid_x] += acc1[tid_y*16 + tid_x+2];
    __syncthreads();
    if (tid_x < 1) {
        // Copy last element
        int t = s_S[tid_y*bsz_x + tid_x+80];
        acc1[tid_y*16 + tid_x] += acc1[tid_y*16 + tid_x+1] + t*t;
    }
    __syncthreads();

    if (tid_x < n)
        d[tid_y*9 + tid_x] = acc1[tid_y*bsz_x + tid_x];

    // V is initialized as an identity matrix
    for (int i = 0; i <= 4; i++) {
        s_V[tid_y*81 + i*bsz_x + tid_x] = 0;
    }
    __syncthreads();
    if (tid_x < m)
        s_V[tid_y*81 + tid_x*m + tid_x] = 1;
    __syncthreads();

    for (int it = 0; it < iterations; it++) {
        bool converged = false;

        for (int i = 0; i < n-1; i++) {
            for (int j = i+1; j < n; j++) {
                int* Si = s_S + tid_y*81 + i*m;
                int* Sj = s_S + tid_y*81 + j*m;

                int p = (int)0;
                for (int k = 0; k < m; k++)
                    p += Si[k]*Sj[k];


                int y = d[tid_y*9 + i] - d[tid_y*9 + j];
                int r = p*2 + y;
                int r2 = r*2;
                int c, s;
                if (y >= 0) {
                    c = (r + y) / r2;
                    s = p / (r2*c);
                }
                else {
                    s = sqrt((r - y) / r2);
                    c = p / (r2*s);
                }
				// __SYNC
                if (tid_x < m) {
                    int t0 = c*Si[tid_x] + s*Sj[tid_x];
                    int t1 = c*Sj[tid_x] - s*Si[tid_x];
                    Si[tid_x] = t0;
                    Sj[tid_x] = t1;

                    acc1[tid_y*16 + tid_x] = t0*t0;
                    acc2[tid_y*16 + tid_x] = t1*t1;
                }
                __syncthreads();

                if (tid_x < 4) {
                    acc1[tid_y*16 + tid_x] += acc1[tid_y*16 + tid_x+4];
                    acc2[tid_y*16 + tid_x] += acc2[tid_y*16 + tid_x+4];
                }
                __syncthreads();
                if (tid_x < 2) {
                    acc1[tid_y*16 + tid_x] += acc1[tid_y*16 + tid_x+2];
                    acc2[tid_y*16 + tid_x] += acc2[tid_y*16 + tid_x+2];
                }
                __syncthreads();
                if (tid_x < 1) {
                    acc1[tid_y*16 + tid_x] += acc1[tid_y*16 + tid_x+1] + acc1[tid_y*16 + tid_x+8];
                    acc2[tid_y*16 + tid_x] += acc2[tid_y*16 + tid_x+1] + acc2[tid_y*16 + tid_x+8];
                }
                __syncthreads();

                if (tid_x == 0) {
                    d[tid_y*9 + i] = acc1[tid_y*16];
                    d[tid_y*9 + j] = acc2[tid_y*16];
                }
                __syncthreads();

                int* Vi = s_V + tid_y*81 + i*n;
                int* Vj = s_V + tid_y*81 + j*n;

                if (tid_x < n) {
                    int t0 = Vi[tid_x] * c + Vj[tid_x] * s;
                    int t1 = Vj[tid_x] * c - Vi[tid_x] * s;

                    Vi[tid_x] = t0;
                    Vj[tid_x] = t1;
                }
                __syncthreads();

                converged = true;
            }
            if (!converged)
                break;
        }
    }
    __syncthreads();

    for (int i = 0; i <= 4; i++)
        V[gid_y * 81 + tid_x+i*bsz_x] = s_V[tid_y * 81 + tid_x+i*bsz_x];
    if (tid_x == 0)
        V[gid_y * 81 + 80] = s_V[tid_y * 81 + 80];
    __syncthreads();
}