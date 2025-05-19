#if HR_LUA_GENERATED && HR_STUDIO_SIMPLE

using UnityEditor;
using UnityEngine;
using Highrise.Lua.Generated;
using Highrise.Studio;
using UnityEngine.UIElements;
using Highrise.UI;
using Highrise.Studio.Tools;


[StudioEditor(typeof(PlaySound))]
public class PlaySoundOverlayEditor : Editor
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
        _audioShaderProp = serializedObject.FindProperty("_audioShader");
        var objectField = StudioInspectorUIUtilities.CreateObjectField(_audioShaderProp);
        _root.Add(objectField);

        //listen for changes on the toggle so we can remove or add the button
        objectField.RegisterValueChangedCallback(evt =>
        {
            _addButton.SetDisplay(evt.newValue == null);
        });

        _addButton = StudioInspectorUIUtilities.CreateButton("Choose Sound", () =>
        {
            _pickerOpen = true;
            EditorGUIUtility.ShowObjectPicker<AudioClip>(null, false, string.Empty, ObjectPickerId);
        });
        objectField.Add(_addButton);
        _addButton.SetDisplay(_audioShaderProp.objectReferenceValue == null);

        _root.Add(StudioInspectorUIUtilities.CreateInputField(serializedObject.FindProperty("_secondsDelay")));

        //listen for the object picker to close
        EditorApplication.update += ListenForObjectPickerClosed;
        //unregister the update event when it is removed from the panel
        _root.RegisterCallback<DetachFromPanelEvent>(evt =>
        {
            EditorApplication.update -= ListenForObjectPickerClosed;
        });

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

            var prop = serializedObject.FindProperty("_audioShader");

            var playSoundTarget = target as PlaySound;
            if (playSoundTarget != null && playSoundTarget._audioShader == null)
            {
                playSoundTarget._audioShader = shader;
                playSoundTarget._audioShader.clips = new AudioClip[] { (AudioClip)selectedClip };
                EditorUtility.SetDirty(playSoundTarget);
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
public class SoundBehaviour : StudioBehaviour
{
    public override string Name => "Play Sound";
    public override UnityEngine.Object Add(GameObject parent)
    {
        return Undo.AddComponent(parent, typeof(PlaySound));
    }
}
#endif