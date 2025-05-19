/*

    Copyright (c) 2024 Pocketz World. All rights reserved.

*/

#ifndef __HR_LUA_H__
#define __HR_LUA_H__

#include "hr_common.h"

#pragma pack(push, 8)

#ifdef __cplusplus
extern "C"
{
#endif

    struct hr_Lua_Reg;
    struct hr_Lua_ByteCode;
    typedef void hr_Lua_Struct;
    typedef void hr_Lua_Environment;

    enum class hr_Lua_LogType : int32_t
    {
        Info = 0,
		Warning = 1,
		Error = 2
    };

    typedef int32_t (*hr_Lua_MethodPtr)(hr_Lua_State* state);
    typedef void (*hr_Lua_PrintPtr)(hr_Lua_State* state, hr_Lua_LogType logType, const char* str, const char* callstack);
    typedef void (*hr_Lua_RequirePtr)(hr_Lua_State* state, const char* moduleName);
    typedef void (*hr_Lua_ErrorFunctionPtr)(const char* msg, int line, int column);

    enum class hr_Lua_TypeFlags : uint16_t
    {
        /// <summary>
        /// No flags
        /// </summary>
        None = 0,

        /// <summary>
        /// Indicates that the type is a blittable struct
        /// </summary>
        Struct = 1 << 0,

        /// <summary>
        /// Indicates that the type represents an object that is created externally to the system
        /// </summary>
        Foreign = 1 << 1
    };

    struct hr_Lua_TypeInfo
    {
        const char* name;
        hr_Lua_TypeCode typeCode;
        hr_Lua_TypeCode baseTypeCode;
        hr_Lua_TypeFlags flags;
        uint16_t size;
        hr_Lua_Reg* staticMethods;
        hr_Lua_Reg* staticGetters;
        hr_Lua_Reg* staticSetters;
        hr_Lua_Reg* instanceMethods;
        hr_Lua_Reg* instanceGetters;
        hr_Lua_Reg* instanceSetters;
        hr_Lua_Reg* instanceMeta;
    };

    struct hr_Lua_ByteCode
    {
        uint8_t* code;
        int32_t size;
        const char* name;
    };


    struct hr_Lua_Attribute
    {
        const char* name;
        const char* params;
    };

    struct hr_Lua_Property
    {
        const char* name;
        const char* type;
        int32_t valueOffsetBegin;
        int32_t valueOffsetEnd;
        int32_t attributeCount;
        hr_Lua_Attribute** attributes;

        union
        {
            double_t d;
            const char* s;
            bool b;
        } value;
    };

    struct hr_Lua_ParseResults
    {
        hr_Lua_Property** properties;
        int32_t propertyCount;

        hr_Lua_Attribute** attributes;
        int32_t attributeCount;

        const char** dependencies;
        int32_t dependencyCount;
    };

    struct hr_Lua_VMOptions
    {
        hr_Lua_PrintPtr print;
        hr_Lua_RequirePtr require;
        bool debug;
    };

    HR_API hr_Lua_State* hr_Lua_CreateVM(hr_Lua_VMOptions* options);
    HR_API void hr_Lua_FreeVM(hr_Lua_State* state);

    HR_API int32_t hr_Lua_GetLastError(hr_Lua_State* L);

    HR_API int32_t hr_Lua_GetVmId(hr_Lua_State* L);
    HR_API int32_t hr_Lua_GetTop(hr_Lua_State* L);
    HR_API void hr_Lua_Call(hr_Lua_State* L, int32_t functionRef, int32_t nargs, int32_t nresults);
    HR_API void hr_Lua_Collect(hr_Lua_State* state);
    HR_API void hr_Lua_RegisterTypes(hr_Lua_State* state, hr_Lua_TypeInfo * types);
    HR_API void hr_Lua_Run(hr_Lua_State* L, hr_Lua_ByteCode * byteCode, int32_t returns);
    HR_API hr_Lua_ParseResults * hr_Lua_Parse(const char* code, hr_Lua_ErrorFunctionPtr error);
    HR_API void hr_Lua_FreeParseResults(hr_Lua_ParseResults * results);
    HR_API hr_Lua_ByteCode* hr_Lua_Compile(const char* code);
    HR_API hr_Lua_ByteCode* hr_Lua_CreateByteCode(const uint8_t* bytes, int32_t size, const char* name);
    HR_API void hr_Lua_FreeByteCode(hr_Lua_ByteCode * byteCode);
    HR_API void hr_Lua_RegisterGlobals(hr_Lua_State* L, int32_t globalCount);
    HR_API int32_t hr_Lua_CheckStack(hr_Lua_State* L, int32_t count);
    HR_API void hr_Lua_Error(hr_Lua_State* L, const char* error);
    HR_API void hr_Lua_ArgError(hr_Lua_State* L, int index, const char* error);
    HR_API void hr_Lua_Insert(hr_Lua_State* L, int index);

    HR_API hr_Lua_TypeCode hr_Lua_GetTypeCode(const char* s);
    HR_API hr_Lua_Struct * hr_Lua_CreateStruct(hr_Lua_State* L, hr_Lua_TypeCode typeCode);

    HR_API void hr_Lua_NewTable(hr_Lua_State* L);
    HR_API void hr_Lua_SetTable(hr_Lua_State* L, int32_t index);
    HR_API void hr_Lua_GetTable(hr_Lua_State* l, int32_t index);
    HR_API bool hr_Lua_Next(hr_Lua_State* l, int32_t  index);
    HR_API int hr_Lua_ObjLen(hr_Lua_State* l, int32_t index);
    HR_API int32_t hr_Lua_Ref(hr_Lua_State* L, int32_t index);
    HR_API void hr_Lua_Unref(hr_Lua_State* L, int32_t ref);
    HR_API void hr_Lua_PushRef(hr_Lua_State* L, int32_t ref);

    HR_API hr_Lua_TypeCode hr_Lua_ToTypeCode(hr_Lua_State* L, int32_t index);
    HR_API int32_t hr_Lua_ToInteger(hr_Lua_State* L, int32_t index);
    HR_API int32_t hr_Lua_ToFunctionRef(hr_Lua_State* L, int32_t index);
    HR_API double_t hr_Lua_ToNumber(hr_Lua_State* state, int32_t index);
    HR_API int32_t hr_Lua_ToBoolean(hr_Lua_State* state, int32_t index);
    HR_API const char* hr_Lua_ToString(hr_Lua_State* state, int32_t index);
    HR_API hr_Lua_Struct * hr_Lua_ToStruct(hr_Lua_State* state, int32_t index);
    HR_API uint64_t hr_Lua_ToUInt64(hr_Lua_State* L, int32_t index);
    HR_API uint32_t hr_Lua_ToUInt32(hr_Lua_State* L, int32_t index);

    HR_API bool hr_Lua_GetStruct(hr_Lua_State* l, int32_t index, hr_Lua_TypeCode typeCode, hr_Lua_Struct** value);
    HR_API bool hr_Lua_TryGetStruct(hr_Lua_State* l, int32_t index, hr_Lua_TypeCode typeCode, hr_Lua_Struct** value);
    HR_API bool hr_Lua_RefEquals(hr_Lua_State* l, int lhs, int rhs);

    HR_API int32_t hr_Lua_OptBoolean(hr_Lua_State* state, int32_t index, int32_t defaultValue);

    HR_API void hr_Lua_PushString(hr_Lua_State* state, const char* value);
    HR_API void hr_Lua_PushNumber(hr_Lua_State* state, double_t value);
    HR_API void hr_Lua_PushInteger(hr_Lua_State* state, int32_t value);
    HR_API void hr_Lua_PushBoolean(hr_Lua_State* state, int32_t value);
    HR_API void hr_Lua_PushNil(hr_Lua_State* state);;

    HR_API void hr_Lua_Pop(hr_Lua_State* L, int32_t n);

    HR_API uint64_t hr_Lua_GetCallSignature(hr_Lua_State* L);
    HR_API void hr_Lua_GetCallParameters(hr_Lua_State* l, hr_Lua_TypeCode* params, int32_t argc);
    HR_API uint64_t hr_Lua_GenerateCallSignature(hr_Lua_TypeCode* args, int32_t nargs);


#ifdef __cplusplus
}
#endif

#pragma pack(pop)

#endif // __HR_LUA_H__
