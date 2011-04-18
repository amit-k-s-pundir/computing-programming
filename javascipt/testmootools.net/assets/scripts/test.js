var headings = document.evaluate('//h2', document, null, XPathResult.ANY_TYPE, null ); 
var thisHeading = headings.iterateNext();

var alertText = 'Level 2 headings in this document are:\n'

while (thisHeading) {
  alertText += thisHeading.textContent + '\n';
  thisHeading = headings.iterateNext();
}
alert(alertText);

var req = new XMLHttpRequest();
req.open('GET', 'http://www.mozilla.org/', false); 
req.send(null);
if(req.status == 200)
  dump(req.responseText);

