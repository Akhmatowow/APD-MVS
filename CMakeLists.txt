cmake_minimum_required (VERSION 2.8)
project (APD)

set(Boost_USE_STATIC_LIBS ON)
set(Boost_USE_MULTITHREADED ON)
set(Boost_USE_STATIC_RUNTIME OFF)

# recommend >=3.3.0
find_package(OpenCV REQUIRED)
# recommend >=1.62.0
find_package(Boost REQUIRED COMPONENTS filesystem system)
# recommend >=10.2.
find_package(CUDA REQUIRED )

include_directories(
${OpenCV_INCLUDE_DIRS}
${Boost_INCLUDE_DIRS})
include_directories(.)

# Adjust CUDA_NVCC_FLAGS for NVIDIA Tesla P100-PCIE
set(CUDA_NVCC_FLAGS ${CUDA_NVCC_FLAGS};-O3 --use_fast_math --maxrregcount=128 --ptxas-options=-v -std=c++11 --compiler-options -Wall -gencode arch=compute_60,code=sm_60)

if(CMAKE_COMPILER_IS_GNUCXX)
    add_definitions(-std=c++11)
    add_definitions(-pthread)
    add_definitions(-Wall)
    add_definitions(-Wextra)
    add_definitions(-pedantic)
    add_definitions(-Wno-unused-function)
    add_definitions(-Wno-switch)
    set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_C_FLAGS_RELEASE} -O3 -ffast-math -march=native")
endif()

cuda_add_executable(
    APD
    main.h
    APD.h
    APD.cpp
    APD.cu
    main.cpp
)

target_link_libraries(APD
"${Boost_LIBRARIES}"
"${OpenCV_LIBS}"
)
