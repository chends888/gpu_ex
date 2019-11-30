cmake_minimum_required(VERSION 3.9)

project (project2)



add_executable(seq tsp-seq.cpp)
add_executable(seq-opt tsp-seq.cpp)

add_executable(par1 tsp-par1.cpp)
add_executable(par1-opt tsp-par1.cpp)

add_executable(locsea tsp-locsea.cpp)
add_executable(locsea-opt tsp-locsea.cpp)

add_executable(bb tsp-bb.cpp)
add_executable(bb-opt tsp-bb.cpp)

add_executable(locsea-bb tsp-locsea-bb.cpp)
add_executable(locsea-bb-opt tsp-locsea-bb.cpp)



find_package(OpenMP REQUIRED)
target_link_libraries(par1 OpenMP::OpenMP_CXX)
target_link_libraries(par1-opt OpenMP::OpenMP_CXX)

target_link_libraries(locsea OpenMP::OpenMP_CXX)
target_link_libraries(locsea-opt OpenMP::OpenMP_CXX)

target_link_libraries(bb OpenMP::OpenMP_CXX)
target_link_libraries(bb-opt OpenMP::OpenMP_CXX)

target_link_libraries(locsea-bb OpenMP::OpenMP_CXX)
target_link_libraries(locsea-bb-opt OpenMP::OpenMP_CXX)



target_compile_options(seq PUBLIC)
target_compile_options(seq-opt PUBLIC -O3)

target_compile_options(par1 PUBLIC -fopenmp)
target_compile_options(par1-opt PUBLIC -O3 -fopenmp)

target_compile_options(locsea PUBLIC -fopenmp)
target_compile_options(locsea-opt PUBLIC -O3 -fopenmp)

target_compile_options(bb PUBLIC -fopenmp)
target_compile_options(bb-opt PUBLIC -O3 -fopenmp)

target_compile_options(locsea-bb PUBLIC -fopenmp)
target_compile_options(locsea-bb-opt PUBLIC -O3 -fopenmp)