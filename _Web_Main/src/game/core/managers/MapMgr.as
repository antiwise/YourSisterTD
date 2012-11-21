package game.core.managers
{
	import common.base.interfaces.IMgr;
	import common.data.IMapData;
	import common.data.MapData;
	
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.events.EventDispatcher;
	
	import game.core.map.MapBlockView;
	import game.core.models.statics.MapModel;
	import game.untils.MapLoader;
	
	import starling.textures.Texture;

	/**
	 * 地图管理器 
	 * @author noah
	 * 
	 */	
	public class MapMgr extends EventDispatcher implements IMgr
	{
		private var _mapData:IMapData;
		
		public function get mapData():IMapData
		{
			return _mapData;
		}
		private var _mapBlockList:Vector.<MapBlockView>;
		
		public function MapMgr()
		{
			super();
			_mapData = new MapData();
			_mapBlockList = new Vector.<MapBlockView>(2);
		}
		
		public function loadMap( mapUrl:String, func:Function ):void
		{
			MapLoader.load( mapUrl, func );
		}
		
		public function getMapBlock( type:int, x:int, y:int ):MapBlockView
		{
			if( _mapBlockList[type] == null )
			{
				makeMapBlock( type, x, y );
			}
			return _mapBlockList[type].clone( type, x, y );
		}

		/**
		 * 创建地图单元贴图，根据type选择不同贴图
		 * @param type
		 * @param x
		 * @param y
		 */		
		private function makeMapBlock( type:int, x:int, y:int ):void
		{
			var s:Shape = new Shape();
			s.graphics.beginFill( type > 0?0x333333:0x999999 );
			s.graphics.lineStyle( 0.1, 0x333333)
			s.graphics.lineTo( 0 , 0  );
			s.graphics.lineTo( MapModel.BLOCK_WIDTH, 0 );
			s.graphics.lineTo( MapModel.BLOCK_WIDTH  , MapModel.BLOCK_WIDTH );
			s.graphics.lineTo( 0 , MapModel.BLOCK_WIDTH);
			s.graphics.endFill();
			
			var bd:BitmapData = new BitmapData( MapModel.BLOCK_WIDTH + 1, MapModel.BLOCK_WIDTH + 1, true, 0x00000000);
			bd.draw( s );
			
			var mTexture:Texture = Texture.fromBitmapData(bd, false, false);
			
			_mapBlockList[type] = new MapBlockView( type, x, y, mTexture);
		}
		
		public function dispose():void
		{
			
		}
		
		public function get isDisposed():Boolean
		{
			return false;
		}
	}
}