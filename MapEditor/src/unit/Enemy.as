package unit
{
    public class Enemy extends Unit
    {
        /**
         * 0right, 1down, 2left, 3up 
         */
        private var _currentDir:int;
        private var _speed:Number = 2;
        private var _isMoving:Boolean;
        private var _nextBlockX:int;
        private var _nextBlockY:int;
        
        public function Enemy( color:uint, i:int )
        {
            super( color, i );
            
            _couldTick = true;
        }
        
        override public function tick( delta:Number ):void
        {
            if( _isMoving )
            {
                if( _currentDir == 0 )
                {
                    this.x += _speed;
                }
                else if( _currentDir == 1 )
                {
                    this.y += _speed;
                }
                else if( _currentDir == 2 )
                {
                    this.x -= _speed;
                }
                else if( _currentDir == 3 )
                {
                    this.y -= _speed;
                }
                check();
            }
        }
        
        private function check():void
        {
            if( _currentDir == 0 && x / ( 32 *0.6 ) >= _nextBlockX )
            {
                x = 32 * 0.6 * _nextBlockX;
                _isMoving = false;
            }
            else if( _currentDir == 2 && x / ( 32 *0.6 ) <= _nextBlockX )
            {
                x = 32 * 0.6 * _nextBlockX;
                _isMoving = false;
            }
            else if( _currentDir == 1 && y / ( 32 * 0.6 ) >= _nextBlockY )
            {
                y = 32 * 0.6 * _nextBlockY;
                _isMoving = false;
            }
            else if( _currentDir == 3 && y / ( 32 * 0.6 ) <= _nextBlockY )
            {
                y = 32 * 0.6 * _nextBlockY;
                _isMoving = false;
            }
            
        }
        
        public function move( nextX:int, nextY:int, dir:int ):void
        {
            trace( "move " + _nextBlockX + "," + _nextBlockY + " to " + nextX + "," + nextY + " d " + dir );
            _nextBlockX = nextX;
            _nextBlockY = nextY;
            _currentDir = dir;
            _isMoving = true;
        }
        
        public function get currentDir():int
        {
            return _currentDir;
        }
        
        public function get isMoving():Boolean
        {
            return _isMoving;
        }
    }
}