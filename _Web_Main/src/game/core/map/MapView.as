package game.core.map
{
    import common.core.interfaces.IMapData;
    import common.core.interfaces.ITickable;
    
    import flash.display.BitmapData;
    import flash.geom.Matrix;
    import flash.geom.Rectangle;
    
    import game.base.units.GameUint;
    import game.core.interfaces.model.IMapModel;
    import game.core.interfaces.view.ICharacterView;
    import game.core.interfaces.view.IMapView;
    import game.core.models.statics.MapModel;
    import game.core.unit.CharacterUnit;
    import game.untils.MgrObjects;
    import game.untils.QuadTrees;
    
    import starling.animation.IAnimatable;
    import starling.display.Image;
    import starling.display.Sprite;
    import starling.textures.RenderTexture;
    import starling.textures.Texture;
    
    public class MapView extends GameUint  implements IMapView, IAnimatable
    {
        /**
         * 当没有贴图时使用的贴图 
         */        
        protected static const NULL_TEXTURE:Texture = Texture.fromBitmapData(new BitmapData(1,1,true,0));
        /**
         * 四叉树 
         */		
        protected var _objTree:QuadTrees;
        /**
         * 地面层 
         */		
        protected var _groundLevel:Sprite;
        /**
         * 容器层 (排序)
         */		
        protected var _contentLevel:Sprite;
        /**
         * 天空层 
         */		
        protected var _airLevel:Sprite;
        
        protected var initParams:Object;
        
        public function get mapModel():IMapModel
        {
            return _model as IMapModel;
        }
        /**
         * 构造函数
         * 创建模型
         * 创建四叉树
         * @param data
         */		
        public function MapView( mapData:IMapData )
        {
            super();
            initParams = {"mapData":mapData};
        }
        
        override public function init():void
        {
            _airLevel = new Sprite();
            _contentLevel = new Sprite();
            _groundLevel = new Sprite();
            addChild(_groundLevel);
            addChild(_contentLevel);
            addChild(_airLevel);
            
            _model = new MapModel( initParams["mapData"] );
            objTree = new QuadTrees( 3 , new Rectangle(0,0, 960 , 640));
            drawMapBlocks();
            
            _couldTick = true;
        }
        
        override public function tick( delta:Number ):void
        {
            super.tick( delta );
            
            var child:ITickable;
            for(var i:int = 0;i< _groundLevel.numChildren;i++)
            {
                child = _groundLevel.getChildAt( i ) as ITickable;
                if(child && child.couldTick == true)
                {
                    child.tick( delta );
                }
            }
            for( i = 0;i< _contentLevel.numChildren;i++)
            {
                child = _contentLevel.getChildAt( i ) as ITickable;
                if(child && child.couldTick == true)
                {
                    child.tick( delta );
                }
            }
            for( i = 0;i< _airLevel.numChildren;i++)
            {
                child = _airLevel.getChildAt( i ) as ITickable;
                if(child && child.couldTick == true)
                {
                    child.tick( delta );
                }
            }
        }
        
        override public function advanceTime(time:Number):void
        {
            //TODO: implement function
        }
        
        private function drawMapBlocks():void
        {
            var type:int;
            for (var j:uint = 0;j<MapModel.MAP_HEIGHT;j++)
            {
                for (var i:uint = 0;i<MapModel.MAP_WIDTH;i++)
                {
                    type =  mapModel.dataList[ j* MapModel.MAP_WIDTH + i ];
                    if( type )
                    {
                        drawContentBlock(  i, j );
                    }
                    else
                    {
                        drawGroundBlock( i, j );
                    }
                }
            }
        }
        
        private function drawContentBlock( x:uint, y:uint):void
        {
            var block:MapBlockView = MgrObjects.mapMgr.getMapBlock( 1, x, y );
            _contentLevel.addChild( block );
            objTree.insertObj(block);
        }
        
        private function drawGroundBlock( x:uint, y:uint ):void
        {
            var block:MapBlockView = MgrObjects.mapMgr.getMapBlock( 0, x, y );
            _groundLevel.addChild( block );
            objTree.insertObj(block);
        }
        
        public function addCharacter( character:ICharacterView ):void
        {
            _contentLevel.addChild( character as CharacterUnit );
        }
        
        //		/**
        //		 * 添加怪物
        //		 * @param monster
        //		 */		
        //		public function addMonster(monster:IObjectView):void
        //		{
        //			objTree.insertObj( monster );
        //			this._contentLevel.addChild( monster as BaseView );
        //		}
        //		/**
        //		 * 添加玩家
        //		 * @param p
        //		 */		
        //		public function addPlayer(p:IObjectView):void 
        //		{
        //			objTree.insertObj( p );
        //			this._contentLevel.addChild( p as BaseView );
        //		}
        //		/**
        //		 * 获取指定的block
        //		 * @param args
        //		 */		
        //		public function getBlocks( pArr:Array):Array
        //		{
        //			var arr:Array = [];
        //			for each(var point:Point in pArr){
        //				var newNode:QuadNode = this.objTree.nodes.get(point.x + "-" + point.y) as QuadNode;
        //				arr.push( newNode );
        //			}
        //			return arr;
        //		}
        
        public function get groundLevel():Sprite
        {
            return this._groundLevel;
        }
        public function get contentLevel():Sprite
        {
            return this._contentLevel;
        }
        public function get airLevel():Sprite
        {
            return this._airLevel;
        }
        public function get objTree():QuadTrees
        {
            return this._objTree;
        }
        public function set objTree(value:QuadTrees):void
        {
            this._objTree = value;
        }
    }
}