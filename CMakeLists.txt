cmake_minimum_required(VERSION 3.12)

option(CONFIG_ENABLE_STEAM_NETWORKING_SOCKETS "If enabled, steam networking socket modules will be enabled. Requires steamworks." OFF)

set(PROJ_NAME_PREFIX pr_game_networking)
set(CONFIG_USE_STEAMWORKS_NETWORKING OFF)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/cmake/modules")

if(CONFIG_ENABLE_STEAM_NETWORKING_SOCKETS MATCHES ON)
	find_package(steamworks REQUIRED)
endif()

pr_fetch_prebuilt_binaries(
    "${PRAGMA_DEPS_DIR}/GameNetworkingSockets"
    "https://github.com/Silverlan/GameNetworkingSockets_prebuilt/releases/download"
    "517fff"
)
find_package(valve_gamenetworkingsockets REQUIRED)

add_subdirectory(shared)
add_subdirectory(client)
add_subdirectory(server)

if(${CONFIG_ENABLE_STEAM_NETWORKING_SOCKETS})
    set(PROJ_NAME_PREFIX pr_steam_networking)
    set(CONFIG_USE_STEAMWORKS_NETWORKING ON)
    add_subdirectory(steam_client)
    add_subdirectory(steam_server)
endif()

set(TARGET_LIST pr_game_networking_client pr_game_networking_server)
set_target_properties(pr_game_networking_client PROPERTIES FOLDER modules/networking)
set_target_properties(pr_game_networking_server PROPERTIES FOLDER modules/networking)
if(${CONFIG_ENABLE_STEAM_NETWORKING_SOCKETS})
    set_target_properties(pr_steam_networking_client PROPERTIES FOLDER modules/networking)
    set_target_properties(pr_steam_networking_server PROPERTIES FOLDER modules/networking)

    list(APPEND TARGET_LIST pr_steam_networking_client pr_steam_networking_server)
endif()

set_property(GLOBAL PROPERTY PRAGMA_MODULE_SKIP_TARGET_PROPERTY_FOLDER 1)
set_property(GLOBAL APPEND PROPERTY PRAGMA_MODULE_TARGETS ${TARGET_LIST})
