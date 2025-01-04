vcpkg_download_distfile(ARCHIVE
  URLS "https://www.bytereef.org/software/mpdecimal/releases/mpdecimal-${VERSION}.tar.gz"
  FILENAME "mpdecimal-${VERSION}.tar.gz"
  SHA512 7610ac53ac79f7a8a33fa7a3e61515810444ec73ebca859df7a9ddc18e96b990c99323172810c9cc7f6d6e1502c0be308cd443d6c2d5d0c871648e4842e05d59
)

vcpkg_extract_source_archive(
  SOURCE_PATH
  ARCHIVE ${ARCHIVE}
)

set(libdec_path ${SOURCE_PATH}/libmpdec)

execute_process(
  COMMAND ${CMAKE_COMMAND} -E rename Makefile.vc Makefile
  COMMAND nmake /f Makefile MACHINE=x64 DEBUG=0
  WORKING_DIRECTORY ${libdec_path}
)

file(INSTALL ${libdec_path}/mpdecimal.h DESTINATION ${CURRENT_PACKAGES_DIR}/include)
file(INSTALL ${libdec_path}/libmpdec-${VERSION}.dll.lib DESTINATION ${CURRENT_PACKAGES_DIR}/lib)
file(INSTALL ${libdec_path}/libmpdec-${VERSION}.dll DESTINATION ${CURRENT_PACKAGES_DIR}/bin)
file(INSTALL ${libdec_path}/libmpdec-${VERSION}.dll.lib DESTINATION ${CURRENT_PACKAGES_DIR}/lib)
file(RENAME ${CURRENT_PACKAGES_DIR}/lib/libmpdec-${VERSION}.dll.lib ${CURRENT_PACKAGES_DIR}/lib/mpdec.lib)
configure_file(${libdec_path}/.pc/libmpdec.pc.in
  ${CURRENT_PACKAGES_DIR}/lib/pkgconfig/libmpdec.pc
  @ONLY
)
vcpkg_fixup_pkgconfig()
vcpkg_replace_string(${CURRENT_PACKAGES_DIR}/lib/pkgconfig/libmpdec.pc
  "-lmpdec -lm" "-lmpdec"
)
