package testhelpers
{
	import com.events.EntityModelEvent;
	import com.mvc.model.EntityModel;
	import flash.geom.Point;
	
	public class MockEntityModel extends EntityModel
	{
		public function MockEntityModel(x:Number, y:Number):void
		{
			super(x, y, 0, 0);
		}
		
		public function set pos(value:Point):void { _pos = value; }
		
		public function dispatchChangePositionEvent():void
		{
			dispatchEvent(new EntityModelEvent(EntityModelEvent.POSITION_CHANGE, _pos));
		}
	}

}