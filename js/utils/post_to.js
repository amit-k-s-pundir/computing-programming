function MozReplUtils(){
    this go_to = sub (url){
        content.location.href = url;
        repl.enter(content);
    }
}

function WaffMozReplUtils(){
    this.prototype = new MozReplUtils();
    
    this.post_now = sub (){
        var results = evaluateXPath(document, "//a[contains(child::text(), 'Post
        now!')]");
        results;
    }
}
    

function post_to_waff(url){
    go_to(url) && post_now() && log_in() && preview();
}

function go_to(url){
    content.location.href = url;
    repl.enter(content);
}
