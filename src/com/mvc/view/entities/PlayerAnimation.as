package com.mvc.view.entities {
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.utils.Timer;


	public class PlayerAnimation extends Sprite {
		private var ticker:Timer = new Timer(100);
		private var frames:Array = [];
		private var currentFrame:uint = 0;

		[Embed(source="../../../../../lib/images/Walk/frame1.png")]
		public var img1:Class;

		[Embed(source="../../../../../lib/images/Walk/frame2.png")]
		public var img2:Class;

		[Embed(source="../../../../../lib/images/Walk/frame3.png")]
		public var img3:Class;

		[Embed(source="../../../../../lib/images/Walk/frame4.png")]
		public var img4:Class;

		[Embed(source="../../../../../lib/images/Walk/frame5.png")]
		public var img5:Class;

		[Embed(source="../../../../../lib/images/Walk/frame6.png")]
		public var img6:Class;

		public function PlayerAnimation() {
			frames.push(new img1());
			frames.push(new img2());
			frames.push(new img3());
			frames.push(new img4());
			frames.push(new img5());
			frames.push(new img6());

			ticker.addEventListener(TimerEvent.TIMER, changeImage);
			ticker.start();
		}

		private function changeImage(e:TimerEvent):void {
			for (var i:uint = 0; i < frames.length; i++)
				if (contains(frames[i]))
					removeChild(frames[i]);
			addChild(frames[currentFrame]);
			currentFrame++;
			if (currentFrame >= frames.length)
				currentFrame = 0;
		}
	}
}