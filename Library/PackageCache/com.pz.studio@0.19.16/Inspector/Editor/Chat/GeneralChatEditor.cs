#if HR_LUA_GENERATED

using System;
using UnityEditor;
using Highrise.Lua.Generated;

[CustomEditor(typeof(GeneralChat)), CanEditMultipleObjects]
public class GeneralChatEditor : Editor
{
    enum DefaultChannel
    {
        NoVoice,
        Voice,
        Broadcast
    }

    public override void OnInspectorGUI()
    {
        serializedObject.Update();

        EditorGUI.BeginDisabledGroup(true);
        EditorGUILayout.PropertyField(serializedObject.FindProperty("_script"));
        EditorGUI.EndDisabledGroup();

        var enableVoiceProperty = serializedObject.FindProperty("m_enableVoice");
        EditorGUILayout.PropertyField(enableVoiceProperty);
        if (enableVoiceProperty.boolValue)
        {
            var defaultChannelProperty = serializedObject.FindProperty("m_defaultChannel");
            defaultChannelProperty.doubleValue = Convert.ToInt32(EditorGUILayout.EnumPopup("Default Channel", (DefaultChannel)defaultChannelProperty.doubleValue));

            EditorGUILayout.PropertyField(serializedObject.FindProperty("m_noVoiceChannelName"));
            EditorGUILayout.PropertyField(serializedObject.FindProperty("m_voiceChannelName"));
            EditorGUILayout.PropertyField(serializedObject.FindProperty("m_broadcastChannelName"));

            var proximityChatProperty = serializedObject.FindProperty("m_enableProximityChat");
            EditorGUILayout.PropertyField(proximityChatProperty);
            if (proximityChatProperty.boolValue)
            {
                EditorGUI.indentLevel++;
                EditorGUILayout.PropertyField(serializedObject.FindProperty("m_maxVolumeDistance"));
                EditorGUILayout.PropertyField(serializedObject.FindProperty("m_minVolumeDistance"));
                EditorGUI.indentLevel--;
            }
        }

        serializedObject.ApplyModifiedProperties();
    }
}
#endif