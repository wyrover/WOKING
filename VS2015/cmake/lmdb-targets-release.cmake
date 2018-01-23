#----------------------------------------------------------------
# Generated CMake target import file for configuration "Release".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "lmdb" for configuration "Release"
set_property(TARGET lmdb APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(lmdb PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "C"
  IMPORTED_LINK_INTERFACE_LIBRARIES_RELEASE "ntdll.lib"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/lmdb.lib"
  )

list(APPEND _IMPORT_CHECK_TARGETS lmdb )
list(APPEND _IMPORT_CHECK_FILES_FOR_lmdb "${_IMPORT_PREFIX}/lib/lmdb.lib" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
