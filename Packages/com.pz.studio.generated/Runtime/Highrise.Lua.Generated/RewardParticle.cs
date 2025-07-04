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
    [AddComponentMenu("Lua/RewardParticle")]
    [LuaRegisterType(0x47ac0d873a575b14, typeof(LuaBehaviour))]
    public class RewardParticle : LuaBehaviourThunk
    {
        private const string s_scriptGUID = "0927e5fadc3b0bf41b6b2f1d59698d54";
        public override string ScriptGUID => s_scriptGUID;

        [SerializeField] public UnityEngine.Texture m_starSprite = default;
        [SerializeField] public UnityEngine.Texture m_chipsSprite = default;

        protected override SerializedPropertyValue[] SerializeProperties()
        {
            if (_script == null)
                return Array.Empty<SerializedPropertyValue>();

            return new SerializedPropertyValue[]
            {
                CreateSerializedProperty(_script.GetPropertyAt(0), m_starSprite),
                CreateSerializedProperty(_script.GetPropertyAt(1), m_chipsSprite),
                CreateSerializedProperty(_script.GetPropertyAt(2), null),
            };
        }
        
#if HR_STUDIO
        [MenuItem("CONTEXT/RewardParticle/Edit Script")]
        private static void EditScript()
        {
            VisualStudioCodeOpener.OpenPath(AssetDatabase.GUIDToAssetPath(s_scriptGUID));
        }
#endif
    }
}

#endif
