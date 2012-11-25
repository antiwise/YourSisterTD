﻿package common.utils 
{
    import flash.display.DisplayObject;
    import flash.events.Event;
    import flash.events.KeyboardEvent;
    import flash.utils.ByteArray;
    
    public class KeyPoll
    {
        private var states:ByteArray;
        private var dispObj:DisplayObject;
        
        /**
         * Constructor
         * 
         * @param stage A display object on which to listen for keyboard events.
         * To catch all key events, this should be a reference to the stage.
         */
        public function KeyPoll( stage:DisplayObject )
        {
            states = new ByteArray();
            states.writeUnsignedInt( 0 );
            states.writeUnsignedInt( 0 );
            states.writeUnsignedInt( 0 );
            states.writeUnsignedInt( 0 );
            states.writeUnsignedInt( 0 );
            states.writeUnsignedInt( 0 );
            states.writeUnsignedInt( 0 );
            states.writeUnsignedInt( 0 );
            dispObj = stage;
            dispObj.addEventListener( KeyboardEvent.KEY_DOWN, keyDownListener, false, 0, true );
            dispObj.addEventListener( KeyboardEvent.KEY_UP, keyUpListener, false, 0, true );
            dispObj.addEventListener( Event.ACTIVATE, activateListener, false, 0, true );
            dispObj.addEventListener( Event.DEACTIVATE, deactivateListener, false, 0, true );
        }
        
        private function keyDownListener( ev:KeyboardEvent ):void
        {
            states[ ev.keyCode >>> 3 ] |= 1 << (ev.keyCode & 7);
        }
        
        private function keyUpListener( ev:KeyboardEvent ):void
        {
            states[ ev.keyCode >>> 3 ] &= ~(1 << (ev.keyCode & 7));
        }
        
        private function activateListener( ev:Event ):void
        {
            for ( var i:int = 0; i < 32; ++i )
            {
                states[ i ] = 0;
            }
        }
        
        private function deactivateListener( ev:Event ):void
        {
            for ( var i:int = 0; i < 32; ++i )
            {
                states[ i ] = 0;
            }
        }
        
        public function isDown( keyCode:uint ):Boolean
        {
            return ( states[ keyCode >>> 3 ] & (1 << (keyCode & 7)) ) != 0;
        }
        
        public function isUp( keyCode:uint ):Boolean
        {
            return ( states[ keyCode >>> 3 ] & (1 << (keyCode & 7)) ) == 0;
        }
    }
}