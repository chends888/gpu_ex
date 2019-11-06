cmake_minimum_required(VERSION 3.9)

project (project3 LANGUAGES CXX CUDA)

add_executable(random-sol tsp-gpu-rand.cu)
add_executable(cpu-locsea tsp-cpu-locsea.cpp)

find_package(OpenMP REQUIRED)
target_link_libraries(cpu-locsea OpenMP::OpenMP_CXX)


target_compile_options(random-sol PUBLIC -std=c++11 -O3)
target_compile_options(cpu-locsea PUBLIC -fopenmp)
