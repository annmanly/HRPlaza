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
    [AddComponentMenu("Lua/NPCBehaviour")]
    [LuaRegisterType(0xc8085fcaf21dce0b, typeof(LuaBehaviour))]
    public class NPCBehaviour : LuaBehaviourThunk
    {
        private const string s_scriptGUID = "cb109d9aba0b1e544b04f433a8b603de";
        public override string ScriptGUID => s_scriptGUID;

        [Tooltip("The camera to use for the NPC's view")]
        [SerializeField] public UnityEngine.Camera _Camera = default;
        [Tooltip("Whether the NPC is moving or not")]
        [SerializeField] public System.Boolean _IsStatic = false;
        [Tooltip("The radius of the NPC's view")]
        [SerializeField] public System.Double _ViewRadius = 4;
        [Tooltip("The time the NPC will wait to move")]
        [SerializeField] public System.Double _WaitToMoveTime = 10;
        [Tooltip("The waypoints the NPC will move to")]
        [SerializeField] public System.Collections.Generic.List<UnityEngine.Transform> _WayPoints = default;
        [Tooltip("Whether the NPC should idle and wander")]
        [SerializeField] public System.Boolean _ShouldIdleWander = true;
        [Tooltip("The minimum time the NPC will wait before wandering")]
        [SerializeField] public System.Double _MinTimeBeforeWander = 1;
        [Tooltip("The maximum time the NPC will wait before wandering")]
        [SerializeField] public System.Double _MaxTimeBeforeWander = 5;
        [Tooltip("The percentage of the time the NPC will wander")]
        [SerializeField] public System.Double _PercentToWander = 0.67;
        [Tooltip("The animations the NPC will play when idle")]
        [SerializeField] public System.Collections.Generic.List<System.String> _IdleAnimationsToPlay = default;
        [Tooltip("The radius of the NPC's wander")]
        [SerializeField] public System.Double _WanderRadius = 3;
        [Tooltip("The chance the NPC will stop and do idle animation at waypoint")]
        [SerializeField] public System.Double _ChanceToStop = 0.3;
        [Tooltip("Whether to show the NPC's nameplate")]
        [SerializeField] public System.Boolean _ShowNamePlate = true;
        [Tooltip("The prefab for the NPC's nameplate")]
        [SerializeField] public UnityEngine.GameObject _NPCNameLabelPrefab = default;
        [Tooltip("The offset of the NPC's nameplate")]
        [SerializeField] public System.Double _NamePlateOffset = 3.5;
        [Tooltip("The distance to show the NPC's nameplate")]
        [SerializeField] public System.Double _DistanceToShowNamePlate = 10;

        protected override SerializedPropertyValue[] SerializeProperties()
        {
            if (_script == null)
                return Array.Empty<SerializedPropertyValue>();

            return new SerializedPropertyValue[]
            {
                CreateSerializedProperty(_script.GetPropertyAt(0), _Camera),
                CreateSerializedProperty(_script.GetPropertyAt(1), _IsStatic),
                CreateSerializedProperty(_script.GetPropertyAt(2), _ViewRadius),
                CreateSerializedProperty(_script.GetPropertyAt(3), _WaitToMoveTime),
                CreateSerializedProperty(_script.GetPropertyAt(4), _WayPoints),
                CreateSerializedProperty(_script.GetPropertyAt(5), _ShouldIdleWander),
                CreateSerializedProperty(_script.GetPropertyAt(6), _MinTimeBeforeWander),
                CreateSerializedProperty(_script.GetPropertyAt(7), _MaxTimeBeforeWander),
                CreateSerializedProperty(_script.GetPropertyAt(8), _PercentToWander),
                CreateSerializedProperty(_script.GetPropertyAt(9), _IdleAnimationsToPlay),
                CreateSerializedProperty(_script.GetPropertyAt(10), _WanderRadius),
                CreateSerializedProperty(_script.GetPropertyAt(11), _ChanceToStop),
                CreateSerializedProperty(_script.GetPropertyAt(12), _ShowNamePlate),
                CreateSerializedProperty(_script.GetPropertyAt(13), _NPCNameLabelPrefab),
                CreateSerializedProperty(_script.GetPropertyAt(14), _NamePlateOffset),
                CreateSerializedProperty(_script.GetPropertyAt(15), _DistanceToShowNamePlate),
            };
        }
        
#if HR_STUDIO
        [MenuItem("CONTEXT/NPCBehaviour/Edit Script")]
        private static void EditScript()
        {
            VisualStudioCodeOpener.OpenPath(AssetDatabase.GUIDToAssetPath(s_scriptGUID));
        }
#endif
    }
}

#endif
