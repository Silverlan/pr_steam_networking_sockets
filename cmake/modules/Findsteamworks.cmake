set(PCK "steamworks")

if (${PCK}_FOUND)
  return()
endif()

find_path(${PCK}_INCLUDE_DIR
  NAMES steam/steam_api.h
  HINTS
    ${PRAGMA_DEPS_DIR}/steamworks/sdk/public
)

if(UNIX)
  find_library(${PCK}_LIBRARY
    NAMES steam_api
    HINTS
      ${PRAGMA_DEPS_DIR}/steamworks/redistributable_bin/linux64
  )
else()
  find_library(${PCK}_LIBRARY
    NAMES steam_api64
    HINTS
      ${PRAGMA_DEPS_DIR}/steamworks/redistributable_bin/win64
  )
endif()

set(LIB_VARS "${PCK}_LIBRARY")
set(LIB_VALUES "${${PCK}_LIBRARY}")

set(REQ_VARS ${PCK}_INCLUDE_DIR)
if(UNIX)
  set(LIB_VARS ${LIB_VARS})
  set(LIB_VALUES ${LIB_VALUES})
  set(REQ_VARS ${REQ_VARS} ${LIB_VARS})
else()
  find_file(
    ${PCK}_RUNTIME
    NAMES steam_api64.dll
    HINTS ${PRAGMA_DEPS_DIR}/steamworks/redistributable_bin/win64
  )
  set(REQ_VARS ${REQ_VARS} ${PCK}_RUNTIME)
endif()

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(${PCK}
  REQUIRED_VARS ${REQ_VARS}
)

if(${PCK}_FOUND)
  set(${PCK}_LIBRARIES   ${LIB_VALUES})
  set(${PCK}_INCLUDE_DIRS ${${PCK}_INCLUDE_DIR})
  if(WIN32)
    set(${PCK}_RUNTIME ${${PCK}_RUNTIME})
  endif()
endif()
