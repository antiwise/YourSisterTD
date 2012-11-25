package  game.core.models.statics
{
    import common.data.IMapData;
    
    import game.base.models.StaticUnitModel;
    import game.core.interfaces.model.IMapModel;
    
    /**
     * 2D地图模型
     * @author noah
     */	
    public class MapModel extends StaticUnitModel implements IMapModel
    {
        public static const MAP_WIDTH:int = 30;
        public static const MAP_HEIGHT:int = 20;
        
        public static const TILE_BLOCK_WIDTH:uint = 32;
        public static const BLOCK_WIDTH:uint = 32;
        
        private var _dataList:Vector.<int>;
        
        public function get dataList():Vector.<int>
        {
            return this._dataList;
        }
        /**
         * 构造函数
         * 导入地图数据
         * @param data
         */		
        public function MapModel( data:IMapData )
        {
            super();
            
            if(data)
            {
                _dataList = data.dataList;
            }
        }
    }
}