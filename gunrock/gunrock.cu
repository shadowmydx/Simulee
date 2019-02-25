#define SizeT int
#define VertexId int

__global__ void Join(
    const SizeT                 edges,
    const SizeT 		iter,
    const SizeT*    const       pos,
    const SizeT*    const	counts,
          SizeT*    	        flag,
    const VertexId* const	intersect,
    const VertexId* const       froms,
    const VertexId* const       tos,
          VertexId*             froms_out,
          VertexId*             tos_out)
{
    SizeT x = blockIdx.x * blockDim.x + threadIdx.x;
  	SizeT tmp = pos[iter];
    SizeT size = ((iter==0) ? tmp:counts[0]) * (pos[iter+1]-tmp);
    if(x>=0 && x<size*edges)
    {
		SizeT a = (x/edges%((iter==0)?tmp:counts[0]))*edges;
		SizeT b = tmp+x/(edges*((iter==0)?tmp:counts[0])); 

		if(iter==0){ 
	    	froms_out[a]=froms[x/edges%tmp];
	    	tos_out[a]=tos[x/edges%tmp];
		}
	    __syncthreads();

		VertexId c = intersect[iter*2];
		VertexId d = intersect[iter*2+1];
		{
			if(c!=0)  
 			{
	    		SizeT edge = c/2; 
	    		if(c%2==1)
	    		{
					if(froms_out[a+edge]!=froms[b]) {
						flag[x/edges]=0; 
						return;
					}
				} else{ 
					if(tos_out[a+edge-1]!=froms[b]) {
						flag[x/edges]=0; 
						return;
					}
				}
			} else{
				for(SizeT edge = 0; edge<iter+1; edge++){
		    		if(froms[b]==froms_out[a+edge] || froms[b]==tos_out[a+edge])
		    		{
		    			flag[x/edges]=0;
		      			return;
		    		}    
				}
			}
		}

		{
			if(d!=0) {
	    		SizeT edge = d/2;
	    		if(d%2==1){
					if(froms_out[a+edge]!=tos[b]) {
						flag[x/edges]=0; 
						return;
					}
				} else{
					if(tos_out[a+edge-1]!=tos[b]) {
						flag[x/edges]=0; 
						return;
					}
				}
			} else {
	    		for(SizeT edge=0; edge<iter+1; edge++) {
	        		if(tos[b]==froms_out[a+edge] || tos[b]==tos_out[a+edge]) {
	    	    		flag[x/edges]=0; 
		    			return;
					}
	    		}
			}
		}
		flag[x/edges]=1;
    }
}