package game.starling.view
{
	import game.controllers.dynamics.TileMonsterController;
	import game.events.ActionEvent;
	import game.events.ModelEvent;
	import game.interfaces.IMapView;
	import game.managers.Depth3DMgr;
	import game.managers.TextureMgr;
	import game.models.dynamics.TileMonsterModel;
	import game.models.statics.MapModel;
	
	import starling.core.Starling;
	import starling.display.MovieClip;
	
	public class TileMonsterView3D extends MonsterView3D
	{
		private var _model:TileMonsterModel;
		private var _controller:TileMonsterController;
		
		private function get controller():TileMonsterController
		{
			return _controller;
		}
		override public function get model():*{
			return this._model;
		}
		public function TileMonsterView3D()
		{
			super();
		}
		
		override public function init( data:Object = null):void{
			_model = new TileMonsterModel();
			_model.addEventListener( ActionEvent.ATTACK, onAttackHandler);
			_controller = new TileMonsterController();
			_controller.init(_model);
			
			_model.modX = data[1] * MapModel.BLOCK_WIDTH;
			_model.modY = data[2] * MapModel.BLOCK_WIDTH;
			_model.addEventListener( ModelEvent.UPDATE, onUpdateHandler);
			_model.speed = 1;
			
			super.create( data[0] );
			
			super.x = _model.posX - (MapModel.TILE_BLOCK_WIDTH);
			super.y = _model.posY;
			
			_model.getPos( 2 );
		}
		
		/**
		 * 
		 * @param e
		 */		
		override public function onInputHandler( map:IMapView ):void {
			
			if(currentMap != map){
				currentMap = map;
			}
			controller.onInputHandler( map );
		}
		
		override public function draw():void{
			//这里需要面朝向转换，因为地图被倾斜了。
			var tempRate:uint = _model.dir / 8;
			var tempDir:uint;
			if(_model.dir % 8 != 1){
				tempDir = (_model.dir - 1 > 0)?(_model.dir - 1):8 * (tempRate + 1);
			} else {
				tempDir = 8 * (tempRate + 1);
			}
			if(_model.currentDir != tempDir){
				trace("[TilePeopleView]" + _model.currentDir, tempDir);
				_model.currentDir = tempDir;
				removeChild(m);
				Starling.juggler.remove(m);
				if(tempDir < 10){
					m = new MovieClip(TextureMgr.instance.getTextures(modelTypeID, "m0" + tempDir), frameRate);
				} else {
					m = new MovieClip(TextureMgr.instance.getTextures(modelTypeID, "m" + tempDir), frameRate);
				}
				m.x = -20;
				m.y = -80;
				trace( "[TilePeopleView] 当前 tempDir: " + tempDir );
				addChild(m);
				Starling.juggler.add(m);
			}
			if(this.parent){
				Depth3DMgr.swapDepth(this, model.posY);
			}
		}
	}
}