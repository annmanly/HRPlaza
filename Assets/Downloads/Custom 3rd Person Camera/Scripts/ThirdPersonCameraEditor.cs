using UnityEditor;
using UnityEngine;
using Highrise.Lua.Generated;
using Highrise.Studio;

[CustomEditor(typeof(Custom3rdPersonCam)), CanEditMultipleObjects]
public class Custom3rdPersonCamEditor : Editor
{
    private Custom3rdPersonCam _camera;

    private void OnEnable()
    {
        _camera = target as Custom3rdPersonCam;
    }

    public override void OnInspectorGUI()
    {
        serializedObject.Update();

        EditorGUILayout.Space(10);
        EditorGUILayout.LabelField("Camera Position", EditorStyles.boldLabel);
        EditorGUI.indentLevel++;
        EditorGUILayout.PropertyField(serializedObject.FindProperty("_cameraHeight"));
        EditorGUILayout.PropertyField(serializedObject.FindProperty("_offset"));
        EditorGUI.indentLevel--;

        EditorGUILayout.Space(10);
        EditorGUILayout.LabelField("Zoom Settings", EditorStyles.boldLabel);
        EditorGUI.indentLevel++;
        EditorGUILayout.PropertyField(serializedObject.FindProperty("_startZoom"));
        EditorGUILayout.PropertyField(serializedObject.FindProperty("_minimumZoom"));
        EditorGUILayout.PropertyField(serializedObject.FindProperty("_maximumZoom"));
        EditorGUI.indentLevel--;

        EditorGUILayout.Space(10);
        EditorGUILayout.LabelField("Rotation Settings", EditorStyles.boldLabel);
        EditorGUI.indentLevel++;
        
        SerializedProperty pitchEnabled = serializedObject.FindProperty("_pitchEnabled");
        EditorGUILayout.PropertyField(pitchEnabled);
        
        EditorGUI.BeginDisabledGroup(!pitchEnabled.boolValue);
        EditorGUI.indentLevel++;
        EditorGUILayout.PropertyField(serializedObject.FindProperty("_pitchStart"));
        EditorGUILayout.PropertyField(serializedObject.FindProperty("_pitchMin"));
        EditorGUILayout.PropertyField(serializedObject.FindProperty("_pitchMax"));
        EditorGUI.indentLevel--;
        EditorGUI.EndDisabledGroup();

        SerializedProperty yawEnabled = serializedObject.FindProperty("_yawEnabled");
        EditorGUILayout.PropertyField(yawEnabled);
        
        EditorGUI.BeginDisabledGroup(!yawEnabled.boolValue);
        EditorGUI.indentLevel++;
        EditorGUILayout.PropertyField(serializedObject.FindProperty("_yawMin"));
        EditorGUILayout.PropertyField(serializedObject.FindProperty("_yawMax"));
        EditorGUI.indentLevel--;
        EditorGUI.EndDisabledGroup();

        EditorGUILayout.PropertyField(serializedObject.FindProperty("_rotationSensitivity"));
        EditorGUI.indentLevel--;

        EditorGUILayout.Space(10);
        EditorGUILayout.LabelField("Collision Settings", EditorStyles.boldLabel);
        EditorGUI.indentLevel++;
        SerializedProperty collisionEnabled = serializedObject.FindProperty("_enableCollisionAvoidance");
        EditorGUILayout.PropertyField(collisionEnabled);
        
        EditorGUI.BeginDisabledGroup(!collisionEnabled.boolValue);
        EditorGUILayout.PropertyField(serializedObject.FindProperty("_collisionOffset"));
        EditorGUILayout.PropertyField(serializedObject.FindProperty("_obstacleDistanceMinFar"));
        EditorGUILayout.PropertyField(serializedObject.FindProperty("_obstacleDistanceMinNear"));
        EditorGUILayout.PropertyField(serializedObject.FindProperty("_rayDistanceMaxFar"));
        EditorGUILayout.PropertyField(serializedObject.FindProperty("_rayDistanceMinNear"));
        EditorGUI.EndDisabledGroup();
        EditorGUI.indentLevel--;

        EditorGUILayout.Space(10);
        EditorGUILayout.LabelField("First Person Settings", EditorStyles.boldLabel);
        EditorGUI.indentLevel++;
        SerializedProperty firstPersonEnabled = serializedObject.FindProperty("_enableFirstPerson");
        EditorGUILayout.PropertyField(firstPersonEnabled);
        
        EditorGUI.BeginDisabledGroup(!firstPersonEnabled.boolValue);
        EditorGUILayout.PropertyField(serializedObject.FindProperty("_firstPersonFOV"));
        
        SerializedProperty smoothTransition = serializedObject.FindProperty("_enableSmoothTransition");
        EditorGUILayout.PropertyField(smoothTransition);
        
        EditorGUI.BeginDisabledGroup(!smoothTransition.boolValue);
        EditorGUILayout.PropertyField(serializedObject.FindProperty("_FOVTransitionSpeed"));
        EditorGUI.EndDisabledGroup();
        
        EditorGUI.EndDisabledGroup();
        EditorGUILayout.PropertyField(serializedObject.FindProperty("_thirdPersonFOV"));
        EditorGUI.indentLevel--;

        serializedObject.ApplyModifiedProperties();
    }
}