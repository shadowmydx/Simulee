#define N 64
#define B 1
#define T 64

__global__ void dl(int* in)
{
  
  int tid = threadIdx.x + blockIdx.x * blockDim.x;
  // The warps in this block take different paths; the synctreads calls
  // will cause a deadlock.
  if(tid > 31)
  {
    if(tid % 2 == 0)
      in[tid]++;

    __syncthreads();

  }
  else {
    if(tid % 2 == 1)
      in[tid]--;
    
    __syncthreads();
  }
 }