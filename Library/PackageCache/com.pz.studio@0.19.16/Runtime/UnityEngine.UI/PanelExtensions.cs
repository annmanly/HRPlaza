/*

    Copyright (c) 2024 Pocketz World. All rights reserved.

*/

using UnityEngine;
using UnityEngine.UIElements;

#if UNITY_EDITOR
using UnityEditor.UIElements;
#endif

namespace Highrise.UI
{
    public static class PanelExtensions
    {
        /// <summary>
        /// Return the panel scale
        /// </summary>
        public static float GetScale(this IPanel panel)
        {
#if UNITY_EDITOR
            if (panel is EditorPanel editorPanel)
                return editorPanel.scaledPixelsPerPoint;
#endif

            return ((Panel)panel).scale;
        }

        /// <summary>
        /// Return the display width of the panel in scaled units
        /// </summary>
        public static float GetScaledDisplayWidth(this IPanel panel) =>
            panel.GetDisplayRect().width / panel.GetScale();

        /// <summary>
        /// Return the display height of the panel in scaled units
        /// </summary>
        public static float GetScaledDisplayHeight(this IPanel panel) =>
            panel.GetDisplayRect().height / panel.GetScale();

        /// <summary>
        /// Return the display rectangle of the panel
        /// </summary>
        public static Rect GetDisplayRect(this IPanel panel)
        {
#if UNITY_EDITOR
            if (panel is EditorPanel editorPanel)
            {
                var parent = editorPanel.rootIMGUIContainer.parent;
                var rect = (null == parent || parent.childCount < 2)
                    ? editorPanel.rootIMGUIContainer.worldBoundingBox
                    : parent[1].worldBoundingBox;
                var scale = panel.GetScale();
                return new Rect(0, 0, rect.width * scale, rect.height * scale);
            }
#endif

            return ((PanelSettings)((Panel)panel).ownerObject).GetDisplayRect();
        }

        /// <summary>
        /// Update the visual tree of the panel
        /// </summary>
        public static void ValidateLayout(this IPanel panel) => (panel as Panel).ValidateLayout();

        /// <summary>
        /// Convert a local panel coordinate to a world (screen) coordinate
        /// </summary>
        /// <param name="position">Local coordinate</param>
        public static Vector2 LocalToWorld(this IPanel ipanel, Vector2 position)
        {
            var panel = (ipanel as Panel);
            var scale = panel.scale;
            return new Vector2(position.x * scale, (panel.GetDisplayRect().height - (position.y * scale)));
        }

        /// <summary>
        /// Convert a world (screen) coordinate to a local panel coordinate
        /// </summary>
        /// <param name="position">World coordinate</param>
        public static Vector2 WorldToLocal(this IPanel ipanel, Vector2 position)
        {
            var panel = (ipanel as Panel);
            var scale = 1.0f / panel.scale;
            return new Vector2(position.x * scale, (panel.GetDisplayRect().height - position.y) * scale);
        }

        /// <summary>
        /// Return the panel associated with the given panel settings
        /// </summary>
        public static IPanel GetPanel(this PanelSettings panelSettings) => panelSettings.panel;

        /// <summary>
        /// Return the panel associated with the given panel settings
        /// </summary>
        public static void ApplyPanelSettings(this PanelSettings panelSettings) => panelSettings.ApplyPanelSettings();


        public static void PreventCompatibilityMouseEventsPublic(this IPanel ipanel, int pointerId) =>
            (ipanel as Panel).PreventCompatibilityMouseEvents(pointerId);


        public class CustomFocusRing : IFocusRing
        {
            private VisualElementFocusRing _ring;

            public CustomFocusRing(VisualElement root)
            {
                _ring = new VisualElementFocusRing(root);
                this.root = root;
            }

            private VisualElement root;
            private FocusController focusController => root.focusController;

            public FocusChangeDirection GetFocusChangeDirection(Focusable currentFocusable, EventBase e)
            {
                // Pointer down on an element?
                if (e.eventTypeId != EventBase<PointerDownEvent>.TypeId())
                    return _ring.GetFocusChangeDirection(currentFocusable, e);

                var element = e.target as VisualElement;
                while (element != null)
                {
                    if (element is UITextFieldBase textField)
                        return textField.hasFocus ?
                            FocusChangeDirection.unspecified :
                            VisualElementFocusChangeTarget.GetPooled(textField);

                    // If the element is marked as focusable but is not a text field then just clear focus
                    if (element is not TextInputBaseField<string>.TextInputBase &&
                        element is Focusable focusable &&
                        focusable.focusable)
                    {
                        element.panel.Blur();
                        return FocusChangeDirection.none;
                    }

                    element = element.parent;
                }

                return FocusChangeDirection.unspecified;
            }

            public Focusable GetNextFocusable(Focusable currentFocusable, FocusChangeDirection direction)
            {
                // Maintain focus on unspecified
                if (direction == FocusChangeDirection.unspecified)
                    return currentFocusable;

                return _ring.GetNextFocusable(currentFocusable, direction);
            }
        }

        public static void InstallFocusController(this IPanel ipanel)
        {
            var panel = ipanel as Panel;
            panel.focusController = new FocusController(new CustomFocusRing(panel.visualTree));
        }

        /// <summary>
        /// Clear any focus and return true if focus was cleared
        /// </summary>
        public static bool Blur(this IPanel panel, bool immediately = false)
        {
            if (panel.focusController.focusedElement is {} focused)
            {
                if (immediately)
                    focused.BlurImmediately();
                else
                    focused.Blur();
                return true;
            }

            return false;
        }
    }
}
