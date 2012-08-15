package com.partysun.migame.maps 
{
	import com.partysun.migame.pools.GameManager;
	
	import org.flixel.FlxSprite;
	
	/**
	 * Уровень 1 - тестовый
	 * @author Yura - 30.08.2011 18:41
	 */
	public class Level1 extends BaseLevel
	{		
		[Embed(source='../../../../data/map/backStatic.png')] private const BackStaticImg:Class;
		[Embed(source = '../../../../data/map/mou1.png')] private var backMovementsImg:Class;
		[Embed(source = '../../../../data/map/frontLand.png')] private var FrontLandImg:Class;
		
		public function Level1() {}
		
		override public function init():void 
		{			
			var height:int = new FlxSprite(0, 0, BackStaticImg).height; 
			this.backStatic.add(new FlxSprite(0, 0, BackStaticImg));
			this.backMovements.add(new FlxSprite(0, height - 310, backMovementsImg));
			this.backMovements.add(new FlxSprite(1440, height - 310, backMovementsImg));
			this.frontLand.add(new FlxSprite(0, height - 60, FrontLandImg));
			this.frontLand.add(new FlxSprite(1440, height - 60, FrontLandImg));
			super.init();
			
			setID(1);
			setBoundSize(640, height);
		}		
	}	
}