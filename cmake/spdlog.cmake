# Downloads and builds the spdlog C++ logging library from upstream sources.
#
# Change SPDLOG_GIT_TAG below to use a different version.
# Supported values: release tag (e.g. v1.17.0), branch name, or a commit hash.

include(FetchContent)

set(SPDLOG_GIT_TAG "v1.17.0" CACHE STRING "spdlog version to build.")

set(SPDLOG_BUILD_SHARED OFF CACHE BOOL "" FORCE)
set(SPDLOG_BUILD_EXAMPLE OFF CACHE BOOL "" FORCE)
set(SPDLOG_BUILD_TESTS OFF CACHE BOOL "" FORCE)
set(SPDLOG_BUILD_BENCH OFF CACHE BOOL "" FORCE)
set(SPDLOG_INSTALL OFF CACHE BOOL "" FORCE)
set(SPDLOG_SANITIZE_ADDRESS OFF CACHE BOOL "" FORCE)
set(SPDLOG_SANITIZE_THREAD OFF CACHE BOOL "" FORCE)

if(SPDLOG_GIT_TAG MATCHES "^v[0-9]")
    if(POLICY CMP0135)
        FetchContent_Declare(
            spdlog
            URL "https://github.com/gabime/spdlog/archive/refs/tags/${SPDLOG_GIT_TAG}.tar.gz"
            DOWNLOAD_EXTRACT_TIMESTAMP TRUE
        )
    else()
        FetchContent_Declare(
            spdlog
            URL "https://github.com/gabime/spdlog/archive/refs/tags/${SPDLOG_GIT_TAG}.tar.gz"
        )
    endif()
else()
    FetchContent_Declare(
        spdlog
        GIT_REPOSITORY https://github.com/gabime/spdlog.git
        GIT_TAG        ${SPDLOG_GIT_TAG}
        GIT_SHALLOW    TRUE
        GIT_PROGRESS   TRUE
    )
endif()

FetchContent_MakeAvailable(spdlog)

add_library(potok_spdlog INTERFACE)
target_link_libraries(potok_spdlog INTERFACE spdlog::spdlog)

add_library(potok::spdlog ALIAS potok_spdlog)
