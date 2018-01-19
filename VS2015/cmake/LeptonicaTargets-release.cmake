#----------------------------------------------------------------
# Generated CMake target import file for configuration "Release".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "leptonica" for configuration "Release"
set_property(TARGET leptonica APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(leptonica PROPERTIES
  IMPORTED_IMPLIB_RELEASE "${_IMPORT_PREFIX}/lib/leptonica-1.74.4.lib"
  IMPORTED_LINK_INTERFACE_LIBRARIES_RELEASE "E:/Working/dbyoung/VS2015/lib/libgif.lib;E:/Working/dbyoung/VS2015/lib/jpeg.lib;openjp2;E:/Working/dbyoung/VS2015/lib/libpng.lib;E:/Working/dbyoung/VS2015/lib/tiff.lib;webp;E:/Working/dbyoung/VS2015/lib/zlib.lib"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/bin/leptonica-1.74.4.dll"
  )

list(APPEND _IMPORT_CHECK_TARGETS leptonica )
list(APPEND _IMPORT_CHECK_FILES_FOR_leptonica "${_IMPORT_PREFIX}/lib/leptonica-1.74.4.lib" "${_IMPORT_PREFIX}/bin/leptonica-1.74.4.dll" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
