export module pragma.networking.steam.shared:header_data;

export import std.compat;

#pragma pack(push, 1)
export struct HeaderData {
	uint32_t messageId;
	uint32_t bodySize;
};
#pragma pack(pop)
