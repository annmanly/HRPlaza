#if HR_LUA_GENERATED && HR_STUDIO_SIMPLE

using System;
using UnityEditor;
using Highrise.Lua.Generated;
using UnityEngine.UIElements;
using Highrise.Studio.Tools;
using Highrise.UI;
using Highrise.Studio;

[StudioEditor(typeof(RTSCamera))]
public class RTSCameraOverlayEditor : Editor
{
    public override VisualElement CreateInspectorGUI()
    {
        var root = new VisualElement();
        StudioInspectorUIUtilities.AddInspectorStyleSheets(root);
        root.Add(StudioInspectorUIUtilities.CreateInputField(serializedObject.FindProperty("m_zoom"), "Start Zoom"));
        root.Add(StudioInspectorUIUtilities.CreateInputField(serializedObject.FindProperty("m_zoomMin")));
        root.Add(StudioInspectorUIUtilities.CreateInputField(serializedObject.FindProperty("m_zoomMax")));
        root.Add(StudioInspectorUIUtilities.CreateInputField(serializedObject.FindProperty("m_allowRotation")));
        root.Add(StudioInspectorUIUtilities.CreateInputField(serializedObject.FindProperty("m_pitch")));
        root.Add(StudioInspectorUIUtilities.CreateInputField(serializedObject.FindProperty("m_centerOnCharacterWhenMovingSpeed"), "Follow Player Speed"));


        return root;
    }
}
#endif