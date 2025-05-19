#if HR_LUA_GENERATED && HR_STUDIO_SIMPLE

using UnityEditor;
using Highrise.Lua.Generated;
using UnityEngine.UIElements;
using Highrise.Studio.Tools;
using Highrise.Studio;

[StudioEditor(typeof(FirstPersonCamera))]
public class FirstPersonCameraOverlayEditor : Editor
{
    public override VisualElement CreateInspectorGUI()
    {
        var root = new VisualElement();
        StudioInspectorUIUtilities.AddInspectorStyleSheets(root);
        root.Add(StudioInspectorUIUtilities.CreateInputField(serializedObject.FindProperty("m_cameraHeightFromPlayer"), "Camera Height"));

        return root;
    }
}
#endif