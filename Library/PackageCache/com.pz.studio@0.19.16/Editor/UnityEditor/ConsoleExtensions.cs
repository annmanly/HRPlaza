/*

    Copyright (c) 2024 Pocketz World. All rights reserved.

*/

#if UNITY_EDITOR

using System;
using System.Runtime.InteropServices;
using UnityEditor;

namespace Highrise
{
    public static class ConsoleExtensions
    {
        private static void LogRuntime(string message, string filename, int line, string callstack, LogMessageFlags mode)
        {
            var filenameBytes = System.Text.Encoding.UTF8.GetBytes(filename + "\0");
            var filenamePtr = GCHandle.Alloc(filenameBytes, GCHandleType.Pinned);
            var filenameView = new LogEntryUTF8StringView (filenamePtr.AddrOfPinnedObject(), filename.Length);

            var messageBytes = System.Text.Encoding.UTF8.GetBytes(message + "\0");
            var messagePtr = GCHandle.Alloc(messageBytes, GCHandleType.Pinned);
            var messageView = new LogEntryUTF8StringView (messagePtr.AddrOfPinnedObject(), message.Length);

            var callstackBytes = System.Text.Encoding.UTF8.GetBytes(callstack + "\0");
            var callstackPtr = GCHandle.Alloc(callstackBytes, GCHandleType.Pinned);
            var callstackView = new LogEntryUTF8StringView (callstackPtr.AddrOfPinnedObject(), callstack.Length);

            var timestamp = DateTime.Now.ToString();
            var timestampBytes = System.Text.Encoding.UTF8.GetBytes(timestamp + "\0");
            var timestampPtr = GCHandle.Alloc(timestampBytes, GCHandleType.Pinned);
            var timestampView = new LogEntryUTF8StringView (timestampPtr.AddrOfPinnedObject(), timestamp.Length);

            var s = new LogEntryStruct
            {
                message = messageView,
                callstack = callstackView,
                timestamp = timestampView,
                file = filenameView,
                line = line,
                column = 1,
                mode = mode,
                instanceID = 0,
                identifier = 1234567
            };

            ConsoleWindow.AddMessage(ref s);

            filenamePtr.Free();
            messagePtr.Free();
            callstackPtr.Free();
            timestampPtr.Free();
        }

        public static void LogRuntimeError(string message, string filename, int line, string callstack) =>
            LogRuntime(
                message,
                filename,
                line,
                callstack,
                LogMessageFlags.kError |
                LogMessageFlags.kScriptingException |
                LogMessageFlags.kDontExtractStacktrace |
                LogMessageFlags.kMayIgnoreLineNumber);

        public static void LogRuntimeInfo(string message, string filename, int line, string callstack) =>
            LogRuntime(
                message,
                filename,
                line,
                callstack,
                LogMessageFlags.kLog |
                LogMessageFlags.kScriptingLog |
                LogMessageFlags.kDontExtractStacktrace |
                LogMessageFlags.kMayIgnoreLineNumber);

        public static void LogRuntimeWarning(string message, string filename, int line, string callstack) =>
            LogRuntime(
                message,
                filename,
                line,
                callstack,
                LogMessageFlags.kScriptingWarning |
                LogMessageFlags.kDontExtractStacktrace |
                LogMessageFlags.kMayIgnoreLineNumber);
    }
}

#endif
