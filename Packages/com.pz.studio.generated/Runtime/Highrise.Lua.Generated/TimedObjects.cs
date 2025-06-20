/*

    Copyright (c) 2025 Pocketz World. All rights reserved.

    This is a generated file, do not edit!

    Generated by com.pz.studio
*/

#if UNITY_EDITOR

using System;
using System.Linq;
using UnityEngine;
using Highrise.Client;
using Highrise.Studio;
using Highrise.Lua;
using UnityEditor;

namespace Highrise.Lua.Generated
{
    [AddComponentMenu("Lua/TimedObjects")]
    [LuaRegisterType(0xa4edc52a91b4552c, typeof(LuaBehaviour))]
    public class TimedObjects : LuaBehaviourThunk
    {
        private const string s_scriptGUID = "de4da8efa80634319b871e1d36efca2c";
        public override string ScriptGUID => s_scriptGUID;

        [SerializeField] public System.Collections.Generic.List<UnityEngine.GameObject> m_objects = default;
        [SerializeField] public System.Collections.Generic.List<System.String> m_eventStartTimes = default;
        [SerializeField] public System.Collections.Generic.List<System.String> m_eventEndTimes = default;

        protected override SerializedPropertyValue[] SerializeProperties()
        {
            if (_script == null)
                return Array.Empty<SerializedPropertyValue>();

            return new SerializedPropertyValue[]
            {
                CreateSerializedProperty(_script.GetPropertyAt(0), m_objects),
                CreateSerializedProperty(_script.GetPropertyAt(1), m_eventStartTimes),
                CreateSerializedProperty(_script.GetPropertyAt(2), m_eventEndTimes),
            };
        }
        
#if HR_STUDIO
        [MenuItem("CONTEXT/TimedObjects/Edit Script")]
        private static void EditScript()
        {
            VisualStudioCodeOpener.OpenPath(AssetDatabase.GUIDToAssetPath(s_scriptGUID));
        }
#endif
    }
}

#endif
