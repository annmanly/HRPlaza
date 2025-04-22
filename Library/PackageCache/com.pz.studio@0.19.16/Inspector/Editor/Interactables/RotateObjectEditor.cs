#if HR_LUA_GENERATED

using UnityEditor;
using UnityEngine;
using Highrise.Lua.Generated;

[CustomEditor(typeof(RotateObject)), CanEditMultipleObjects]
public class RotateObjectEditor : Editor
{
    private RotateObject _rotateObject;

    private const float DiscRadius = 0.5f;
    private const float ArrowSize = 0.5f;
    private readonly Color YHandleColor = new(0f, 0.7f, 0.0f, 1.0f);
    private readonly Color XHandleColor = new(0.7f, 0.0f, 0.0f, 1.0f);
    private readonly Color ZHandleColor = new(0.0f, 0.0f, 0.7f, 1.0f);

    private void OnEnable()
    {
        _rotateObject = target as RotateObject;
    }

    public override void OnInspectorGUI()
    {
        serializedObject.Update();

        EditorGUI.BeginDisabledGroup(true);
        EditorGUILayout.PropertyField(serializedObject.FindProperty("_script"));
        EditorGUI.EndDisabledGroup();
        EditorGUILayout.PropertyField(serializedObject.FindProperty("_objectToRotate"));

        EditorGUILayout.PropertyField(serializedObject.FindProperty("_xAxisRotationSpeed"));

        EditorGUILayout.PropertyField(serializedObject.FindProperty("_yAxisRotationSpeed"));

        EditorGUILayout.PropertyField(serializedObject.FindProperty("_zAxisRotationSpeed"));

        EditorGUILayout.PropertyField(serializedObject.FindProperty("_rotateDuration"));

        serializedObject.ApplyModifiedProperties();
    }

    public void OnSceneGUI()
    {
        if (Event.current.type != EventType.Repaint)
            return;

        if (_rotateObject == null)
            return;

        if (Application.isPlaying)
            return;

        using (new Handles.DrawingScope(XHandleColor))
        {
            if (_rotateObject._xAxisRotationSpeed != 0f)
            {
                Handles.DrawWireDisc(_rotateObject.transform.position, _rotateObject.transform.right, DiscRadius);

                float invertMult = _rotateObject._xAxisRotationSpeed < 0 ? 1f : -1f;
                //draw arrows for direction along disc
                DrawRotationArrow(invertMult, _rotateObject.transform.forward, _rotateObject.transform.up);
                DrawRotationArrow(-invertMult, -_rotateObject.transform.forward, _rotateObject.transform.up);
            }
        }

        using (new Handles.DrawingScope(YHandleColor))
        {
            if (_rotateObject._yAxisRotationSpeed != 0f)
            {
                Handles.DrawWireDisc(_rotateObject.transform.position, _rotateObject.transform.up, DiscRadius);

                float invertMult = _rotateObject._yAxisRotationSpeed < 0 ? 1f : -1f;
                //draw arrows for direction along disc
                DrawRotationArrow(invertMult, _rotateObject.transform.right, _rotateObject.transform.forward);
                DrawRotationArrow(-invertMult, -_rotateObject.transform.right, _rotateObject.transform.forward);
            }
        }

        using (new Handles.DrawingScope(ZHandleColor))
        {
            if (_rotateObject._zAxisRotationSpeed != 0f)
            {
                Handles.DrawWireDisc(_rotateObject.transform.position, _rotateObject.transform.forward, DiscRadius);

                //draw arrows for direction along disc
                float invertMult = _rotateObject._zAxisRotationSpeed < 0 ? 1f : -1f;
                DrawRotationArrow(invertMult, _rotateObject.transform.up, _rotateObject.transform.right);
                DrawRotationArrow(-invertMult, -_rotateObject.transform.up, _rotateObject.transform.right);
            }
        }
    }

    private void DrawRotationArrow(float invertMult, Vector3 direction, Vector3 perpendicularDir)
    {
        var arrowStart = _rotateObject.transform.position + direction * DiscRadius;
        //find perpendicular vector to the disc
        var arrowEnd = arrowStart + perpendicularDir * invertMult * ArrowSize;
        DrawArrow(arrowStart, arrowEnd);
    }

    private void DrawArrow(Vector3 pos1, Vector3 pos2)
    {
        var direction = pos2 - pos1;
        Handles.DrawDottedLine(pos1, pos2, 5f);
        Handles.ArrowHandleCap(0, pos1, Quaternion.LookRotation(direction), ArrowSize, EventType.Repaint);
    }
}
#endif