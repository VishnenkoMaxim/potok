# Downloads and builds Google Test from upstream sources.
#
# Change GTEST_GIT_TAG below to use a different version.
# Supported values: release tag (e.g. v1.17.0), branch name, or a commit hash.

include(FetchContent)

set(GTEST_GIT_TAG "v1.17.0" CACHE STRING "googletest version to build.")

set(BUILD_GMOCK OFF CACHE BOOL "" FORCE)
set(INSTALL_GTEST OFF CACHE BOOL "" FORCE)
set(GTEST_HAS_ABSL OFF CACHE BOOL "" FORCE)
set(gtest_build_tests OFF CACHE BOOL "" FORCE)
set(gtest_build_samples OFF CACHE BOOL "" FORCE)

if(GTEST_GIT_TAG MATCHES "^v[0-9]")
    if(POLICY CMP0135)
        FetchContent_Declare(
            googletest
            URL "https://github.com/google/googletest/archive/refs/tags/${GTEST_GIT_TAG}.tar.gz"
            DOWNLOAD_EXTRACT_TIMESTAMP TRUE
        )
    else()
        FetchContent_Declare(
            googletest
            URL "https://github.com/google/googletest/archive/refs/tags/${GTEST_GIT_TAG}.tar.gz"
        )
    endif()
else()
    FetchContent_Declare(
        googletest
        GIT_REPOSITORY https://github.com/google/googletest.git
        GIT_TAG        ${GTEST_GIT_TAG}
        GIT_SHALLOW    TRUE
        GIT_PROGRESS   TRUE
    )
endif()

FetchContent_MakeAvailable(googletest)

add_library(potok_gtest INTERFACE)
target_link_libraries(potok_gtest INTERFACE GTest::gtest)

add_library(potok_gtest_main INTERFACE)
target_link_libraries(potok_gtest_main INTERFACE GTest::gtest_main)

add_library(potok::gtest ALIAS potok_gtest)
add_library(potok::gtest_main ALIAS potok_gtest_main)
