package com.partysun.migame.maps 
{
	import com.partysun.migame.enteties.LandObjects;
	import com.partysun.migame.pools.LandObjectManager;
	
	import org.flixel.FlxGroup;
	import org.flixel.FlxG;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	
	import com.partysun.migame.pools.GameManager;
	
	/**
	 * Основа уровня игры
	 * @author Yura - 30.08.2011 18:27
	 */
	public class BaseLevel 
	{
		/**
		 * Список всех слоев игровой сцены.
		 */				
		public var masterLayer:FlxGroup = new FlxGroup;		
		
		/**
		 * Слой : Задник статичный
		 */
		public var backStatic:FlxGroup = new FlxGroup(2);
		
		/**
		 * Слой : Облаков
		 */
		public var backClouds:FlxGroup = new FlxGroup();
		
		/**
		 * Слой : Задник двигающийся
		 */
		public var backMovements:FlxGroup = new FlxGroup();		
		
		/**
		 * Слой : Двигающихся ближних облаков
		 */
		public var frontClouds:FlxGroup = new FlxGroup();		
		
		/**
		 * Слой : Передок с землей
		 */
		public var frontLand:FlxGroup = new FlxGroup();		
		
		private var landObjects:LandObjectManager = new LandObjectManager();
		
		public var boundsMinX:int = 0;
		public var boundsMinY:int = 0;
		public var boundsMaxX:int = 640;
		public var boundsMaxY:int = 480;
		
		protected var id:int = 1;
		
		private var oldPosLand:int = 0;
		private var oldPosbg:int = 0;
		private var bgSwitchLand:Boolean = true;
		private var bgSwitchbg:Boolean = true;
		private var lastLandObj:int = 0;
		
		public function BaseLevel() 
		{			
		}
		
		/**
		 * Устанваливаем размер уровня по ширине и высоте.
		 * @param	maxWidth
		 * @param	maxHeight
		 */
		public function setBoundSize(maxWidth:int,maxHeight:int):void
		{
			this.boundsMaxX = maxWidth;
			this.boundsMaxY = maxHeight;
		}
		
		public function setID(id:int):void
		{
			this.id = id;
		}
		
		public function getID():int 
		{
			return this.id;
		}
		
		/**
		 * Создает левел на активной сцене
		 */
		public function init():void
		{
			masterLayer.add(backStatic);			
			masterLayer.add(backClouds);
			masterLayer.add(backMovements);
			masterLayer.add(frontClouds);
			masterLayer.add(landObjects);
			masterLayer.add(frontLand);					
			backStatic.setAll("scrollFactor", new FlxPoint(0, 1));
			backMovements.setAll("scrollFactor", new FlxPoint(0.05, 1));
		}
		
		public function clear():void
		{
			masterLayer.destroy();
			masterLayer = null;
		}	
		
		// Функция выполняющаяся в апдейте игры
		public function updateLevel():void
		{		
			if (GameManager.player.x - lastLandObj > Math.random() * 100 + 500)
			{
				if (Math.random() > 0.9)
				{
					
					var temp:LandObjects = landObjects.getRandomAlive();
					temp.x = GameManager.player.x + Math.random() * 100 + 1500;
					temp.y = GameManager.level.boundsMaxY - 50 - temp.height;
					lastLandObj = GameManager.player.x;
				}
			}
			if (GameManager.player != null)
			{
				var bg:FlxSprite = backMovements.members[0] as FlxSprite;
				var bg2:FlxSprite = backMovements.members[1] as FlxSprite;
				var land:FlxSprite = frontLand.members[0] as FlxSprite;
				var land2:FlxSprite = frontLand.members[1] as FlxSprite;
				
				if(int(FlxG.camera.scroll.x) - oldPosLand > land.width)
				{
					if (bgSwitchLand)
						land.x += land.width * 2;	
					else
						land2.x += land.width * 2;
					bgSwitchLand = !bgSwitchLand;	
					oldPosLand = int(FlxG.camera.scroll.x * land.scrollFactor.x);
				}
				
				if (int(FlxG.camera.scroll.x * bg.scrollFactor.x) - oldPosbg > bg.width)
				{
					if (bgSwitchbg)
						bg.x += bg.width * 2;				
					else
						bg2.x += bg.width * 2;
					bgSwitchbg = !bgSwitchbg;	
					oldPosbg = int(FlxG.camera.scroll.x * bg.scrollFactor.x);
				}
			}
		}
	}	
}