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
    [AddComponentMenu("Lua/EventUIModule")]
    [LuaRegisterType(0x4ebe8f4351c9fecd, typeof(LuaBehaviour))]
    public class EventUIModule : LuaBehaviourThunk
    {
        private const string s_scriptGUID = "fbc293dee06d78f45a93eba1ff5aa680";
        public override string ScriptGUID => s_scriptGUID;

        [SerializeField] public System.String m_energyShopLink = "";
        [SerializeField] public System.String m_itemBoostShopLink = "";
        [SerializeField] public UnityEngine.GameObject m_tutorialPopupOBJ = default;
        [SerializeField] public UnityEngine.GameObject m_progressTiersOBJ = default;
        [SerializeField] public UnityEngine.GameObject m_EventInfoObj = default;
        [SerializeField] public UnityEngine.GameObject m_EventHudOBJ = default;
        [SerializeField] public UnityEngine.GameObject m_energyWidget = default;
        [SerializeField] public UnityEngine.GameObject m_EventObjs = default;
        [SerializeField] public UnityEngine.GameObject m_bongoMeterOBJ = default;
        [SerializeField] public UnityEngine.GameObject m_buffsShopOBJ = default;
        [SerializeField] public UnityEngine.GameObject m_rewardParticleOBJ = default;
        [SerializeField] public UnityEngine.GameObject m_buffHUDOBJ = default;
        [SerializeField] public UnityEngine.GameObject m_WelcomeUIObj = default;
        [SerializeField] public UnityEngine.GameObject m_HudButtonsOBJ = default;
        [SerializeField] public UnityEngine.GameObject m_mainCam = default;
        [SerializeField] public System.Collections.Generic.List<UnityEngine.Texture> m_BuffIcons = default;
        [SerializeField] public UnityEngine.Texture m_customCurrencyIcon = default;
        [SerializeField] public UnityEngine.Transform m_storeTransform = default;
        [SerializeField] public UnityEngine.ParticleSystem m_tutParticle = default;

        protected override SerializedPropertyValue[] SerializeProperties()
        {
            if (_script == null)
                return Array.Empty<SerializedPropertyValue>();

            return new SerializedPropertyValue[]
            {
                CreateSerializedProperty(_script.GetPropertyAt(0), m_energyShopLink),
                CreateSerializedProperty(_script.GetPropertyAt(1), m_itemBoostShopLink),
                CreateSerializedProperty(_script.GetPropertyAt(2), m_tutorialPopupOBJ),
                CreateSerializedProperty(_script.GetPropertyAt(3), m_progressTiersOBJ),
                CreateSerializedProperty(_script.GetPropertyAt(4), m_EventInfoObj),
                CreateSerializedProperty(_script.GetPropertyAt(5), m_EventHudOBJ),
                CreateSerializedProperty(_script.GetPropertyAt(6), m_energyWidget),
                CreateSerializedProperty(_script.GetPropertyAt(7), m_EventObjs),
                CreateSerializedProperty(_script.GetPropertyAt(8), m_bongoMeterOBJ),
                CreateSerializedProperty(_script.GetPropertyAt(9), m_buffsShopOBJ),
                CreateSerializedProperty(_script.GetPropertyAt(10), m_rewardParticleOBJ),
                CreateSerializedProperty(_script.GetPropertyAt(11), m_buffHUDOBJ),
                CreateSerializedProperty(_script.GetPropertyAt(12), m_WelcomeUIObj),
                CreateSerializedProperty(_script.GetPropertyAt(13), m_HudButtonsOBJ),
                CreateSerializedProperty(_script.GetPropertyAt(14), m_mainCam),
                CreateSerializedProperty(_script.GetPropertyAt(15), m_BuffIcons),
                CreateSerializedProperty(_script.GetPropertyAt(16), m_customCurrencyIcon),
                CreateSerializedProperty(_script.GetPropertyAt(17), m_storeTransform),
                CreateSerializedProperty(_script.GetPropertyAt(18), m_tutParticle),
            };
        }
        
#if HR_STUDIO
        [MenuItem("CONTEXT/EventUIModule/Edit Script")]
        private static void EditScript()
        {
            VisualStudioCodeOpener.OpenPath(AssetDatabase.GUIDToAssetPath(s_scriptGUID));
        }
#endif
    }
}

#endif
