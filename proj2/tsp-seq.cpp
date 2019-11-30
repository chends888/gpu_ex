#include <iostream>
#include <math.h>
#include <vector>
#include <limits>
#include <iomanip>
#include <chrono>
// For writing into file
#include <fstream>
#include <string>


/*
How to compile and run:
clear && g++ tsp-seq.cpp && echo 10 | python3 generator.py | ./a.out
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

double backtrack(std::vector<std::vector<double>> points, int idx, double curr_cost, double best_cost, std::vector<int> curr_sol, std::vector<bool> used, std::vector<int> &best_sol) {
    if (idx == points.size()) {
        curr_cost += dist(points[curr_sol[0]], points[curr_sol[curr_sol.size()-1]]);
        if (curr_cost < best_cost) {
            best_sol = curr_sol;
            best_cost = curr_cost;
        }
        return best_cost;
    }
    for (int i=0; i<points.size(); i++) {
        if (!used[i]) {
            used[i] = true;
            curr_sol[idx] = i;
            double new_cost = curr_cost + dist(points[curr_sol[idx-1]], points[curr_sol[idx]]);
            best_cost = backtrack(points, idx+1, new_cost, best_cost, curr_sol, used, best_sol);

            used[i] = false;
            curr_sol[idx] = -1;
        }
    }
    return best_cost;
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
    std::vector<int> curr_sol;
    std::vector<int> best_sol;
    std::vector<bool> used;
    for (int i=0; i<N; i++) {
        // Filling "points" vector
        std::vector<double> temp;
        std::cin >> x;
        std::cin >> y;
        temp.push_back(x);
        temp.push_back(y);
        points.push_back(temp);

        // Filling "used" vector
        used.push_back(false);
        // Filling "curr_sol" and "best_sol" vectors
        curr_sol.push_back(-1);
        best_sol.push_back(-1);
    }
    curr_sol[0] = 0;
    used[0] = true;
    auto start = std::chrono::high_resolution_clock::now();
    backtrack(points, 1, 0, std::numeric_limits<double>::infinity(), curr_sol, used, best_sol);
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