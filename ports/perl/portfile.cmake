vcpkg_download_distfile(ARCHIVE
  URLS https://www.cpan.org/src/5.0/perl-${VERSION}.tar.gz
  FILENAME perl-${VERSION}.tar.gz
  SHA512 930975ce9867e5a83e70d0611b8e8b3714ed65d53a4802d09a2aad17c10155421012031e28b690a8a029aaf289220d0eb3bab65f870bd78b3f380643b31e2dc0
)
vcpkg_extract_source_archive(
  SOURCE_PATH
  ARCHIVE ${ARCHIVE}
  PATCHES
    config.patch
)

set(ENV{PERLLIB} ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel/lib)
vcpkg_install_nmake(
  SOURCE_PATH ${SOURCE_PATH}
  PROJECT_SUBPATH win32
  PROJECT_NAME Makefile
)
file(GLOB libs "${CURRENT_PACKAGES_DIR}/lib/*")
file(MAKE_DIRECTORY ${CURRENT_PACKAGES_DIR}/lib/perl_tmp)
foreach(f ${libs})
  string(REPLACE ${CURRENT_PACKAGES_DIR}/lib ${CURRENT_PACKAGES_DIR}/lib/perl_tmp new_f ${f})
  file(RENAME ${f} ${new_f})
endforeach()
file(RENAME ${CURRENT_PACKAGES_DIR}/lib/perl_tmp ${CURRENT_PACKAGES_DIR}/lib/perl)
file(RENAME ${CURRENT_PACKAGES_DIR}/site ${CURRENT_PACKAGES_DIR}/share/perl/site)
