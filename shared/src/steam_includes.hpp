#pragma once

#ifdef USE_STEAMWORKS_NETWORKING
#include <steam/steam_api.h>
#include <steam/isteamnetworkingsockets.h>
#include <steam/isteamnetworkingutils.h>
#else
#include <steam/steamnetworkingsockets.h>
#include <steam/isteamnetworkingutils.h>
#endif
