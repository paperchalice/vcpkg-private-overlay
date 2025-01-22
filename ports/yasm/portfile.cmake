vcpkg_from_github(
  OUT_SOURCE_PATH SOURCE_PATH
  REPO yasm/yasm
  REF "v${VERSION}"
  SHA512 f5053e2012e0d2ce88cc1cc06e3bdb501054aed5d1f78fae40bb3e676fe2eb9843d335a612d7614d99a2b9e49dca998d57f61b0b89fac8225afa4ae60ae848f1
  HEAD_REF master
)

vcpkg_cmake_configure(
  SOURCE_PATH ${SOURCE_PATH}
)
vcpkg_cmake_install()
vcpkg_copy_pdbs()
vcpkg_install_copyright(FILE_LIST ${SOURCE_PATH}/COPYING)
