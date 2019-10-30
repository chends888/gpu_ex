#include <iostream>
#include <thrust/device_vector.h>
#include <thrust/host_vector.h>
#include <stdio.h>
#include <math.h>

__global__ void calc_dists(double *xpos, double *ypos, double *dists, int N) {
    //printf("%d", N);
    //int test = blockIdx.x * blockDim.x * blockDim.y + threadIdx.y * blockDim.x + threadIdx.x;
    int i = blockIdx.y * blockDim.y + threadIdx.y;
    int j = blockIdx.x * blockDim.x + threadIdx.x;
    //printf("%d, %d \n", i, j);
    dists[i*N+j] = sqrt(pow((xpos[i] - xpos[j]), 2) + pow((ypos[i] - ypos[j]), 2));
    printf("%f ", dists[i*N+j]);
}

int main() {
    int N;
    std::cin >> N;

    thrust::host_vector<double> xpos(N), ypos(N), dists(N * N);
    double x, y;

    for (int i=0; i<N; i++) {
        // std::cin >> x;
        // std::cin >> y;
        x = 1;
        y = 2;
        xpos[i] = x;
        ypos[i] = y;
    }
    for (int i=0; i<N; i++) {
        std::cout << xpos[i] << " ";
        std::cout << ypos[i] << " ";
    }
    std::cout << std::endl;
    //for (int i=0; i<N*N; i++) {
    //    std::cout << dists[i] << " ";
    //}
    //std::cout << std::endl;
    //cudaMalloc((void **) &xpos, sizeof(double) * N);
    //cudaMalloc((void **) &ypos, sizeof(double) * N);
    //cudaMalloc((void **) &dists, sizeof(double) * N * N);
    thrust::device_vector<double> xpos_d(xpos), ypos_d(ypos), dists_d(dists);

    dim3 threads(32, 32);
    dim3 grid(N / threads.x, N / threads.y);
    calc_dists<<<grid, threads>>>(thrust::raw_pointer_cast(xpos_d.data()),
                                  thrust::raw_pointer_cast(ypos_d.data()),
                                  thrust::raw_pointer_cast(dists_d.data()),
                                  N);
}

