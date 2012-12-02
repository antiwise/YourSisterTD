package unit
{
    import common.core.utils.GeomUtil;
    
    import flash.display.Shape;
    import flash.geom.Point;

    public class Character extends Unit
    {
        private static const WIDTH:Number = 32 * 0.6;
        /**
         * 攻击范围 
         */        
        public var range:Number = WIDTH * 2;
        private var _attackShape:Shape;
        private var _coldDown:Number;
        private var _currentEnemyTarget:Enemy;
        
        public function Character( color:uint, i:int )
        {
            super( color, i );
            
            _couldTick = true;
            _coldDown = 0;
            _attackShape = new Shape();
            addChild( _attackShape );
            showRange();
        }
        
        private function showRange():void
        {
            graphics.beginFill( 0x0000FF, 0.1 );
            graphics.drawCircle( WIDTH >> 1, WIDTH >> 1, range );
            graphics.endFill();
        }
        
        override public function tick( delta:Number ):void
        {
            _attackShape.graphics.clear();
            if( _coldDown > 0 )
            {
                _coldDown -= delta;
            }
            else
            {
                _coldDown = 0;
            }
            if(_currentEnemyTarget)
            {
                if( GeomUtil.getLineLength( new Point( x, y ), new Point( _currentEnemyTarget.x, _currentEnemyTarget.y) ) <= range )
                {
                    _attackShape.graphics.lineStyle( 2, 0xFFFFFDD, 0.5 );
                    _attackShape.graphics.moveTo( WIDTH >> 1, WIDTH >> 1 );
                    _attackShape.graphics.lineTo( _currentEnemyTarget.x - x + WIDTH / 2, _currentEnemyTarget.y - y + WIDTH / 2 );
                }
            }
        }
        
        public function attack( enemy:Enemy ):void
        {
            if( _coldDown == 0 )
            {
                _currentEnemyTarget = enemy;
                _coldDown  = 0.0;
            }
        }
    }
}