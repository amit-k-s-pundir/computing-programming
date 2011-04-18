package yourminis.components
{
	import flash.display.Sprite;
	import flash.text.StyleSheet;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.display.Shape;
	import flash.events.MouseEvent;
	import yourminis.events.YMListCellEvent;
	
	public class ImgListCell extends ListCell
	{
		private var cellContent:Sprite;
		private var hoverOver:Sprite;
		private var hoverOverBG:Shape;
		private var hoverOverLabel:TextField;
		private static var cellPadding:Number = 3;
		private var hoverOverEnabled:Boolean = true;
		
		public function ImgListCell( cc:Sprite, label:String, data:*, w:Number, h:Number, hoverEnabled:Boolean = true )
		{
			super( data, w, h );
			
			//hoverover
			hoverOver = new Sprite();
			hoverOver.visible = false;
			hoverOver.mouseEnabled = false;
			//hoverOver.buttonMode = true;
			hoverOverEnabled = hoverEnabled;
			
			var hover_css = new StyleSheet();
			hover_css.setStyle("def", {fontFamily:'Verdana', fontSize:'10px', color:'#ffffff', fontWeight:'bold', display:'inline'});
			hover_css.setStyle("sn", {fontFamily:'Verdana', fontSize:'10px', color:'#ffffff', fontWeight:'bold', display:'inline'});
			hover_css.setStyle("sp", {fontFamily:'Verdana', fontSize:'10px', color:'#ffffff', fontWeight:'bold', display:'inline'});
			hover_css.setStyle("bp", {fontFamily:'Verdana', fontSize:'10px', color:'#ffffff', fontWeight:'bold', display:'inline'});
			hover_css.setStyle("dt", {fontFamily:'Verdana', fontSize:'10px', color:'#ffffff', fontWeight:'bold', display:'inline'});
			
			hoverOverLabel = new TextField();
			hoverOverLabel.styleSheet = hover_css;
			hoverOverLabel.selectable = false;
			hoverOverLabel.mouseEnabled = false;
			hoverOverLabel.autoSize = TextFieldAutoSize.CENTER;
			hoverOverLabel.htmlText = label;
			
			hoverOverBG = new Shape();
			drawBackground(0x000000);
			
			hoverOver.addChild(hoverOverBG);
			hoverOver.addChild(hoverOverLabel);
			

			//add content
			cellContent = cc;
			this.addChild(cellContent);
			this.addChild(hoverOver);
			
			hoverOverLabel.x=hoverOver.x+7;
			hoverOverLabel.y=hoverOver.y+3;
			hoverOverBG.x = hoverOver.x;
			hoverOverBG.y = hoverOver.y+2;

			//add event handlers
			addEventListener(MouseEvent.CLICK, clickHandler);
			addEventListener(MouseEvent.ROLL_OVER, overHandler);
			addEventListener(MouseEvent.ROLL_OUT, outHandler);
		}
		
		private function clickHandler( evt:MouseEvent )
		{
			evt.stopPropagation();
			if(evt.target == cellContent){
				dispatchEvent( new YMListCellEvent(YMListCellEvent.CLICK, evt.target.parent.cellIndex, evt.target.parent.cellData) );
			}else{
				dispatchEvent( new YMListCellEvent(YMListCellEvent.CLICK, evt.target.cellIndex, evt.target.cellData) );
			}
			
		}
		
		private function overHandler( evt:MouseEvent )
		{
			// places the current cell on top of the layers
			var obj:Sprite = Sprite(this);
			var topPos:uint = parent.numChildren - 1;
			parent.setChildIndex(obj,topPos);
			
			if (hoverOverEnabled)
			{
	
				hoverOver.visible = true;
				hoverOver.x = 0;
				//if (((evt.stageX+hoverOver.width) > parent["width"]) && ((evt.stageX-hoverOver.width) > 0 ))
				if (stage.mouseX > stage.stageWidth/2)
					hoverOver.x = -(hoverOver.width)+ 15;
				else
					hoverOver.x = evt.localX;
				/*
				if (((evt.stageX-hoverOver.width) < 0) && ((evt.stageX+hoverOver.width) < parent["width"]))
					hoverOver.x = 0;
				else if (((evt.stageX+hoverOver.width) > parent["width"]) && ((evt.stageX-hoverOver.width) > 0 ))
					hoverOver.x = -(hoverOver.width)+ 15;
				else
					hoverOver.x = evt.localX;
				*/
				hoverOver.y=0;
			}
			
			if(evt.target == cellContent){
				dispatchEvent( new YMListCellEvent(YMListCellEvent.ROLL_OVER, evt.target.parent.cellIndex, evt.target.parent.cellData) );
			}else{
				dispatchEvent( new YMListCellEvent(YMListCellEvent.ROLL_OVER, evt.target.cellIndex, evt.target.cellData) );
			}

		}
		
		private function outHandler( evt:MouseEvent )
		{
			if (hoverOverEnabled)
				hoverOver.visible = false;
			if(evt.target == cellContent){
				dispatchEvent( new YMListCellEvent(YMListCellEvent.ROLL_OUT, evt.target.parent.cellIndex, evt.target.parent.cellData) );
			}else{
				dispatchEvent( new YMListCellEvent(YMListCellEvent.ROLL_OUT, evt.target.cellIndex, evt.target.cellData) );
			}
		}
		
		private function dblClickHandler( evt:MouseEvent )
		{
			trace("Double Click");
		}
		
		private function drawBackground ( color:Number )
		{
			var cornerRadius = 10;
			var boxWidth = hoverOverLabel.textWidth+15;
			var boxHeight = 18;
			
			hoverOverBG.graphics.lineStyle(2,0xFFFFFF,100,true);
			hoverOverBG.graphics.beginFill(color,100);
			hoverOverBG.graphics.drawRoundRect(0,0,boxWidth,boxHeight,cornerRadius);
			hoverOverBG.graphics.endFill();
		}

	}
}