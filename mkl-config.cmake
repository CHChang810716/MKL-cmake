get_filename_component(PACKAGE_PREFIX_DIR "${CMAKE_CURRENT_LIST_DIR}/../../../" ABSOLUTE)
if(PACKAGE_PREFIX_DIR STREQUAL "/")
  set(PACKAGE_PREFIX_DIR "")
endif()

message(STATUS "MKL prefix: ${PACKAGE_PREFIX_DIR}")

find_library(MKLIOMP5LIB
  NAMES "iomp5" "iomp5md" "libiomp5" "libiomp5md"
  PATHS ${PACKAGE_PREFIX_DIR}/lib
  NO_DEFAULT_PATH
)
if(NOT MKLIOMP5LIB)
  message(FATAL_ERROR "mkl iomp5 not found")
endif()
find_library(MKLMLLIB
  NAMES "mklml" "libmklml" "mklml_gnu"
  PATHS ${PACKAGE_PREFIX_DIR}/lib
  NO_DEFAULT_PATH
)
message(STATUS "MKLMLLIB: ${MKLMLLIB}")
if(NOT MKLMLLIB)
  message(FATAL_ERROR "mklml not found")
endif()

set(MKL_INCLUDE_DIR ${PACKAGE_PREFIX_DIR}/include)
message(STATUS "MKL_INCLUDE_DIR: ${MKL_INCLUDE_DIR}")

add_library(mkl::mkl UNKNOWN IMPORTED)
set_target_properties(mkl::mkl PROPERTIES
  INTERFACE_INCLUDE_DIRECTORIES "${MKL_INCLUDE_DIR}"
  INTERFACE_LINK_LIBRARIES "${MKLIOMP5LIB}"
)
set_target_properties(mkl::mkl PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "C"
  IMPORTED_LOCATION "${MKLMLLIB}"
)
mark_as_advanced(MKLMLLIB MKL_INCLUDE_DIR MKLIOMP5LIB)