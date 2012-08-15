package com.partysun.migame.enteties 
{
	import com.partysun.migame.pools.GameManager;
	
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Mike
	 */
	public class LandObjects extends FlxSprite
	{
		[Embed(source = '../../../../data/map/tree12.png')] private var tree:Class;
		[Embed(source = '../../../../data/map/rock1.png')] private var rock1:Class;
		[Embed(source = '../../../../data/map/rock2.png')] private var rock2:Class;
		[Embed(source = '../../../../data/map/rock3.png')] private var rock3:Class;
		[Embed(source = '../../../../data/map/rock4.png')] private var rock4:Class;
		[Embed(source = '../../../../data/map/rock5.png')] private var rock5:Class;
		[Embed(source = '../../../../data/map/rock6.png')] private var rock6:Class;
		
		public static const TREE:int = 0;
		public static const ROCK1:int = 1;
		public static const ROCK2:int = 2;
		public static const ROCK3:int = 3;
		public static const ROCK4:int = 4;
		public static const ROCK5:int = 5;
		public static const ROCK6:int = 6;
		
		public function LandObjects(x:int = 0, y:int = 0, type:int = LandObjects.TREE) 
		{
			super(x, y);
			switch (type) 
			{
				case LandObjects.TREE:
					loadGraphic(tree);
				break;
				case LandObjects.ROCK1:
					loadGraphic(rock1);
				break;
				case LandObjects.ROCK2:
					loadGraphic(rock2);
				break;
				case LandObjects.ROCK3:
					loadGraphic(rock3);
				break;
				case LandObjects.ROCK4:
					loadGraphic(rock4);
				break;
				case LandObjects.ROCK5:
					loadGraphic(rock5);
				break;
				case LandObjects.ROCK6:
					loadGraphic(rock6);
				break;
				default:
					loadGraphic(tree);
				break;
			}
			kill();
		}
		
		override public function update():void 
		{
			super.update();
			if (Boolean(int(GameManager.player.x - this.x < 1000) & int(this.alive)))
				kill();
		}
		
	}

}