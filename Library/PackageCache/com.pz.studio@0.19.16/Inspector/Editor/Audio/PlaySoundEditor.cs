#if HR_LUA_GENERATED

using UnityEditor;
using UnityEngine;
using Highrise.Lua.Generated;
using Highrise.Studio;

[CustomEditor(typeof(PlaySound)), CanEditMultipleObjects]
public class PlaySoundEditor : Editor
{
    public override void OnInspectorGUI()
    {
        serializedObject.Update();

        EditorGUI.BeginDisabledGroup(true);
        EditorGUILayout.PropertyField(serializedObject.FindProperty("_script"));
        EditorGUI.EndDisabledGroup();

        SerializedProperty audioShaderProp = serializedObject.FindProperty("_audioShader");
        EditorGUILayout.PropertyField(audioShaderProp);

        if (audioShaderProp.objectReferenceValue == null)
        {
            EditorGUILayout.Space();
            // Add a button to create an Audio Shader for each target
            if (GUILayout.Button("Create Audio Shader"))
            {
                foreach (Object targetObject in targets)
                {
                    PlaySound playSoundTarget = targetObject as PlaySound;
                    if (playSoundTarget != null && playSoundTarget._audioShader == null)
                    {
                        var shader = AudioShaderUtility.CreateAudioShader();
                        if (shader != null)
                        {
                            playSoundTarget._audioShader = shader;
                            EditorUtility.SetDirty(playSoundTarget);
                        }
                    }
                }
                AssetDatabase.SaveAssets();
            }
            EditorGUILayout.Space();
        }

        EditorGUILayout.PropertyField(serializedObject.FindProperty("_secondsDelay"));

        serializedObject.ApplyModifiedProperties();
    }
}
#endif