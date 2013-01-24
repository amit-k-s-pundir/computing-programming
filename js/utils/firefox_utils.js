function open_new_window(){
    window.open();
    var wm = Components.classes["@mozilla.org/appshell/window-mediator;1"]
        .getService(Components.interfaces.nsIWindowMediator);
    var newWindow = wm.getMostRecentWindow("navigator:browser");
    var b = newWindow.gBrowser;
}

function reuse_and_focus_on_named_windows(){
    var wenum = Components.classes["@mozilla.org/embedcomp/window-watcher;1"]
        .getService(Components.interfaces.nsIWindowWatcher)
        .getWindowEnumerator();
    var index = 1;
    var windowName = "yourWindowName";
    while (wenum.hasMoreElements()) {
        var win = wenum.getNext();
        if (win.name == windowName) {
            win.focus();
            return;
        }
        index++
    }
    window.open("chrome://to/your/window.xul", windowName, "features");
}
