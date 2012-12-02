package panel
{
    import com.bit101.components.Panel;
    
    import common.core.interfaces.IMapData;
    
    import flash.display.DisplayObjectContainer;
    import flash.display.Shape;
    import flash.events.Event;
    import flash.events.MouseEvent;
    
    public class MapPanel extends Panel
    {
        private var _addType:int = 1;
        private var _mapData:IMapData;
        private var _mapModel:MapModel;
        private var _mouseBlock:Shape;
        private 	const WIDTH:Number = 32 * 0.6;
        private var _isReset:Boolean;
        
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
            
            if(blockX + blockY * 30 > 600)
            {
                return;
            }
            if(blockX >= 0 && blockX < 30 && blockY >= 0 && blockY < 20)
            {
                if( _addType >= 1000)
                {
                    if( _addType == int.MAX_VALUE )
                    {
                        _mapData.compentList[ blockX + blockY * 30 ] = 0;
                    } 
                    else if( _mapData.compentList[ blockX + blockY * 30 ] != _addType )
                    {
                        _mapData.compentList[ blockX + blockY * 30 ] = _addType;
                    }
                    _mapModel.updateCompentBlock( _mapData.compentList[ blockX + blockY * 30 ], blockX + blockY * 30 );
                }
                else
                {
                    if(_mapData.dataList[ blockX + blockY * 30 ] != _addType)
                    {
                        _mapData.dataList[ blockX + blockY * 30 ] = _addType;
                        _mapModel.updateBlock( _mapData.dataList[ blockX + blockY * 30 ], blockX + blockY * 30 );
                    }
                }
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
        
        public function setData( mapData:IMapData ):void
        {
            _mapData = mapData;
            _mapModel.update( _mapData );
        }
        
        public function onMouseUpStage():void
        {
            onMapModelOutHandler(null);
        }
        
        public function tick(delta:Number):void
        {
            if(_mapModel)
            {
                _isReset = false;
                _mapModel.tick( delta ); 
            }
        }
        
        public function reloadMap():void
        {
            if(!_isReset)
            {
                _isReset = true;
                _mapModel.update( _mapData );
            }
        }
    }
}