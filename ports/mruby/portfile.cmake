vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO mruby/mruby
    REF ${VERSION}
    SHA512 2defb1d1ad1130180db901e8f5444c1f4c3e7b5ef045d9d5fc6fafa8f1aac01167bb5705b67eb75ac1d32929241a0cc92cda457ac1e4d39a0f028ccf48bf0361
    HEAD_REF master
)

vcpkg_find_acquire_program(RUBY)
get_filename_component(RUBY_PATH ${RUBY} DIRECTORY)
vcpkg_add_to_path(${RUBY_PATH})

file(WRITE ${SOURCE_PATH}/build_config/vcpkg.rb [[
MRuby::Build.new do |conf|
  conf.toolchain :visualcpp
  conf.gembox 'full-core'
  conf.enable_bintest
  conf.enable_test
end
]])
set(ENV{MRUBY_CONFIG} ${SOURCE_PATH}/build_config/vcpkg.rb)
set(ENV{PREFIX} ${CURRENT_PACKAGES_DIR})
execute_process(
  COMMAND rake
  COMMAND rake install:full
  WORKING_DIRECTORY
    ${SOURCE_PATH}
)
vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)
