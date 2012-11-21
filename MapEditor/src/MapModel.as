package
{
	import common.data.IMapData;
	
	import flash.display.Sprite;

	public class MapModel extends Sprite
	{
		public function MapModel()
		{
		}
		
		public function update( mapData:IMapData ):void
		{
			var iLen:int = mapData.dataList.length;
			for( var i:int = 0;i<iLen;i++)
			{
				makeBlock( mapData.dataList[i], i );
			}
		}
		
		public function updateBlock( data:int, i:int ):void
		{
			makeBlock( data, i );
		}
		
		private function makeBlock( data:int , i:int ):void
		{
			var WIDTH:Number = 32 * 0.6;
			var posX:Number = ( i % 30 ) * WIDTH;
			var posY:Number = ( (i - ( i % 30 )) / 30) * WIDTH;
			graphics.beginFill( data?0x333333:0x999999 );
			graphics.lineStyle( 1, 0x333333, 1 );
			graphics.drawRect( posX, posY, WIDTH, WIDTH );
			graphics.endFill();
		}
	}
}