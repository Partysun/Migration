package com.partysun.migame.enteties.physic 
{
	import org.flixel.FlxSprite;
	
	import Box2D.Dynamics.b2World;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2FixtureDef;
	import Box2D.Collision.Shapes.b2CircleShape;
	
	import com.partysun.migame.pools.GameManager;
	
	/**
	 * Игровой объект имеющий физику.
	 * @author Yura - 30.08.2011 12:45
	 */
	public class PhysObject extends FlxSprite
	{ 
        public var _fixDef:b2FixtureDef;
        public var _bodyDef:b2BodyDef
		// Body
        public var _body:b2Body;
        //Physics params default value
		//Трение
        public var _friction:Number = 1;
		// Упругость
        public var _restitution:Number = 0.05;
		// Плотность
        public var _density:Number = 3; 
        //Default angle
        public var _angle:Number = 0;
        //Default body type
        protected var _type:uint = b2Body.b2_dynamicBody;		
		// Синхронизировать угол поворота физического объекта с графическим представление
		protected var isB2AngleSynchronized:Boolean = true;
		// Мир в котором существует физический объект
		private var _world:b2World; 
		// Warning: ratio from GameManager
		protected var ratio:int = GameManager.RATIO;
		
		public function PhysObject(X:Number, Y:Number, Width:Number, Height:Number, World:b2World) 
		{
			// Создаем графическую оболочку
			super(X, Y);
			
			width = Width;
            height = Height;			
            _world = World;			
		}
		
		// Синхронизирует угол визуального  игрового объект с физическим
		override public function update():void 
		{
			super.update();
			if(isB2AngleSynchronized)
				angle = _body.GetAngle() * (180 / Math.PI);
		}
		
		// Создаем физическое Body игрового объекта
		public function createBody():void
        {            
            _fixDef = new b2FixtureDef();
            _fixDef.density = _density;
            _fixDef.restitution = _restitution;
            _fixDef.friction = _friction;                                   
			_fixDef.shape = new b2CircleShape(width/2/ratio);
 
            _bodyDef = new b2BodyDef();
            _bodyDef.position.Set((x + (width/2)) / ratio, (y + (height/2)) / ratio);
            _bodyDef.angle = _angle * (Math.PI / 180);	
            _bodyDef.type = _type;		
			_bodyDef.angularDamping = 5;
 
            _body = _world.CreateBody(_bodyDef);			
            _body.CreateFixture(_fixDef);		
        }
	}	
}