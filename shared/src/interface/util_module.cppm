export module pragma.networking.steam.shared:util_module;

export import std;

export {
	bool initialize_steam_game_networking_sockets(std::string &err);
	void kill_steam_game_networking_sockets();
}
