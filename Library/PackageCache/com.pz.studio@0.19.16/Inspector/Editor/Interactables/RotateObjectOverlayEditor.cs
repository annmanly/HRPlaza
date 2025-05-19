#if HR_LUA_GENERATED && HR_STUDIO_SIMPLE

using UnityEditor;
using Highrise.Lua.Generated;
using Highrise.Studio.Tools;
using Highrise.Studio;
using UnityEngine.UIElements;
using UnityEngine;

[StudioEditor(typeof(RotateObject))]
public class RotateObjectOverlayEditor : Editor
{
    public override VisualElement CreateInspectorGUI()
    {
        var root = new VisualElement();
        StudioInspectorUIUtilities.AddInspectorStyleSheets(root);
        root.Add(StudioInspectorUIUtilities.CreateObjectField(serializedObject.FindProperty("_objectToRotate"), true));
        root.Add(StudioInspectorUIUtilities.CreateInputField(serializedObject.FindProperty("_xAxisRotationSpeed"), "X Rotation Speed"));
        root.Add(StudioInspectorUIUtilities.CreateInputField(serializedObject.FindProperty("_yAxisRotationSpeed"), "Y Rotation Speed"));
        root.Add(StudioInspectorUIUtilities.CreateInputField(serializedObject.FindProperty("_zAxisRotationSpeed"), "Z Rotation Speed"));
        root.Add(StudioInspectorUIUtilities.CreateInputField(serializedObject.FindProperty("_rotateDuration")));
        return root;
    }
}

#if HR_STUDIO_SIMULATOR
[Icon("Assets/Sprites/Icons/icon_rotate.png")]
#else
[Icon("Packages/com.pz.studio/Assets/Sprites/Icons/icon_rotate.png")]
#endif
public class RotateObjectBehaviour : StudioBehaviour
{
    public override string Name => "Rotate Object";
    public override UnityEngine.Object Add(GameObject parent)
    {
        return Undo.AddComponent(parent, typeof(RotateObject));
    }

    public override void OnAdd(GameObject parent, Object added)
    {
        var rotateObject = added as RotateObject;
        if (rotateObject == null)
            return;

        rotateObject._objectToRotate = rotateObject.transform;
    }
}
#endif