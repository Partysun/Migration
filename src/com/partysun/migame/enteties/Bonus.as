package com.partysun.migame.enteties 
{
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Mike
	 */
	public class Bonus extends FlxSprite
	{
		[Embed(source = '../../../../data/bunusandcoins.png')] private var bonus:Class;
		public function Bonus(x:int = 0, y:int = 0) 
		{
			super(x, y);
			this.loadGraphic(bonus, true, false, 40, 40);
			addAnimation("play", [8, 9], 2);
			PlayBonus();
		}
		
		private function PlayBonus():void
		{
			play("play");
		}
	}

}