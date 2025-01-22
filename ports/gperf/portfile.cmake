vcpkg_download_distfile(ARCHIVE
    URLS https://ftp.gnu.org/gnu/gperf/gperf-${VERSION}.tar.gz
    FILENAME gperf-${VERSION}.tar.gz
    SHA512 855EBCE5FF36753238A44F14C95BE7AFDC3990B085960345CA2CAF1A2DB884F7DB74D406CE9EEC2F4A52ABB8A063D4ED000A36B317C9A353EF4E25E2CCA9A3F4
)

vcpkg_extract_source_archive(
    SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)
file(WRITE ${SOURCE_PATH}/lib/config.h [[
#ifndef CONFIG_H
#define CONFIG_H
#define HAVE_DYNAMIC_ARRAY 0
#endif
]])
file(WRITE ${SOURCE_PATH}/config.cmake.in [[
@PACKAGE_INIT@

include("${CMAKE_CURRENT_LIST_DIR}/gperf-targets.cmake")
]])
file(COPY ${CMAKE_CURRENT_LIST_DIR}/CMakeLists.txt DESTINATION ${SOURCE_PATH})

vcpkg_cmake_configure(
    SOURCE_PATH ${SOURCE_PATH}
)

vcpkg_cmake_install()
vcpkg_copy_pdbs()
vcpkg_install_copyright(FILE_LIST ${SOURCE_PATH}/COPYING)
