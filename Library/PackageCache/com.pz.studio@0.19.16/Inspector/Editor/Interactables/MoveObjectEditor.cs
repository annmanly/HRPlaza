#if HR_LUA_GENERATED

using UnityEditor;
using UnityEngine;
using Highrise.Lua.Generated;

[CustomEditor(typeof(MoveObject)), CanEditMultipleObjects]
public class MoveObjectEditor : Editor
{
    private MoveObject _moveObject;

    private GUIStyle _labelStyle;

    private const float DiscRadius = 0.3f;
    private const float ArrowSize = 0.8f;
    private readonly Color LoopHandleColor = new(0f, 0.5f, 0.0f, 1.0f);
    private readonly Color HandleColor = new(0.5f, 0.0f, 0.0f, 1.0f);

    private void OnEnable()
    {
        _moveObject = target as MoveObject;
    }

    private GUIStyle GetGUILabel()
    {
        if (_labelStyle == null)
            _labelStyle = new GUIStyle("sv_label_2");

        return _labelStyle;
    }

    public override void OnInspectorGUI()
    {
        serializedObject.Update();

        EditorGUI.BeginDisabledGroup(true);
        EditorGUILayout.PropertyField(serializedObject.FindProperty("_script"));
        EditorGUI.EndDisabledGroup();
        EditorGUILayout.PropertyField(serializedObject.FindProperty("_objectToMove"));

        EditorGUILayout.PropertyField(serializedObject.FindProperty("_travelPoints"));

        EditorGUILayout.PropertyField(serializedObject.FindProperty("_durationInSeconds"));

        EditorGUILayout.PropertyField(serializedObject.FindProperty("_faceMoveDirection"));

        EditorGUILayout.PropertyField(serializedObject.FindProperty("_wrapBackToStart"));

        EditorGUILayout.PropertyField(serializedObject.FindProperty("_loop"));

        EditorGUILayout.PropertyField(serializedObject.FindProperty("_reverseAfterReachEnd"));

        EditorGUILayout.PropertyField(serializedObject.FindProperty("_smoothMove"));

        serializedObject.ApplyModifiedProperties();
    }

    public void OnSceneGUI()
    {
        if (Event.current.type != EventType.Repaint)
            return;

        if (_moveObject == null)
            return;

        if (Application.isPlaying)
            return;

        if (_moveObject._travelPoints == null)
            return;

        var color = _moveObject._loop ? LoopHandleColor : HandleColor;
        using (new Handles.DrawingScope(color))
        {
            for (int i = 0; i < _moveObject._travelPoints.Count; i++)
            {
                var point = _moveObject._travelPoints[i];
                if (point == null)
                    continue;

                Handles.DrawWireDisc(point.position, Vector3.up, DiscRadius);
                Handles.Label(point.position, $"Move Point {i}", GetGUILabel());

                //draw arrow to next point
                if (i < _moveObject._travelPoints.Count - 1)
                {
                    DrawArrow(point.position, _moveObject._travelPoints[i + 1].position);
                }

                if (_moveObject._wrapBackToStart)
                {
                    if (i == _moveObject._travelPoints.Count - 1)
                    {
                        DrawArrow(point.position, _moveObject._travelPoints[0].position);
                    }
                }
            }
        }
    }

    private void DrawArrow(Vector3 pos1, Vector3 pos2)
    {
        var direction = pos2 - pos1;
        Handles.DrawDottedLine(pos1, pos2, 5f);
        Handles.ArrowHandleCap(0, pos1, Quaternion.LookRotation(direction), ArrowSize, EventType.Repaint);
    }
}
#endif