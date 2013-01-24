function genTable(rows, cols){
    var rootDiv = document.createElement("div");
    for(var i = 0; i <= rows; i++){
        var childDiv = document.createElement("div");
        childDiv.textContent = "div" + i;
        rootDiv.appendChild(childDiv);
        for(var j = 0; j <= cols; j++){
            var childSpan = document.createElement("span");
            childDiv.appendChild(childSpan);
            childSpan.textContent = "span" + j;
        }
    }
    return(rootDiv);
}
