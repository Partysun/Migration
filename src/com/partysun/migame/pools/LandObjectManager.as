package com.partysun.migame.pools 
{
	import com.partysun.migame.enteties.LandObjects;
	import org.flixel.FlxGroup;
	/**
	 * ...
	 * @author Mike
	 */
	public class LandObjectManager extends FlxGroup
	{
		private var j:int = 0;
		
		public function LandObjectManager() 
		{
			for (var i:int = 0; i < 2; i++) 
			{
				add(new LandObjects(0, 0, LandObjects.TREE));
				add(new LandObjects(0, 0, LandObjects.TREE));
				add(new LandObjects(0, 0, LandObjects.ROCK1));
				add(new LandObjects(0, 0, LandObjects.ROCK2));
				add(new LandObjects(0, 0, LandObjects.ROCK3));
				add(new LandObjects(0, 0, LandObjects.ROCK4));
				add(new LandObjects(0, 0, LandObjects.ROCK5));
				add(new LandObjects(0, 0, LandObjects.ROCK6));
			}
		}
		
		public function getRandomAlive():LandObjects
		{
			if (!(this.members[Math.round(Math.random() * 15)] as LandObjects).alive)
				return (this.members[Math.round(Math.random() * 15)] as LandObjects);
			else
			{
				trace("Глубина рекурсии: " + j++);
				return getRandomAlive();
			}
		}
	}

}