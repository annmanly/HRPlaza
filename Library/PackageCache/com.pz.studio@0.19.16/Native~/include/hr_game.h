/*

    Copyright (c) 2024 Pocketz World. All rights reserved.

*/

#ifndef __HR_GAME_H__
#define __HR_GAME_H__

#include "hr_common.h"

#pragma pack(push, 8)

#ifdef __cplusplus
extern "C"
{
#endif

    typedef void hr_Game;
    typedef void hr_ObjectRef;
    typedef void hr_ForeignObject;
    typedef uint32_t hr_SessionId;

    typedef void (*hr_PrintFunction)(const char* message);
    typedef void (*hr_DebugPrintFunction)(const char* message, const char* callstack);
    typedef void (*hr_IntValue_ChangedPtr)(hr_Lua_State* l, hr_ObjectRef* userdata, int32_t newValue, int32_t oldValue);

    typedef struct
    {
        uint32_t Size;
        const void* Data;
    } hr_Message;

    /// <summary>
    /// Destroy a game instance.
    /// </summary>
    HR_API void hr_Game_Destroy(hr_Game* game);

    /// <summary>
    /// Return the game for the given lua stack
    /// </summary>
    HR_API hr_Game* hr_Game_Get(hr_Lua_State* L);

    /// <summary>
    /// Return the object that represents the game
    /// </summary>
    HR_API const hr_ObjectRef* hr_Game_GetSelf(hr_Game* game, int64_t instanceId);

    /// <summary>
    /// Run a single tick of the game.  This will process any pending messages and update the game state.
    /// </summary>
    HR_API void hr_Game_Update(hr_Game* game, float delta);

    /// <summary>
    /// Manually issue a fixed update of the game. 
    /// </summary>
    HR_API void hr_Game_FixedUpdate(hr_Game* game, float delta);

    /// <summary>
    /// Manually issue a late update of the game.
    /// </summary>
    HR_API void hr_Game_LateUpdate(hr_Game* game);

    /// <summary>
    /// Pop messages from the outbound game queue and returns the number of messages retrieved.  The 
    /// number of messages retrieved will not exceed the messageCount parameter.  All data returned in messages
    /// is owned by the game and will be freed by the game.  All data returned in messages will
    /// be considered valid until the next call to hr_GameClient_GetMessages or hr_GameClient_Destroy.
    /// </summary>
    HR_API uint32_t hr_Game_PopMessages(hr_Game* game, hr_Message* messages, uint32_t messageCount);

    /// <summary>
    /// Push a single message to the inbound game queue. Any data passed to the game via messages can safely be freed
    /// after a call to hr_GameClient_SendMessages.  Messages may or may not be processed immediately by the game, if not
    /// processed immediately they will be queued for processing at the next call to hr_GameClient_Tick.
    /// </summary>
    HR_API void hr_Game_PushMessage(hr_Game* game, hr_Message* message);

    /// <summary>
    /// Set the elapsed time since the game was started
    /// </summary>
    HR_API void hr_Game_SetTime(hr_Game* game, double_t time);

    /// <summary>
    /// Concatenate two player ids to create a unique channel id for whispering. The greater id is the higher 32 bits, the lower id is the lower 32 bits.
    /// </summary>
    HR_API uint64_t hr_Game_CreatePairedId(uint32_t player1, uint32_t player2);

    /// <summary>
    /// Push the given object reference to the stack
    /// </summary>
    HR_API void hr_Game_PushObjectRef(hr_Lua_State* l, const hr_ObjectRef* objectRef);

    /// <summary>
    /// Create a generic foreign object 
    /// </summary>
    HR_API const hr_ObjectRef* hr_Game_CreateObject(hr_Lua_State* L, hr_Lua_TypeCode typeCode, int64_t instanceId, hr_NetworkId networkId, bool autoDispose);

    /// <summary>
    /// Set properties on an object
    /// </summary>
    HR_API void hr_Game_SetObjectProperties(hr_Lua_State* L, const hr_ObjectRef* object, int count);

    /// <summary>
    /// Get an object from the stack that matches the given type code or throw an error
    /// </summary>
    HR_API const hr_ObjectRef* hr_Game_GetObjectRef(hr_Lua_State* L, int index, hr_Lua_TypeCode typeCode);

    /// <summary>
    /// Release an object created using any of the object creation methods
    /// </summary>
    HR_API void hr_Game_DisposeObject(const hr_ObjectRef* object);

    /// <summary>
    /// Returns the session identifier of the player that owns the given object or zero
    /// </summary>
    HR_API hr_SessionId hr_Object_GetOwnerId(const hr_ObjectRef* object);

    /// <summary>
    /// Return the object that matches the given network id or null
    /// </summary>
    HR_API const hr_ObjectRef* hr_Object_GetByNetworkId(hr_Lua_State* L, hr_NetworkId networkId);

    /// <summary>
    /// Create a new event.  Pops two items from stack, the first is the name, the second is the owner which can be nil
    /// </summary>
    HR_API const hr_ObjectRef* hr_Game_CreateEvent(hr_Lua_State* L, int64_t instanceId);

    /// <summary>
    /// Fire an event with the given number of arguments.  This call will pop the event and arguments from the stack.
    /// </summary>
    HR_API void hr_Game_FireEvent(hr_Lua_State* L, int nargs);

    /// <summary>
    /// Return the number of connections of the event
    /// </summary>
    HR_API int32_t hr_Game_GetEventConnectionCount(const hr_ObjectRef* object);

    /// <summary>
    /// Create an int value attached to the given behaviour.  The returned value is a user data object and the
    /// caller will need to unref when it is no longer using it.
    /// </summary>
    HR_API const hr_ObjectRef* hr_Game_CreateIntValue(const hr_ObjectRef* owner, const char* name, int defaultValue, int64_t instanceId, hr_IntValue_ChangedPtr changed);

    /// <summary>
    /// Return the name of a specific betwork object, if found.
    /// </summary>
    HR_API bool hr_Game_GetNetworkObjectName(hr_Game* game, hr_NetworkId networkId, char *out, int len);

    /// <summary>
    /// Sets whether the game is running in the Unity Editor or not.
    /// </summary>
    HR_API void hr_Game_SetIsEditor(hr_Game* game, bool isEditor);

#ifdef __cplusplus
}
#endif

#pragma pack(pop)

#endif // __HR_GAME_H__
