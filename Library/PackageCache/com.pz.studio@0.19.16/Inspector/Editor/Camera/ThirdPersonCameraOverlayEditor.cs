#if HR_LUA_GENERATED && HR_STUDIO_SIMPLE

using UnityEditor;
using Highrise.Lua.Generated;
using UnityEngine.UIElements;
using Highrise.Studio.Tools;
using Highrise.Studio;

[StudioEditor(typeof(ThirdPersonCamera))]
public class ThirdPersonCameraOverlayEditor : Editor
{
    public override VisualElement CreateInspectorGUI()
    {
        var root = new VisualElement();
        StudioInspectorUIUtilities.AddInspectorStyleSheets(root);
        root.Add(StudioInspectorUIUtilities.CreateInputField(serializedObject.FindProperty("m_cameraPivotHeight"), "Pivot Height"));
        root.Add(StudioInspectorUIUtilities.CreateInputField(serializedObject.FindProperty("m_initalDistanceFromPivot"), "Distance From Pivot"));
        root.Add(StudioInspectorUIUtilities.CreateInputField(serializedObject.FindProperty("m_cameraOffset")));
        root.Add(StudioInspectorUIUtilities.CreateInputField(serializedObject.FindProperty("m_initialPitch")));

        return root;
    }
}
#endif