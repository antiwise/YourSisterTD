package panel
{
    import com.bit101.components.Panel;
    import com.bit101.components.PushButton;
    
    import flash.display.DisplayObjectContainer;
    import flash.events.Event;
    import flash.events.MouseEvent;
    
    public class ControlsPanel extends Panel
    {
        private var _addWalkBtn:PushButton;
        private var _addBlockBtn:PushButton;
        private var _addCharacterBtn:PushButton;
        private var _addEnemyBtn:PushButton;
        private var _playBtn:PushButton;
        private var _cleanBtn:PushButton;
        private var _pauseBtn:PushButton;
        
        public function ControlsPanel(parent:DisplayObjectContainer=null, xpos:Number=0, ypos:Number=0)
        {
            super(parent, xpos, ypos);
            
            _addWalkBtn = new PushButton( this, 10, 10, "行走区域", onAddHandler );
            _addWalkBtn.setSize( 70 , 20 );
            _addBlockBtn = new PushButton( this, 10, 40, "阻挡区域", onAddHandler );
            _addBlockBtn.setSize( 70 , 20 );
            _addCharacterBtn = new PushButton( this, 10, 70, "角色", onAddHandler );
            _addCharacterBtn.setSize( 70 , 20 );
            _addEnemyBtn = new PushButton( this, 10, 100, "敌人", onAddHandler );
            _addEnemyBtn.setSize( 70 , 20 );
            _cleanBtn = new PushButton( this, 10, 130, "清除", onAddHandler );
            _cleanBtn.setSize( 70 , 20 );
            
            _playBtn = new PushButton( this, 10, 300, "开始", onPlayStopHandler );
            _playBtn.setSize( 70, 20 );

            _pauseBtn = new PushButton( this, 10, 330, "暂停", onPauseHandler );
            _pauseBtn.setSize( 70, 20 );
        }
        
        private function onPauseHandler( e:MouseEvent ):void
        {
            dispatchEvent(new Event( "pause" ));
        }
        
        private function onPlayStopHandler( e:MouseEvent ):void
        {
            dispatchEvent(new Event( "playStop" ));
        }
        
        private function onAddHandler( e:MouseEvent ):void
        {
            if( e.currentTarget == _addWalkBtn )
            {
                dispatchEvent(new Event( "addWalk" ));
            }
            else if( e.currentTarget == _addBlockBtn )
            {
                dispatchEvent(new Event( "addBlock" ));
            }
            else if( e.currentTarget == _addCharacterBtn )
            {
                dispatchEvent(new Event( "addCharacter" ));
            }
            else if( e.currentTarget == _addEnemyBtn )
            {
                dispatchEvent(new Event( "addEnemy" ));
            }
            else
            {
                dispatchEvent(new Event( "clean" ));
            }
        }
    }
}