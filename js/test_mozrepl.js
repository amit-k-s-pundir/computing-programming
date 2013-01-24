var wm = Components.classes["@mozilla.org/appshell/window-mediator;1"]
    .getService(Components.interfaces.nsIWindowMediator);
var browserEnumerator = wm.getEnumerator("navigator:browser");
var found = false;
var no_of_wins = 0;
while(!found &&  browserEnumerator.getNext()){
    no_of_wins++;
}
repl.print(no_of_wins);

// Some WAFF automation.
var waffUrl = "www.network54.com/Forum/211833/";

gBrowser.selectedTab = gBrowser.addTab(waffUrl);

var newTabBrowser = gBrowser.getBrowserForTab(gBrowser.selectedTab);
newTabBrowser.addEventListener("load", function(){
    newTabBrowser.contentDocument.body.innerHTML = "<div>Hello World</div>";
}, true);
