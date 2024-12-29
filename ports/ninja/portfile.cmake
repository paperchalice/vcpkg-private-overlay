vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO ninja-build/ninja
    REF "v${VERSION}"
    SHA512 d6e6f0e89a4844a69069ff0c7cefc07704a41c7b0c062a57534de87decdde63e27928147b321111b806aa7efa1061f031a1319b074391db61b0cbdccf096954c
    HEAD_REF master
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DBUILD_TESTING=OFF
)

vcpkg_cmake_install()

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/COPYING")
