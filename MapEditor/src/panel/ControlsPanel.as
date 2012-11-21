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
		
		public function ControlsPanel(parent:DisplayObjectContainer=null, xpos:Number=0, ypos:Number=0)
		{
			super(parent, xpos, ypos);
			
			_addWalkBtn = new PushButton( this, 10, 10, "可行走区域", onAddHandler );
			_addBlockBtn = new PushButton( this, 10, 40, "阻挡区域", onAddHandler );
			_addCharacterBtn = new PushButton( this, 10, 70, "角色", onAddHandler );
			_addEnemyBtn = new PushButton( this, 10, 100, "敌人", onAddHandler );
			
			_playBtn = new PushButton( this, 10, 400, "开始", onPlayStopHandler );
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
		}
	}
}