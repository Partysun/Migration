package com.partysun.migame.enteties 
{
	import Box2D.Collision.Shapes.b2MassData;
	import Box2D.Common.Math.b2Vec2;
	import org.flixel.FlxSprite;
	import org.flixel.FlxPoint;
	import org.flixel.FlxG;
	import org.flixel.FlxU;
	import Box2D.Dynamics.Controllers.b2ConstantForceController;
	import Box2D.Dynamics.b2World;
	import Box2D.Dynamics.b2Body;
	
	import flash.utils.getTimer;
	
	import org.flixel.plugin.photonstorm.FlxVelocity;
	
	import com.partysun.migame.pools.GameManager;
	import com.partysun.migame.enteties.physic.B2FlxSprite;
	/**
	 * Класс самолетика игрока. Главный дейсвующий объект игры.
	 * @author Mike
	 */
	public class Plane extends B2FlxSprite
	{
		[Embed(source = '../../../../data/plane.png')] private var PlaneImg:Class;
		
		private var vectorfirst:FlxPoint = new FlxPoint();
		private var vectorsecond:FlxPoint = new FlxPoint();
		private var vectorfirstang:FlxPoint = new FlxPoint();
		private var vectorsecondang:FlxPoint = new FlxPoint();
		private var vectorcheck:uint = 0;
		private var launchStart:Boolean = false;
		
		private var trigerLaunch:Boolean = true;
		
		// Ограничения при броске
		private var adjust:FlxPoint = new FlxPoint(20, GameManager.level.boundsMaxY - 450);
		// Сила крыльев
		private var wingPower:b2ConstantForceController;
		
		private const WING_DRAG_H:Number = 0.08;         // horizontal component of wing's drag
		private const WING_DRAG_V:Number = 5;            // vertical component of wing's drag

		
		// объект для ведения камеры за объектом
		private var dummy:FlxSprite = new FlxSprite();
		private var isDummyLock:Boolean = true;
		private var isDummyFollow:Boolean = false;		
		
		public function Plane(world:b2World, x:int = 0, y:int = 0 )
		{
			super(x, y, 18, 18, world);
			
			_body.SetLinearVelocity(new b2Vec2(0, 0));
			loadGraphic(PlaneImg);
			
			var mass:b2MassData = new b2MassData();
			mass.mass = 1;
			mass.center.SetZero();
			mass.I =  2; // 2* mass        
			this._body.SetMassData(mass);
		
			this.antialiasing = true;
			wingPower = new b2ConstantForceController();	
			wingPower.AddBody(this._body);
			world.AddController(wingPower);
			FlxG.state.add(dummy);
			dummy.x = 300;
			dummy.y = GameManager.level.boundsMaxY - 250;		
			dummy.visible = false;
			FlxG.camera.follow(dummy);					
		}
		
		public function rotate(aimAngle:Number):void
		{
			if (this._body.GetAngle() >= 2*Math.PI)
				this._body.SetAngle(this._body.GetAngle() - 2*Math.PI);
			if (this._body.GetAngle() < 0)
				this._body.SetAngle(this._body.GetAngle() + 2*Math.PI);
			var aimAng:Number = aimAngle + 180;
			var thisAng:Number = this._body.GetAngle()*180/Math.PI + 180;
			if (aimAng > 360)
				aimAng -= 360;
			if (aimAng < 0)
				aimAng += 360;
			if (thisAng > 360)
				thisAng -= 360;
			if (thisAng < 0)
				thisAng += 360;
			if (Math.abs(aimAng - thisAng) > 180)
				{
					if (Math.round(aimAng) > Math.round(thisAng))
						this._body.SetAngle(this._body.GetAngle() - Math.PI / 180);
					if (Math.round(aimAng) < Math.round(thisAng))
						this._body.SetAngle(this._body.GetAngle() + Math.PI / 180);
				}
			if (Math.abs(aimAng - thisAng) < 180)
				{
					if (Math.round(aimAng) > Math.round(thisAng))
						this._body.SetAngle(this._body.GetAngle() + Math.PI / 180);
					if (Math.round(aimAng) < Math.round(thisAng))
						this._body.SetAngle(this._body.GetAngle() - Math.PI / 180);
				}
		}
		
		override public function update():void 
		{
			super.update();			
			
			// Один раз запускаем самолетик в его жизни.
			if (trigerLaunch)
			{
				// Если мышка зажата и самолетик под ней то запускаем в полет
				if ( FlxG.mouse.justPressed() && FlxU.inSprite(this))
				{					
					launchStart = true;					
				}
				
				// Удерживаем  физический объект в поле экрана с небольшими отступами
				// на время запуска
				if (launchStart)
				{
					this._body.SetPosition(getFixedMousePos());					
				}
				
				// Каждые 100 мс запоминаем позиции мышки (для генерации вектора броска)
				if (launchStart && getTimer() > vectorcheck + 50)
				{
					vectorcheck = getTimer();
					vectorsecond = vectorfirst;		
					vectorfirst = new FlxPoint(FlxG.mouse.screenX, FlxG.mouse.screenY);
				}
				
				// Если мышка отжата и мы запускали объект , то запускаем.
				if (FlxG.mouse.justReleased() && launchStart)
				{
					launchStart = false;				
					trigerLaunch = false;			
					GameManager.gameCondition = GameManager.RUNNING;
					//TODO: сделать плавное движение камеры за объектом					
					isDummyLock = false;
					//FlxG.camera.follow(this);
					// Добавляем физ.объекту силу ветра
					//this._body.ApplyForce(new b2Vec2( -250, 0), this._body.GetWorldCenter());
					// Придаем импульс броска
					this._body.ApplyImpulse(new b2Vec2((vectorfirst.x - vectorsecond.x) / 10, (vectorfirst.y - vectorsecond.y) / 10), this._body.GetWorldCenter());	
					var dx:Number = vectorfirst.x - vectorsecond.x;
					var dy:Number = vectorfirst.y - vectorsecond.y;
					this._body.SetAngle(Math.atan2(dy,dx));
					//((FlxU.getAngle(vectorsecond, vectorfirst)) - 90) / 180 * Math.PI);						
				}
				vectorfirstang = new FlxPoint(this.x, this.y);
			}		
			
			// Если думми не догнал еще самолетик
			if (!isDummyLock)
			{
				FlxVelocity.moveTowardsPoint(dummy, new FlxPoint(this.getMidpoint().x +200, this.getMidpoint().y), this._body.GetLinearVelocity().x * 30 + 500);
				if (this.y < 500)
				{
					
				}
				if (dummy.x > this.x + 200)
				{
					isDummyLock = true;
					dummy.y = this.y;
					dummy.x = this.x + 200;
					isDummyFollow = true;
				}				
			}
			
			// Если думми догнал то следуем за обектом
			if (isDummyFollow)
			{
				dummy.y = this.y;
				dummy.x = this.x + 200;
			}
		
			// Контролируем полет объекта над землей
			if (GameManager.gameCondition == GameManager.RUNNING && this.y < GameManager.level.boundsMaxY - 80)
			{				
				if (getTimer() > vectorcheck + 100)
				{						
					vectorcheck = getTimer();
					vectorsecondang = vectorfirstang;		
					vectorfirstang = new FlxPoint(this.x, this.y);
					var dx:Number = vectorfirstang.x - vectorsecondang.x;
					var dy:Number = vectorfirstang.y - vectorsecondang.y;				
					rotate(Math.atan2(dy,dx) / Math.PI * 180);
					//trace(this.angle + "  " + wingPower.F.x + "  "+ wingPower.F.y);
				}
			}
			
			//TODO заменить на коллайд физ объекта с физ землей
			if (this.isB2AngleSynchronized && this.y > GameManager.level.boundsMaxY - 80 && GameManager.gameCondition == GameManager.RUNNING)
			{
				this.isB2AngleSynchronized = false;
				this.angle = 0;
				wingPower.RemoveBody(this._body);
				//if (this._obj.GetLinearVelocity().x < 0.2)
					//this._obj.SetLinearVelocity(new b2Vec2(0,_obj.GetLinearVelocity().y));
			}	
			
			// Контролируем подъемную силу крыльев во время полета
			if (GameManager.gameCondition == GameManager.RUNNING)
			{
				var wings:b2Vec2   = wingsForce();
				wingPower.F = new b2Vec2(wings.x * 0.01, wings.y * 0.01);// newtons per kg				
			}
		}
		
		/**
		 * Проверка нахождения мышки в экране для без багованого полета
		 */
		protected function getFixedMousePos():b2Vec2
		{
			var objPos:b2Vec2 ;
			
			objPos = new b2Vec2(FlxG.mouse.x / GameManager.RATIO, FlxG.mouse.y / GameManager.RATIO);
			
			if (FlxG.mouse.x < adjust.x)
				objPos.x = adjust.x/GameManager.RATIO;
			
			if (FlxG.mouse.x > Migration.ScreenWidth - adjust.x)
				objPos.x = (Migration.ScreenWidth-adjust.x) / GameManager.RATIO;				
			
			if (FlxG.mouse.y < adjust.y)
				objPos.y = adjust.y/GameManager.RATIO;
			
			if (FlxG.mouse.y > Migration.ScreenHeight + adjust.y - 100)
				objPos.y = (Migration.ScreenHeight + adjust.y - 100)/ GameManager.RATIO;
			
			return objPos;
		}	
		
		// Aerodynamic force
		private function wingsForce():b2Vec2
		{
			var angle:Number = this._body.GetAngle(); // hull angle
			//			
			var velocity:b2Vec2 = this._body.GetLinearVelocity();
			var v:Number = Math.sqrt( velocity.x*velocity.x + velocity.y*velocity.y );
			var velAngle:Number = Math.atan2( velocity.y, velocity.x );
			//
			//static const double WING_INCLINATION = 0.04;    // hull-wings angle
			//
			//var attack:Number = angle + (WING_INCLINATION*_orientation) - velAngle; // angle of attack
			var attack:Number = angle -  velAngle; // angle of attack

			var sina:Number = Math.sin(attack);
			// lift
			//double lift = v*v * ( WING_LIFT + FLAPS_EXTRA_LIFT*_flaps ) * sina;
			var lift:Number = v * v * sina;		
			// 			
			//drag
			//double dragH = WING_DRAG_H + FLAPS_EXTRA_DRAG*_flaps;
			var dragH:Number = WING_DRAG_H;
			var drag:Number = v*v*(dragH +(WING_DRAG_V-dragH) * sina*sina ) * 0.1;
			//
			return new b2Vec2( -drag*Math.cos(angle)  - lift*Math.sin(angle)
					,   -drag*Math.sin(angle) + lift*Math.cos(angle));
		}
	}
}