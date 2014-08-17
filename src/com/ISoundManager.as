package com {
	public interface ISoundManager {
		function playLevelMusic():void;
		function playJump():void;
		function playCorrectLetter():void;
		function playIncorrectLetter():void;
		function playCollectSweet():void;
		function playMenuTheme():void;
		function playDeathSound():void;
		function playWinSound():void;
		function stopMusic():void;
	}
}