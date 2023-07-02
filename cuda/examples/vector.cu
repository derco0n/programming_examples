// This is an example on how to calculate numbers in parallel on a nvidia GPU using Cuda.
// Compile with: nvcc vector.cu -o cuda_vector-example

#include <iostream>
#include <math.h>
#include <stdio.h>

// Kernel function to add the elements of two arrays
__global__
/// @brief This will add the values (at the index that matches the current thread id) of a and b and store it in c
/// @param a Pointer to the a-array
/// @param b Pointer to the b-array
/// @param c Pointer to the c-array
void vectorAdd(int *a, int *b, int *c)
{    
    int i= threadIdx.x; //Get the ID of the current Thread. We're using this as an index here....
    c[i] = a[i] + b[i];

    return;
}

int main(void)
{
    // Initialize input arrays
    int a[] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20};
    int b[] = {21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40};

    // Initialize output array
    int c[sizeof(a)/sizeof(int)]={0};

    printf("Creating pointers into the GPU...\n");
    //create pointer into the gpu
    int *cudaA =0;
    int *cudaB =0;
    int *cudaC =0;

    printf("Allocating GPU-Memory...\n");
    //allocate memory in the GPU that are of the same size as the arrays on the host (we need to copy them over later)
    cudaMalloc(&cudaA, sizeof(a));
    cudaMalloc(&cudaB, sizeof(b));
    cudaMalloc(&cudaC, sizeof(c));

    printf("Copying data to the GPU-Memory...\n");
    //copy the vectors into the gpu (Host => GPU)
    cudaMemcpy(cudaA, a, sizeof(a), cudaMemcpyHostToDevice);
    cudaMemcpy(cudaB, b, sizeof(b), cudaMemcpyHostToDevice);

    printf("Prforming parallel calculations...\n");
    //Calling the function that should be run in parallel like: 1vectorAdd <<< GRID_SIZE, BLOCK_SIZE >>> (ARGUMENTS)
    vectorAdd <<< 1, (sizeof(a) / sizeof(int)) >>> (cudaA, cudaB, cudaC); //Blocks: 1, Threads per Block: (sizeof(a) / sizeof(int))

    printf("Copying results from GPU's Memory to Host's memory...\n");
    //Copying the results back from the GPU into the host's memory (GPU => Host)
    cudaMemcpy(c, cudaC, sizeof(c), cudaMemcpyDeviceToHost);

    printf("Printing results...\n");
    for(int res: c){
        printf("%d\n",res);
    }

    return 0;
}
