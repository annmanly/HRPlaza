/*

    Copyright (c) 2023 Pocketz World. All rights reserved.

*/

using System;
using System.Text.RegularExpressions;
using UnityEngine;
using UnityEngine.UIElements;

namespace Highrise.UI
{
    public class ReturnEvent : EventBase<ReturnEvent>
    {
        public string Value;
    }

    public class ShiftReturnEvent : EventBase<ShiftReturnEvent> { }

    public class ValueRejectedEvent : EventBase<ValueRejectedEvent>
    {
        public string Value;
    }

    public class BackspaceEvent : EventBase<BackspaceEvent> { }

    //
    // Summary:
    //     A textfield is a rectangular area where the user can edit a string.
    public class UITextFieldBase : TextInputBaseField<string>
    {
        //
        // Summary:
        //     Instantiates a TextField using the data read from a UXML file.
        public new class UxmlFactory : UxmlFactory<UITextFieldBase, UxmlTraits>
        {
        }

        //
        // Summary:
        //     Defines UxmlTraits for the TextField.
        public new class UxmlTraits : TextInputBaseField<string>.UxmlTraits
        {
            private UxmlBoolAttributeDescription m_Multiline = new() { name = "multiline" };

            public override void Init(VisualElement ve, IUxmlAttributes bag, CreationContext cc)
            {
                UITextFieldBase textField = (UITextFieldBase)ve;
                textField.multiline = m_Multiline.GetValueFromBag(bag, cc);
                base.Init(ve, bag, cc);
            }
        }

        private class TextInput : TextInputBase
        {
            private bool m_Multiline;

            private UITextFieldBase parentTextField => (UITextFieldBase)base.parent;

            public bool multiline
            {
                get
                {
                    return m_Multiline;
                }
                set
                {
                    m_Multiline = value;
                    if (!value)
                    {
                        base.text = base.text.Replace("\n", "");
                    }

#if UNITY_EDITOR || !(UNITY_IOS || UNITY_ANDROID)
                    textEdition.multiline = m_Multiline;
                    if (m_Multiline)
                        SetVerticalScrollerVisibility(ScrollerVisibility.Auto);
#endif

                    SetTextAlign();
                }
            }

            public override bool isPasswordField
            {
                set
                {
                    base.isPasswordField = value;
                    if (value)
                    {
                        multiline = false;
                    }

                    (parent as UITextFieldBase).OnIsPasswordFieldChanged();
                }
            }

            public TextAnchor TextAlign
            {
                get => resolvedStyle.unityTextAlign;
                set => style.unityTextAlign = value;
            }

#if UNITY_2021
            public void SelectTextEnd() => editorEngine.SelectTextEnd();
#else
            public void SelectTextEnd() => textSelection.SelectRange(text.Length, text.Length);
#endif

            public void ReplaceSelection(string value)
            {
#if UNITY_2021
                editorEngine.ReplaceSelection(value);
                parentTextField.value = editorEngine.text;
#else
                textElement.editingManipulator.editingUtilities.ReplaceSelection(value);
                parentTextField.value = textElement.editingManipulator.editingUtilities.text;
#endif
            }

            private void SetTextAlign()
            {
                if (m_Multiline)
                {
                    RemoveFromClassList(singleLineInputUssClassName);
                    AddToClassList(multilineInputUssClassName);
                }
                else
                {
                    RemoveFromClassList(multilineInputUssClassName);
                    AddToClassList(singleLineInputUssClassName);
                }
            }

            protected override string StringToValue(string str)
            {
                return str;
            }

            protected override void ExecuteDefaultActionAtTarget(EventBase evt)
            {
                if (evt == null)
                {
                    return;
                }

                if (evt.eventTypeId == EventBase<KeyDownEvent>.TypeId())
                {
                    KeyDownEvent keyDownEvent = evt as KeyDownEvent;
                    if (!parentTextField.isDelayed || (!multiline && ((keyDownEvent != null && keyDownEvent.keyCode == KeyCode.KeypadEnter) || (keyDownEvent != null && keyDownEvent.keyCode == KeyCode.Return))))
                    {
                        parentTextField.value = base.text;
                    }

                    if (multiline)
                    {
                        if (keyDownEvent?.character == '\t' && keyDownEvent.modifiers == EventModifiers.None)
                        {
                            keyDownEvent?.StopPropagation();
                            keyDownEvent?.PreventDefault();
                        }
                        else if ((keyDownEvent?.character == '\u0003' && keyDownEvent != null && keyDownEvent.shiftKey) || (keyDownEvent?.character == '\n' && (keyDownEvent?.shiftKey ?? false)))
                        {
                            base.parent.Focus();
                            evt.StopPropagation();
                            evt.PreventDefault();
                        }
                    }
                    else if (keyDownEvent?.character == '\u0003' || keyDownEvent?.character == '\n')
                    {
                        evt.StopPropagation();
                        evt.PreventDefault();
                    }
                }
                else if (evt.eventTypeId == EventBase<ExecuteCommandEvent>.TypeId())
                {
                    ExecuteCommandEvent executeCommandEvent = evt as ExecuteCommandEvent;
                    string commandName = executeCommandEvent.commandName;
                    if (!parentTextField.isDelayed && (commandName == "Paste" || commandName == "Cut"))
                    {
                        parentTextField.value = base.text;
                    }
                }
                else if (evt.eventTypeId == EventBase<NavigationSubmitEvent>.TypeId() ||
                         evt.eventTypeId == EventBase<NavigationCancelEvent>.TypeId() ||
                         evt.eventTypeId == EventBase<NavigationMoveEvent>.TypeId())
                {
                    evt.StopPropagation();
                    evt.PreventDefault();
                }

#if !(UNITY_IOS || UNITY_ANDROID)
                base.ExecuteDefaultActionAtTarget(evt);
#endif
            }

            protected override void ExecuteDefaultAction(EventBase evt)
            {
                if (parentTextField.isDelayed && evt?.eventTypeId == EventBase<BlurEvent>.TypeId())
                {
                    parentTextField.value = base.text;
                }

#if !(UNITY_IOS || UNITY_ANDROID)
                base.ExecuteDefaultAction(evt);
#endif
            }
        }

        //
        // Summary:
        //     USS class name of elements of this type.
        public new static readonly string ussClassName = "text-field";

        //
        // Summary:
        //     USS class name of labels in elements of this type.
        public new static readonly string labelUssClassName = ussClassName + "__label";

        //
        // Summary:
        //     USS class name of input elements in elements of this type.
        public new static readonly string inputUssClassName = ussClassName + "__input";

        /// <summary>
        /// Returns the base text input as a UITextField.TextInput
        /// </summary>
        private TextInput textInput => (TextInput)base.textInputBase;

        /// <summary>
        /// True if multiline editing is enabled
        /// </summary>
        public bool multiline
        {
            get => textInput.multiline;
            set => textInput.multiline = value;
        }

        /// <summary>
        /// Anchor of UITextField.TextInput
        /// </summary>
        /// <returns></returns>
        public TextAnchor TextAlign
        {
            get => textInput.TextAlign;
            set => textInput.TextAlign = value;
        }

        public FontStyle FontStyle => textInput.resolvedStyle.unityFontStyleAndWeight;

        /// <summary>
        /// Current text value of the field
        /// </summary>
        public override string value
        {
            get => base.value;
            set
            {
                if (_rxInputPattern != null && !_rxInputPattern.Match(value).Success)
                {
                    SendValueRejectedEvent(value);
                    SetValueWithoutNotify(base.value);
                    return;
                }

                var sanitizedValue = value.Sanitized();
                base.value = sanitizedValue;
                this.text = ProcessRawValue(sanitizedValue);
                if (multiline && !IsShiftReturnModeEnabled && sanitizedValue.ContainsLineBreak())
                    SendReturnEvent(sanitizedValue.RemoveLineBreaks());
            }
        }

        public TextElement TextElement => textInput.textElement;

        /// <summary>
        /// A regular expression to match valid values that can be inserted into the textfield by the user.
        /// Invalid values will be rejected.
        /// </summary>
        public string InputPattern
        {
            get => _rxInputPattern?.ToString();
            set
            {
                if (string.IsNullOrEmpty(value))
                {
                    _rxInputPattern = null;
                    return;
                }

                var prefix = value.StartsWith("^") ? "" : "^";
                var suffix = value.EndsWith("$") ? "" : "$";
                _rxInputPattern = new Regex($"{prefix}{value}{suffix}");
            }
        }

        private Regex _rxInputPattern = null;

        protected void SendReturnEvent(string value)
        {
            using var returnEvent = ReturnEvent.GetPooled();
            returnEvent.target = this;
            returnEvent.Value = value;
            SendEvent(returnEvent);
        }

        protected void SendShiftReturnEvent()
        {
            using var returnEvent = ShiftReturnEvent.GetPooled();
            returnEvent.target = this;
            SendEvent(returnEvent);
        }

        protected void SendValueRejectedEvent(string value)
        {
            using var valueRejectedEvent = ValueRejectedEvent.GetPooled();
            valueRejectedEvent.target = this;
            valueRejectedEvent.Value = value;
            SendEvent(valueRejectedEvent);
        }

        protected void SendBackspaceEvent()
        {
            using var backspaceEvent = BackspaceEvent.GetPooled();
            backspaceEvent.target = this;
            SendEvent(backspaceEvent);
        }

        public string OriginalValue => base.text;

        /// <summary>
        /// Enables a mode in which Return key sends a ReturnEvent
        /// and Shift+Return sends ShiftReturnEvent.
        /// Warning: Works only on non-mobile platforms!
        /// </summary>
        public bool IsShiftReturnModeEnabled
        {
            get => _isShiftReturnModeEnabled;
            set
            {
#if UNITY_STANDALONE || UNITY_EDITOR
                _isShiftReturnModeEnabled = value;
#else
                _isShiftReturnModeEnabled = false;
#endif
            }
        }

        private bool _isShiftReturnModeEnabled = false;

        //
        // Summary:
        //     Creates a new textfield.
        public UITextFieldBase() : this(null)
        {
        }

        public static IEmojiParser EmojiParser;
        public static Func<string, TextElement, string> FixRightToLeft;

        //
        // Summary:
        //     Creates a new textfield.
        //
        // Parameters:
        //   maxLength:
        //     The maximum number of characters this textfield can hold. If 0, there is no limit.
        //
        //   multiline:
        //     Set this to true to allow multiple lines in the textfield and false if otherwise.
        //
        //   isPasswordField:
        //     Set this to true to mask the characters and false if otherwise.
        //
        //   maskChar:
        //     The character used for masking in a password field.
        public UITextFieldBase(int maxLength, bool multiline, bool isPasswordField, char maskChar)
            : this(null, maxLength, multiline, isPasswordField, maskChar)
        {
        }

        //
        // Summary:
        //     Creates a new textfield.
        //
        // Parameters:
        //   label:
        public UITextFieldBase(string label)
            : this(label, -1, multiline: false, isPasswordField: false, '\u2022')
        {
        }

        //
        // Summary:
        //     Creates a new textfield.
        //
        // Parameters:
        //   maxLength:
        //     The maximum number of characters this textfield can hold. If 0, there is no limit.
        //
        //   multiline:
        //     Set this to true to allow multiple lines in the textfield and false if otherwise.
        //
        //   isPasswordField:
        //     Set this to true to mask the characters and false if otherwise.
        //
        //   maskChar:
        //     The character used for masking in a password field.
        //
        //   label:
        public UITextFieldBase(string label, int maxLength, bool multiline, bool isPasswordField, char maskChar)
            : base(label, maxLength, maskChar, (TextInputBase)new TextInput())
        {
            AddToClassList(ussClassName);
            base.labelElement.AddToClassList(labelUssClassName);
            base.visualInput.AddToClassList(inputUssClassName);

#if !UNITY_EDITOR && !UNITY_STANDALONE
            base.pickingMode = PickingMode.Ignore;
#endif
            SetValueWithoutNotify("");
            this.multiline = multiline;
            base.isPasswordField = isPasswordField;
        }

        /// <summary>
        /// Move the cursor to the end of the text with no selection
        /// </summary>
        public void SelectTextEnd()
        {
            textInput.SelectTextEnd();
            textInput.IncrementVersion(VersionChangeType.Repaint);
        }

        public void ReplaceSelection(string value)
        {
            textInput.ReplaceSelection(value);
        }

        public override void SetValueWithoutNotify(string newValue)
        {
            base.SetValueWithoutNotify(newValue);
            ((INotifyValueChanged<string>)this.textInput.textElement).SetValueWithoutNotify(ProcessRawValue(rawValue));
        }

        internal override void OnViewDataReady()
        {
            base.OnViewDataReady();
            this.OverwriteFromViewData((object)this, this.GetFullHierarchicalViewDataKey());
            this.text = ProcessRawValue(rawValue);
        }

        protected override string ValueToString(string value) => value;

        protected override string StringToValue(string str) => str;

        protected virtual void OnIsPasswordFieldChanged() { }

        protected virtual void OnValueChanged() { }

        private string ProcessRawValue(string value)
        {
            var emojiParsedValue = EmojiParser?.Parse(value) ?? value;
            return FixRightToLeft(emojiParsedValue, textInput.textElement);
        }
    }
}
