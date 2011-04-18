
package 
{

import flash.display.Sprite;
import mx.core.IFlexModuleFactory;
import mx.core.mx_internal;
import mx.styles.CSSStyleDeclaration;
import mx.styles.StyleManager;
import mx.skins.halo.BusyCursor;

[ExcludeClass]

public class _CursorManagerStyle
{
    [Embed(_resolvedSource='/mnt/windows/Documents and Settings/COMPAQ/My Documents/programming/flex/flex_sdk_3/frameworks/libs/framework.swc$Assets.swf', symbol='mx.skins.cursor.BusyCursor', source='/mnt/windows/Documents and Settings/COMPAQ/My Documents/programming/flex/flex_sdk_3/frameworks/libs/framework.swc$Assets.swf', original='Assets.swf', _line='509', _file='/mnt/windows/Documents and Settings/COMPAQ/My Documents/programming/flex/flex_sdk_3/frameworks/libs/framework.swc$defaults.css')]
    private static var _embed_css_Assets_swf_mx_skins_cursor_BusyCursor_344770818:Class;

    public static function init(fbs:IFlexModuleFactory):void
    {
        var style:CSSStyleDeclaration = StyleManager.getStyleDeclaration("CursorManager");
    
        if (!style)
        {
            style = new CSSStyleDeclaration();
            StyleManager.setStyleDeclaration("CursorManager", style, false);
        }
    
        if (style.defaultFactory == null)
        {
            style.defaultFactory = function():void
            {
                this.busyCursor = mx.skins.halo.BusyCursor;
                this.busyCursorBackground = _embed_css_Assets_swf_mx_skins_cursor_BusyCursor_344770818;
            };
        }
    }
}

}
