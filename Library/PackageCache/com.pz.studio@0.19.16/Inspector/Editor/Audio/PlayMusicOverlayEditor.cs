#if HR_LUA_GENERATED && HR_STUDIO_SIMPLE

using UnityEditor;
using UnityEngine;
using Highrise.Lua.Generated;
using Highrise.Studio;
using UnityEngine.UIElements;
using Highrise.Studio.Tools;
using UnityEditor.UIElements;
using Highrise.UI;

[StudioEditor(typeof(PlayMusic))]
public class PlayMusicOverlayEditor : Editor
{
    private const int ObjectPickerId = 1;

    private VisualElement _root;
    private VisualElement _addButton;
    private SerializedProperty _audioShaderProp;
    private bool _pickerOpen;
    private Object _selectedObject;

    public override VisualElement CreateInspectorGUI()
    {
        _root = new VisualElement();
        StudioInspectorUIUtilities.AddInspectorStyleSheets(_root);
        var urlProp = serializedObject.FindProperty("_playMusicFromURL");
        var urlToggleField = StudioInspectorUIUtilities.CreateInputField(urlProp, "Play From URL");
        _root.Add(urlToggleField);

        var musicURLStringField = StudioInspectorUIUtilities.CreateInputField(serializedObject.FindProperty("_musicURL"));
        _root.Add(musicURLStringField);
        musicURLStringField.SetDisplay(false);

        _audioShaderProp = serializedObject.FindProperty("_musicAudioShader");
        ObjectField musicShaderField = StudioInspectorUIUtilities.CreateObjectField(_audioShaderProp, overrideName: "Music");
        _root.Add(musicShaderField);

        VisualElement loopToggleField = null;

        urlToggleField.RegisterCallback<ChangeEvent<bool>>(evt =>
        {
            musicURLStringField.SetDisplay(evt.newValue);
            musicShaderField.SetDisplay(!evt.newValue);
            _addButton.SetDisplay(!evt.newValue && _audioShaderProp.objectReferenceValue == null);
            loopToggleField.SetDisplay(!evt.newValue);
        });

        musicShaderField.RegisterValueChangedCallback(evt =>
        {
            _addButton.SetDisplay(evt.newValue == null);
        });

        _addButton = StudioInspectorUIUtilities.CreateButton("Choose Music", () =>
        {
            _pickerOpen = true;
            EditorGUIUtility.ShowObjectPicker<AudioClip>(null, false, string.Empty, ObjectPickerId);
        });
        musicShaderField.Add(_addButton);
        _addButton.SetDisplay(_audioShaderProp.objectReferenceValue == null);

        EditorApplication.update += ListenForObjectPickerClosed;
        //unregister the update event when it is removed from the panel
        _root.RegisterCallback<DetachFromPanelEvent>(evt =>
        {
            EditorApplication.update -= ListenForObjectPickerClosed;
        });

        loopToggleField = StudioInspectorUIUtilities.CreateInputField(serializedObject.FindProperty("_loopMusic"));
        _root.Add(loopToggleField);

        var volumeProp = serializedObject.FindProperty("_volume");
        var volumeField = StudioInspectorUIUtilities.CreateInputField(volumeProp);
        _root.Add(volumeField);
        _root.Add(StudioInspectorUIUtilities.CreateInputField(serializedObject.FindProperty("_fadeIn")));

        return _root;
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

            var prop = serializedObject.FindProperty("_musicAudioShader");

            var playMusicTarget = target as PlayMusic;
            if (playMusicTarget != null && playMusicTarget._musicAudioShader == null)
            {
                playMusicTarget._musicAudioShader = shader;
                playMusicTarget._musicAudioShader.clips = new AudioClip[] { (AudioClip)selectedClip };
                EditorUtility.SetDirty(playMusicTarget);
                prop.objectReferenceValue = shader;

                _addButton.SetDisplay(false);
            }
            serializedObject.ApplyModifiedProperties();
        }
    }
}

#if HR_STUDIO_SIMULATOR
[Icon("Assets/Sprites/Icons/icon_sound.png")]
#else
[Icon("Packages/com.pz.studio/Assets/Sprites/Icons/icon_sound.png")]
#endif
public class MusicBehaviour : StudioBehaviour
{
    public override string Name => "Play Music";
    public override UnityEngine.Object Add(GameObject parent)
    {
        return Undo.AddComponent(parent, typeof(PlayMusic));
    }
}
#endif