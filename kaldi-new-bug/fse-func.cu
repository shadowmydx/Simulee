__device__
double _sum_reduce(double buffer[]) {
   
  int nTotalThreads = blockDim.x;
  __syncthreads();
   
  while (nTotalThreads > 1) {
    int halfPoint = ((1 + nTotalThreads) >> 1);  
     
    if (threadIdx.x >= halfPoint) {  
       
      double temp = 0.0;
      if (threadIdx.x < nTotalThreads) {  
        temp = buffer[threadIdx.x];  
      }
      buffer[threadIdx.x - halfPoint] += temp;
    }
    __syncthreads();
    nTotalThreads = ((1 + nTotalThreads) >> 1);  
  }
   
  return buffer[0];
}