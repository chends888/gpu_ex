#include <iostream>
#include <thrust/device_vector.h>
#include <thrust/host_vector.h>
#include <stdio.h>
#include <math.h>

#include "curand.h"
#include "curand_kernel.h"

#define ITER 10000



__global__ void calc_dists(double *xpos, double *ypos, double *dists, int N) {
    int i = blockIdx.y * blockDim.y + threadIdx.y;
    int j = blockIdx.x * blockDim.x + threadIdx.x;
    dists[i * N + j] = sqrt(pow((xpos[i] - xpos[j]), 2) + pow((ypos[i] - ypos[j]), 2));
}

__global__ void calc_path_dists(int *all_paths, double* path_dists, double *dists, int N) {
    int t_i = blockIdx.x * blockDim.x + threadIdx.x;
    if (t_i >= N * ITER) return;

    curandState st;
    curand_init(0, t_i, 0, &st);
    for (int i=0; i<N; i++) {
        all_paths[(t_i * N) + i] = i;
    }

    for (int i=1; i<N; i++) {
        int tmp = all_paths[N * t_i + i];
        int rand_i = (int) ((N - i) * curand_uniform(&st) + i);
        all_paths[N * t_i + i] = all_paths[N * t_i + rand_i];
        all_paths[N * t_i + rand_i] = tmp;
    }

    double path_dist;
    for (int i=0; i<N; i++) {
        path_dist += dists[all_paths[t_i * N + i] * N + all_paths[t_i * N + i + 1]];
    }
    path_dist += dists[all_paths[N - 1]];
    path_dists[t_i] = path_dist;
    //path_dists[t_i] += dists[all_paths[N - 1]];

}

int main() {
    int N;
    std::cin >> N;
    //long steps = 5000;

    thrust::host_vector<double> xpos(N), ypos(N);
    //thrust::host_vector<int> all_paths(N * steps);
    double x, y;

    for (int i=0; i<N; i++) {
        std::cin >> x;
        std::cin >> y;
        xpos[i] = x;
        ypos[i] = y;
        //points[i] = i;
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
    thrust::device_vector<double> xpos_d(xpos), ypos_d(ypos), dists_d(N * N), path_dists_d(ITER);
    thrust::device_vector<int> all_paths_d(N * ITER);

    dim3 threads(32, 32);
    dim3 grid(N / threads.x, N / threads.y);

    cudaEvent_t start, stop;
    cudaEventCreate(&start);
    cudaEventCreate(&stop);
    cudaEventRecord(start, NULL);

    calc_dists<<<grid, threads>>>(thrust::raw_pointer_cast(xpos_d.data()),
                                  thrust::raw_pointer_cast(ypos_d.data()),
                                  thrust::raw_pointer_cast(dists_d.data()),
                                  N);
    calc_path_dists<<<ceil(ITER/1024.0), 1024>>>(thrust::raw_pointer_cast(all_paths_d.data()),
                                 thrust::raw_pointer_cast(path_dists_d.data()),
                                 thrust::raw_pointer_cast(dists_d.data()),
                                    N);
    cudaEventRecord(stop, NULL);
    cudaEventSynchronize(stop);
    float msecTotal = 0.0f;
    cudaEventElapsedTime(&msecTotal, start, stop);

    thrust::device_vector<double>::iterator min = thrust::min_element(path_dists_d.begin(), path_dists_d.end());
    int min_idx = min - path_dists_d.begin();
    double min_val = *min;
    //printf("%d\n", min_idx);
    printf("%f 0\n", min_val);

    for (int i=min_idx*N; i<(min_idx+1)*N; i++) {
        std::cout << all_paths_d[i] << " ";
    }
    printf("\n");

    std::cerr << msecTotal/1000 << " s" << std::endl;

}
