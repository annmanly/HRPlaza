/*

    Copyright (c) 2024 Pocketz World. All rights reserved.

*/

#ifndef __HR_GAME_SERVER_H_
#define __HR_GAME_SERVER_H_

#include "hr_game.h"

#pragma pack(push, 8)

#ifdef __cplusplus
extern "C"
{
#endif

    typedef struct
    {
        uint32_t id;
        hr_PrintFunction printFunction;
        hr_DebugPrintFunction debugPrintFunction;
    } hr_GameServerOptions;

    /// <summary>
    /// Create a new game server using the given server bundle and options.  The caller can safely free the memory
    /// used by bundle and options after a call to hr_CreateGameServer as the game server will make a copy.
    /// </summary>
    HR_API hr_Game* hr_Game_CreateServer(hr_Buffer* bundle, hr_GameServerOptions* options);

    /// <summary>
    /// Serialize the game server to a buffer.  The caller is responsible for freeing the buffer using hr_Buffer_Free.
    HR_API hr_Buffer* hr_GameServer_Serialize(hr_Game* game);

#ifdef __cplusplus
}
#endif

#pragma pack(pop)

#endif // __HR_GAME_SERVER_H_
