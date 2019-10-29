#include <iostream>
#include <thrust/device_vector.h>
#include <thrust/host_vector.h>

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
        xpos.push_back(x);
        ypos.push_back(y);
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

}
