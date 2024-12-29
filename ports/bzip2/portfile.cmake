vcpkg_from_gitlab(
    OUT_SOURCE_PATH SOURCE_PATH
    GITLAB_URL https://gitlab.com/
    REPO paperchalice/bzip2
    REF a0682ed0f32e9063e5c0b44076280eee0fb5c8e3
    SHA512 805430759ba7f6e607578af0056b210b73c9651cd5b609e336c5cb4e10c0cbce1528a611f66c17162771ad366952515335f8b9d1393e78588319154d4304bd2c
    HEAD_REF master
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DENABLE_SYMLINK_ON_WINDOWS=ON
)

vcpkg_cmake_install()
vcpkg_fixup_pkgconfig()
vcpkg_copy_pdbs()

file(COPY "${CMAKE_CURRENT_LIST_DIR}/usage" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}")
vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/COPYING")
