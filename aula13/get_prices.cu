#include <thrust/device_vector.h>
#include <thrust/host_vector.h>
#include <thrust/reduce.h>
#include <iostream>
#include <chrono>


int main() {
    thrust::host_vector<double> host;
    while (!std::cin.eof()) {
        double temp;
        std::cin >> temp;
        host.push_back(temp);
    }
    // std::cout << host[0] << std::endl;
    auto start = std::chrono::high_resolution_clock::now();
    thrust::device_vector<double> device(host);
    auto finish = std::chrono::high_resolution_clock::now();
    auto time_span = (std::chrono::duration_cast<std::chrono::duration<double>>(finish-start)).count();
    std::cout << "Time to copy: " << time_span << " s" << std::endl;
    double mean = thrust::reduce(device.begin(), device.end(), 0, thrust::plus<double>());
    mean = mean / device.size();
    std::cout << "Mean (10 years): " << mean << std::endl;
    // return 0;
}
