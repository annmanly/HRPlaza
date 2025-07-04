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
    [AddComponentMenu("Lua/SlotMachineUI")]
    [LuaRegisterType(0x7120a3d31ca1ee9c, typeof(LuaBehaviour))]
    public class SlotMachineUI : LuaBehaviourThunk
    {
        private const string s_scriptGUID = "e263252658ae97f40bbda58ada70b38c";
        public override string ScriptGUID => s_scriptGUID;

        [SerializeField] public UnityEngine.ParticleSystem m_Particle = default;
        [SerializeField] public System.Collections.Generic.List<UnityEngine.Texture> m_ItemIcons = default;

        protected override SerializedPropertyValue[] SerializeProperties()
        {
            if (_script == null)
                return Array.Empty<SerializedPropertyValue>();

            return new SerializedPropertyValue[]
            {
                CreateSerializedProperty(_script.GetPropertyAt(0), m_Particle),
                CreateSerializedProperty(_script.GetPropertyAt(1), m_ItemIcons),
                CreateSerializedProperty(_script.GetPropertyAt(2), null),
                CreateSerializedProperty(_script.GetPropertyAt(3), null),
            };
        }
        
#if HR_STUDIO
        [MenuItem("CONTEXT/SlotMachineUI/Edit Script")]
        private static void EditScript()
        {
            VisualStudioCodeOpener.OpenPath(AssetDatabase.GUIDToAssetPath(s_scriptGUID));
        }
#endif
    }
}

#endif
