package game.starling
{
	import common.base.views.starling.BaseView;
	import common.data.IMapData;
	
	import flash.utils.ByteArray;
	
	import game.core.interfaces.view.IMapView;
	import game.core.managers.DebugMgr;
	import game.core.managers.MainMgr;
	import game.core.map.MapView;
	import game.core.unit.CharacterUnit;
	import game.core.unit.EnemyUnit;
	import game.untils.MgrObjects;
	
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	import starling.events.Event;
	import starling.events.KeyboardEvent;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	public class GameWorld extends Sprite
	{
		/**
		 * 
		 */		
		private var _characterUnit:CharacterUnit;
		/**
		 * 
		 */		
		private var _enemyUnit:EnemyUnit;
		/**
		 * 
		 */		
		private var _enemyUnitArr:Array;
		/**
		 *  
		 */		
		private var _map:IMapView;
		/**
		 * 
		 */		
		public static var GAME_MODE:uint;
		
		public function GameWorld()
		{
			super();
			if(stage) initialize();
			else addEventListener(Event.ADDED_TO_STAGE, initialize);
		}
		
		private function initialize(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, initialize);
			
			stage.color = 0;
			
			Starling.current.showStats = true;
//			var stats:DisplayObject = Starling.current.stage.getChildAt(stage.numChildren-1);
//			stats.y = 50;

			Starling.current.antiAliasing = 0;
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDownEventHandle);
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUpEventHandle);
			stage.addEventListener(TouchEvent.TOUCH, onTouch);
			addEventListener(EnterFrameEvent.ENTER_FRAME, onEnterFrame);
			
			MgrObjects.debugMgr.log( "初始化耗时: " + MainMgr.instance.endTimeCount() );
			
//			MgrObjects.uiMgr.init(();
			var mapUrl:String = "data/map0001.map";
			MgrObjects.mapMgr.loadMap( mapUrl, onMapJsonLoadCompleteHandler );
		}
		
		private function onMapJsonLoadCompleteHandler( data:ByteArray ):void
		{
			MgrObjects.debugMgr.log( "地图加载耗时: " + MainMgr.instance.endTimeCount() );
			
			var mapData:IMapData = MgrObjects.mapMgr.mapData
			mapData.fromByteArray( data );

			_map = new MapView( mapData );
			_map.init();
			MgrObjects.debugMgr.log( "初始化地图耗时: " + MainMgr.instance.endTimeCount() );
			addChild( _map as BaseView );
			
			_characterUnit = new CharacterUnit( 5, 5, 1 );
			_characterUnit.init();
			_map.addCharacter( _characterUnit );
			
//			_enemyUnitArr = [];
			
//			for(var i:uint=4;i<8;i++)
//			{
//				for(var j:uint=4;j<8;j++)
//				{
//					if(GAME_MODE == 1)
//					{
//						enemyUnit = new EnemyUnit();
//					}
//					else if(GAME_MODE == 2 || GAME_MODE == 3)
//					{
//						enemyUnit = new TileEnemyUnit();
//					}
//					enemyUnitArr.push(enemyUnit);
//					enemyUnit.init( [3,j,i] );
//					enemyUnit.draw();
//					map.addMonster( enemyUnit );
//				}
//			}
			
//			KeyBoardMgr.instance.init( MgrObjects.displayMgr.getStage );;
		}
		
		/**
		 * 八面
		 * 1下 2右下 3右 4右上 5上 6左上 7左 8左下
		 * @param e
		 */			
		private function onEnterFrame(e:EnterFrameEvent):void
		{
//			if(_map)
//			{
//				(_map as BaseView).sortChildren( sortFunction );
//			}
			if( _characterUnit )
			{
				_characterUnit.onUpdateHandler(null);
			}
//			for each(enemyUnit in enemyUnitArr)
//			{
//				if(enemyUnit)
//				{
//					enemyUnit.onInputHandler( map );
//				}
//			}
		}
		
//		private function sortFunction( objA:DisplayObject, objB:DisplayObject ):Number
//		{
//			return (objA.y*2560+objA.x)-(objB.y*2560+objB.x);
//		}
		private function onRemovedFromStage(event:Event):void
		{
			//stage.removeEventListener(TouchEvent.TOUCH, onTouch);
		}
		
		private function onTouch(event:TouchEvent):void
		{
			var touch:Touch = event.getTouch(stage);
			if (touch)
			{
				if(touch.phase == TouchPhase.BEGAN)
				{
					MgrObjects.debugMgr.serverLog( "[GameWorld] onTouch BEGAN " + touch.globalX + "," + touch.globalY, DebugMgr.PACKET_SEND );
				}
				else if(touch.phase == TouchPhase.ENDED)
				{
					
				}
			}
		}
		
		private function onMouseDown(e:TouchEvent):void
		{
			var touch:Touch = e.getTouch(stage);
		}
		
		private function onKeyUpEventHandle(e:KeyboardEvent):void
		{
//			trace("onKeyUpEventHandle:", e.keyCode);
		}
		
		private function onKeyDownEventHandle(e:KeyboardEvent):void
		{
//			trace("onKeyDownEventHandle:", e.keyCode);
		}
	}
}