module;

#include "steam_includes.hpp"
#include <cassert>

module pragma.networking.steam.shared;

import :util_module;

static constexpr const char *cvarNameInstances = "steam_networking_sockets_instances";
static int32_t get_net_lib_instance_count()
{
	// Internal console command to keep track of the number of steam networking library instances.
	// This is required because 'GameNetworkingSockets_Init' must only be called once per application,
	// however if a server is created and connected to locally, two library instances exist (server and client),
	// in which case we must ensure it's not called an additional time.
	auto cvInstanceCount = pragma::Engine::Get()->RegisterConVar(cvarNameInstances, udm::Type::Boolean, "0", pragma::console::ConVarFlags::Hidden, "");
	if(cvInstanceCount == nullptr)
		return -1;
	return pragma::Engine::Get()->GetConVarInt(cvarNameInstances);
}

bool initialize_steam_game_networking_sockets(std::string &err)
{
	auto numInstances = get_net_lib_instance_count();
	if(numInstances < 0) {
		err = "Unable to initialize game networking sockets: An error has occurred previously!";
		return false;
	}
	if(numInstances == 0) {
		// This is the first library instance; Initialize the game networking sockets (This must only be done once per application)
		auto success = numInstances != -1;
		std::string errMsg = "";
		if(success) {
#ifdef USE_STEAMWORKS_NETWORKING
			success = SteamAPI_Init();
#else
			SteamDatagramErrMsg err {};
			success = GameNetworkingSockets_Init(nullptr, err);
			if(success == false)
				errMsg = err;
#endif
		}
		if(success == false) {
			err = "Unable to initialize game networking sockets: " + errMsg;
			pragma::Engine::Get()->SetConVar(cvarNameInstances, std::to_string(-1));
			return false;
		}
	}
	pragma::Engine::Get()->SetConVar(cvarNameInstances, std::to_string(numInstances + 1));
	return true;
}
void kill_steam_game_networking_sockets()
{
	auto numInstances = get_net_lib_instance_count();
	assert(numInstances != 0);
	if(numInstances <= 0)
		return;
	if(numInstances == 1) // This is the last library instance
	{
#ifdef USE_STEAMWORKS_NETWORKING
		SteamAPI_Shutdown();
#else
		GameNetworkingSockets_Kill();
#endif
	}
	pragma::Engine::Get()->SetConVar(cvarNameInstances, std::to_string(numInstances - 1));
}
