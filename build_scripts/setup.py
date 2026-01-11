import os
import subprocess
import sys
import stat
import argparse
from sys import platform
from pathlib import Path

# Building the GameNetworkingSockets library can be problematic on both Windows and Linux due to the dependency on system packages (and vcpkg on Windows).
# For this reason we'll always use prebuilt binaries unless --build-game-networking-sockets has been specified explicitly.

parser = argparse.ArgumentParser(description='pr_steam_networking_sockets build script', allow_abbrev=False, formatter_class=argparse.ArgumentDefaultsHelpFormatter, epilog="")
parser.add_argument("--build-game-networking-sockets", type=str2bool, nargs='?', const=True, default=False, help="Build the GameNetworkingSockets library (otherwise uses pre-built binaries).")
args,unknown = parser.parse_known_args()
args = vars(args)

build_gns = args["build_game_networking_sockets"]

if build_gns:
	# Required so we can import relative packages
	sys.path.insert(0, os.path.dirname(__file__))

	from third_party import GameNetworkingSockets
	GameNetworkingSockets.main()
else:
	print_msg("Downloading prebuilt GameNetworkingSockets binaries...")
	os.chdir(install_dir)

	version = "517fff"
	staging_dir = get_library_root_dir("GameNetworkingSockets")
	mkpath(staging_dir)
	os.chdir(staging_dir)
	install_prebuilt_binaries(
		"https://github.com/Silverlan/GameNetworkingSockets_prebuilt/releases/download/" +version +"/",
		version = version,
		toolset = "msvc" if (sys.platform == "win32") else "clang"
	)

cmake_args.append("-DDEPENDENCY_VALVE_GAMENETWORKINGSOCKETS_INCLUDE=" +get_library_include_dir("GameNetworkingSockets"))
if platform == "win32":
	cmake_args.append("-DDEPENDENCY_VALVE_GAMENETWORKINGSOCKETS_LIBRARY=" +get_library_lib_dir("GameNetworkingSockets") +"GameNetworkingSockets.lib")
else:
	cmake_args.append("-DDEPENDENCY_VALVE_GAMENETWORKINGSOCKETS_LIBRARY=" +get_library_lib_dir("GameNetworkingSockets") +"libGameNetworkingSockets.so")
cmake_args.append("-DDEPENDENCY_GAMENETWORKINGSOCKETS_BINARY_DIR=" +get_library_bin_dir("GameNetworkingSockets"))

additional_build_targets.append("pr_game_networking_client")
additional_build_targets.append("pr_game_networking_server")
