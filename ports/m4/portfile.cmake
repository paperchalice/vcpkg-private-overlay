vcpkg_download_distfile(ARCHIVE
  URLS https://ftp.gnu.org/gnu/m4/m4-${VERSION}.tar.xz
  FILENAME m4-${VERSION}.tar.xz
  SHA512 47f595845c89709727bda0b3fc78e3188ef78ec818965b395532e7041cabe9e49677ee4aca3d042930095a7f8df81de3da1026b23b6897be471f6cf13ddd512b
)
vcpkg_extract_source_archive(
  SOURCE_PATH
  ARCHIVE ${ARCHIVE}
)

vcpkg_make_configure(
  SOURCE_PATH ${SOURCE_PATH}
)
vcpkg_make_install()
vcpkg_copy_pdbs()
vcpkg_install_copyright(FILE_LIST ${SOURCE_PATH}/COPYING)
