package com.partysun.migame.pools 
{
	import com.partysun.migame.enteties.Plane;
	import com.partysun.migame.maps.BaseLevel;
	import com.partysun.migame.maps.Level1;
	import org.flixel.FlxSound;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import flash.display.Stage;
	import org.flixel.FlxGroup;
	import org.flixel.FlxCamera;
	import org.flixel.FlxG;	
	import Box2D.Dynamics.*;
	
	/**
	 * Класс глобальной видимости из любой точки проекта.
	 * Можно получить сведения об игроке и камере и других нужных штуках.
	 * @author Yura
	 */
	public class GameManager 
	{	
		public static const STOPED:int = 0;
		public static const RUNNING:int = 1;
		public static const WIN:int = 2;
		public static const FAILED:int = 3;
		public static const END:int = 4;
		
		public static const RATIO:int = 30;		
		
		public static var gameCondition:int = STOPED;
	    public static var stage:Stage;
        public static var player:Plane;	
		public static var level:BaseLevel;
		public static var levelID:int = 0;			
		public static var countTime: int;		
		private static var _volume:Number = 0.5;
		private static var _musicVolume:Number = 0.6;
		public static var world:b2World;
		
		public function GameManager() 
		{						
        }
		
		static public function init():void
		{			
			FlxG.mouse.show();
			// Устанавливаем игровое состояние в начальное
			GameManager.gameCondition = GameManager.STOPED;
			levelID = 1;
			GameManager.level = GameManager.getLevelByID(levelID);			
			GameManager.level.init();
			// Устанавливаем размеры ограничивающие камеру
			FlxG.camera.setBounds(0, 0, 1000000, (GameManager.level.boundsMaxY));
		}
		
		/**
		 * Очищаем Игровой Менеджер. Освобождаем память.
		 */
		static public function clear():void
		{
			stage = null;			
			player = null;		
		}
		
		/**
		 * Возвращает уровень по id
		 */
		private static function getLevelByID(id:int):BaseLevel
		{
			switch (id) 
			{
				case 1:
					return new Level1();
					break;
				default:
					return new Level1();
			}
		}		
	}
}