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
clear && g++ tsp-par1.cpp -fopenmp && echo 10 | python3 generator.py | ./a.out
*/


double dist(std::vector<double> p1, std::vector<double> p2) {
    return sqrt(pow((p1[0] - p2[0]), 2) + pow((p1[1] - p2[1]), 2));
}

double path_dist(std::vector<int> sol, std::vector<std::vector<double>> points) {
    double d = dist(points[sol[sol.size()-1]], points[sol[0]]);
    for (int i=0; i<sol.size()-1; i++) {
        d += dist(points[sol[i]], points[sol[i+1]]);
    }
    return d;
}

double path_dist_loc(std::vector<std::vector<double>> points) {
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

void local_search(std::vector<std::vector<double>> points, double &best_cost) {
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
    auto curr_cost = path_dist_loc(points);
    if (curr_cost > best_cost) {}
    else {
        #pragma omp critical
        {
            if (curr_cost < best_cost) {
                best_cost = curr_cost;
            }
        }
    }
    return;
}



void branch_n_bound(std::vector<std::vector<double>> points, int idx, double curr_cost, double &best_cost, std::vector<int> curr_sol, std::vector<bool> used, std::vector<int> &best_sol, int start = 0) {
    if (curr_cost > best_cost) {
        return;
    }
    if (idx == points.size()) {
        curr_cost += dist(points[curr_sol[0]], points[curr_sol[curr_sol.size()-1]]);
        if (curr_cost > best_cost){}
        else {
            #pragma omp critical
            {
                if (curr_cost > best_cost) {
                }
                else {
                    best_cost = curr_cost;
                    best_sol = curr_sol;
                }
            }
        }
        return;
    }
    int max_iter = points.size();
    if (start) {
        max_iter = start + 1;
    }
    for (int i=start; i<max_iter; i++) {
        if (!used[i]) {
            used[i] = true;
            curr_sol[idx] = i;
            double new_cost = curr_cost + dist(points[curr_sol[idx-1]], points[curr_sol[idx]]);
            branch_n_bound(points, idx+1, new_cost, best_cost, curr_sol, used, best_sol);

            used[i] = false;
            curr_sol[idx] = -1;
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
    // Points vector for branch and bound
    std::vector<std::vector<double>> points;
    // Points vector for local search
    std::vector<std::vector<double>> points_loc;
    // Positions os the points
    double x, y;
    std::vector<int> best_sol(N, -1);
    for (int i=0; i<N; i++) {
        // Filling "points" vector
        std::vector<double> temp;
        std::cin >> x;
        std::cin >> y;
        temp.push_back(x);
        temp.push_back(y);
        points.push_back(temp);
        temp.push_back(i);
        points_loc.push_back(temp);
    }
    double best_cost = std::numeric_limits<double>::infinity();
    auto start = std::chrono::high_resolution_clock::now();
    #pragma omp parallel
    {
        #pragma omp master
        {
            for (int i=1; i<200; i++) {
                auto rng = std::default_random_engine {};
                #pragma omp task shared(best_cost)
                {
                    auto tempvec = points_loc;
                    std::random_shuffle(std::begin(tempvec), std::end(tempvec));
                    local_search(tempvec, best_cost);
                }
            }

            for (int i=1; i<N; i++) {
                #pragma omp task shared(best_sol, best_cost)
                {
                    std::vector<bool> used(N, false);
                    used[0] = true;
                    std::vector<int> curr_sol(N, -1);
                    curr_sol[0] = 0;
                    branch_n_bound(points, 1, 0, best_cost, curr_sol, used, best_sol, i);
                }
            }
        }
    }
    auto finish = std::chrono::high_resolution_clock::now();
    auto time_span = (std::chrono::duration_cast<std::chrono::duration<double>>(finish-start)).count();

    std::cout << path_dist(best_sol, points) << " 1" << std::endl;
    for (int i=0; i<best_sol.size(); i++) {
        std::cout << best_sol[i];
        if (i < best_sol.size()-1) {
            std::cout << " ";
        }
    }
    std::cout << std::endl;

    std::cerr << time_span << std::endl;
    return 0;
}