package com.mvc.model {

	public class GameLoopError extends Error {
		public function GameLoopError(message:*="", id:*=0) {
			super(message, id);
		}
	}
}