import os
import subprocess
import sys
import stat
from sys import platform
from pathlib import Path

if build_all:
	# Required so we can import relative packages
	sys.path.insert(0, os.path.dirname(__file__))

	from third_party import GameNetworkingSockets
	GameNetworkingSockets.main()

cmake_args.append("-DDEPENDENCY_VALVE_GAMENETWORKINGSOCKETS_INCLUDE=" +get_library_include_dir("GameNetworkingSockets"))
if platform == "win32":
	cmake_args.append("-DDEPENDENCY_VALVE_GAMENETWORKINGSOCKETS_LIBRARY=" +get_library_lib_dir("GameNetworkingSockets") +"GameNetworkingSockets.lib")
else:
	cmake_args.append("-DDEPENDENCY_VALVE_GAMENETWORKINGSOCKETS_LIBRARY=" +get_library_lib_dir("GameNetworkingSockets") +"libGameNetworkingSockets.so")
cmake_args.append("-DDEPENDENCY_GAMENETWORKINGSOCKETS_BINARY_DIR=" +get_library_bin_dir("GameNetworkingSockets"))

additional_build_targets.append("pr_game_networking_client")
additional_build_targets.append("pr_game_networking_server")
