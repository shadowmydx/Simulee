#define N 64
#define B 2
#define T 32

__global__ void dl(int* in)
{
  
  int tid = threadIdx.x + blockIdx.x * blockDim.x;
  if(blockIdx.x % 2 == 0)
  {
    if(tid % 2 == 0)
      in[tid]++;
    // Fine because conditional synchronization will
    // happen within a block.
    __syncthreads();

  }
  else {
    if(tid % 2 == 1)
      in[tid]--;
    
    __syncthreads();
  }
}