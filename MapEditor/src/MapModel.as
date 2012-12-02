package
{
    import ai.EnemyAI;
    
    import common.core.interfaces.IMapData;
    import common.core.interfaces.ITickable;
    
    import flash.display.Sprite;
    
    import unit.Character;
    import unit.Enemy;
    import unit.Unit;
    
    public class MapModel extends Sprite
    {
        private var _mapData:IMapData;
        public function get mapData():IMapData
        {
            return _mapData;
        }
        private var _enemyList:Vector.<Unit>;
        private var _characterList:Vector.<Unit>;
        
        public function MapModel()
        {
            _enemyList = new Vector.<Unit>( 600 );
            _characterList = new Vector.<Unit>( 600 );
        }
        
        public function update( mapData:IMapData ):void
        {
            _mapData = mapData;
            var iLen:int = mapData.dataList.length;
            for( var i:int = 0;i<iLen;i++)
            {
                makeBlock( mapData.dataList[i], i );
                updateCompentBlock( mapData.compentList[i], i );
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
        
        public function updateCompentBlock( data:int, i:int ):void
        {
            var color:uint;
            if(data == 1000)
            {
                color = 0xff0000;
                if(_characterList[i])
                {
                    _characterList[i].parent.removeChild(_characterList[i]);
                    _characterList[i].dispose();
                }
                _characterList[i] = new Character( color, i );
                addChild( _characterList[i] );
            }
            else if(data == 2000)
            {
                color = 0x00ff00;
                if(_enemyList[i])
                {
                    _enemyList[i].parent.removeChild(_enemyList[i]);
                    _enemyList[i].dispose();
                }
                _enemyList[i] = new Enemy( color, i );
                addChild( _enemyList[i] );
            }
            else if(data == 0)
            {
                if(_enemyList[i])
                {
                    if(_enemyList[i].parent)
                    {
                        _enemyList[i].parent.removeChild(_enemyList[i]);
                    }
                }
                if(_characterList[i])
                {
                    if(_characterList[i].parent)
                    {
                        _characterList[i].parent.removeChild(_characterList[i]);
                    }
                }
            }
        }
        
        public function tick(delta:Number):void
        {
            var child:ITickable;
            for(var i:int = 0;i<_enemyList.length;i++)
            {
                child = _enemyList[i] as ITickable;
                if(child && child.couldTick)
                {
                    EnemyAI.execute( _enemyList[i] as Enemy, this );
                    child.tick(delta);
                }
            }
            for( i = 0;i<_characterList.length;i++)
            {
                child = _characterList[i] as ITickable;
                if(child && child.couldTick)
                {
                    child.tick(delta);
                }
            }
        }
    }
}