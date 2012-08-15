package com.partysun.migame
{
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	
	/**
	 * MenuState - class of Menu Scene.
	 * @author Yura
	 */
	public class MenuState extends FlxState
	{	
		private var text:FlxText;
		
		public function MenuState() 
		{
			super();
		}
		
		override public function create():void 
		{
			super.create();			
			// Play Title			
			text = new FlxText(FlxG.width/2-40,FlxG.height/3+139,80,"X+C TO PLAY");
			text.color = 0x729954;
			//text.
			text.alignment = "center";
			//text.alpha = 0;
			add(text);						
		}		
		
		override public function update():void
		{
			super.update();
			if(FlxG.keys.X && FlxG.keys.C) //|| (FlxG.mouse.justPressed)) 
			{
				FlxG.mouse.hide();
				onButton();	
			}			
		}
		
		private function onButton():void
		{		
			FlxG.flash(0xffffffff,0.5);
			FlxG.fade(0xff000000,1,onFade);
		}
		
		private function onFade():void
		{
			FlxG.switchState(new PlayState());
		}	
	}	
}