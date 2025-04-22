#if HR_LUA_GENERATED && HR_STUDIO_SIMPLE

using UnityEditor;
using Highrise.UI;
using Highrise.Lua.Generated;
using Highrise.Studio;
using UnityEngine.UIElements;
using Highrise.Studio.Tools;
using UnityEngine;

[StudioEditor(typeof(TeleporterObject))]
public class TeleporterObjectOverlayEditor : Editor
{
    private const int ObjectPickerId = 1;

    private VisualElement _addButton;
    private SerializedProperty _audioShaderProp;
    private bool _pickerOpen;
    private Object _selectedObject;

    public override VisualElement CreateInspectorGUI()
    {
        var root = new VisualElement();
        StudioInspectorUIUtilities.AddInspectorStyleSheets(root);
        root.Add(StudioInspectorUIUtilities.CreateObjectField(serializedObject.FindProperty("m_destination"), true));
        var soundProp = serializedObject.FindProperty("m_playSound");
        var soundPropField = StudioInspectorUIUtilities.CreateInputField(soundProp);
        root.Add(soundPropField);

        _audioShaderProp = serializedObject.FindProperty("m_soundToPlay");
        var chosenSoundField = StudioInspectorUIUtilities.CreateObjectField(_audioShaderProp);
        root.Add(chosenSoundField);
        chosenSoundField.SetDisplay(soundProp.boolValue);

        soundPropField.RegisterCallback<ChangeEvent<bool>>(evt =>
        {
            chosenSoundField.SetDisplay(evt.newValue);
        });

        chosenSoundField.RegisterValueChangedCallback(evt =>
        {
            _addButton.SetDisplay(evt.newValue == null);
        });

        _addButton = StudioInspectorUIUtilities.CreateButton("Choose Sound", () =>
        {
            _pickerOpen = true;
            EditorGUIUtility.ShowObjectPicker<AudioClip>(null, false, string.Empty, ObjectPickerId);
        });
        chosenSoundField.Add(_addButton);
        _addButton.SetDisplay(_audioShaderProp.objectReferenceValue == null);

        var playParticleProp = serializedObject.FindProperty("m_playParticleEffect");
        var playParticleField = StudioInspectorUIUtilities.CreateInputField(playParticleProp);
        root.Add(playParticleField);

        var particleField = StudioInspectorUIUtilities.CreateInputField(serializedObject.FindProperty("m_teleportParticles"));
        root.Add(particleField);
        particleField.SetDisplay(playParticleProp.boolValue);

        playParticleField.RegisterCallback<ChangeEvent<bool>>(evt =>
        {
            particleField.SetDisplay(evt.newValue);
        });

        root.Add(StudioInspectorUIUtilities.CreateInputField(serializedObject.FindProperty("m_resetCameraAfterTeleport"), "Camera Follow"));

        var horzGroup = new VisualElement();
        horzGroup.style.flexDirection = FlexDirection.Row;
        var sceneView = SceneView.lastActiveSceneView;
        horzGroup.Add(StudioInspectorUIUtilities.CreateButton("Look At Teleporter", () =>
        {
            var teleporter = (TeleporterObject)targets[0];
            sceneView.LookAt(teleporter.transform.position, sceneView.rotation, 2.0f);
        }));

        horzGroup.Add(StudioInspectorUIUtilities.CreateButton("Look At Destination", () =>
        {
            var teleporter = (TeleporterObject)targets[0];
            sceneView.LookAt(teleporter.transform.position, sceneView.rotation, 2.0f);
        }));
        root.Add(horzGroup);

        //listen for the object picker to close
        EditorApplication.update += ListenForObjectPickerClosed;
        //unregister the update event when it is removed from the panel
        root.RegisterCallback<DetachFromPanelEvent>(evt =>
        {
            EditorApplication.update -= ListenForObjectPickerClosed;
        });
        return root;
    }

    private void ListenForObjectPickerClosed()
    {
        int objPickerId = EditorGUIUtility.GetObjectPickerControlID();
        if (_pickerOpen && objPickerId == ObjectPickerId) // Picker closed
        {
            _selectedObject = EditorGUIUtility.GetObjectPickerObject();
        }

        if (_pickerOpen && objPickerId != ObjectPickerId) // Picker closed
        {
            _pickerOpen = false;
            var selectedClip = _selectedObject as AudioClip;
            if (selectedClip == null)
                return;

            var shader = AudioShaderUtility.CreateAudioShaderCustom(selectedClip.name + "AudioShader", false);
            if (shader == null)
                return;

            var prop = serializedObject.FindProperty("m_soundToPlay");

            var teleporterObject = target as TeleporterObject;
            if (teleporterObject != null && teleporterObject.m_soundToPlay == null)
            {
                teleporterObject.m_soundToPlay = shader;
                teleporterObject.m_soundToPlay.clips = new AudioClip[] { selectedClip };
                EditorUtility.SetDirty(teleporterObject);
                prop.objectReferenceValue = shader;

                _addButton.SetDisplay(false);
            }
            serializedObject.ApplyModifiedProperties();
        }
    }
}

#if HR_STUDIO_SIMULATOR
[Icon("Assets/Sprites/Icons/icon_reply.png")]
#else
[Icon("Packages/com.pz.studio/Assets/Sprites/Icons/icon_reply.png")]
#endif
public class TeleporterObjectBehaviour : PrefabBehaviour
{
    public override string Name => "Teleport Object";
    protected override string Path => "Packages/com.pz.studio/Editor/Interactables/Teleporter.prefab";
}
#endif