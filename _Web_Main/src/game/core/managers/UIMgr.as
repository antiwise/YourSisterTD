package game.core.managers
{
    import common.base.interfaces.IMgr;
    
    import flash.display.Loader;
    import flash.display.MovieClip;
    import flash.display.SimpleButton;
    import flash.events.Event;
    import flash.events.EventDispatcher;
    import flash.events.MouseEvent;
    import flash.net.URLRequest;
    import flash.utils.setTimeout;
    
    import game.untils.MgrObjects;
    
    /**
     * 
     * @author noah
     */
    public class UIMgr extends EventDispatcher implements IMgr
    {
        /**
         * 
         */		
        private var _loader:Loader;
        private var _isDisposed:Boolean;
        
        /**
         * 构造函数
         */		
        public function UIMgr()	
        {
            
        }
        /**
         * 初始化
         */		
        public function init():void
        {
            _loader = new Loader();
            _loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadComplete);
            _loader.load(new URLRequest("TDui.swf"));
        }
        
        private var _mainMc:MovieClip;
        
        protected function onLoadComplete(e:Event):void
        {
            _mainMc = (_loader.content as MovieClip)["mc"];
            MgrObjects.displayMgr.getStage.addChildAt( _mainMc, 0 );
            
            initMainUI();
        }
        
        private function initMainUI(e:MouseEvent = null):void
        {
            if(e)
            {
                e.stopPropagation();
            }
            _mainMc.gotoAndStop( 1 );
            _mainMc.addEventListener(MouseEvent.MOUSE_DOWN, onMainUIClickHandler);
        }
        
        protected function onMainUIClickHandler(e:MouseEvent):void
        {
            _mainMc.removeEventListener(MouseEvent.MOUSE_DOWN, onMainUIClickHandler);
            initChooseUI();
        }
        
        private function initChooseUI():void
        {
            _mainMc.gotoAndStop( 2 );
            _topBgMc = _mainMc["topBgMc"];
            _bgMc = _mainMc["bgMc"];
            
            (_mainMc["mainBtn"] as SimpleButton).addEventListener(MouseEvent.MOUSE_DOWN, initMainUI );
            (_mainMc["startBtn"] as SimpleButton).addEventListener(MouseEvent.MOUSE_DOWN, onStartGame );
        }
        
        protected function onStartGame(e:MouseEvent):void
        {
            initLoadingUI();
            
            //加载地图
            setTimeout( initGameUI, 500 );
        }
        
        private var _menuMc:MovieClip;
        private var _gameOverMc:MovieClip;
        private var _gameWinMc:MovieClip;
        private var _topBgMc:MovieClip;
        private var _bgMc:MovieClip;
        
        private function initGameUI():void
        {
            _mainMc.gotoAndStop( 4 );
            
            _mainMc.addEventListener(Event.ENTER_FRAME, onGameEnterFrameHandler);
        }
        
        protected function onGameEnterFrameHandler(e:Event):void
        {
            if(_mainMc.currentFrame == 4)
            {
                _mainMc.removeEventListener(Event.ENTER_FRAME, onGameEnterFrameHandler );
                
                initGameStart();
            }
        }
        
        private function initGameStart():void
        {
            _bgMc.visible = false;
            _menuMc = _mainMc["menuMc"];
            _menuMc.visible = false;
            _gameOverMc = _mainMc["gameOverMc"];
            _gameOverMc.visible =false;
            _gameWinMc = _mainMc["gameWinMc"];
            _gameWinMc.visible = false;
            
        }
        
        private function initLoadingUI():void
        {
            _mainMc.gotoAndStop( 3 );
        }
        
        /**
         * 获取加载器 
         * @return 
         */		
        public function get loader():Loader{
            return _loader;
        }
        
        public function dispose():void
        {
            if(_isDisposed == false)
            {
                distruct();
                _isDisposed = true;
            }
        }
        
        protected function distruct():void
        {
            //TODO dispose resource table.
        }
        
        public function get isDisposed():Boolean
        {
            return _isDisposed;
        }
    }
}