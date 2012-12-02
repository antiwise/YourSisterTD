package unit
{
    import common.core.interfaces.ITickable;
    import common.core.utils.Counter;
    
    import flash.display.Shape;
    import flash.display.Sprite;
    
    public class Unit extends Sprite implements ITickable
    {
        protected var _couldTick:Boolean;
        protected var _counter:Counter;
        protected var _targetFrameRate:Number = 0.033;
        
        public function Unit( color:uint, i:int )
        {
            var R:Number = 16 * 0.6;
            graphics.beginFill( color );
            graphics.drawCircle( R, R, R );
            graphics.endFill();
            var WIDTH:Number = 32 * 0.6;
            var posX:Number = ( i % 30 ) * WIDTH;
            var posY:Number = ( (i - ( i % 30 )) / 30) * WIDTH;
            this.x = posX;
            this.y = posY;
            
            _counter = new Counter();
        }
        
        public function tick(delta:Number):void
        {
            _counter.tick( delta );
        }
        
        public function dispose():void
        {
            _couldTick = false;
        }
        public function get couldTick():Boolean
        {
            return _couldTick;
        }
    }
}