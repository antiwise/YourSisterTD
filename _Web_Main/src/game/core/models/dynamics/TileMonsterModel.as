package game.core.models.dynamics
{
	import common.base.models.BaseModel;
	
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import game.core.events.ModelEvent;
	import game.core.interfaces.IMapModel;
	import game.core.interfaces.IPeopleModel;
	import game.core.interfaces.ITileObjectModel;
	import game.base.models.TileObjectModel;
	import game.core.models.statics.MapModel;
	
	public class TileMonsterModel extends BaseModel //implements IPeopleModel,ITileObjectModel
	{
//		private var monsterModel:MonsterModel;
//		
//		public function set isAniPlaying(value:Boolean):void{
//			monsterModel.isAniPlaying = value;
//		}
//		public function get isAniPlaying():Boolean{
//			return monsterModel.isAniPlaying;
//		}
//		public function get isGCD():Boolean{
//			return monsterModel.isGCD;
//		}
//		public function set isGCD(value:Boolean):void{
//			monsterModel.isGCD = value;
//		}
//		public function get speed():Number{
//			return monsterModel.speed;
//		}
//		public function set speed(value:Number):void{
//			monsterModel.speed = value;
//		}
//		public function get currentDir():uint{
//			return monsterModel.currentDir;
//		}
//		public function set currentDir(value:uint):void{
//			monsterModel.currentDir = value;
//		}	
//		public function get x():Number{
//			var ppp:Point = tileXY( new Point(monsterModel.x, monsterModel.y));
//			return ppp.x + TileObjectModel.PADDING_LEFT + MapModel.TILE_BLOCK_WIDTH;
//		}
//		public function get y():Number{
//			var ppp:Point = tileXY( new Point(monsterModel.x, monsterModel.y));
//			return ppp.y;
//		}
//		public function TileMonsterModel()
//		{
//			super();
//			monsterModel = new MonsterModel();
//			monsterModel.addEventListener(ModelEvent.UPDATE, onUpdateHanlder);
//		}
//		
//		protected function onUpdateHanlder(event:Event):void
//		{
//			dispatchEvent(new ModelEvent(ModelEvent.UPDATE));
//		}
//		
//		public function getPos(type:uint):Point{
//			
//			return monsterModel.getPos(type);
//		}
//		
//		/**
//		 * 
//		 */		
//		public function move( mapModel:IMapModel ):void
//		{
//			monsterModel.move( mapModel );
//		}
//		public function set modX(value:Number):void{
//			monsterModel.modX = value;
//		}
//		public function get modX():Number{
//			return monsterModel.modX;
//		}
//		public function set modY(value:Number):void{
//			monsterModel.modY = value;
//		}
//		public function get modY():Number{
//			return monsterModel.modY;
//		}
//		public function get gridXs():Array{
//			return monsterModel.gridXs;
//		}
//		public function get gridYs():Array{
//			return monsterModel.gridYs;
//		}
//		public function get gridX():uint{
//			return monsterModel.gridX;
//		}
//		public function get gridY():uint{
//			return monsterModel.gridY;
//		}
//		public function set dir(value:uint):void{
//			monsterModel.dir = value;
//		}
//		public function get dir():uint{
//			return monsterModel.dir;
//		}
//		public function tileXY( p:Point ):Point{
//			return TileObjectModel.tileXY( p );
//		}
	}
}