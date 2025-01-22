cmake_minimum_required(VERSION 3.30)

project(gperf
  VERSION 3.1
  LANGUAGES C CXX
)

include(GNUInstallDirs)
include(CMakePackageConfigHelpers)

add_library(gp STATIC
  lib/getline.cc
  lib/getopt.c
  lib/getopt1.c
  lib/hash.cc
)
target_include_directories(gp PUBLIC lib)

add_executable(gperf
  src/bool-array.cc
  src/hash-table.cc
  src/input.cc
  src/keyword-list.cc
  src/keyword.cc
  src/main.cc
  src/options.cc
  src/output.cc
  src/positions.cc
  src/search.cc
  src/version.cc
)
target_link_libraries(gperf
  PRIVATE gp
)
target_compile_definitions(gperf
  PRIVATE $<$<CONFIG:Release,MinSizeRel>:__OPTIMIZE__>
)

configure_package_config_file(config.cmake.in
  ${CMAKE_CURRENT_BINARY_DIR}/gperf-config.cmake
  INSTALL_DESTINATION ${CMAKE_INSTALL_DATAROOTDIR}/gperf
)
write_basic_package_version_file(
  ${CMAKE_CURRENT_BINARY_DIR}/gperf-version.cmake
  VERSION ${PROJECT_VERSION}
  COMPATIBILITY AnyNewerVersion
)

install(TARGETS gperf
  EXPORT gperf-targets
)

install(EXPORT gperf-targets
  DESTINATION ${CMAKE_INSTALL_DATAROOTDIR}/gperf
  NAMESPACE unofficial::gperf::
)
install(FILES
  ${CMAKE_CURRENT_BINARY_DIR}/gperf-config.cmake
  ${CMAKE_CURRENT_BINARY_DIR}/gperf-version.cmake
  DESTINATION ${CMAKE_INSTALL_DATAROOTDIR}/gperf
)
