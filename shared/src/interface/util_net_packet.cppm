module;

#include "steam_includes.hpp"

export module pragma.networking.steam.shared:util_net_packet;

export import :header_data;
export import pragma.shared;

export {
	class BaseSteamNetworkingSocket;
	class NetPacketReceiver {
	public:
		std::optional<NetPacket> ReceiveDataFragment(BaseSteamNetworkingSocket &sns, ISteamNetworkingMessage &msg);
	private:
		HeaderData m_packetHeader = {};
		NetPacket m_packetBody;
		bool m_bReceivedHeader = false;
	};

	class NetPacketDispatcher {
	public:
		bool SendData(ISteamNetworkingSockets &sns, uint32_t hConnection, pragma::networking::Protocol protocol, const void *data, uint32_t dataSize, pragma::networking::Error &outErr);
		bool SendPacket(ISteamNetworkingSockets &sns, uint32_t hConnection, pragma::networking::Protocol protocol, NetPacket &packet, pragma::networking::Error &outErr);
	};
}
