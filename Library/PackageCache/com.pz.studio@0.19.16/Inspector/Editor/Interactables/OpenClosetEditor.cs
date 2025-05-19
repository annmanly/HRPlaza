#if HR_LUA_GENERATED

using UnityEditor;
using UnityEngine;
using Highrise.Lua.Generated;
using Highrise;
using Highrise.Studio.Clothing;

[CustomEditor(typeof(OpenClosetObject)), CanEditMultipleObjects]
public class OpenClosetObjectEditor : Editor
{
    public override void OnInspectorGUI()
    {
        serializedObject.Update();

        EditorGUI.BeginDisabledGroup(true);
        EditorGUILayout.PropertyField(serializedObject.FindProperty("_script"));
        EditorGUI.EndDisabledGroup();

        EditorGUILayout.PropertyField(serializedObject.FindProperty("_includePlayerClosetInventory"));

        SerializedProperty clothingCollectionsProp = serializedObject.FindProperty("_includedClothingCollections");
        EditorGUILayout.PropertyField(clothingCollectionsProp);

        EditorGUILayout.Space();
        if (GUILayout.Button("Add Additional Clothing"))
        {
            var collection = CreateClothingCollection(serializedObject, "ClosetClothingCollection", true, true);
            foreach (Object targetObject in targets)
            {
                OpenClosetObject openClosetTarget = targetObject as OpenClosetObject;
                if (openClosetTarget != null)
                {
                    openClosetTarget._startingClosetOutfit = collection;
                    UnityEditor.EditorUtility.SetDirty(openClosetTarget);
                }
            }
            serializedObject.ApplyModifiedProperties();
        }
        EditorGUILayout.Space(24);

        SerializedProperty useCustomStartingOutfitProp = serializedObject.FindProperty("_useCustomStartingOutfit");
        EditorGUILayout.PropertyField(useCustomStartingOutfitProp);

        if (useCustomStartingOutfitProp.boolValue)
        {
            SerializedProperty startingClosetOutfitProp = serializedObject.FindProperty("_startingClosetOutfit");
            EditorGUILayout.PropertyField(startingClosetOutfitProp);

            if (startingClosetOutfitProp.objectReferenceValue == null)
            {
                EditorGUILayout.Space();
                if (GUILayout.Button("Create Starting Outfit"))
                {
                    var collection = CreateClothingCollection(serializedObject, "StartingOutfitClothingCollection", false, true);
                    foreach (Object targetObject in targets)
                    {
                        var openClosetTarget = targetObject as OpenClosetObject;
                        if (openClosetTarget != null)
                        {
                            openClosetTarget._startingClosetOutfit = collection;
                            UnityEditor.EditorUtility.SetDirty(openClosetTarget);
                        }
                    }
                    serializedObject.ApplyModifiedProperties();
                }
                EditorGUILayout.Space();
            }
        }

        EditorGUILayout.PropertyField(serializedObject.FindProperty("_defaultToFirstTab"));

        EditorGUILayout.PropertyField(serializedObject.FindProperty("_closetTitle"));
        EditorGUILayout.PropertyField(serializedObject.FindProperty("_saveButtonText"));

        serializedObject.ApplyModifiedProperties();
    }

    public static ClothingCollection CreateClothingCollection(SerializedObject serializedObject, string name, bool array, bool selectObject = false)
    {
        string path = "Assets/" + name + ".asset";
        var collection = ScriptableObject.CreateInstance<ClothingCollection>();
        //find unique name
        path = AssetDatabase.GenerateUniqueAssetPath(path);
        AssetDatabase.CreateAsset(collection, path);
        if (array)
        {
            var prop = serializedObject.FindProperty("_includedClothingCollections");
            prop.arraySize++;
            prop.GetArrayElementAtIndex(prop.arraySize - 1).objectReferenceValue = collection;
        }

        AssetDatabase.SaveAssets();

        if (selectObject)
            Selection.activeObject = collection;

        EditorGUIUtility.PingObject(collection);

#if HR_STUDIO
        //open collection editor
        ClothingCollectionEditor.Show(collection);
#endif
        return collection;
    }
}
#endif