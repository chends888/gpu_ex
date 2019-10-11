#include <thrust/device_vector.h>
#include <thrust/host_vector.h>
#include <iostream>


int main() {
    thrust::host_vector<double> host();
    while (!cin.eof()) {
        double temp;
        cin >> temp;
        host.push_back(temp);
    }
    // return 0;
}