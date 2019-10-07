
cmake_minimum_required(VERSION 3.10.0)

project(mkl-cmake-wrapper VERSION 0.19)

include(ExternalProject) # ExternalProject_Add

macro(ep_add url sha1str)
  ExternalProject_Add(
      "MKL"
      URL ${url}
      URL_HASH
        SHA1=${sha1str}
      DOWNLOAD_DIR
        "${CMAKE_BINARY_DIR}/download"
      SOURCE_DIR
        "${CMAKE_BINARY_DIR}/source"
      CONFIGURE_COMMAND ""
      BUILD_COMMAND ""
      INSTALL_COMMAND
        "${CMAKE_COMMAND}"
        "-Dfrom=${CMAKE_BINARY_DIR}/source"
        "-Dto=${CMAKE_BINARY_DIR}/install"
        -P "${CMAKE_SOURCE_DIR}/copy-from-to.cmake"
      COMMAND # Copy license files
        "${CMAKE_COMMAND}"
        "-Dlicense_file=${CMAKE_BINARY_DIR}/source/license.txt"
        "-Dto=${CMAKE_INSTALL_PREFIX}/licenses/MKL"
        -P "${CMAKE_SOURCE_DIR}/copy-license.cmake"
  )
endmacro()
if(WIN32)
  ep_add(
    "https://github.com/intel/mkl-dnn/releases/download/v0.19/mklml_win_2019.0.5.20190502.zip"
    "9d6ff4d5a486689338158093e96c43ee442b65f0"
  )
elseif(APPLE)
  ep_add(
    "https://github.com/intel/mkl-dnn/releases/download/v0.19/mklml_mac_2019.0.5.20190502.tgz"
    "a1c42af04f990b0e515a1c31946424b2e68fccc9"
  )
elseif(UNIX)
  ep_add(
    "https://github.com/intel/mkl-dnn/releases/download/v0.19/mklml_lnx_2019.0.5.20190502.tgz"
    "6ab490f0b358124338d04ee9383c3cbc536969d8"
  )
else()
  message(FATAL_ERROR "Platform not supported")
endif()

include(GNUInstallDirs)
install(
  DIRECTORY ${CMAKE_BINARY_DIR}/install/include/ 
  DESTINATION ${CMAKE_INSTALL_PREFIX}/include
)
install(
  DIRECTORY ${CMAKE_BINARY_DIR}/install/lib/ 
  DESTINATION ${CMAKE_INSTALL_PREFIX}/lib
)
install(
  FILES ${CMAKE_SOURCE_DIR}/mkl-config.cmake 
  DESTINATION ${CMAKE_INSTALL_PREFIX}/lib/cmake/mkl
)