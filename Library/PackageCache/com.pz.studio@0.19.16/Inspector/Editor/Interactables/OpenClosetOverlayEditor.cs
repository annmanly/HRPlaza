#if HR_LUA_GENERATED && HR_STUDIO_SIMPLE

using UnityEditor;
using Highrise.Lua.Generated;
using UnityEngine.UIElements;
using Highrise.Studio.Tools;
using Highrise.Studio;
using Highrise.UI;
using UnityEngine;
using Highrise.Client;

[StudioEditor(typeof(OpenClosetObject))]
public class OpenClosetOverlayEditor : Editor
{
    private VisualElement _addOutfitButton;
    private SerializedProperty _useStartingOutfitProp;

    public override VisualElement CreateInspectorGUI()
    {
        var root = new VisualElement();
        StudioInspectorUIUtilities.AddInspectorStyleSheets(root);
        root.Add(StudioInspectorUIUtilities.CreateToggleField(serializedObject.FindProperty("_includePlayerClosetInventory"), overrideName: "Use Closet Inventory"));

        var collectionListField = StudioInspectorUIUtilities.CreateInputField(serializedObject.FindProperty("_includedClothingCollections"));
        root.Add(collectionListField);

        if (targets.Length <= 1)
        {
            root.Add(StudioInspectorUIUtilities.CreateButton("Add New Collection", () =>
            {
                var collection = OpenClosetObjectEditor.CreateClothingCollection(serializedObject, "ClosetClothingCollection", true);
                foreach (var target in targets)
                {
                    var closetTarget = target as OpenClosetObject;
                    closetTarget._startingClosetOutfit = collection;
                    UnityEditor.EditorUtility.SetDirty(closetTarget);
                }
                serializedObject.ApplyModifiedProperties();
                root.Remove(collectionListField);
                collectionListField = StudioInspectorUIUtilities.CreateInputField(serializedObject.FindProperty("_includedClothingCollections"));
                root.Insert(1, collectionListField);
            }));
        }

        _useStartingOutfitProp = serializedObject.FindProperty("_useCustomStartingOutfit");
        var startingOutfitToggleField = StudioInspectorUIUtilities.CreateInputField(_useStartingOutfitProp, "Custom Outfit");
        root.Add(startingOutfitToggleField);

        var startingOutfitProp = serializedObject.FindProperty("_startingClosetOutfit");
        var startingOutfitField = StudioInspectorUIUtilities.CreateObjectField(startingOutfitProp, overrideName: "Starting Outfit");
        root.Add(startingOutfitField);
        startingOutfitField.SetDisplay(_useStartingOutfitProp.boolValue);
        startingOutfitField.RegisterValueChangedCallback(evt =>
        {
            _addOutfitButton.SetDisplay(evt.newValue == null);
        });

        _addOutfitButton = StudioInspectorUIUtilities.CreateButton("Create", () =>
        {
            var collection = OpenClosetObjectEditor.CreateClothingCollection(serializedObject, "StartingOutfitClothingCollection", false);
            foreach (var target in targets)
            {
                var closetTarget = target as OpenClosetObject;
                closetTarget._startingClosetOutfit = collection;
                UnityEditor.EditorUtility.SetDirty(closetTarget);
            }

            _addOutfitButton.SetDisplay(false);
        });
        startingOutfitField.Add(_addOutfitButton);
        _addOutfitButton.SetDisplay(startingOutfitProp.objectReferenceValue == null);

        root.Add(StudioInspectorUIUtilities.CreateInputField(serializedObject.FindProperty("_closetTitle")));

        startingOutfitToggleField.RegisterCallback<ChangeEvent<bool>>(evt =>
        {
            startingOutfitField.SetDisplay(evt.newValue);
            _addOutfitButton.SetDisplay(evt.newValue && startingOutfitProp.objectReferenceValue == null);
        });
        return root;
    }
}

#if HR_STUDIO_SIMULATOR
[Icon("Assets/Sprites/Icons/closet_tops.png")]
#else
[Icon("Packages/com.pz.studio/Assets/Sprites/Icons/closet_tops.png")]
#endif
public class OpenClosetBehaviour : PrefabBehaviour
{
    public override string Name => "Open Closet";
    protected override string Path => "Packages/com.pz.studio/Editor/Interactables/OpenCloset.prefab";

    public override void OnAdd(GameObject parent, Object addedObject)
    {
        base.OnAdd(parent, addedObject);

        var addedGameObject = addedObject as GameObject;
        if (addedGameObject == null)
            return;

        var tapHandler = addedGameObject.GetComponent<TapHandler>();
        if (tapHandler == null)
            return;

        tapHandler.SetMoveTarget_Editor(addedGameObject.transform);

    }
}
#endif