#if HR_LUA_GENERATED && HR_STUDIO_SIMPLE

using UnityEditor;
using Highrise.Lua.Generated;
using UnityEngine.UIElements;
using Highrise.Studio.Tools;
using Highrise.Studio;
using UnityEngine;

[StudioEditor(typeof(MoveObject))]
public class MoveObjectOverlayEditor : Editor
{
    public override VisualElement CreateInspectorGUI()
    {
        var root = new VisualElement();
        StudioInspectorUIUtilities.AddInspectorStyleSheets(root);
        root.Add(StudioInspectorUIUtilities.CreateObjectField(serializedObject.FindProperty("_objectToMove"), true));

        var travelPointsProp = serializedObject.FindProperty("_travelPoints");
        var travelsPointField = StudioInspectorUIUtilities.CreateInputField(travelPointsProp);
        root.Add(travelsPointField);

        if (targets.Length <= 1)
        {
            root.Add(StudioInspectorUIUtilities.CreateButton("Add New Travel Point", () =>
            {
                var child = new GameObject("TravelPoint");
                child.transform.SetParent((target as MoveObject).transform);

                travelPointsProp.arraySize++;
                travelPointsProp.GetArrayElementAtIndex(travelPointsProp.arraySize - 1).objectReferenceValue = child;
                serializedObject.ApplyModifiedProperties();

                Selection.activeGameObject = child;
            }));
        }

        root.Add(StudioInspectorUIUtilities.CreateInputField(serializedObject.FindProperty("_durationInSeconds")));
        root.Add(StudioInspectorUIUtilities.CreateInputField(serializedObject.FindProperty("_faceMoveDirection")));
        root.Add(StudioInspectorUIUtilities.CreateInputField(serializedObject.FindProperty("_wrapBackToStart")));
        root.Add(StudioInspectorUIUtilities.CreateInputField(serializedObject.FindProperty("_loop")));
        root.Add(StudioInspectorUIUtilities.CreateInputField(serializedObject.FindProperty("_reverseAfterReachEnd"), "Reverse After End"));
        return root;
    }
}

#if HR_STUDIO_SIMULATOR
[Icon("Assets/Sprites/Icons/icon_move_all.png")]
#else
[Icon("Packages/com.pz.studio/Assets/Sprites/Icons/icon_move_all.png")]
#endif
public class MoveObjectBehaviour : PrefabBehaviour
{
    public override string Name => "Move Object";
    protected override string Path => "Packages/com.pz.studio/Editor/Interactables/MoveObject.prefab";

    public override void OnAdd(GameObject parent, Object addedObject)
    {
        base.OnAdd(parent, addedObject);

        var addedGameObject = addedObject as GameObject;
        if (addedGameObject == null)
            return;

        var moveObject = addedGameObject.GetComponent<MoveObject>();
        if (moveObject == null)
            return;

        moveObject._objectToMove = parent.transform;
    }
}
#endif