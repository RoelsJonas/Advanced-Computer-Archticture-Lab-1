#include <iostream>

//void swap(int *pInt, int *pInt1);

__global__ void swap(int* in, int* out, int size) {
    int i = blockIdx.x * blockDim.x + threadIdx.x;
    if(i < size) out[size-1-i] = in[i];
}

int main() {
    int size = 100000;
    int* temp = (int*)(malloc(size * sizeof(int)));
    for(int i = 0; i < size; i++) {
        temp[i] = i;
    }

    int* input;
    cudaMalloc(&input, size*sizeof(int));
    cudaMemcpy( input, temp, size*sizeof(int), cudaMemcpyHostToDevice);

    int* output;
    cudaMalloc(&output, size*sizeof(int));

    int blocks = size/1024 + 1;
    int threads = size / blocks + 1;
    std::cout << blocks << ", " << threads << std::endl;

    swap<<<blocks, threads>>>(input, output, size);

    int* out = (int*)(malloc(size * sizeof(int)));
    cudaMemcpy( out, output, size*sizeof(int), cudaMemcpyDeviceToHost);

    std::cout << "Results: " << std::endl;
    for(int i = 0; i < size; i++) std::cout << temp[i] << ", ";
    std::cout << std::endl;
    for(int i = 0; i < size; i++) std::cout << out[i] << ", ";
    std::cout << std::endl;

    free(temp);
    free(out);
    return 0;
}



