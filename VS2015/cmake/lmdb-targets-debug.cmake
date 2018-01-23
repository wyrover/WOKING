#----------------------------------------------------------------
# Generated CMake target import file for configuration "Debug".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "lmdb" for configuration "Debug"
set_property(TARGET lmdb APPEND PROPERTY IMPORTED_CONFIGURATIONS DEBUG)
set_target_properties(lmdb PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_DEBUG "C"
  IMPORTED_LINK_INTERFACE_LIBRARIES_DEBUG "ntdll.lib"
  IMPORTED_LOCATION_DEBUG "${_IMPORT_PREFIX}/lib/lmdbd.lib"
  )

list(APPEND _IMPORT_CHECK_TARGETS lmdb )
list(APPEND _IMPORT_CHECK_FILES_FOR_lmdb "${_IMPORT_PREFIX}/lib/lmdbd.lib" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
