/*
  
    Copyright � 2022 Pocketz World. All rights reserved.

*/

using System;
using System.Linq;
using UnityEngine;
using UnityEngine.UIElements;

namespace Highrise.UI
{
    public static class StyleSheetExtensions
    {
        private static bool TryGetProperty(this StyleSheet sheet, string name, out StyleProperty property)
        {
            if (sheet == null)
            {
                property = null;
                return false;
            }

            property = sheet.rules.SelectMany(r => r.properties).FirstOrDefault(r => r.name == name);
            return property != null;
        }
        
        /// <summary>
        /// Set the value of an existing variable in the style sheet
        /// </summary>
        /// <param name="name">Name of the variable</param>
        /// <param name="value">New value of the variable</param>
        public static void SetVariable(this StyleSheet sheet, string name, StyleLength value)
        {
            if (!sheet.TryGetProperty(name, out var property))
                return;

            if (property.values.Length != 1)
                return;

            var propertyValue = property.values[0];
            if (propertyValue.valueType != StyleValueType.Dimension)
                return;

            var dimension = sheet.dimensions[propertyValue.valueIndex];
            dimension.value = value.value.value;
            dimension.unit = value.value.unit switch
            {
                LengthUnit.Percent => UnityEngine.UIElements.StyleSheets.Dimension.Unit.Percent,
                LengthUnit.Pixel => UnityEngine.UIElements.StyleSheets.Dimension.Unit.Pixel,
                _ => throw new NotImplementedException()
            };

            sheet.dimensions[propertyValue.valueIndex] = dimension;
        }

        public static IStyle Overlay(this IStyle style)
        {
            style.position = Position.Absolute;
            style.left = 0;
            style.right = 0;
            style.top = 0;
            style.bottom = 0;

            return style;
        }
    }
}
