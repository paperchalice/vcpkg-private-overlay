vcpkg_download_distfile(ARCHIVE
  URLS https://www.cpan.org/src/5.0/perl-${VERSION}.tar.gz
  FILENAME perl-${VERSION}.tar.gz
  SHA512 930975ce9867e5a83e70d0611b8e8b3714ed65d53a4802d09a2aad17c10155421012031e28b690a8a029aaf289220d0eb3bab65f870bd78b3f380643b31e2dc0
)
vcpkg_extract_source_archive(
  SOURCE_PATH
  ARCHIVE ${ARCHIVE}
)

set(make_file ${SOURCE_PATH}/win32/Makefile)
cmake_path(NATIVE_PATH CURRENT_PACKAGES_DIR NORMALIZE install_dir_native)

vcpkg_replace_string(${make_file} "#CCTYPE[ \t]*= MSVC143" "CCTYPE=MSVC143" REGEX)
vcpkg_replace_string(${make_file} [[$(INST_DRV)\perl]] "${install_dir_native}")

vcpkg_install_nmake(
  SOURCE_PATH ${SOURCE_PATH}
  PROJECT_SUBPATH win32
  PROJECT_NAME Makefile
)
