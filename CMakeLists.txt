cmake_minimum_required(VERSION 3.21)
project(flip_index CUDA)

set(CMAKE_CUDA_STANDARD 14)

add_executable(flip_index main.cu)

set_target_properties(flip_index PROPERTIES
        CUDA_SEPARABLE_COMPILATION ON)
