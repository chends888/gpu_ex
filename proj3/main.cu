#include <iostream>
int main() {
    int N;
    std::cin >> N;

    double *xpos(double*) malloc(sizeof(double)*N);
    double *ypos(double*) malloc(sizeof(double)*N);

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
}