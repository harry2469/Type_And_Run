package 
{
	import flash.display.Sprite;/*
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;*/
	import org.flashdevelop.utils.FlashConnect;
	
	public class Main extends Sprite
	{/*
		static public const URL_1:String = "../Shortened Dictionary1.txt";
		static public const URL_2:String = "../Shortened Dictionary2.txt";
		static public const URL_3:String = "../Shortened Dictionary3.txt";
		static public const URL_4:String = "../Shortened Dictionary4.txt";
		static public const URL_5:String = "../Shortened Dictionary5.txt";*/
		
		public function Main():void 
		{
			var array:Array = 
			["abc","def"];
			FlashConnect.trace(array);
			
			/*
			var myTextLoader:URLLoader = new URLLoader();
			
			myTextLoader.addEventListener(Event.COMPLETE, onLoaded);
			myTextLoader.addEventListener(IOErrorEvent.IO_ERROR, loaderIOErrorHandler);
			
			myTextLoader.load(new URLRequest(URL_1));*/
		}
		/*
		private function onLoaded(e:Event):void {
			retrieveWords(e.target.data);
		}
		
		private function loaderIOErrorHandler(e:IOErrorEvent):void 
		{
			FlashConnect.trace("EE");
			throw new Error("Dictionary file cannot be found", 2);
		}
		
		private function retrieveWords(wordRaw:String):void
		{
			var words:Vector.<String> = Vector.<String>(wordRaw.split(/\n/));
			for (var i:int = 0; i < words.length; i++) 
			{
				if (words[i].length <= 8){
					FlashConnect.trace(words[i].slice( 0, -1 ));
				}
			}
		}*/
	}
	
}