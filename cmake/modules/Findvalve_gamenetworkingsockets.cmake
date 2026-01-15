set(PCK "valve_gamenetworkingsockets")

if (${PCK}_FOUND)
  return()
endif()

find_path(${PCK}_INCLUDE_DIR
  NAMES steam/steam_api_common.h
  HINTS
    ${PRAGMA_DEPS_DIR}/GameNetworkingSockets/include
)

find_library(${PCK}_LIBRARY
  NAMES GameNetworkingSockets
  HINTS
    ${PRAGMA_DEPS_DIR}/GameNetworkingSockets/lib
)

set(LIB_VARS "${PCK}_LIBRARY")
set(LIB_VALUES "${${PCK}_LIBRARY}")

set(REQ_VARS ${PCK}_INCLUDE_DIR)
if(UNIX)
  set(LIB_VARS ${LIB_VARS})
  set(LIB_VALUES ${LIB_VALUES})
  set(REQ_VARS ${REQ_VARS} ${LIB_VARS})
else()
  find_file(
    ${PCK}_ABSEIL_RUNTIME
    NAMES abseil_dll.dll
    HINTS ${PRAGMA_DEPS_DIR}/GameNetworkingSockets/bin
  )
  find_file(
    ${PCK}_LIBCRYPTO_RUNTIME
    NAMES libcrypto-3-x64.dll
    HINTS ${PRAGMA_DEPS_DIR}/GameNetworkingSockets/bin
  )
  find_file(
    ${PCK}_LIBPROTOBUF_RUNTIME
    NAMES libprotobuf.dll
    HINTS ${PRAGMA_DEPS_DIR}/GameNetworkingSockets/bin
  )
  find_file(
    ${PCK}_RUNTIME
    NAMES GameNetworkingSockets.dll
    HINTS ${PRAGMA_DEPS_DIR}/GameNetworkingSockets/bin
  )
  set(REQ_VARS ${REQ_VARS} ${PCK}_ABSEIL_RUNTIME ${PCK}_LIBCRYPTO_RUNTIME ${PCK}_LIBPROTOBUF_RUNTIME ${PCK}_RUNTIME)
endif()

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(${PCK}
  REQUIRED_VARS ${REQ_VARS}
)

if(${PCK}_FOUND)
  set(${PCK}_LIBRARIES   ${LIB_VALUES})
  set(${PCK}_INCLUDE_DIRS ${${PCK}_INCLUDE_DIR})
  if(WIN32)
    set(${PCK}_RUNTIME  ${${PCK}_ABSEIL_RUNTIME} ${${PCK}_LIBCRYPTO_RUNTIME} ${${PCK}_LIBPROTOBUF_RUNTIME} ${${PCK}_RUNTIME})
  endif()
endif()
