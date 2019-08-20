#define SizeT int
#define VertexId int

__global__ void Collect(
    const SizeT                 edges,
    const SizeT 		iter,
    const SizeT*    const 	flag,
    const VertexId* const	froms_data,
    const VertexId* const	tos_data,
    	  VertexId* 	        froms,
    	  VertexId* 	        tos,
    	  SizeT*     	        pos,
	  SizeT*		counts)
{
    SizeT x = blockIdx.x * blockDim.x + threadIdx.x;
    SizeT size = ((iter==0) ? pos[iter]:counts[0]) * (pos[iter+1]-pos[iter]);
    if(x>=0 && x<size*edges)
    {
	//SizeT a = x%(((iter==0)?pos[iter]:counts[0]) * edges);
	SizeT a = (x/edges%((iter==0)?pos[iter]:counts[0]))*edges+x%edges;
	SizeT b = pos[iter]+x/(edges*((iter==0)?pos[iter]:counts[0])); // edge iter+1 e_id

	if(flag[x/edges]>=1 && (x/edges==0 || flag[x/edges]>flag[x/edges-1]))
	{
// printf("large group:%d small group: %d  iter:%d froms_out[%d]:%d->tos_out[%d]:%d flag[%d]=%d\n",x/edges%(pos[iter+1]-pos[iter]), x/edges/(pos[iter+1]-pos[iter]),iter,a,froms[a],a,tos[a],x/edges,flag[x/edges]);
	    	VertexId from = froms[a];
	    	VertexId to = tos[a];
	    	//VertexId from = froms[x];
	    	//VertexId to = tos[x];
	    	__syncthreads();
		if(x%edges!=iter+1){
	    	froms[(flag[x/edges]-1)*edges+x%edges]=from;
		tos[(flag[x/edges]-1)*edges+x%edges]=to;}
		else{
		froms[(flag[x/edges]-1)*edges+iter+1] = froms_data[b];
		tos[(flag[x/edges]-1)*edges+iter+1] = tos_data[b];}
//printf("iter:%d 	froms[%d]:%d -> tos[%d]:%d	flag[%d]:%d\n",iter,(flag[x/edges]-1)*edges+x%edges,froms[(flag[x/edges]-1)*edges+x%edges],(flag[x/edges]-1)*edges+x%edges, tos[(flag[x/edges]-1)*edges+x%edges],x/edges,flag[x/edges]);
//printf("iter:%d 	froms[%d]:%d -> tos[%d]:%d	flag[%d]:%d\n",iter,(flag[x/edges]-1)*edges+x%edges,from,(flag[x/edges]-1)*edges+x%edges, to,x/edges,flag[x/edges]);
		counts[0] = flag[size-1];
	}
    } 
	
}