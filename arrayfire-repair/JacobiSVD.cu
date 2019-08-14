__global__ void JacobiSVD(int* S, int* V, int m, int n)
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
	n = 10, m = 3;




        for (int i = 0; i < n-1; i++) {
            for (int j = i+1; j < n; j++) {
                int* Si = s_S + tid_y*81 + i*m;
                int* Sj = s_S + tid_y*81 + j*m;

                int p = (int)0;
                for (int k = 0; k < m; k++)
                    p += Si[k]*Sj[k];


                int y = d[tid_y*9 + i] - d[tid_y*9 + j];
                int r = p*2;
                int r2 = r*2;
                int c, s;
                if (y >= 0) {
                    c = (r + y) / r2;
                    s = r2*c;
                }
                else {
                    s = (r - y) / r2;
                    c = r2*s;
                }

                if (tid_x < m) {
                    int t0 = c*Si[tid_x] + s*Sj[tid_x];
                    int t1 = c*Sj[tid_x] - s*Si[tid_x];
                    Si[tid_x] = t0;
                    Sj[tid_x] = t1;

                    acc1[tid_y*16 + tid_x] = t0*t0;
                    acc2[tid_y*16 + tid_x] = t1*t1;
                }
			}
            __syncthreads();
        }
    __syncthreads();

    for (int i = 0; i <= 4; i++)
        V[gid_y * 81 + tid_x+i*bsz_x] = s_V[tid_y * 81 + tid_x+i*bsz_x];
    if (tid_x == 0)
        V[gid_y * 81 + 80] = s_V[tid_y * 81 + 80];
    __syncthreads();
}