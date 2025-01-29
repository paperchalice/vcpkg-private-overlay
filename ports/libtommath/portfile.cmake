vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO libtom/libtommath
    REF "v${VERSION}"
    SHA512 3dbd7053a670afa563a069a9785f1aa4cab14a210bcd05d8fc7db25bd3dcce36b10a3f4f54ca92d75a694f891226f01bdf6ac15bacafeb93a8be6b04c579beb3
    HEAD_REF develop
)

vcpkg_cmake_configure(SOURCE_PATH ${SOURCE_PATH})
vcpkg_cmake_install()
vcpkg_copy_pdbs()
vcpkg_cmake_config_fixup(CONFIG_PATH lib/cmake/${PORT})
vcpkg_fixup_pkgconfig()
vcpkg_install_copyright(FILE_LIST ${SOURCE_PATH}/LICENSE)

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
