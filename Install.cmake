set(INSTALL_PATH "modules/networking/game_networking")
pr_install_create_directory("${INSTALL_PATH}")
pr_install_targets(pr_game_networking_client pr_game_networking_server INSTALL_DIR "${INSTALL_PATH}")
if(WIN32)
    pr_install_files(
        ${valve_gamenetworkingsockets_RUNTIMES}
        INSTALL_DIR "${INSTALL_PATH}"
    )
else()
    pr_install_files(
        ${valve_gamenetworkingsockets_LIBRARIES}
        INSTALL_DIR "${INSTALL_PATH}"
    )
endif()

if(${CONFIG_ENABLE_STEAM_NETWORKING_SOCKETS})
    set(INSTALL_PATH "modules/networking/steam_networking")
    pr_install_create_directory("${INSTALL_PATH}")
    pr_install_targets(pr_steam_networking_client pr_steam_networking_server INSTALL_DIR "${INSTALL_PATH}")
endif()
