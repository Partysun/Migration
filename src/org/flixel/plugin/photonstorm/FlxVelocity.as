/**
 * FlxVelocity
 * -- Part of the Flixel Power Tools set
 * 
 * v1.5 New methods: velocityFromAngle, accelerateTowardsObject, accelerateTowardsMouse, accelerateTowardsPoint
 * v1.4 New methods: moveTowardsPoint, distanceToPoint, angleBetweenPoint
 * v1.3 Updated for the Flixel 2.5 Plugin system
 * 
 * @version 1.5 - June 10th 2011
 * @link http://www.photonstorm.com
 * @author Richard Davey / Photon Storm
 * @see Depends on FlxMath
*/

package org.flixel.plugin.photonstorm 
{
	import flash.accessibility.Accessibility;
	import org.flixel.*;
	
	public class FlxVelocity 
	{
		
		public function FlxVelocity() 
		{
		}
		
		/**
		 * Sets the source FlxSprite x/y velocity so it will move directly towards the destination FlxSprite at the speed given (in pixels per second)<br>
		 * If you specify a maxTime then it will adjust the speed (over-writing what you set) so it arrives at the destination in that number of seconds.<br>
		 * Timings are approximate due to the way Flash timers work, and irrespective of SWF frame rate. Allow for a variance of +- 50ms.<br>
		 * The source object doesn't stop moving automatically should it ever reach the destination coordinates.<br>
		 * If you need the object to accelerate, see accelerateTowardsObject() instead
		 * Note: Doesn't take into account acceleration, maxVelocity or drag (if you set drag or acceleration too high this object may not move at all)
		 * 
		 * @param	source		The FlxSprite on which the velocity will be set
		 * @param	dest		The FlxSprite where the source object will move to
		 * @param	speed		The speed it will move, in pixels per second (default is 60 pixels/sec)
		 * @param	maxTime		Time given in milliseconds (1000 = 1 sec). If set the speed is adjusted so the source will arrive at destination in the given number of ms
		 */
		public static function moveTowardsObject(source:FlxSprite, dest:FlxSprite, speed:int = 60, maxTime:int = 0):void
		{
			var a:Number = angleBetween(source, dest);
			
			if (maxTime > 0)
			{
				var d:int = distanceBetween(source, dest);
				
				//	We know how many pixels we need to move, but how fast?
				speed = d / (maxTime / 1000);
			}
			
			source.velocity.x = Math.cos(a) * speed;
			source.velocity.y = Math.sin(a) * speed;
		}
		
		/**
		 * Sets the x/y acceleration on the source FlxSprite so it will move towards the destination FlxSprite at the speed given (in pixels per second)<br>
		 * You must give a maximum speed value, beyond which the FlxSprite won't go any faster.<br>
		 * If you don't need acceleration look at moveTowardsObject() instead.
		 * 
		 * @param	source			The FlxSprite on which the acceleration will be set
		 * @param	dest			The FlxSprite where the source object will move towards
		 * @param	speed			The speed it will accelerate in pixels per second
		 * @param	xSpeedMax		The maximum speed in pixels per second in which the sprite can move horizontally
		 * @param	ySpeedMax		The maximum speed in pixels per second in which the sprite can move vertically
		 */
		public static function accelerateTowardsObject(source:FlxSprite, dest:FlxSprite, speed:int, xSpeedMax:uint, ySpeedMax:uint):void
		{
			var a:Number = angleBetween(source, dest);
			
			source.velocity.x = 0;
			source.velocity.y = 0;
			
			source.acceleration.x = int(Math.cos(a) * speed);
			source.acceleration.y = int(Math.sin(a) * speed);
			
			source.maxVelocity.x = xSpeedMax;
			source.maxVelocity.y = ySpeedMax;
		}
		
		/**
		 * Move the given FlxSprite towards the mouse pointer coordinates at a steady velocity
		 * If you specify a maxTime then it will adjust the speed (over-writing what you set) so it arrives at the destination in that number of seconds.<br>
		 * Timings are approximate due to the way Flash timers work, and irrespective of SWF frame rate. Allow for a variance of +- 50ms.<br>
		 * The source object doesn't stop moving automatically should it ever reach the destination coordinates.<br>
		 * 
		 * @param	source		The FlxSprite to move
		 * @param	speed		The speed it will move, in pixels per second (default is 60 pixels/sec)
		 * @param	maxTime		Time given in milliseconds (1000 = 1 sec). If set the speed is adjusted so the source will arrive at destination in the given number of ms
		 */
		public static function moveTowardsMouse(source:FlxSprite, speed:int = 60, maxTime:int = 0):void
		{
			var a:Number = angleBetweenMouse(source);
			
			if (maxTime > 0)
			{
				var d:int = distanceToMouse(source);
				
				//	We know how many pixels we need to move, but how fast?
				speed = d / (maxTime / 1000);
			}
			
			source.velocity.x = Math.cos(a) * speed;
			source.velocity.y = Math.sin(a) * speed;
		}
		
		/**
		 * Sets the x/y acceleration on the source FlxSprite so it will move towards the mouse coordinates at the speed given (in pixels per second)<br>
		 * You must give a maximum speed value, beyond which the FlxSprite won't go any faster.<br>
		 * If you don't need acceleration look at moveTowardsMouse() instead.
		 * 
		 * @param	source			The FlxSprite on which the acceleration will be set
		 * @param	speed			The speed it will accelerate in pixels per second
		 * @param	xSpeedMax		The maximum speed in pixels per second in which the sprite can move horizontally
		 * @param	ySpeedMax		The maximum speed in pixels per second in which the sprite can move vertically
		 */
		public static function accelerateTowardsMouse(source:FlxSprite, speed:int, xSpeedMax:uint, ySpeedMax:uint):void
		{
			var a:Number = angleBetweenMouse(source);
			
			source.velocity.x = 0;
			source.velocity.y = 0;
			
			source.acceleration.x = int(Math.cos(a) * speed);
			source.acceleration.y = int(Math.sin(a) * speed);
			
			source.maxVelocity.x = xSpeedMax;
			source.maxVelocity.y = ySpeedMax;
		}
		
		/**
		 * Sets the x/y velocity on the source FlxSprite so it will move towards the target coordinates at the speed given (in pixels per second)<br>
		 * If you specify a maxTime then it will adjust the speed (over-writing what you set) so it arrives at the destination in that number of seconds.<br>
		 * Timings are approximate due to the way Flash timers work, and irrespective of SWF frame rate. Allow for a variance of +- 50ms.<br>
		 * The source object doesn't stop moving automatically should it ever reach the destination coordinates.<br>
		 * 
		 * @param	source		The FlxSprite to move
		 * @param	target		The FlxPoint coordinates to move the source FlxSprite towards
		 * @param	speed		The speed it will move, in pixels per second (default is 60 pixels/sec)
		 * @param	maxTime		Time given in milliseconds (1000 = 1 sec). If set the speed is adjusted so the source will arrive at destination in the given number of ms
		 */
		public static function moveTowardsPoint(source:FlxSprite, target:FlxPoint, speed:int = 60, maxTime:int = 0):void
		{
			var a:Number = angleBetweenPoint(source, target);
			
			if (maxTime > 0)
			{
				var d:int = distanceToPoint(source, target);
				
				//	We know how many pixels we need to move, but how fast?
				speed = d / (maxTime / 1000);
			}
			
			source.velocity.x = Math.cos(a) * speed;
			source.velocity.y = Math.sin(a) * speed;
		}
		
		/**
		 * Sets the x/y acceleration on the source FlxSprite so it will move towards the target coordinates at the speed given (in pixels per second)<br>
		 * You must give a maximum speed value, beyond which the FlxSprite won't go any faster.<br>
		 * If you don't need acceleration look at moveTowardsPoint() instead.
		 * 
		 * @param	source			The FlxSprite on which the acceleration will be set
		 * @param	target			The FlxPoint coordinates to move the source FlxSprite towards
		 * @param	speed			The speed it will accelerate in pixels per second
		 * @param	xSpeedMax		The maximum speed in pixels per second in which the sprite can move horizontally
		 * @param	ySpeedMax		The maximum speed in pixels per second in which the sprite can move vertically
		 */
		public static function accelerateTowardsPoint(source:FlxSprite, target:FlxPoint, speed:int, xSpeedMax:uint, ySpeedMax:uint):void
		{
			var a:Number = angleBetweenPoint(source, target);
			
			source.velocity.x = 0;
			source.velocity.y = 0;
			
			source.acceleration.x = int(Math.cos(a) * speed);
			source.acceleration.y = int(Math.sin(a) * speed);
			
			source.maxVelocity.x = xSpeedMax;
			source.maxVelocity.y = ySpeedMax;
		}
		
		/**
		 * Find the distance (in pixels, rounded) between two FlxSprites, taking their origin into account
		 * 
		 * @param	a	The first FlxSprite
		 * @param	b	The second FlxSprite
		 * @return	int	Distance (in pixels)
		 */
		public static function distanceBetween(a:FlxSprite, b:FlxSprite):int
		{
			var dx:Number = (a.x + a.origin.x) - (b.x + b.origin.x);
			var dy:Number = (a.y + a.origin.y) - (b.y + b.origin.y);
			
			return int(FlxMath.vectorLength(dx, dy));
		}
		
		/**
		 * Find the distance (in pixels, rounded) from an FlxSprite to the given FlxPoint, taking the source origin into account
		 * 
		 * @param	a		The first FlxSprite
		 * @param	target	The FlxPoint
		 * @return	int		Distance (in pixels)
		 */
		public static function distanceToPoint(a:FlxSprite, target:FlxPoint):int
		{
			var dx:Number = (a.x + a.origin.x) - (target.x);
			var dy:Number = (a.y + a.origin.y) - (target.y);
			
			return int(FlxMath.vectorLength(dx, dy));
		}
		
		/**
		 * Find the distance (in pixels, rounded) from the object x/y and the mouse x/y
		 * 
		 * @param	a	The FlxSprite to test against
		 * @return	int	The distance between the given sprite and the mouse coordinates
		 */
		public static function distanceToMouse(a:FlxSprite):int
		{
			var dx:Number = (a.x + a.origin.x) - FlxG.mouse.screenX;
			var dy:Number = (a.y + a.origin.y) - FlxG.mouse.screenY;
			
			return int(FlxMath.vectorLength(dx, dy));
		}
		
		/**
		 * Find the angle (in radians) between an FlxSprite and an FlxPoint. The source sprite takes its x/y and origin into account.
		 * The angle is calculated in clockwise positive direction (down = 90 degrees positive, right = 0 degrees positive, up = 90 degrees negative)
		 * 
		 * @param	a			The FlxSprite to test from
		 * @param	target		The FlxPoint to angle the FlxSprite towards
		 * @param	asDegrees	If you need the value in degrees instead of radians, set to true
		 * 
		 * @return	Number The angle (in radians unless asDegrees is true)
		 */
		public static function angleBetweenPoint(a:FlxSprite, target:FlxPoint, asDegrees:Boolean = false):Number
        {
			var dx:Number = (target.x) - (a.x + a.origin.x);
			var dy:Number = (target.y) - (a.y + a.origin.y);
			
			if (asDegrees)
			{
				return FlxMath.asDegrees(Math.atan2(dy, dx));
			}
			else
			{
				return Math.atan2(dy, dx);
			}
        }
		
		/**
		 * Find the angle (in radians) between the two FlxSprite, taking their x/y and origin into account.
		 * The angle is calculated in clockwise positive direction (down = 90 degrees positive, right = 0 degrees positive, up = 90 degrees negative)
		 * 
		 * @param	a			The FlxSprite to test from
		 * @param	b			The FlxSprite to test to
		 * @param	asDegrees	If you need the value in degrees instead of radians, set to true
		 * 
		 * @return	Number The angle (in radians unless asDegrees is true)
		 */
		public static function angleBetween(a:FlxSprite, b:FlxSprite, asDegrees:Boolean = false):Number
        {
			var dx:Number = (b.x + b.origin.x) - (a.x + a.origin.x);
			var dy:Number = (b.y + b.origin.y) - (a.y + a.origin.y);
			
			if (asDegrees)
			{
				return FlxMath.asDegrees(Math.atan2(dy, dx));
			}
			else
			{
				return Math.atan2(dy, dx);
			}
        }
		
		/**
		 * Given the angle and speed calculate the velocity and return it as an FlxPoint
		 * 
		 * @param	angle	The angle (in degrees) calculated in clockwise positive direction (down = 90 degrees positive, right = 0 degrees positive, up = 90 degrees negative)
		 * @param	speed	The speed it will move, in pixels per second sq
		 * 
		 * @return	An FlxPoint where FlxPoint.x contains the velocity x value and FlxPoint.y contains the velocity y value
		 */
		public static function velocityFromAngle(angle:int, speed:int):FlxPoint
		{
			var a:Number = FlxMath.asRadians(angle);
			
			var result:FlxPoint = new FlxPoint;
			
			result.x = int(Math.cos(a) * speed);
			result.y = int(Math.sin(a) * speed);
			
			return result;
		}
		
		/**
		 * Find the angle (in radians) between an FlxSprite and the mouse, taking their x/y and origin into account.
		 * The angle is calculated in clockwise positive direction (down = 90 degrees positive, right = 0 degrees positive, up = 90 degrees negative)
		 * 
		 * @param	a			The FlxObject to test from
		 * @param	b			The FlxObject to test to
		 * @param	asDegrees	If you need the value in degrees instead of radians, set to true
		 * 
		 * @return	Number The angle (in radians unless asDegrees is true)
		 */
		public static function angleBetweenMouse(a:FlxSprite, asDegrees:Boolean = false):Number
		{
			//	In order to get the angle between the object and mouse, we need the objects screen coordinates (rather than world coordinates)
			var p:FlxPoint = a.getScreenXY();
			
			//p.x = p.x + a.width * 0.5;
			//p.y = p.y + a.height * 0.5;
			
			var dx:Number = FlxG.mouse.screenX - p.x;
			var dy:Number = FlxG.mouse.screenY - p.y;
			
			if (asDegrees)
			{
				return FlxMath.asDegrees(Math.atan2(dy, dx));
			}
			else
			{
				return Math.atan2(dy, dx);
			}
		}
        
		
		
	}

}