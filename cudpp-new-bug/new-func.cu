__global__ 
void sparseMatrixVectorSetFlags(
                                unsigned int             *d_flags, 
                                const unsigned int       *d_rowindx, 
                                unsigned int             numRows
                                )
{
    unsigned int iGlobal = (blockIdx.x * (blockDim.x << 3)) + threadIdx.x;

    bool isLastBlock = (blockIdx.x == (gridDim.x-1));

    for (unsigned int i = 0; i < 8; ++i)
    {
        if (isLastBlock)
        {
            if (iGlobal < numRows)
            {
                d_flags[d_rowindx[iGlobal]] = 1;
            }
        }
        else
        {
            d_flags[d_rowindx[iGlobal]] = 1;
        }

        iGlobal += blockDim.x;
    }
    
    __syncthreads();
}
