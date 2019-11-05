#include <iostream>
#include <math.h>
#include <vector>
#include <omp.h>
#include <chrono>
// For infinite
#include <limits>
// For output decimal numbers
#include <iomanip>
// For writing into file
#include <fstream>
#include <string>
// Randomizing vectors
#include <algorithm>
#include <random>

/*
How to compile and run:
clear && g++ tsp-locsea.cpp -fopenmp && echo 10 | python3 generator.py | ./a.out
*/


double dist(std::vector<double> p1, std::vector<double> p2) {
    return sqrt(pow((p1[0] - p2[0]), 2) + pow((p1[1] - p2[1]), 2));
}

double path_dist(std::vector<std::vector<double>> points) {
    double d = dist(points[points.size()-1], points[0]);
    for (int i=0; i<points.size()-1; i++) {
        d += dist(points[i], points[i+1]);
    }
    return d;
}

// https://stackoverflow.com/a/14177062/9785530
bool check_intersec(std::vector<double> p1, std::vector<double> p2, std::vector<double> q1, std::vector<double> q2) {
    return (((q1[0]-p1[0])*(p2[1]-p1[1]) - (q1[1]-p1[1])*(p2[0]-p1[0]))
            * ((q2[0]-p1[0])*(p2[1]-p1[1]) - (q2[1]-p1[1])*(p2[0]-p1[0])) < 0)
            &&
           (((p1[0]-q1[0])*(q2[1]-q1[1]) - (p1[1]-q1[1])*(q2[0]-q1[0]))
            * ((p2[0]-q1[0])*(q2[1]-q1[1]) - (p2[1]-q1[1])*(q2[0]-q1[0])) < 0);
}

void local_search(std::vector<std::vector<double>> points, double &best_cost, std::vector<std::vector<double>> &best_sol) {
    bool flag = true;
    while (flag) {
        for (int i=0; i<points.size()-1; i++) {
            for (int j=i+1; j<points.size(); j++) {
                if (j == points.size() - 1) {
                    if (check_intersec(points[i], points[i+1], points[j], points[0])) {
                        auto temp = points[i+1];
                        points[i+1] = points[j];
                        points[j] = temp;
                        flag = true;
                    }
                    else {
                        flag = false;
                    }
                }
                else {
                    if (check_intersec(points[i], points[i+1], points[j], points[j+1])) {
                        auto temp = points[i+1];
                        points[i+1] = points[j];
                        points[j] = temp;
                        flag = true;
                    }
                    else {
                        flag = false;
                    }
                }
            }
        }
    }
    auto curr_cost = path_dist(points);
    if (curr_cost > best_cost) {}
    else {
        #pragma omp critical
        {
            if (curr_cost < best_cost) {
                best_cost = curr_cost;
                best_sol = points;
            }
        }
    }
    return;
}

int main() {
    // Setting print decimal precision
    std::cout << std::fixed << std::setprecision(5);
    // Number of points
    int N;
    std::cin >> N;
    std::vector<std::vector<double>> points;
    // Positions os the points
    double x, y;
    for (int i=0; i<N; i++) {
        // Filling "points" vector
        std::vector<double> temp;
        std::cin >> x;
        std::cin >> y;
        temp.push_back(x);
        temp.push_back(y);
        temp.push_back(i);
        points.push_back(temp);
    }
    auto best_sol = points;
    double best_cost = std::numeric_limits<double>::infinity();
    auto start = std::chrono::high_resolution_clock::now();

    #pragma omp parallel
    {
        #pragma omp master
        {
            for (int i=1; i<10000; i++) {
                auto rng = std::default_random_engine {};
                #pragma omp task shared(best_cost, best_sol)
                {
                    auto tempvec = points;
                    std::random_shuffle(std::begin(tempvec), std::end(tempvec));
                    local_search(tempvec, best_cost, best_sol);
                }
            }
        }
    }
    auto finish = std::chrono::high_resolution_clock::now();
    auto time_span = (std::chrono::duration_cast<std::chrono::duration<double>>(finish-start)).count();

    std::cout << path_dist(best_sol) << " 0" << std::endl;
    for (int i=0; i<best_sol.size(); i++) {
        std::cout << int(best_sol[i][2]);
        if (i < best_sol.size()-1) {
            std::cout << " ";
        }
    }
    std::cout << std::endl;

    std::cerr << time_span << std::endl;
    return 0;
}
