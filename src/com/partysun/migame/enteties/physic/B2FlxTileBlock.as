package com.partysun.migame.enteties.physic 
{
	import org.flixel.FlxSprite;
	import org.flixel.FlxTileblock;
	import Box2D.Dynamics.*;
	import Box2D.Collision.*;
	import Box2D.Collision.Shapes.*;
	import Box2D.Common.Math.*;
	
	/**
	 * Box2d FlxTileBlock
	 * @author Yura - 23.08.2011 15:08
	 */
	public class B2FlxTileBlock extends FlxSprite
	{
		[Embed(source = '../../../../../data/auto_tile.png')] private const AutoTileImg:Class;
		
		private var ratio:Number = 30;
 
		public var _fixDef:b2FixtureDef;
		public var _bodyDef:b2BodyDef
		public var _obj:b2Body;
		 
		//References			
		private var _world:b2World;
		 
		//Physics params default value
		public var _friction:Number = 2;
		public var _restitution:Number = 0.3;
		public var _density:Number = 1;
		 
		//Default angle
		public var _angle:Number = 0;
		//Default body type
		public var _type:uint = b2Body.b2_staticBody;

		public function B2FlxTileBlock(X:int , Y:int ,Width:uint, Height:uint , w:b2World) 
		{
			super(X, Y, AutoTileImg);   
			 _world = w;
			create();
		}
		
		private final function create():void 
		{	
			var boxShape:b2PolygonShape = new b2PolygonShape();
			boxShape.SetAsBox((width/2) / ratio, (height/2) /ratio);            
		 
			_fixDef = new b2FixtureDef();
			_fixDef.density = _density;
			_fixDef.restitution = _restitution;
			_fixDef.friction = _friction;            
			_fixDef.shape = boxShape;
		 
			_bodyDef = new b2BodyDef();
			_bodyDef.position.Set((x + (width/2)) / ratio, (y + (height/2)) / ratio);
			_bodyDef.angle = _angle * (Math.PI / 180);
			_bodyDef.type = _type;			

			_obj = _world.CreateBody(_bodyDef);
			_obj.CreateFixture(_fixDef);
		}
	}
	
}