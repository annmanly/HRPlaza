/*

    Copyright (c) 2024 Pocketz World. All rights reserved.

*/

#if HR_STUDIO

using System;
using System.Collections.Generic;
using System.Linq;
using UnityEditor;
using UnityEngine;
using Object = UnityEngine.Object;

/// <summary>
/// Based on AnimationWindowEventInspector. https://github.com/Unity-Technologies/UnityCsReference/blob/master/Editor/Mono/Animation/AnimationWindow/AnimationWindowEventInspector.cs
/// Functionallity has been reduced so that only the string field is displayed and the function field is pre-filled
/// </summary>
[CustomEditor(typeof(AnimationWindowEvent))]
[CanEditMultipleObjects]
public class CharacterAnimationEventEditor : Editor
{

    private const string CharacterAnimatorFunctionName = "HandleEvent";

    AnimationEventEditorState m_State = new();

    public override void OnInspectorGUI()
    {
        var awes = targets.Select(o => o as AnimationWindowEvent).ToArray();
        OnEditAnimationEvents(awes, m_State);
    }

    protected override void OnHeaderGUI()
    {
        string targetTitle = (targets.Length == 1) ? "Animation Event" : targets.Length + " Animation Events";
        DrawHeaderGUI(this, targetTitle);
    }

    private static void OnEditAnimationEvent(AnimationWindowEvent awe, AnimationEventEditorState state)
    {
        OnEditAnimationEvents(new AnimationWindowEvent[] { awe }, state);
    }

    private static void OnEditAnimationEvents(AnimationWindowEvent[] awEvents, AnimationEventEditorState state)
    {
        AnimationWindowEventData data = GetData(awEvents);
        if (data.events == null || data.selectedEvents == null || data.selectedEvents.Length == 0)
            return;

        AnimationEvent firstEvent = data.selectedEvents[0];

        bool singleFunctionName = Array.TrueForAll(data.selectedEvents, evt => evt.functionName == firstEvent.functionName);

        EditorGUI.BeginChangeCheck();

        foreach (var evt in data.selectedEvents)
        {
            if (evt.functionName != CharacterAnimatorFunctionName)
            {
                evt.functionName = CharacterAnimatorFunctionName;
            }
        }

        HandleEventName(data.selectedEvents);

        foreach (var evt in data.selectedEvents)
        {
            if (evt.floatParameter != 0f)
            {
                evt.floatParameter = 0f;
            }

            if (evt.intParameter != 0)
            {
                evt.intParameter = 0;
            }

            if (evt.objectReferenceParameter != null)
            {
                evt.objectReferenceParameter = null;
            }
        }

        if (EditorGUI.EndChangeCheck())
            SetData(awEvents, data);
    }

    private static void HandleEventName(AnimationEvent[] events)
    {
        AnimationEvent firstEvent = events[0];

        bool singleParamValue = Array.TrueForAll(events, evt => evt.stringParameter == firstEvent.stringParameter);

        EditorGUI.BeginChangeCheck();
        EditorGUI.showMixedValue = !singleParamValue;
        string newValue = EditorGUILayout.TextField("Event Name", firstEvent.stringParameter);
        EditorGUI.showMixedValue = false;

        if (EditorGUI.EndChangeCheck())
        {
            foreach (var evt in events)
                evt.stringParameter = newValue;
        }
    }

    private struct AnimationWindowEventData
    {
        public GameObject root;
        public AnimationClip clip;
        public AnimationClipInfoProperties clipInfo;

        public AnimationEvent[] events;
        public AnimationEvent[] selectedEvents;
    }


    // this are used so we don't alloc new lists on every call
    static List<AnimationEvent> getDataSelectedEvents;
    private static AnimationWindowEventData GetData(AnimationWindowEvent[] awEvents)
    {
        var data = new AnimationWindowEventData();
        if (awEvents.Length == 0)
            return data;

        AnimationWindowEvent firstAwEvent = awEvents[0];
        data.root = firstAwEvent.root;
        data.clip = firstAwEvent.clip;
        data.clipInfo = firstAwEvent.clipInfo;

        if (data.clip != null)
            data.events = AnimationUtility.GetAnimationEvents(data.clip);
        else if (data.clipInfo != null)
            data.events = data.clipInfo.GetEvents();

        if (data.events != null)
        {
            getDataSelectedEvents ??= new List<AnimationEvent>();
            getDataSelectedEvents.Clear();
            foreach (var awEvent in awEvents)
            {
                if (awEvent.eventIndex >= 0 && awEvent.eventIndex < data.events.Length)
                    getDataSelectedEvents.Add(data.events[awEvent.eventIndex]);
            }

            data.selectedEvents = getDataSelectedEvents.ToArray();
        }

        return data;
    }

    private static void SetData(AnimationWindowEvent[] awEvents, AnimationWindowEventData data)
    {
        if (data.events == null)
            return;

        if (data.clip != null)
        {
            Undo.RegisterCompleteObjectUndo(data.clip, "Animation Event Change");
            AnimationUtility.SetAnimationEvents(data.clip, data.events);
        }
        else if (data.clipInfo != null)
        {
            foreach (var awEvent in awEvents)
            {
                if (awEvent.eventIndex >= 0 && awEvent.eventIndex < data.events.Length)
                    data.clipInfo.SetEvent(awEvent.eventIndex, data.events[awEvent.eventIndex]);
            }
        }
    }
}

#endif
