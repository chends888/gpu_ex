cmake_minimum_required(VERSION 3.9)

project (project4)


find_package(Boost REQUIRED mpi serialization)
find_package(MPI)

add_executable(loc_sea loc_sea.cpp)

target_link_libraries(loc_sea Boost::mpi)
target_link_libraries(loc_sea MPI::MPI_CXX)

add_executable(ex_enum exaust_enum.cpp)

target_link_libraries(ex_enum Boost::mpi)
target_link_libraries(ex_enum MPI::MPI_CXX)