vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO libssh2/libssh2
    REF "libssh2-${VERSION}"
    SHA512 616efcd7f5c1fb1046104ebce70549e4756e2a55150efa2df5bb7123051d3bf336023cedcbfe932cd7c690a0b4d1f1a93c760ea39f1dba50c2b06d0945dca958
    HEAD_REF master
)

vcpkg_check_features(OUT_FEATURE_OPTIONS FEATURE_OPTIONS
    FEATURES
        zlib    ENABLE_ZLIB_COMPRESSION
    INVERTED_FEATURES
        zlib    CMAKE_DISABLE_FIND_PACKAGE_ZLIB # for use by the cryto backend
)
if("openssl" IN_LIST FEATURES)
    list(APPEND FEATURE_OPTIONS "-DCRYPTO_BACKEND=OpenSSL")
elseif(VCPKG_TARGET_IS_WINDOWS)
    list(APPEND FEATURE_OPTIONS "-DCRYPTO_BACKEND=WinCNG")
else()
    message(FATAL_ERROR "Port ${PORT} only supports OpenSSL and WinCNG crypto backends.")
endif()
if(VCPKG_LIBRARY_LINKAGE STREQUAL "dynamic")
    list(APPEND FEATURE_OPTIONS "-DBUILD_STATIC_LIBS:BOOL=OFF")
endif()

# So the name is ssh2.dll and ssh2.lib
vcpkg_replace_string(${SOURCE_PATH}/src/CMakeLists.txt [["libssh2"]] ssh2)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DBUILD_EXAMPLES=OFF
        -DBUILD_TESTING=OFF
        ${FEATURE_OPTIONS}
    OPTIONS_DEBUG
        -DENABLE_DEBUG_LOGGING=OFF
    MAYBE_UNUSED_VARIABLES
        CMAKE_DISABLE_FIND_PACKAGE_ZLIB
)

vcpkg_cmake_install()
vcpkg_copy_pdbs()
vcpkg_fixup_pkgconfig()

vcpkg_cmake_config_fixup(CONFIG_PATH lib/cmake/libssh2)

vcpkg_replace_string(${CURRENT_PACKAGES_DIR}/lib/pkgconfig/libssh2.pc
    [[ ${prefix}/lib/zlib.lib]] ""
)

if (VCPKG_TARGET_IS_WINDOWS)
    if(VCPKG_LIBRARY_LINKAGE STREQUAL "dynamic")
        vcpkg_replace_string("${CURRENT_PACKAGES_DIR}/include/libssh2.h" "defined(_WINDLL)" "1")
    endif()
endif()


file(INSTALL "${CURRENT_PORT_DIR}/usage" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}")
file(INSTALL "${SOURCE_PATH}/COPYING" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)
