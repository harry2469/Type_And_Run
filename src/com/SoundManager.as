package com {
	import com.ISoundManager;
	import flash.media.Sound;
	import flash.media.SoundChannel;

	public class SoundManager implements ISoundManager {
		[Embed(source="../../lib/sounds/music/Main Level Theme.mp3")]
		public var LEVEL_MUSIC:Class;

		[Embed(source="../../lib/sounds/music/Title Theme.mp3")]
		public var MENU_THEME:Class;


		[Embed(source="../../lib/sounds/effects/Jump.mp3")]
		public var JUMP_SOUND:Class;

		[Embed(source="../../lib/sounds/effects/Collect Star.mp3")]
		public var COLLECTABLE_SOUND:Class;

		[Embed(source="../../lib/sounds/effects/Typing Sound.mp3")]
		public var CORRECT_LETTER:Class;

		[Embed(source="../../lib/sounds/effects/Wrong Key.mp3")]
		public var INCORRECT_LETTER:Class;

		[Embed(source="../../lib/sounds/music/You Dieded.mp3")]
		public var DEATH_SOUND:Class;

		[Embed(source="../../lib/sounds/music/You Wonded.mp3")]
		public var WIN_SOUND:Class;


		private var backgroundMusic:SoundChannel = new SoundChannel();

		public function playLevelMusic():void {
			loopMusic(new LEVEL_MUSIC() as Sound);
		}

		public function playJump():void {
			playSoundOnce(new JUMP_SOUND() as Sound);
		}

		public function playCorrectLetter():void {
			playSoundOnce(new CORRECT_LETTER() as Sound);
		}

		public function playIncorrectLetter():void {
			playSoundOnce(new INCORRECT_LETTER() as Sound);
		}

		public function playCollectSweet():void {
			playSoundOnce(new COLLECTABLE_SOUND() as Sound);
		}

		public function playMenuTheme():void {
			loopMusic(new MENU_THEME() as Sound);
		}

		public function playDeathSound():void {
			stopMusic()
			playSoundOnce(new DEATH_SOUND() as Sound);
		}

		public function playWinSound():void {
			stopMusic()
			playSoundOnce(new WIN_SOUND() as Sound);
		}

		private function playSoundOnce(sound:Sound):SoundChannel {
			return sound.play();
		}

		private function loopMusic(sound:Sound):void {
			stopMusic();
			backgroundMusic = sound.play(0, int.MAX_VALUE);
		}

		public function stopMusic():void {
			backgroundMusic.stop();
		}
	}
}