#include <iostream>
#include <math.h>
#include <vector>
#include <omp.h>
#include <chrono>

// For output decimal numbers
#include <iomanip>

// For writing into file
#include <fstream>
#include <string>

// Randomizing vectors
#include <algorithm>
#include <random>

// Boost mpi
#include <boost/mpi.hpp>
#include <boost/serialization/vector.hpp>


/*
How to compile and run:
mpicxx loc_sea.cpp -lboost_mpi -lboost_serialization
mpiexec --oversubscribe -n 5 ./a.out < inputs/in10
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
        if (curr_cost < best_cost) {
            best_cost = curr_cost;
            best_sol = points;
        }
    return;
}


int main(int argc, char *argv[]) {
    boost::mpi::environment env{argc, argv};
    boost::mpi::communicator world;

    std::vector<std::vector<double>> points, best_sol;
    double best_cost = INFINITY;
    
    if (world.rank() == 0) {

        // Number of points
        int N;
        std::cin >> N;
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
        best_sol = points;
    }
    auto start = std::chrono::high_resolution_clock::now();
    broadcast(world, points, 0);

    for (int i=0; i<10000; i++) {
        auto tempvec = points;
        std::default_random_engine seed(world.rank());
        // std::default_random_engine seed(std::chrono::system_clock::now().time_since_epoch().count());
        std::shuffle(tempvec.begin() + 1, tempvec.end(), seed);
        local_search(tempvec, best_cost, best_sol);
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

        // Setting print decimal precision
        std::cout << std::fixed << std::setprecision(5);
        std::cout << path_dist(best_sol) << " 0" << std::endl;
        for (int i=0; i<best_sol.size(); i++) {
            std::cout << int(best_sol[i][2]);
            if (i < best_sol.size()-1) {
                std::cout << " ";
            }
        }

        std::cerr << std::endl << time_span << " s" << std::endl;
        /* Writing results to file */
        std::string test = "loc_sea10";
        std::ofstream myfile;
        myfile.open ("../results/" + test + ".json");
        myfile << "{\n    ";
        myfile << '"' << "mean" << '"' << ": " << (double)time_span << "\n}";
        std::cerr << "Wrote results to: " << test << ".json" << std::endl;
    }


    return 0;
}