package com.partysun.migame.enteties.physic 
{
	
	import org.flixel.*;
	
	import com.partysun.migame.enteties.physic.PhysObject;
	
    import Box2D.Dynamics.*;
    import Box2D.Collision.*;
    import Box2D.Collision.Shapes.*;
    import Box2D.Common.Math.*;
 
	/**
	 * @author Yura - 23.08.2011 16:49
	 */
    public class B2FlxSprite extends PhysObject
    {
       	//Счетчик для сброса (зацикливания физического мира)
		private var countCycle:uint = 0;
 
        public function B2FlxSprite(X:Number, Y:Number, Width:Number, Height:Number, World:b2World):void
        {
            super(X,Y,Width,Height,World); 
			this.createBody();
        }
 
        override public function update():void
        {
			super.update();
			
			if (_body.GetPosition().x>40)
			{
				_body.SetPosition(new b2Vec2(0, _body.GetPosition().y));
				countCycle++;					
			}
			
            x = (_body.GetPosition().x * ratio) - width / 2+ countCycle*1200;
            y = (_body.GetPosition().y * ratio) - height / 2;
        }	
    }	
}