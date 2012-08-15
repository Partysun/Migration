package com.partysun.migame 
{
	
	import com.partysun.migame.enteties.physic.PhysObject;
	import org.flixel.*;
	
	import Box2D.Dynamics.*;
	import Box2D.Collision.*;
	import Box2D.Collision.Shapes.*;
	import Box2D.Common.Math.*;
	import Box2D.Dynamics.Controllers.*;
	
	import flash.display.Sprite;
	import flash.display.BitmapData;
	
	import flash.utils.getTimer;
	import com.partysun.migame.pools.GameManager;
	import com.partysun.migame.enteties.Bonus;
	import com.partysun.migame.enteties.Plane;
	import com.partysun.migame.enteties.physic.B2FlxTileBlock;
	import com.partysun.migame.enteties.physic.B2FlxSprite;
	
	import flash.net.FileReference;
	import flash.utils.ByteArray;
	
	public class PlayState extends FlxState
	{
		public var _world:b2World;
		private var plane:Plane;
		private var block1:B2FlxTileBlock;
		private var m_controller:b2Controller;
		
		private var testObj:B2FlxSprite;
		private var timer:Number = 0;
		private var lastCheck:Number = 0;
		
		override public function create():void
		{			
			GameManager.init();
			add(GameManager.level.masterLayer);
			
			// Создаем физический мир
			setupWorld();			
			block1 = new B2FlxTileBlock(0, GameManager.level.boundsMaxY - 50, 1280, 50, _world);
			GameManager.level.masterLayer.add(block1);
			block1.visible = false;
			// Создаем главны игровой объект
			plane = new Plane(_world, 50, GameManager.level.boundsMaxY - 70);				
			GameManager.level.masterLayer.add(plane);
			GameManager.player = plane;
			
		    FlxG.camera.focusOn(new FlxPoint(0, GameManager.level.boundsMaxY - 250));
			
			// Включаем дебаг отрисовку
			FlxG.visualDebug = true;
			var debug:PhysDebugSprite = new PhysDebugSprite(FlxG.width, FlxG.height, 30,_world);
			add(debug);		
		}		
		
		private function setupWorld():void
		{
			var gravity:b2Vec2 = new b2Vec2(0, 5);
			_world = new b2World(gravity, true);						
			GameManager.world = _world;					
		}
		
		override public function update():void
		{
			_world.Step(FlxG.elapsed, 10, 10);		
			_world.ClearForces();
			super.update();	
			GameManager.level.updateLevel();
			//if (FlxG.keys.justReleased("Z"))
			//{
				 //var _xml:XML =
				 //<xml>
                        //<test>data</test>
                 //</xml>;
				//var ba:ByteArray = new ByteArray();
                //ba.writeUTFBytes(_xml);
				//var fr:FileReference = new FileReference();				
				//fr.save("test + " +ba,"hello.txt");
			//}

			//timer += FlxG.elapsed;		
			//if (timer - lastCheck > 0.20)
			//{
				//trace(plane.x + " " + plane.y);
				//lastCheck = timer;
			//}

			// Рисуем бонусы ( пока неадекватный способ )
			if (Math.random() > 0.5)
				FlxG.state.add(new Bonus(plane.x + 640, (GameManager.level.boundsMaxY - 80) * Math.random()));				
		
			
			// Событие срабатывающие на окончание раунда игры
			if (GameManager.gameCondition == GameManager.RUNNING && plane._body.GetLinearVelocity().x == 0 && plane._body.GetLinearVelocity().y == 0)
			{				
				GameManager.gameCondition = GameManager.STOPED;
				trace("Length = " + plane.x / 300);
				FlxG.resetState();
			}
			if (FlxG.keys.LEFT)
			{
				plane._body.SetAngle(plane._body.GetAngle() - Math.PI / 180);
			}
			if (FlxG.keys.RIGHT)
			{
				plane._body.SetAngle(plane._body.GetAngle() + Math.PI / 180);
			}
            if (FlxG.keys.X)
            {
                plane._body.ApplyImpulse(new b2Vec2(0.7, -0.7), plane._body.GetWorldCenter());
            }
		}
	}	
}
