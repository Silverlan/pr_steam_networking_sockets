include("${CMAKE_SOURCE_DIR}/cmake/install_helper.cmake")

set(version "517fff")
set(base_url "https://github.com/Silverlan/GameNetworkingSockets_prebuilt/releases/download/${version}")
set(sns_toolset)

if(WIN32)
    set(sns_toolset "win32")
endif()

pr_fetch_prebuilt_binaries("${PRAGMA_DEPS_DIR}/GameNetworkingSockets" "${base_url}" "${version}" ${sns_toolset})
