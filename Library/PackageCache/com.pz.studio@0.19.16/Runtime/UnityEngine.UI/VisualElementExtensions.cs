/*

    Copyright (c) 2023 Pocketz World. All rights reserved.

*/

using System.Linq;
using UnityEngine;
using UnityEngine.UIElements;

namespace Highrise.UI
{
    public static class VisualElementHooks
    {
        /// <summary>
        /// Returns true if the element is being displayed in the heirarchy
        /// </summary>
        public static bool IsHierarchyDisplayed(this VisualElement element) => element.isHierarchyDisplayed;

        /// <summary>
        /// Send the given event immediately
        /// </summary>
        public static void SendEventImmediate(this VisualElement element, EventBase evt) =>
            element.SendEvent(evt, DispatchMode.Immediate);

        /// <summary>
        /// Returns true if the given element is a child element
        /// </summary>
        public static bool IsChildOf(this VisualElement element, VisualElement parent)
        {
            for (element = element.parent; element != null; element = element.parent)
                if (parent == element)
                    return true;

            return false;
        }

        /// <summary>
        /// Returns true if the given element or optionally any of its children have focus
        /// </summary>
        public static bool HasFocus(this VisualElement element, bool includeChildren = true)
        {
            if (element == null || element.focusController == null)
                return false;

            var focused = element.focusController.focusedElement;
            if (focused == null)
                return false;

            if (focused == element)
                return true;

            if (includeChildren && focused is VisualElement focusedElement && focusedElement.IsChildOf(element))
                return true;

            return false;
        }

        public static TElement Name<TElement>(this TElement element, string name) where TElement : VisualElement
        {
            element.name = name;
            return element;
        }

        /// <summary>
        /// Add a class to the element using the builder pattern
        /// </summary>
        public static TElement Class<TElement>(this TElement element, string classname) where TElement : VisualElement
        {
            element.AddToClassList(classname);
            return element;
        }

        /// <summary>
        /// Add a child element using the builder pattern
        /// </summary>
        public static TElement Child<TElement>(this TElement element, VisualElement add) where TElement : VisualElement
        {
            element.Add(add);
            return element;
        }

        /// <summary>
        /// Extension method to expose the root visual container of an element
        /// </summary>
        public static VisualElement GetRootVisualContainer(this VisualElement element) =>
            element.GetRootVisualContainer();

        private static void SetPseudoState(this VisualElement element, PseudoStates states, bool value)
        {
            if (value)
                element.pseudoStates |= states;
            else
                element.pseudoStates &= (~states);
        }

        /// <summary>
        /// Returns true if the element has the checked psudeo state
        /// </summary>
        public static bool HasCheckedPseudoState(this VisualElement element) =>
            (element.pseudoStates & PseudoStates.Checked) == PseudoStates.Checked;

        /// <summary>
        /// Set the "checked" pseudo state on the given element
        /// </summary>
        public static void SetCheckedPseudoState(this VisualElement element, bool value) =>
            element.SetPseudoState(PseudoStates.Checked, value);

        /// <summary>
        /// Set the "focus" pseudo state on the given element
        /// </summary>
        public static void SetFocusPseudoState(this VisualElement element, bool value) =>
            element.SetPseudoState(PseudoStates.Focus, value);

        /// <summary>
        /// Set the "active" pseudo state on the given element
        /// </summary>
        public static void SetActivePseudoState(this VisualElement element, bool value) =>
            element.SetPseudoState(PseudoStates.Active, value);

        /// <summary>
        /// Set the "disabled" pseudo state on the given element
        /// </summary>
        public static void SetDisabledPseudoState(this VisualElement element, bool value) =>
            element.SetPseudoState(PseudoStates.Disabled, value);

        /// <summary>
        /// Returns true if the element is set to be displayed
        /// </summary>
        public static bool IsDisplayed(this VisualElement element) =>
            element.style.display.value != DisplayStyle.None;

        /// <summary>
        /// Hide / Show an element
        /// </summary>
        public static void SetDisplay(this VisualElement element, bool display)
        {
            var localDisplay = display ? DisplayStyle.Flex : DisplayStyle.None;
            if (localDisplay == element.style.display)
                return;

            element.style.display = localDisplay;
        }

        public static object GetUserProperty(this VisualElement self, PropertyName key) =>
            self.GetProperty(key);

        public static void SetUserProperty(this VisualElement self, PropertyName key, object value) =>
            self.SetProperty(key, value);

        public static bool HasUserProperty(this VisualElement self, PropertyName key) =>
            self.HasProperty(key);

        /// <summary>
        /// Returns the bounding box of the element
        /// </summary>
        /// <param name="element"></param>
        /// <returns></returns>
        public static Rect GetBoundingBox(this VisualElement element) => element.boundingBox;

        /// <summary>
        /// Set the DisableClipping flag on the element
        /// </summary>
        public static void DisableClipping(this VisualElement element, bool disable) =>
            element.disableClipping = disable;

        /// <summary>
        /// Returns the style sheet with the given name that is associated with the element
        /// </summary>
        public static StyleSheet FindStyleSheet(this VisualElement element, string name)
        {
            for (int i = 0; i < element.styleSheets.count; i++)
            {
                var sheet = element.styleSheets[i];
                if (sheet.name == name)
                    return sheet;

                sheet = sheet.flattenedRecursiveImports.FirstOrDefault(s => s.name == name);
                if (sheet != null)
                    return sheet;
            }

            return null;
        }

        /// <summary>
        /// Force a layout on an element
        /// </summary>
        /// <param name="element"></param>
        public static void IncrementVersionLayout(this VisualElement element) =>
            element.IncrementVersion(VersionChangeType.Layout);

        /// <summary>
        /// Force an element to repait
        /// </summary>
        /// <param name="element"></param>
        public static void IncrementVersionRepaint(this VisualElement element) =>
            element.IncrementVersion(VersionChangeType.Repaint);

        /// <summary>
        /// Force an element to update its styles
        /// </summary>
        /// <param name="element"></param>
        public static void IncrementVersionStyles(this VisualElement element) =>
            element.IncrementVersion(VersionChangeType.Styles);

        /// <summary>
        /// Invalidate all styles on the element
        /// </summary>
        /// <param name="element"></param>
        public static void InvalidateStyles(this VisualElement element) =>
            element.IncrementVersion(VersionChangeType.StyleSheet);

        public static float RoundToPixelGrid(this VisualElement element, float round) =>
            GUIUtility.RoundToPixelGrid(round);


        public static void ForceLayout(this VisualElement element) =>
            element.yogaNode.CalculateLayout();

        /// <summary>
        /// Calculate the size of an element within its parent
        /// </summary>
        public static Vector2 CalculateSize(this VisualElement element, bool considerParentWidth = false)
        {
            // element is either not yet added or already removed from the hierarchy - abort
            if (element.panel == null)
                return element.rect.size;

            if (!element.styleInitialized)
                ((Panel)element.panel).ApplyStyles();

            var width = (considerParentWidth && element.parent != null) ? element.parent.rect.width : float.NaN;

            // If the width is not a reasonable value, set it to NaN to ignore width
            if (width < 4.0f)
                width = float.NaN;

            element.yogaNode.CalculateLayout(width);

            return new Vector2(element.rect.width, element.rect.height);
        }

        public static void SetRequiresMeasureFunction(this VisualElement element, bool measure) =>
            element.requireMeasureFunction = measure;

        public static void SetClamped(this Slider slider, bool clamped) =>
            slider.clamped = clamped;

        public static VisualElement GetDragElement(this Slider slider) =>
            slider.dragElement;

        public static int GetLayoutPass(this GeometryChangedEvent evt) =>
            evt.layoutPass;

        public static bool IsHandledByDraggable(this PointerMoveEvent evt) =>
            evt.isHandledByDraggable;

        public static void SetHandledByDraggable(this PointerMoveEvent evt, bool handled) =>
            evt.isHandledByDraggable = handled;

        public static UxmlTraits GetTraits<TCreatedType, TTraits>(this UxmlFactory<TCreatedType, TTraits> factory)
            where TCreatedType : VisualElement, new() where TTraits : UxmlTraits, new() =>
            factory.m_Traits;

        public static float GetFixedPaneDimension(this TwoPaneSplitView splitView) =>
            splitView.fixedPaneDimension;

        public static void SetFixedPaneDimension(this TwoPaneSplitView splitView, float value)
        {
            splitView.fixedPaneInitialDimension = value;
            splitView.fixedPaneDimension = value;
        }

        public static T GetCustomProperty<T>(this VisualElement element, string propertyName)
        {
            var style = element.customStyle;
            // unfortunately just using T in TryGetValue directly doesn't work
            if (typeof(T) == typeof(float))
            {
                if (style.TryGetValue(new CustomStyleProperty<float>(propertyName), out float fValue) &&
                    fValue is T ftValue)
                    return ftValue;
            }
            else if (typeof(T) == typeof(int))
            {
                if (style.TryGetValue(new CustomStyleProperty<int>(propertyName), out int iValue) &&
                    iValue is T itValue)
                    return itValue;
            }
            else if (typeof(T) == typeof(bool))
            {
                if (style.TryGetValue(new CustomStyleProperty<bool>(propertyName), out bool bValue) &&
                    bValue is T btValue)
                    return btValue;
            }
            else if (typeof(T) == typeof(string))
            {
                if (style.TryGetValue(new CustomStyleProperty<string>(propertyName), out string sValue) &&
                    sValue is T stValue)
                    return stValue;
            }
            else if (typeof(T) == typeof(Color))
            {
                if (style.TryGetValue(new CustomStyleProperty<Color>(propertyName), out Color cValue) &&
                    cValue is T ctValue)
                    return ctValue;
            }

            return default(T);
        }
    }
}