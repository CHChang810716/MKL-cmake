cmake_minimum_required(VERSION 3.10.0)

project(mkl-cmake-test LANGUAGES C CXX)
find_package(mkl CONFIG REQUIRED)
add_executable(test_main main.cpp)
target_link_libraries(test_main mkl::mkl)
# target_link_libraries(test_main ${MKLMLLIB} ${MKLIOMP5LIB})
# target_include_directories(test_main PRIVATE ${MKL_INCLUDE_DIR})