package unit
{
    public class Character extends Unit
    {
        public function Character( color:uint, i:int )
        {
            super( color, i );
            
            _couldTick = true;
        }
        
        override public function tick( delta:Number ):void
        {
            
        }
    }
}