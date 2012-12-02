package unit
{
    import common.core.interfaces.ITickable;
    
    import flash.display.Shape;
    import flash.display.Sprite;
    
    public class Unit extends Sprite implements ITickable
    {
        protected var _couldTick:Boolean;
        
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
        }
        
        public function tick(delta:Number):void
        {
            
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