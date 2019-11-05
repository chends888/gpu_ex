cmake_minimum_required(VERSION 3.9)

project (project3 LANGUAGES CXX CUDA)

add_executable(randomsol main.cu)
add_executable(locsea tsp-locsea.cpp)

find_package(OpenMP REQUIRED)
target_link_libraries(locsea OpenMP::OpenMP_CXX)


target_compile_options(randomsol PUBLIC -std=c++11 -O3)
target_compile_options(locsea PUBLIC -fopenmp)
