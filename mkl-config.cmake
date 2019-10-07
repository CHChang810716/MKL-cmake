get_filename_component(PACKAGE_PREFIX_DIR "${CMAKE_CURRENT_LIST_DIR}/../../" ABSOLUTE)
message(STATUS "MKL prefix: ${PACKAGE_PREFIX_DIR}")

find_library(MKLIOMP5LIB
  NAMES "iomp5" "iomp5md" "libiomp5" "libiomp5md"
  HINTS ${PACKAGE_PREFIX_DIR}/lib
)
if(NOT MKLIOMP5LIB)
  message(FATAL_ERROR "mkl iomp5 not found")
endif()