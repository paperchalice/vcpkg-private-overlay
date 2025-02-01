vcpkg_from_github(
  OUT_SOURCE_PATH SOURCE_PATH
  REPO qt-labs/jom
  REF 5b295dbee66504d21b8cc7d05d5e88e87644d586
  SHA512 60f2bb7e46389f62377f07f0f0efa41da9eb3f4f0bf45fbe49acda90bb7d25b23fd1a524a961e954c019800ba046b84576546270bf78abd357de17bea324cee6
)

vcpkg_cmake_configure(SOURCE_PATH ${SOURCE_PATH})
vcpkg_cmake_install()
vcpkg_copy_pdbs()
vcpkg_install_copyright(FILE_LIST ${SOURCE_PATH}/LICENSE.GPL)
