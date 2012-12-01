package
{
    import common.core.interfaces.ITickable;
    
    import flash.display.Sprite;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;
    import flash.events.Event;
    import flash.ui.ContextMenu;
    import flash.utils.setTimeout;
    
    import game.core.managers.DisplayMgr;
    import game.core.managers.MainMgr;
    import game.untils.MgrObjects;
    
    import utils.BusyInidcate;
    
    [SWF(width="960", height="640", frameRate="30",backgroundColor="0x000000")]
    public class _Web_Main extends Sprite
    {
        private var _lastRenderTimeStamp:Number;
        
        public function _Web_Main()
        {
            stage.align = StageAlign.TOP_LEFT;
            stage.scaleMode = StageScaleMode.NO_SCALE;
            setTimeout(doInitialize, 100);
        }
        
        protected function doInitialize():void
        {
            if(stage) initialize()
            else 	addEventListener(Event.ADDED_TO_STAGE,initialize);
        }
        
        protected function initialize(e:Event = null):void
        {
            removeEventListener(Event.ADDED_TO_STAGE, initialize);
            
            stage.frameRate = 30;
            stage.align = StageAlign.TOP_LEFT;
            stage.scaleMode = StageScaleMode.NO_SCALE;
            var rightMouseMenu:ContextMenu = new ContextMenu();
            rightMouseMenu.hideBuiltInItems();
            contextMenu = rightMouseMenu;
            
            BusyInidcate.initialize( stage ).onResize( stage );
            BusyInidcate.showBusy();
            
            MainMgr.init(this, true );
            
            _lastRenderTimeStamp = new Date().time;
            stage.addEventListener(Event.RESIZE, onStageResize);
            stage.addEventListener(Event.ENTER_FRAME, onEnterFrameHandle);
            stage.addEventListener(Event.RESIZE, onResize, false, int.MAX_VALUE);
            
            onResize();
        }
        
        protected function onStageResize(e:Event):void
        {
            MgrObjects.displayMgr.computeStats();
//            ServiceObjects.viewContainerManagerService.onResize();
        }
        
        protected function onEnterFrameHandle(e:Event):void
        {
            var currentTimeStamp:Number = new Date().time;
            var delta:Number = (currentTimeStamp - _lastRenderTimeStamp)/1000;
            _lastRenderTimeStamp = currentTimeStamp;
            
            MainMgr.tick( delta );
        }
        
        protected function onResize(e:Event = null):void
        {
            var displayMgr:DisplayMgr = MgrObjects.displayMgr;
            if(displayMgr == null)
            {
                return;
            }
            displayMgr.computeStats();
//            ServiceObjects.viewContainerManagerService.onResize();
        }
    }
}