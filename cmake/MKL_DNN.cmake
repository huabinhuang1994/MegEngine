include(ExternalProject)
include(GNUInstallDirs)

set(MKLDNN_DIR "${PROJECT_SOURCE_DIR}/third_party/intel-mkl-dnn" CACHE STRING "mkldnn directory")
set(MKLDNN_BUILD_DIR ${PROJECT_BINARY_DIR}/third_party/intel-mkl-dnn)
set(MKLDNN_LIB ${MKLDNN_BUILD_DIR}/${CMAKE_INSTALL_LIBDIR}/libdnnl.a)

if(MGE_BLAS STREQUAL "MKL")
    list(APPEND MKLDNN_BUILD_ARGS -D_DNNL_USE_MKL=ON -DMKLROOT=${MKL_ROOT_DIR})
else()
    list(APPEND MKLDNN_BUILD_ARGS -D_DNNL_USE_MKL=OFF)
endif()

ExternalProject_add(
    mkl_dnn
    SOURCE_DIR ${MKLDNN_DIR}
    PREFIX ${MKLDNN_BUILD_DIR}
    CMAKE_ARGS -DCMAKE_C_COMPILER_LAUNCHER=${CMAKE_C_COMPILER_LAUNCHER} -DCMAKE_CXX_COMPILER_LAUNCHER=${CMAKE_CXX_COMPILER_LAUNCHER} -DDNNL_BUILD_TESTS=OFF -DDNNL_BUILD_EXAMPLES=OFF -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE} -DCMAKE_INSTALL_PREFIX=${MKLDNN_BUILD_DIR} -DCMAKE_TOOLCHAIN_FILE=${CMAKE_TOOLCHAIN_FILE} -DDNNL_LIBRARY_TYPE=STATIC -DDNNL_CPU_RUNTIME=DNNL_RUNTIME_SEQ ${MKLDNN_BUILD_ARGS}
    BUILD_BYPRODUCTS ${MKLDNN_LIB}
)

set(MKLDNN_INC ${MKLDNN_BUILD_DIR}/include)
file(MAKE_DIRECTORY ${MKLDNN_INC})

add_library(libmkl_dnn STATIC IMPORTED GLOBAL)
add_dependencies(libmkl_dnn mkl_dnn)
set_target_properties(
    libmkl_dnn PROPERTIES
    IMPORTED_LOCATION ${MKLDNN_LIB}
    INTERFACE_INCLUDE_DIRECTORIES ${MKLDNN_INC}
)
