module;

#include "steam_includes.hpp"

export module pragma.networking.steam.shared:common;

export import pragma.shared;

export {
	// https://stackoverflow.com/a/7477384/2482983
	// +6 for ports
	constexpr size_t MAX_IP_CHAR_LENGTH = 45 + 6;

	inline int get_send_flags(pragma::networking::Protocol protocol)
	{
		int sendFlags = k_nSteamNetworkingSend_NoNagle; // TODO: Allow caller to control nagle?
		switch(protocol) {
		case pragma::networking::Protocol::FastUnreliable:
			sendFlags |= k_nSteamNetworkingSend_Unreliable;
			break;
		case pragma::networking::Protocol::SlowReliable:
		default:
			sendFlags |= k_nSteamNetworkingSend_Reliable;
			break;
		}
		return sendFlags;
	}

	bool initialize_steam_game_networking_sockets(std::string &err);
	void kill_steam_game_networking_sockets();

	class BaseSteamNetworkingSocket {
	public:
		void Initialize();
		ISteamNetworkingSockets &GetSteamInterface() const;
		pragma::util::Clock::duration GetDurationSinceStart(SteamNetworkingMicroseconds t) const;
		pragma::util::Clock::time_point GetStartTime() const;
		SteamNetworkingMicroseconds GetSteamStartTime() const;
		static void DebugOutput(ESteamNetworkingSocketsDebugOutputType eType, const char *msg);
	private:
		ISteamNetworkingSockets *m_pInterface = nullptr;
		SteamNetworkingMicroseconds m_steamStartTime = 0;
		pragma::util::Clock::time_point m_chronoStartTime;
	};
}
