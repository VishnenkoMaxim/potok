# Downloads and builds the Boost C++ libraries from upstream sources.
#
# Change BOOST_GIT_TAG below to use a different version.
# Supported values: release tag (e.g. boost-1.91.0-1), branch name, or a commit hash.

include(FetchContent)

set(BOOST_GIT_TAG "boost-1.91.0-1" CACHE STRING "Boost version to build.")

set(BOOST_INCLUDE_LIBRARIES filesystem system json program_options algorithm range asio beast CACHE STRING "" FORCE)
set(BUILD_SHARED_LIBS OFF CACHE BOOL "" FORCE)

set(_POTOK_SAVED_BUILD_TESTING "${BUILD_TESTING}")
set(BUILD_TESTING OFF CACHE BOOL "" FORCE)

if(BOOST_GIT_TAG MATCHES "^boost-")
    if(POLICY CMP0135)
        FetchContent_Declare(
            boost_upstream
            URL "https://github.com/boostorg/boost/releases/download/${BOOST_GIT_TAG}/${BOOST_GIT_TAG}-cmake.tar.xz"
            DOWNLOAD_EXTRACT_TIMESTAMP TRUE
        )
    else()
        FetchContent_Declare(
            boost_upstream
            URL "https://github.com/boostorg/boost/releases/download/${BOOST_GIT_TAG}/${BOOST_GIT_TAG}-cmake.tar.xz"
        )
    endif()
else()
    FetchContent_Declare(
        boost_upstream
        GIT_REPOSITORY https://github.com/boostorg/boost.git
        GIT_TAG        ${BOOST_GIT_TAG}
        GIT_SHALLOW    TRUE
        GIT_PROGRESS   TRUE
    )
endif()

FetchContent_MakeAvailable(boost_upstream)

set(BUILD_TESTING "${_POTOK_SAVED_BUILD_TESTING}" CACHE BOOL "" FORCE)
unset(_POTOK_SAVED_BUILD_TESTING)

