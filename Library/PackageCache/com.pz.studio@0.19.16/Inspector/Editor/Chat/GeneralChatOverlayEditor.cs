#if HR_LUA_GENERATED && HR_STUDIO_SIMPLE

using System;
using UnityEditor;
using Highrise.Lua.Generated;
using UnityEngine.UIElements;
using Highrise.Studio.Tools;
using Highrise.UI;
using Highrise.Studio;

[StudioEditor(typeof(GeneralChat))]
public class GeneralChatOverlayEditor : Editor
{
    public override VisualElement CreateInspectorGUI()
    {
        var root = new VisualElement();
        StudioInspectorUIUtilities.AddInspectorStyleSheets(root);
        root.Add(StudioInspectorUIUtilities.CreateInputField(serializedObject.FindProperty("m_enableVoice")));
        var proximityProp = serializedObject.FindProperty("m_enableProximityChat");
        var proximityField = StudioInspectorUIUtilities.CreateInputField(proximityProp, "Proximity Chat");
        root.Add(proximityField);

        var maxDistField = StudioInspectorUIUtilities.CreateInputField(serializedObject.FindProperty("m_maxVolumeDistance"));
        root.Add(maxDistField);
        var minDistField = StudioInspectorUIUtilities.CreateInputField(serializedObject.FindProperty("m_minVolumeDistance"));
        root.Add(minDistField);

        maxDistField.SetDisplay(proximityProp.boolValue);
        minDistField.SetDisplay(proximityProp.boolValue);

        proximityField.RegisterCallback<ChangeEvent<bool>>(evt =>
        {
            maxDistField.SetDisplay(evt.newValue);
            minDistField.SetDisplay(evt.newValue);
        });


        return root;
    }
}
#endif