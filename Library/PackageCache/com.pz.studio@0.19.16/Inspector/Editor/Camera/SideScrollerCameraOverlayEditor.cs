#if HR_LUA_GENERATED && HR_STUDIO_SIMPLE

using UnityEditor;
using Highrise.UI;
using Highrise.Lua.Generated;
using UnityEngine.UIElements;
using Highrise.Studio.Tools;
using Highrise.Studio;

[StudioEditor(typeof(SideScrollerCamera))]
public class SideScrollerCameraOverlayEditor : Editor
{
    public override VisualElement CreateInspectorGUI()
    {
        var root = new VisualElement();
        StudioInspectorUIUtilities.AddInspectorStyleSheets(root);
        var canZoomProp = serializedObject.FindProperty("m_canZoom");
        var canZoomField = StudioInspectorUIUtilities.CreateInputField(canZoomProp);
        root.Add(canZoomField);


        root.Add(StudioInspectorUIUtilities.CreateInputField(serializedObject.FindProperty("m_zoom")));
        var zoomMinProp = serializedObject.FindProperty("m_zoomMin");
        var zoomMinField = StudioInspectorUIUtilities.CreateInputField(zoomMinProp);
        root.Add(zoomMinField);
        var zoomMaxProp = serializedObject.FindProperty("m_zoomMax");
        var zoomMaxField = StudioInspectorUIUtilities.CreateInputField(zoomMaxProp);
        root.Add(zoomMaxField);

        zoomMinField.SetDisplay(canZoomProp.boolValue);
        zoomMaxField.SetDisplay(canZoomProp.boolValue);

        canZoomField.RegisterCallback<ChangeEvent<bool>>(evt =>
        {
            zoomMinField.SetDisplay(evt.newValue);
            zoomMaxField.SetDisplay(evt.newValue);
        });


        root.Add(StudioInspectorUIUtilities.CreateInputField(serializedObject.FindProperty("m_camerFollowPlayer"), "Follow Player"));

        root.Add(StudioInspectorUIUtilities.CreateInputField(serializedObject.FindProperty("m_canPan")));

        return root;
    }
}
#endif