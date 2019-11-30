#include <iostream>
#include <math.h>
#include <vector>

#include <iomanip>

#include <chrono>
// For writing into file
#include <fstream>
#include <string>

// Boost mpi
#include <boost/mpi.hpp>
#include <boost/serialization/vector.hpp>


/*
How to compile and run:
clear && mpicxx exaust_enum.cpp -lboost_mpi -lboost_serialization
mpiexec --oversubscribe -n 5 ./a.out < inputs/in8
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

double backtrack(std::vector<std::vector<double>> points, int idx, double curr_cost, double best_cost, std::vector<int> curr_sol, std::vector<bool> used, std::vector<int> &best_sol, boost::mpi::communicator world) {
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
            if (idx == 1) {
                if (i % world.size() == world.rank()) {
                    best_cost = backtrack(points, idx+1, new_cost, best_cost, curr_sol, used, best_sol, world);
                }
            }
            else {
                best_cost = backtrack(points, idx+1, new_cost, best_cost, curr_sol, used, best_sol, world);
            }

            used[i] = false;
            curr_sol[idx] = -1;
        }
    }
    return best_cost;
}

int main(int argc, char *argv[]) {
    boost::mpi::environment env{argc, argv};
    boost::mpi::communicator world;

    // Setting print decimal precision
    std::cout << std::fixed << std::setprecision(5);

    std::vector<std::vector<double>> points;
    // Positions os the point's x and y
    double x, y;
    int N;
    if (world.rank() == 0) {
        std::cin >> N;
        for (int i=0; i<N; i++) {
            std::vector<double> temp;
            std::cin >> x;
            std::cin >> y;
            temp.push_back(x);
            temp.push_back(y);
            points.push_back(temp);
        }
    }
    auto start = std::chrono::high_resolution_clock::now();

    broadcast(world, points, 0);
    broadcast(world, N, 0);
    std::vector<bool> used(N, false);
    std::vector<int> curr_sol(N, -1);
    std::vector<int> best_sol(N, -1);
    curr_sol[0] = 0;
    used[0] = true;
    double best_cost = backtrack(points, 1, 0, INFINITY, curr_sol, used, best_sol, world);
    if (world.rank() != 0) {
        world.send(0, 0, best_sol);
        world.send(0, 1, best_cost);
    }
    if (world.rank() == 0) {
        if (world.size() > 1) {
            for (int i=1; i<world.size(); i++) {
                std::vector<int> tmp_sol;
                double tmp_cost;
                world.recv(i, 0, tmp_sol);
                world.recv(i, 1, tmp_cost);
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

        std::cerr << std::endl << time_span << " s" << std::endl;
        /* Writing results to file */
        std::string test = "ex_enum10";
        std::ofstream myfile;
        myfile.open ("../results/" + test + ".json");
        myfile << "{\n    ";
        myfile << '"' << "mean" << '"' << ": " << (double)time_span << "\n}";
        std::cerr << "Wrote results to: " << test << ".json" << std::endl;
    }
    return 0;
}