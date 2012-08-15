package com.partysun.migame 
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.ui.Mouse;
	import org.flixel.*;
	import Box2D.Dynamics.*;
	import Box2D.Collision.*;
	import Box2D.Collision.Shapes.*;
	import Box2D.Common.Math.*;
	/**
	 * Box2D debug drawing for Flixel.
	 *
	 * To use it, add this to your PlayState's create() method:
	 *
	 *	var debug:PhysDebugSprite = new PhysDebugSprite(FlxG.width, FlxG.height, 30);
	 *	add(debug);
	 *
	 * @param width	width of the debug drawing window
	 * @param height height of the debug drawing window
	 * @param b2scale Box2D ratio of pixels per meter
	 */
	public class PhysDebugSprite extends FlxBasic {
		public var debugSprite:Sprite;
		public var debugDraw:b2DebugDraw;
		public var world:b2World;
		
		public function PhysDebugSprite(width:uint, height:uint, b2scale:Number, world:b2World):void {
			super();
			debugSprite = new Sprite();
			debugSprite.width = width;
			debugSprite.height = height;
			debugDraw = new b2DebugDraw();
			debugDraw.SetSprite(debugSprite);
			debugDraw.SetDrawScale(b2scale);
			debugDraw.SetLineThickness(0.1);
			debugDraw.SetAlpha(0.5);
			debugDraw.SetFillAlpha(0.6);
			debugDraw.SetFlags(b2DebugDraw.e_shapeBit | b2DebugDraw.e_centerOfMassBit);
			this.world = world;
			world.SetDebugDraw(debugDraw);
			//Globals.debugSprite = this;
		}
		
		override public function drawDebug(Camera:FlxCamera = null):void 
		{
			debugSprite.graphics.clear();
			this.world.DrawDebugData();
			
			var mat:Matrix = new Matrix();
			//mat.scale(Const.ZOOM, Const.ZOOM);
			//mat.translate(-FlxG.camera.scroll.x * Const.ZOOM, -FlxG.camera.scroll.y * Const.ZOOM);
			mat.translate(-FlxG.camera.scroll.x, -FlxG.camera.scroll.y);
			FlxG.camera.buffer.draw(debugSprite, mat);
			super.drawDebug(Camera);
		}
	}
	
}