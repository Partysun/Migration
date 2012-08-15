package 
{
	import org.flixel.FlxGame;
	import com.partysun.migame.PlayState;
	/**
	 * Main class
	 * @author Yura - 23.08.2011 13:01
	 */
	
	[SWF(width="640", height="480", backgroundColor="#000000")]
	[Frame(factoryClass="Preloader")]
	
	public class Migration extends FlxGame
	{
		static public const ScreenWidth:uint = 640;
		static public const ScreenHeight:uint = 480;
		
		public function Migration() 
		{
			super(ScreenWidth, ScreenHeight, PlayState, 1);				
		}
		
	}
}