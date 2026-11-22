cmake_minimum_required(VERSION 3.18)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")

set(CMAKE_CXX_STANDARD 20)
set(PROJECT_VERSION 0.1)
set(PROJECT_NAME potok)
set(SRC_PATH ${CMAKE_SOURCE_DIR}/src)

if(POLICY CMP0135)
    cmake_policy(SET CMP0135 NEW)
endif()

project(${PROJECT_NAME} VERSION ${PROJECT_VERSION})

enable_testing()

include(spdlog)
include(gtest)
include(boost)

configure_file(version.h.in version.h)

set(EXT_LIB_LIST Boost::filesystem Boost::system Boost::json)

include_directories(${CMAKE_CURRENT_BINARY_DIR})
include_directories(headers)

link_directories(${CMAKE_BINARY_DIR})

add_executable(${PROJECT_NAME} main.cpp)

target_link_libraries(${PROJECT_NAME} PRIVATE 
                spdlog)
target_compile_options(${PROJECT_NAME} PRIVATE -Wall -Wextra -pedantic)
