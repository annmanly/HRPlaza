/*

    Copyright (c) 2024 Pocketz World. All rights reserved.

*/

#ifndef __HR_GAME_CLIENT_H__
#define __HR_GAME_CLIENT_H__

#include "hr_lua.h"
#include "hr_game.h"

#pragma pack(push, 8)

enum hr_SpecialMethod
{
    Awake = 0,
    OnEnable = 1,
    Start = 2,
    Update = 3,
    LateUpdate = 4,
    FixedUpdate = 5,
    OnDisable = 6,
    OnDestroy = 7,
    OnTriggerEnter = 8,
    OnTriggerStay = 9,
    OnTriggerExit = 10,
    OnCollisionEnter = 11,
    OnCollisionStay = 12,
    OnCollisionExit = 13,
    Count = OnCollisionExit + 1
};

#ifdef __cplusplus
extern "C"
{
#endif

    struct hr_Vector3;
    
    typedef struct
    {
        int a;
        int b;
        int c;
    } hr_ObjectId;

    typedef void (*hr_GameClient_HandleMessageFunction)(hr_Lua_State* state, const hr_Message* message);
    typedef void (*hr_ForeignObject_DestructorPtr)(hr_Game* game, int64_t instanceId);

    typedef struct
    {
        hr_GameClient_HandleMessageFunction handleMessageFunction;
        hr_ForeignObject_DestructorPtr foreignObjectDestructor;

    } hr_GameClientOptions;


    HR_API hr_Game* hr_Game_CreateClient(hr_Lua_State* L, hr_GameClientOptions* options);
    
    HR_API void hr_GameClient_EnableLegacyNetworkId(bool enable);

    /// <summary>
    /// Get a player object reference for the player with the given session identifier
    /// </summary>
    HR_API const hr_ObjectRef* hr_GameClient_GetPlayer(hr_Lua_State* L, hr_SessionId playerId, int64_t instanceId);

    /// <summary>
    /// Get a user object reference for the player with the given session identifier
    /// </summary>
    HR_API const hr_ObjectRef* hr_GameClient_GetUser(hr_Lua_State* L, hr_SessionId playerId, int64_t instanceId);    

    /// <summary>
    /// Push the game user data object onto the stack
    /// </summary>
    HR_API void hr_Game_Push(hr_Game* game, hr_Lua_State* L);

    /// <summary>
    /// Create a new behaviour
    /// </summary>
    HR_API const hr_ObjectRef* hr_GameClient_CreateBehaviour(hr_Lua_State* L, hr_Lua_TypeCode typeCode, int64_t instanceId, hr_NetworkId networkId, uint32_t sceneId, bool enabled);

    /// <summary>
    /// Create a new scriptable object
    /// </summary>
    HR_API const hr_ObjectRef* hr_GameClient_CreateScriptableObject(hr_Lua_State* L, hr_Lua_TypeCode typeCode, int64_t instanceId, hr_NetworkId networkId);

    /// <summary>
    /// Run the behaviour
    /// </summary>
    HR_API void hr_GameClient_RunBehaviour(hr_Lua_State* L, const hr_ObjectRef* behaviour, const hr_Lua_ByteCode* script, int globalCount, int propertyCount);

    /// <summary>
    /// Run ScriptableObject
    /// </summary>
    HR_API void hr_GameClient_RunScriptableObject(hr_Lua_State* L, const hr_ObjectRef* object, const hr_Lua_ByteCode* script, int globalCount, int propertyCount);

    /// <summary>
    /// Call a special method on a behaviour
    /// </summary>
    HR_API void hr_GameClient_CallBehaviourSpecialMethod(hr_Lua_State* L, const hr_ObjectRef* behaviour, hr_SpecialMethod specialMethod, int nargs);

    /// <summary>
    /// Returns true if the given behaviour has the given special method
    /// </summary>
    HR_API bool hr_GameClient_DoesBehaviourHaveSpecialMethod(const hr_ObjectRef* behaviour, hr_SpecialMethod specialMethod);


#ifdef __cplusplus
}
#endif

#pragma pack(pop)

#endif // __HR_GAME_CLIENT_H__

