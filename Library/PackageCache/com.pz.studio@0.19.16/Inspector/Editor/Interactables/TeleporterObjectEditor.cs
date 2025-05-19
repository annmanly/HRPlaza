#if HR_LUA_GENERATED

using UnityEditor;
using UnityEngine;
using Highrise.Lua.Generated;
using Highrise.Studio;

[CustomEditor(typeof(TeleporterObject)), CanEditMultipleObjects]
public class TeleporterObjectEditor : Editor
{
    private GUIStyle _labelStyle = null;
    private TeleporterObject _teleporter;

    private const float DiscRadius = 0.3f;
    private readonly Color HandleColor = new(0f, 0.0f, 0.5f, 1.0f);

    private void OnEnable()
    {
        _teleporter = target as TeleporterObject;
    }

    public override void OnInspectorGUI()
    {
        serializedObject.Update();

        EditorGUILayout.PropertyField(serializedObject.FindProperty("m_destination"));

        EditorGUILayout.PropertyField(serializedObject.FindProperty("m_teleportCharactersOnly"));

        var playSoundProp = serializedObject.FindProperty("m_playSound");
        EditorGUILayout.PropertyField(playSoundProp);
        if (playSoundProp.boolValue)
        {
            EditorGUI.indentLevel++;
            var audioShaderProp = serializedObject.FindProperty("m_soundToPlay");
            EditorGUILayout.PropertyField(audioShaderProp);

            if (audioShaderProp.objectReferenceValue == null)
            {
                EditorGUILayout.Space();
                // Add a button to create an Audio Shader for each target
                if (GUILayout.Button("Create Audio Shader"))
                {
                    foreach (Object targetObject in targets)
                    {
                        var teleporterTarget = targetObject as TeleporterObject;
                        if (teleporterTarget != null && teleporterTarget.m_soundToPlay == null)
                        {
                            var shader = AudioShaderUtility.CreateAudioShader();
                            if (shader != null)
                            {
                                teleporterTarget.m_soundToPlay = shader;
                                EditorUtility.SetDirty(teleporterTarget);
                            }
                        }
                    }
                    AssetDatabase.SaveAssets();
                }
                EditorGUILayout.Space();
            }
            EditorGUI.indentLevel--;
        }

        var playParticleEffectProp = serializedObject.FindProperty("m_playParticleEffect");
        EditorGUILayout.PropertyField(playParticleEffectProp);
        if (playParticleEffectProp.boolValue)
        {
            EditorGUI.indentLevel++;
            EditorGUILayout.PropertyField(serializedObject.FindProperty("m_teleportParticles"));
            EditorGUI.indentLevel--;
        }

        EditorGUILayout.PropertyField(serializedObject.FindProperty("m_resetCameraAfterTeleport"));

        var sceneView = SceneView.lastActiveSceneView;
        if (sceneView != null)
        {
            EditorGUILayout.BeginHorizontal();
            if (GUILayout.Button("Look At Teleporter"))
            {
                var teleporter = (TeleporterObject)targets[0];
                sceneView.LookAt(teleporter.transform.position, sceneView.rotation, 2.0f);
            }
            if (GUILayout.Button("Look At Destination"))
            {
                var teleporter = (TeleporterObject)targets[0];
                sceneView.LookAt(teleporter.m_destination.position, sceneView.rotation, 2.0f);
            }
            EditorGUILayout.EndHorizontal();
        }

        serializedObject.ApplyModifiedProperties();
    }

    public void OnSceneGUI()
    {
        using (new Handles.DrawingScope(HandleColor))
        {
            Handles.DrawWireDisc(_teleporter.transform.position, Vector3.up, DiscRadius);

            if (_teleporter.m_destination == null)
                return;

            var destination = _teleporter.m_destination;
            Handles.DrawWireDisc(destination.position, Vector3.up, DiscRadius);

            EditorGUI.BeginChangeCheck();
            var newDestination = Handles.PositionHandle(destination.position, destination.rotation);
            if (EditorGUI.EndChangeCheck())
            {
                Undo.RecordObject(destination, "Move Destination");
                destination.position = newDestination;
            }

            _labelStyle ??= new GUIStyle("sv_label_2");
            if (_labelStyle != null)
                Handles.Label(destination.position, "Destination", _labelStyle);
        }
    }
}
#endif