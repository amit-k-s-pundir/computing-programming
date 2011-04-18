var timoutID;

//alert("hello");

function startTimer(fn, delay){
        var timerForm = document.forms.timerForm;
        var delay = timerForm.elements.startButton.value;
        timoutID = setTimeout(fn, delay, arguments);
}

function stopTimer(event){
    clearTimeout(timeoutID);
}

