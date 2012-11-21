package panel
{
	import com.bit101.components.Panel;
	
	import data.MapData;
	
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class MapPanel extends Panel
	{
		private var _addType:int = 1;
		private var _mapData:MapData;
		private var _mapModel:MapModel;
		
		public function set addType( value:int ):void
		{
			_addType = value;	
		}
		
		public function MapPanel(parent:DisplayObjectContainer=null, xpos:Number=0, ypos:Number=0)
		{
			super(parent, xpos, ypos);
			_mapModel = new MapModel();
			addChild( _mapModel );
			_mapModel.addEventListener(MouseEvent.MOUSE_DOWN, onMapModelUpDownHandler);
			_mapModel.addEventListener(MouseEvent.MOUSE_UP, onMapModelUpDownHandler);
			_mapModel.addEventListener(MouseEvent.ROLL_OUT, onMapModelOutHandler);
		}
		
		private function onMapModelOverHandler(e:Event):void
		{
			var WIDTH:Number = 32 * 0.6;
			var blockX:int = mouseX / WIDTH;
			var blockY:int = mouseY / WIDTH;
			
			if(_mapData.dataList[ blockX + blockY * 30 ] != _addType)
			{
				_mapData.dataList[ blockX + blockY * 30 ] = _addType;
				_mapModel.updateBlock( _mapData.dataList[ blockX + blockY * 30 ], blockX + blockY * 30 );
			}
		}
		
		private function onMapModelOutHandler(e:MouseEvent):void
		{
			_mapModel.removeEventListener(Event.ENTER_FRAME, onMapModelOverHandler);
			_mapModel.removeEventListener(MouseEvent.ROLL_OUT, onMapModelOutHandler);
		}
		
		private function onMapModelUpDownHandler(e:MouseEvent):void
		{
			if(e.type == MouseEvent.MOUSE_DOWN )
			{
				_mapModel.addEventListener(Event.ENTER_FRAME, onMapModelOverHandler);
			}
			else if(e.type == MouseEvent.MOUSE_UP )
			{
				onMapModelOutHandler(null);
			}
		}
		
		public function setData( mapData:MapData ):void
		{
			_mapData = mapData;
			_mapModel.update( _mapData );
		}
	}
}