package panel
{
	import com.bit101.components.Panel;
	
	import data.MapData;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class MapPanel extends Panel
	{
		private var _addType:int = 1;
		private var _mapData:MapData;
		private var _mapModel:MapModel;
		private var _mouseBlock:Shape;
		private 	const WIDTH:Number = 32 * 0.6;
		
		public function set addType( value:int ):void
		{
			_addType = value;	
		}
		
		public function MapPanel(parent:DisplayObjectContainer=null, xpos:Number=0, ypos:Number=0)
		{
			super(parent, xpos, ypos);
			_mapModel = new MapModel();
			addChild( _mapModel );
			_mouseBlock = new Shape();
			_mouseBlock.graphics.beginFill( 0xFF0000, 0.7 );
			_mouseBlock.graphics.drawRect( 0, 0, WIDTH, WIDTH );
			_mouseBlock.graphics.endFill();
			_mouseBlock.x = 0;
			_mouseBlock.y = 0;
			addChild( _mouseBlock );
			_mapModel.addEventListener(Event.ENTER_FRAME, onMapModelEnterFrameHandler);
			_mapModel.addEventListener(MouseEvent.MOUSE_DOWN, onMapModelUpDownHandler);
			_mapModel.addEventListener(MouseEvent.MOUSE_UP, onMapModelUpDownHandler);
			_mapModel.addEventListener(MouseEvent.ROLL_OUT, onMapModelOutHandler);
		}
		
		private function onMapModelEnterFrameHandler(e:Event):void
		{
			var blockX:int = mouseX / WIDTH;
			var blockY:int = mouseY / WIDTH;
			moveMouse( blockX, blockY );
		}
		
		private function moveMouse(blockX:int, blockY:int):void
		{
			_mouseBlock.x = blockX * WIDTH;
			_mouseBlock.y = blockY * WIDTH;
		}
		
		private function onMapModelOverHandler(e:Event):void
		{
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