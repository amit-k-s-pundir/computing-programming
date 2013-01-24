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

// Programatically modifying HTML

// When attempting to modify HTML elements, it is important to specify the namespace. For example, the following code will
// add a horizontal rule.

function add_xhtml_namespace(){

    var hr = document.createElementNS("http://www.w3.org/1999/xhtml", "html:hr");
    document.getElementById("id1").appendChild(hr);
}
