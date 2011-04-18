<?xml version="1.0"?>
<!-- usingas/UsingCDATA.mxml -->
<mx:Application xmlns:mx="http://www.adobe.com/2006/mxml"
creationComplete="doSomething()">
    <mx:Script><![CDATA[
        public var m:Number;
        public var n:Number;
        public function doSomething():void {
            n = 42;
            m = 40;
            label1.text = "42 > 40 = " + String(n > m);
        }
    ]]></mx:Script>
    <mx:Label id="label1"/>
</mx:Application>

  
