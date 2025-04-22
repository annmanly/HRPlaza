using System.Reflection;
using UnityEditor;
using UnityEngine;
using System.IO;
using System.Text;
using System.Collections.Generic;
using System.Runtime.CompilerServices;

[assembly: InternalsVisibleTo("com.pz.studio.editor")]

namespace Highrise.Studio
{
    internal static class MenuExtractor
    {
        public static IEnumerable<string> GetMenuItems()
        {
            var service = typeof(Editor).Assembly.GetType("UnityEditor.MenuService", false);
            var get = service.GetMethod("GetMenusItemsFromModeFile", BindingFlags.Static | BindingFlags.NonPublic);
            var menus = get.Invoke(null, new[] { "default" }) as MenuService.MenuItemsTree<MenuItemOrderingNative>;
            var roots = new HashSet<string>();

            menus.onlyLeafHaveValue = false;
            foreach (var item in menus.menuItemChildrenSorted)
            {
                var @base = item.Name.Substring(0, item.Name.IndexOf('/'));
                roots.Add(@base);
            }

            var menu = typeof(Menu).GetMethod("GetMenuItems", BindingFlags.NonPublic | BindingFlags.Static);

            foreach (var root in roots)
            {
                var items = menu.Invoke(null, new object[] { root, false, false }) as ScriptingMenuItem[];

                foreach (var i in items)
                    yield return i.path;
            }
        }
    }
}