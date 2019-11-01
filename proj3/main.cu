#include <iostream>
#include <thrust/device_vector.h>
#include <thrust/host_vector.h>
#include <stdio.h>
#include <math.h>

#include "curand.h"
#include "curand_kernel.h"

#define SIZE 1

__global__ void calc_dists(double *xpos, double *ypos, double *dists, int N) {
    //printf("%d", N);
    //int test = blockIdx.x * blockDim.x * blockDim.y + threadIdx.y * blockDim.x + threadIdx.x;
    int i = blockIdx.y * blockDim.y + threadIdx.y;
    int j = blockIdx.x * blockDim.x + threadIdx.x;
    //printf("%d, %d \n", i, j);
    dists[i*N+j] = sqrt(pow((xpos[i] - xpos[j]), 2) + pow((ypos[i] - ypos[j]), 2));
    //printf("%f ", dists[i*N+j]);
}

__global__ void shuff_vecs(double *xpos, double *ypos, int *points, int N) {
    int t_i = blockIdx.x * blockDim.x + threadIdx.x;

    curandState st;
    curand_init(0, 1, 0, &st);
    //N = 4;

    for (int i=1; i<N; i++) {
        double tmp = points[i];
        //double tmp_y = points[i];
        //double new_x = xpos[(int) ((N-i) * curand_uniform(&st) + i)];
        int rand_i = (int) ((N-i) * curand_uniform(&st) + i);
        //posx[i] = posx[rand_i];
        points[i] = points[rand_i];
        points[rand_i] = tmp;
        //posy[rand_i] = tmp_y;
        //printf("%d, ", test);
    }
    for (int i=0; i<N; i++) {
        printf("%d, ", points[i]);
    }
}

int main() {
    int N;
    std::cin >> N;

    thrust::host_vector<double> xpos(N), ypos(N), dists(N * N), points(N);
    double x, y;

    for (int i=0; i<N; i++) {
        std::cin >> x;
        std::cin >> y;
        xpos[i] = x;
        ypos[i] = y;
        points[i] = i;
    }
    //for (int i=0; i<N; i++) {
    //    std::cout << xpos[i] << " ";
    //    std::cout << ypos[i] << " ";
    //}
    //std::cout << std::endl;
    //for (int i=0; i<N*N; i++) {
    //    std::cout << dists[i] << " ";
    //}
    //std::cout << std::endl;
    //cudaMalloc((void **) &xpos, sizeof(double) * N);
    //cudaMalloc((void **) &ypos, sizeof(double) * N);
    //cudaMalloc((void **) &dists, sizeof(double) * N * N);
    thrust::device_vector<double> xpos_d(xpos), ypos_d(ypos), dists_d(dists);
    thrust::device_vector<int> points_d(points);

    dim3 threads(32, 32);
    dim3 grid(N / threads.x, N / threads.y);
    calc_dists<<<grid, threads>>>(thrust::raw_pointer_cast(xpos_d.data()),
                                  thrust::raw_pointer_cast(ypos_d.data()),
                                  thrust::raw_pointer_cast(dists_d.data()),
                                  N);
    shuff_vecs<<<SIZE, 1>>>(thrust::raw_pointer_cast(xpos_d.data()),
                               thrust::raw_pointer_cast(ypos_d.data()),
                               thrust::raw_pointer_cast(points_d.data()),
                               N);
    //dim3 threads(1024);
    //dim3 grid(SIZE);

}

