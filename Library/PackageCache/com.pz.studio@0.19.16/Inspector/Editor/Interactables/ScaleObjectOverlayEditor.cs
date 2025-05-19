#if HR_LUA_GENERATED && HR_STUDIO_SIMPLE
using Highrise.Lua.Generated;
using Highrise.Studio;
using Highrise.Studio.Tools;
using UnityEditor;
using UnityEngine;
using UnityEngine.UIElements;

[StudioEditor(typeof(ScaleObject))]
public class ScaleObjectOverlayEditor : Editor
{
    public override VisualElement CreateInspectorGUI()
    {
        var root = new VisualElement();
        StudioInspectorUIUtilities.AddInspectorStyleSheets(root);
        root.Add(StudioInspectorUIUtilities.CreateObjectField(serializedObject.FindProperty("_objectToScale"), true));
        root.Add(StudioInspectorUIUtilities.CreateInputField(serializedObject.FindProperty("_startScale")));
        root.Add(StudioInspectorUIUtilities.CreateInputField(serializedObject.FindProperty("_endScale")));
        root.Add(StudioInspectorUIUtilities.CreateInputField(serializedObject.FindProperty("_durationInSeconds"), "Duration"));
        root.Add(StudioInspectorUIUtilities.CreateInputField(serializedObject.FindProperty("_loop")));
        return root;
    }
}

#if HR_STUDIO_SIMULATOR
[Icon("Assets/Sprites/Icons/icon_move_vertical.png")]
#else
[Icon("Packages/com.pz.studio/Assets/Sprites/Icons/icon_move_vertical.png")]
#endif
public class ScaleObjectBehaviour : StudioBehaviour
{
    public override string Name => "Scale Object";
    public override UnityEngine.Object Add(GameObject parent)
    {
        return Undo.AddComponent(parent, typeof(ScaleObject));
    }

    public override void OnAdd(GameObject parent, Object added)
    {
        var rotateObject = added as ScaleObject;
        if (rotateObject == null)
            return;

        rotateObject._objectToScale = rotateObject.transform;
    }
}
#endif