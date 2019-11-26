#include <iostream>
#include <math.h>
#include <vector>

#include <iomanip>
// Setting print decimal precision
std::cout << std::fixed << std::setprecision(5);

#include <chrono>
// For writing into file
// #include <fstream>
// #include <string>

// Boost mpi
#include <boost/mpi.hpp>
#include <boost/serialization/vector.hpp>


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
            // std::cout << curr_sol[idx-1] << std::endl;
            double new_cost = curr_cost + dist(points[curr_sol[idx-1]], points[curr_sol[idx]]);
            best_cost = backtrack(points, idx+1, new_cost, best_cost, curr_sol, used, best_sol);

            used[i] = false;
            curr_sol[idx] = -1;
        }
    }
    return best_cost;
}

int main(int argc, char *argv[]) {
    boost::mpi::environment env{argc, argv};
    boost::mpi::communicator world;

    // Number of points
    int N;
    std::cin >> N;
    std::vector<std::vector<double>> points;
    // Positions os the points
    double x, y;
    double best_cost = INFINITY;
    double curr_cost;
    std::vector<int> curr_sol;
    std::vector<int> best_sol;
    std::vector<bool> used;
    int idx = 1;
    if (world.rank() == 0) {
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
    }
    curr_sol[0] = 0;
    used[0] = true;
    // curr_sol[1] = 1;
    // used[1] = true;
    // used[2] = true;
    // used[3] = true;
    if (world.rank() == 0) {
        auto start = std::chrono::high_resolution_clock::now();
        for (int i=0; i<points.size(); i++) {
            if (!used[i]) {
                used[i] = true;
                curr_sol[idx] = i;
                // std::cout << curr_sol[idx-1] << std::endl;
                double new_cost = curr_cost + dist(points[curr_sol[idx-1]], points[curr_sol[idx]]);
                best_cost = backtrack(points, idx+1, new_cost, best_cost, curr_sol, used, best_sol);
                world.send(0, 0, idx+1);
                world.send(0, 1, new_cost);
                world.send(0, 2, used);
                world.send(0, 3, curr_sol);

                used[i] = false;
                curr_sol[idx] = -1;
            }
        }
    }
    else {
        world.recv(0, 0, idx);
        world.recv(0, 1, curr_cost);
        world.recv(0, 2, used);
        world.recv(0, 3, curr_sol);
        curr_cost = backtrack(points, 1, curr_cost, best_cost, curr_sol, used, best_sol);
        if (curr_cost < best_cost) {
            best_cost = curr_cost;
        }
    }
    if (world.rank() != 0) {
        world.send(0, 0, best_sol);
        world.send(0, 1, best_cost);
    }
    if (world.rank() == 0) {
        if (world.size() > 1) {
            for (int i=1; i<world.size(); i++) {
                std::vector<std::vector<double>> tmp_sol;
                double tmp_cost;
                world.recv(i, 0, tmp_sol);
                world.recv(i, 1, tmp_cost);
                // std::cout << tmp_cost << std::endl;
                if (tmp_cost < best_cost) {
                    best_cost = tmp_cost;
                    best_sol = tmp_sol;
                }
            }
        }
        auto finish = std::chrono::high_resolution_clock::now();
        auto time_span = (std::chrono::duration_cast<std::chrono::duration<double>>(finish-start)).count();

        std::cout << best_cost << " 1" << std::endl;
        for (int i=0; i<best_sol.size(); i++) {
            std::cout << best_sol[i];
            if (i < best_sol.size()-1) {
                std::cout << " ";
            }
        }
        std::cout << std::endl;
        std::cerr << time_span << std::endl;
    }
    return 0;
}