/*

    Copyright (c) 2024 Pocketz World. All rights reserved.

*/

using UnityEditor;
using UnityEditorInternal;
using UnityEngine;

namespace Highrise
{
    [CustomEditor(typeof(TagManager))]
    internal class HighriseTagManagerInspector : TagManagerInspector
    {
        private ReorderableList _layersList;

        public override void OnEnable()
        {
            base.OnEnable();

            _layersList ??= (ReorderableList)typeof(TagManagerInspector)
                .GetField("m_LayersList", System.Reflection.BindingFlags.NonPublic | System.Reflection.BindingFlags.Instance)?
                .GetValue(this);

            if (_layersList != null)
                _layersList.drawElementCallback = DrawLayerListElementOverride;
        }

        private void DrawLayerListElementOverride(Rect rect, int index, bool selected, bool focused)
        {
            ++rect.yMin;
            --rect.yMax;
            var flag = index > 8;
            var enabled = GUI.enabled;
            GUI.enabled = m_IsEditable & flag;
            var stringValue = m_Layers.GetArrayElementAtIndex(index).stringValue;
            var str = !flag ? EditorGUI.TextField(rect, " Builtin Layer " + index, stringValue) : EditorGUI.TextField(rect, " User Layer " + index, stringValue);
            if (str != stringValue)
                m_Layers.GetArrayElementAtIndex(index).stringValue = str;
            GUI.enabled = enabled;
        }
    }
}
