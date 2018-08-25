__global__ void g_getCost_3(float* cost,
	float* weight,
	float lambda, int wlen)
{
	__shared__ float _sum[32];
	_sum[threadIdx.x] = 0;
	__syncthreads();
	

	for(int i = 0; i < wlen; i += blockDim.x)
	{
		int id = i + threadIdx.x;
		if(id < wlen)
		{
			_sum[threadIdx.x] += weight[id] * weight[id];
		}
	}

	int len = blockDim.x;
	while(len != 1)
	{
		__syncthreads();
		int skip = (len + 1) >> 1;
		if(threadIdx.x < skip && (threadIdx.x + skip) < len)
		{
			_sum[threadIdx.x] += _sum[threadIdx.x + skip];
		}
		len = skip;
	}
}