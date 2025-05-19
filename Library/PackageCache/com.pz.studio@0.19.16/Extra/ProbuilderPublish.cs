/*

    Copyright (c) 2024 Pocketz World. All rights reserved.

*/

#if HR_PROBUILDER

using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using Highrise.Build;
using UnityEditor;
using UnityEditor.ProBuilder;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.Scripting;
using UnityEngine.ProBuilder;
using UnityEngine.SceneManagement;

using Highrise.Studio.Bundle;
using BuildPipeline = Highrise.Build.BuildPipeline;
using Object = UnityEngine.Object;
using UEditorUtility = UnityEditor.EditorUtility;

namespace Highrise.Studio
{
    /// <summary>
    /// Remove Probuilder components at publish time.
    /// </summary>
    [Preserve]
    internal class ProbuilderPublish : BundleBuilderPreProcessor
    {
        private const string ProbuilderMeshAssetPath = "Assets/HR_ProbuilderMeshAssets";

        private static readonly string[] ProbuilderComponentFilter = new[]
        {
            "UnityEngine.ProBuilder.Entity",
            "UnityEngine.ProBuilder.Shapes.ProBuilderShape",
            "UnityEngine.ProBuilder.BezierShape",
        };

        private static IEnumerable<T> FindAllInScenes<T>(BuildPipeline builder) where T : Object
        {
            var scenes = WorldSettings.instance.GetScenes().Select(AssetDatabase.GetAssetPath);
            foreach (var path in scenes)
            {
                Scene scene;

                try
                {
                    scene = EditorSceneManager.OpenScene(path, OpenSceneMode.Single);
                }
                catch(Exception e)
                {
                    builder.LogException(e);
                    continue;
                }

                var modified = false;
                foreach(var go in scene.GetRootGameObjects())
                    foreach (var value in go.GetComponentsInChildren<T>())
                        if (!UEditorUtility.IsPersistent(value))
                        {
                            modified = true;
                            yield return value;
                        }


                if (!modified)
                    yield break;

                EditorSceneManager.SaveOpenScenes();
                AssetDatabase.ImportAsset(path, ImportAssetOptions.ForceSynchronousImport);
            }
        }

        private static void RemoveComponents(BuildPipeline builder, GameObject gameObject)
        {
            if (!gameObject.TryGetComponent<ProBuilderMesh>(out var probuilderMeshComponent)
                || !gameObject.TryGetComponent<MeshFilter>(out var filter))
                return;

            // Probuilder mesh assets are not saved in prefabs, so we need to force that mesh into
            // existence before saving it.
            if (PrefabUtility.IsPartOfPrefabAsset(gameObject))
            {
                probuilderMeshComponent.ToMesh();
                probuilderMeshComponent.Refresh();
                EditorMeshUtility.Optimize(probuilderMeshComponent, true);
            }

            if(filter.sharedMesh == null)
                return;

            if (gameObject.TryGetComponent(out PolyShape polyShape))
                Object.DestroyImmediate(polyShape, true);

            for (int i = gameObject.GetComponentCount() - 1; i > -1; --i)
            {
                var component = gameObject.GetComponentAtIndex(i);
                var type = component?.GetType().FullName;
                if(!string.IsNullOrEmpty(type) && ProbuilderComponentFilter.Any(x=> type.Contains(x)))
                    Object.DestroyImmediate(component, true);
            }

            var mesh = filter.sharedMesh;

            if (string.IsNullOrEmpty(AssetDatabase.GetAssetPath(mesh)))
            {
                Directory.CreateDirectory(ProbuilderMeshAssetPath);
                var meshPath = AssetDatabase.GenerateUniqueAssetPath($"{ProbuilderMeshAssetPath}/{mesh.name}.asset");
                AssetDatabase.CreateAsset(mesh, meshPath);
                AssetDatabase.ImportAsset(meshPath, ImportAssetOptions.ForceSynchronousImport);
            }
            else
                builder.LogVerbose($"Skipping mesh asset creation for {mesh.name} because it already " +
                          $"exists! {AssetDatabase.GetAssetPath(mesh)}");

            probuilderMeshComponent.preserveMeshAssetOnDestroy = true;

            Object.DestroyImmediate(probuilderMeshComponent, true);

            if (PrefabUtility.IsPartOfPrefabAsset(gameObject))
            {
                PrefabUtility.SavePrefabAsset(gameObject, out bool success);
                if (!success)
                    builder.LogError($"Failed saving prefab asset: {gameObject}");
                else
                    builder.LogVerbose($"Destroy pbmesh, prefab instance: {gameObject} {gameObject.GetInstanceID()} mesh: {(mesh != null ? AssetDatabase.GetAssetPath(mesh) : "null")}");
            }
            else
            {
                if (PrefabUtility.IsPartOfPrefabInstance(gameObject))
                {
                    PrefabUtility.RecordPrefabInstancePropertyModifications(filter);
                    builder.LogVerbose($"Destroy pbmesh, prefab instance: {gameObject} {gameObject.GetInstanceID()} mesh: {(mesh != null ? AssetDatabase.GetAssetPath(mesh) : "null")}");
                }
                else
                {
                    builder.LogVerbose(
                        $"Destroy pbmesh, scene: {gameObject} {gameObject.GetInstanceID()} mesh: {(mesh != null ? AssetDatabase.GetAssetPath(mesh) : "null")}");
                    UEditorUtility.SetDirty(gameObject);
                }
            }
        }

        public override void Execute(BuildPipeline builder)
        {
            // Process all scenes
            foreach (var mesh in FindAllInScenes<ProBuilderMesh>(builder))
            {
                if (PrefabUtility.IsPartOfPrefabInstance(mesh))
                {
                    var modifications = PrefabUtility.GetPropertyModifications(mesh);

                    // When a Probuilder mesh is modified we keep the in-scene mesh rather than
                    // linking it to the prefab asset.
                    if (modifications.Any(x => x.propertyPath == "m_VersionIndex" && x.target is ProBuilderMesh))
                    {
                        builder.LogVerbose($"Modified prefab instance m_Mesh property: {mesh.gameObject} {mesh.gameObject.GetInstanceID()}");
                        RemoveComponents(builder, mesh.gameObject);
                    }
                    // If the ProbuilderMesh is not modified, we'll remove the "m_Mesh"
                    // overrides. This allows the changes to the prefab asset to be applied in the
                    // next step where we process prefabs.
                    else
                    {
                        var filtered = new List<PropertyModification>(modifications.Length);
                        foreach(var mod in modifications)
                            if(!(mod.propertyPath == "m_Mesh" && mod.target is ProBuilderMesh or MeshCollider or MeshFilter))
                                filtered.Add(mod);
                        var outermost = PrefabUtility.GetOutermostPrefabInstanceRoot(mesh);
                        PrefabUtility.SetPropertyModifications(outermost, filtered.ToArray());
                        builder.LogVerbose($"Revert m_Mesh property, prefab instance: {mesh.gameObject} {mesh.gameObject.GetInstanceID()}");
                    }
                }
                else
                {
                    RemoveComponents(builder, mesh.gameObject);
                }
            }

            // Process all prefabs
            foreach (var guid in AssetDatabase.FindAssets("t:prefab"))
            {
                var gameObject = AssetDatabase.LoadAssetAtPath<GameObject>(AssetDatabase.GUIDToAssetPath(guid));
                RemoveComponents(builder, gameObject);
            }

            State = ExecuteState.Complete;
        }
    }
}

#endif