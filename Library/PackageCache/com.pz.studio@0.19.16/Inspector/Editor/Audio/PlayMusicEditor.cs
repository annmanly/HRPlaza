#if HR_LUA_GENERATED

using UnityEditor;
using UnityEngine;
using Highrise.Lua.Generated;
using Highrise.Studio;

[CustomEditor(typeof(PlayMusic)), CanEditMultipleObjects]
public class PlayMusicEditor : Editor
{
    public override void OnInspectorGUI()
    {
        serializedObject.Update();

        EditorGUI.BeginDisabledGroup(true);
        EditorGUILayout.PropertyField(serializedObject.FindProperty("_script"));
        EditorGUI.EndDisabledGroup();
        EditorGUILayout.PropertyField(serializedObject.FindProperty("_playMusicFromURL"));

        SerializedProperty playMusicFromURL = serializedObject.FindProperty("_playMusicFromURL");
        if (playMusicFromURL.boolValue)
        {
            EditorGUI.indentLevel++;
            EditorGUILayout.PropertyField(serializedObject.FindProperty("_musicURL"));
            EditorGUI.indentLevel--;
        }
        else
        {
            SerializedProperty musicAudioShader = serializedObject.FindProperty("_musicAudioShader");
            EditorGUILayout.PropertyField(musicAudioShader);

            EditorGUI.indentLevel++;
            if (musicAudioShader.objectReferenceValue == null)
            {
                EditorGUILayout.Space();
                // Add a button to create an Audio Shader for each target
                if (GUILayout.Button("Create Audio Shader"))
                {
                    foreach (Object targetObject in targets)
                    {
                        PlayMusic playMusicTarget = targetObject as PlayMusic;
                        if (playMusicTarget != null && playMusicTarget._musicAudioShader == null)
                        {
                            var shader = AudioShaderUtility.CreateAudioShader();
                            if (shader != null)
                            {
                                playMusicTarget._musicAudioShader = shader;
                                EditorUtility.SetDirty(playMusicTarget);
                            }
                        }
                    }
                    AssetDatabase.SaveAssets();
                }
                EditorGUILayout.Space();
            }

            EditorGUILayout.PropertyField(serializedObject.FindProperty("_loopMusic"));
            EditorGUI.indentLevel--;
        }

        EditorGUILayout.PropertyField(serializedObject.FindProperty("_volume"));
        EditorGUILayout.PropertyField(serializedObject.FindProperty("_fadeIn"));

        serializedObject.ApplyModifiedProperties();
    }
}
#endif