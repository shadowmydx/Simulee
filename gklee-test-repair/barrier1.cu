#define N 15
#define B 2
#define T 32

__global__ void dl(int* in)
{
  
  int tid = threadIdx.x + blockIdx.x * blockDim.x;
  if(tid < N)
  {
    if(tid % 2 == 0)
      in[tid]++;

    __syncthreads(); // ouch

    int sum = in[tid];
    if(tid > 0)
      sum += in[tid-1];
    if(tid < N - 1)
      sum += in[tid+1];
    in[tid] = sum / 3;
  }
}

// dl<<<B,T>>>(din);