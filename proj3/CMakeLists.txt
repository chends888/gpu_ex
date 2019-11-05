cmake_minimum_required(VERSION 3.9)

project (project3 LANGUAGES CXX CUDA)

add_executable(randomsol main.cu)

target_compile_options(randomsol PUBLIC -std=c++11 -O3)

