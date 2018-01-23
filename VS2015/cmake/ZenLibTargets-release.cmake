#----------------------------------------------------------------
# Generated CMake target import file for configuration "Release".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "zen" for configuration "Release"
set_property(TARGET zen APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(zen PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "CXX"
  IMPORTED_LOCATION_RELEASE "E:/Working/dbyoung/VS2015/lib/zen.lib"
  )

list(APPEND _IMPORT_CHECK_TARGETS zen )
list(APPEND _IMPORT_CHECK_FILES_FOR_zen "E:/Working/dbyoung/VS2015/lib/zen.lib" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
