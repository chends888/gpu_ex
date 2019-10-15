// how to compile: nvcc -std=c++11 FILE -o EXECUTABLE


#include <thrust/device_vector.h>
#include <thrust/host_vector.h>
#include <iostream>
#include <chrono>
#include <math.h>

int main () {
    thrust::host_vector<double> host(5);
    thrust::host_vector<double> mean(5);
    thrust::fill(thrust::host, mean.begin(), mean.end(), 500);
    std::cout << "ok";
    // fill host vector with numbers
    for (int i=0; i<host.size(); i++) {
        host.push_back(i);
    }
    // calculate variance
    auto start = std::chrono::high_resolution_clock::now();
    for (int i=0; i<host.size(); i++) {
        host[i] = host[i] - mean[i];
    }
    double sum = 0;
    for (int i=0; i<host.size(); i++) {
        sum += pow(host[i], 2);
    }
    auto finish = std::chrono::high_resolution_clock::now();
    auto time_span = (std::chrono::duration_cast<std::chrono::duration<double>>(finish-start)).count();
    std::cout << "Time using 2 vecs: " << time_span << " s" << std::endl;
    std::cout << "Variance: " << sum << std::endl;

    start = std::chrono::high_resolution_clock::now();
    sum = 0;
    thrust::transform(host.begin(), host.end(),
                      thrust::make_constant_iterator(500),
                      host.begin(),
                      thrust::minus<double>());
    for (int i=0; i<host.size(); i++) {
        sum += pow(host[i], 2);
    }
    finish = std::chrono::high_resolution_clock::now();
    time_span = (std::chrono::duration_cast<std::chrono::duration<double>>(finish-start)).count();
    std::cout << "Time using constant iterator: " << time_span << " s" << std::endl;
    std::cout << "Variance: " << sum << std::endl;

}
