include(ExternalProject)
include(GNUInstallDirs)

set(OPENBLAS_DIR "${PROJECT_SOURCE_DIR}/third_party/OpenBLAS" CACHE STRING "OpenBLAS directory")
set(OPENBLAS_BUILD_DIR ${PROJECT_BINARY_DIR}/third_party/OpenBLAS)

set(OPENBLAS_INC ${OPENBLAS_BUILD_DIR}/include)
set(OPENBLAS_LIB ${OPENBLAS_BUILD_DIR}/${CMAKE_INSTALL_LIBDIR}/libopenblas.a)

if(${CMAKE_GENERATOR} STREQUAL "Ninja")
    set(MAKE_COMMAND make)
else()
    set(MAKE_COMMAND "$(MAKE)")
endif()

ExternalProject_add(
    openblas
    SOURCE_DIR ${OPENBLAS_DIR}
    PREFIX ${OPENBLAS_BUILD_DIR}
    CMAKE_GENERATOR "Unix Makefiles"
    CMAKE_ARGS -DCMAKE_C_COMPILER_LAUNCHER=${CMAKE_C_COMPILER_LAUNCHER} -DCMAKE_CXX_COMPILER_LAUNCHER=${CMAKE_CXX_COMPILER_LAUNCHER} -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE} -DCMAKE_INSTALL_PREFIX=${OPENBLAS_BUILD_DIR} -DCMAKE_TOOLCHAIN_FILE=${CMAKE_TOOLCHAIN_FILE} -DCMAKE_POSITION_INDEPENDENT_CODE=ON
    BUILD_COMMAND ${MAKE_COMMAND}
    BUILD_BYPRODUCTS ${OPENBLAS_LIB} ${OPENBLAS_PROTOC_EXECUTABLE}
)

file(MAKE_DIRECTORY ${OPENBLAS_INC})

add_library(libopenblas STATIC IMPORTED GLOBAL)
add_dependencies(libopenblas openblas)
set_target_properties(
    libopenblas PROPERTIES
    IMPORTED_LOCATION ${OPENBLAS_LIB}
    INTERFACE_INCLUDE_DIRECTORIES ${OPENBLAS_BUILD_DIR}/include
)
