/*

    Copyright (c) 2024 Pocketz World. All rights reserved.

*/

using UnityEngine;

namespace Highrise.UnityEditorExtensions
{
    public static class TransformExtensions
    {
        public static void SetLocalEulerHint(this Transform transform)
        {
            transform.SetLocalEulerHint(transform.GetLocalEulerAngles(transform.rotationOrder));
        }
    }
}
