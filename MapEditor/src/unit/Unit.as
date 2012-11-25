package unit
{
    import flash.display.Shape;
    
    public class Unit extends Shape
    {
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
    }
}