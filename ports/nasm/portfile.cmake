
vcpkg_download_distfile(ARCHIVE
  URLS "https://www.nasm.us/pub/nasm/releasebuilds/2.16.03/nasm-2.16.03.tar.xz"
  FILENAME "nasm-2.16.03.tar.xz"
  SHA512 0c706e41a9c33e1ac3bad5056e8bf8cbcd51785b551a6e34ce7d0d723df8eaab8603a033e89b3dcda1004b558f9e9ef3196691500f10d8201bf47a323a516f84
)
vcpkg_extract_source_archive(SOURCE_PATH
  ARCHIVE "${ARCHIVE}"
)

vcpkg_install_nmake(
  SOURCE_PATH ${SOURCE_PATH}
  PROJECT_NAME Mkfiles/msvc.mak
  OPTIONS prefix=${CURRENT_PACKAGES_DIR}
)

set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER  enabled)

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
