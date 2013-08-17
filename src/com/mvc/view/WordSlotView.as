package com.mvc.view {
	import com.events.WordSlotEvent;
	import com.mvc.model.words.IWordSlotModel;
	import com.mvc.view.text.*;
	import flash.display.*;
	
	/** @author Kristian Welsh */
	public class WordSlotView {
		
		[Embed(source="../../../../lib/images/simple/Word.png")]
		private var _image:Class;
		private var _art:Bitmap = new _image();
		private var _lettersToSpell:LettersToSpell;
		private var _lettersSpelt:LettersSpelt;
		
		public function WordSlotView(container:DisplayObjectContainer, model:IWordSlotModel, lettersToSpell:LettersToSpell, lettersSpelt:LettersSpelt):void {
			addChildrenToContainer(container, [_art, lettersToSpell, lettersSpelt]);
			positionArtRelativeTo(lettersToSpell);
			addListenersTo(model);
			_lettersToSpell = lettersToSpell;
			_lettersSpelt = lettersSpelt;
		}
		
		private function positionArtRelativeTo(lettersToSpell:LettersToSpell):void {
			_art.x = lettersToSpell.x - 28;
			_art.y = lettersToSpell.y + 2;
		}
		
		private function addListenersTo(model:IWordSlotModel):void {
			model.addEventListener(WordSlotEvent.ADVANCE, advanceDisplay);
			model.addEventListener(WordSlotEvent.CHANGE, changeDisplay);
		}
		
		private function advanceDisplay(e:WordSlotEvent):void {
			_lettersSpelt.text += _lettersToSpell.shift();
		}
		
		private function changeDisplay(e:WordSlotEvent):void {
			_lettersToSpell.text = e.wordToSpell;
			_lettersSpelt.text = "";
		}
		
		private function addChildrenToContainer(container:DisplayObjectContainer, components:Array):void {
			for each (var component:DisplayObject in components)
				container.addChild(component);
		}
	}
}