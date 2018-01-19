#----------------------------------------------------------------
# Generated CMake target import file for configuration "Debug".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "snappy" for configuration "Debug"
set_property(TARGET snappy APPEND PROPERTY IMPORTED_CONFIGURATIONS DEBUG)
set_target_properties(snappy PROPERTIES
  IMPORTED_IMPLIB_DEBUG "${_IMPORT_PREFIX}/lib/snappy.lib"
  IMPORTED_LOCATION_DEBUG "${_IMPORT_PREFIX}/bin/snappy.dll"
  )

list(APPEND _IMPORT_CHECK_TARGETS snappy )
list(APPEND _IMPORT_CHECK_FILES_FOR_snappy "${_IMPORT_PREFIX}/lib/snappy.lib" "${_IMPORT_PREFIX}/bin/snappy.dll" )

# Import target "snappy_static" for configuration "Debug"
set_property(TARGET snappy_static APPEND PROPERTY IMPORTED_CONFIGURATIONS DEBUG)
set_target_properties(snappy_static PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_DEBUG "CXX"
  IMPORTED_LOCATION_DEBUG "${_IMPORT_PREFIX}/lib/snappy_static.lib"
  )

list(APPEND _IMPORT_CHECK_TARGETS snappy_static )
list(APPEND _IMPORT_CHECK_FILES_FOR_snappy_static "${_IMPORT_PREFIX}/lib/snappy_static.lib" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
