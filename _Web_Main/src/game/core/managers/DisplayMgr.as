package  game.core.managers
{
    import common.core.interfaces.IMgr;
    
    import flash.display.Stage;

    public class DisplayMgr implements IMgr
    {
        /**
         * 默认的舞台高度(像素)
         */ 
        private const DEFAULT_GAME_SCREEN_WIDTH:int = 1248;
        
        /**
         * 默认的舞台高度(像素)
         */ 
        private const DEFAULT_GAME_SCREEN_HEIGHT:int = 648;
        /**
         * 最大的游戏屏幕宽度(像素)
         */ 
        private const MAX_GAME_SCREEN_WIDTH:int = DEFAULT_GAME_SCREEN_WIDTH;
        
        /**
         * 最大的游戏屏幕高度(像素)
         */        
        private const MAX_GAME_SCREEN_HEIGHT:int = DEFAULT_GAME_SCREEN_HEIGHT;
        
        /**
         * 当前的舞台高度(像素)
         */ 
        private var _screenWidth:int;
        
        /**
         * 当前的舞台高度(像素)
         */ 
        private var _screenHeight:int;
        
        /**
         * 当前的舞台宽度与默认的比例
         */ 
        private var _gameScreenWidthRadio:Number;
        
        /**
         * 当前的舞台高度与默认的比例
         */ 
        private var _gameScreenHeightRadio:Number;
        
        /**
         * 项目当前的舞台
         */ 
        private var _projectStage:Stage;
        
        /**
         * 是否已经释放
         */
        private var _isDisposed:Boolean;
        
        /**
         * 游戏屏幕宽度
         */
        private var _gameScreenWidth:int;
        
        /**
         * 游戏屏幕高度
         */        
        private var _gameScreenHeight:int;
        
        private var _gameScreenOffsetY:int;
        
        private var _gameScreenOffsetX:int;
        
        /**
         * 构造
         * @param stage	项目当前的舞台
         */ 
        public function DisplayMgr()
        {
            
        }
        
        public function init( stage:Stage ):void
        {
            _projectStage = stage;
            computeStats();
        }
        /**
         * 计算统计数据
         */ 
        public function computeStats():void
        {
            _screenWidth = _projectStage.stageWidth;
            _screenHeight = _projectStage.stageHeight;
            
            _gameScreenWidth = DEFAULT_GAME_SCREEN_WIDTH;
            _gameScreenHeight = DEFAULT_GAME_SCREEN_HEIGHT;
            
            _gameScreenOffsetX = Math.floor((_screenWidth - _gameScreenWidth)*.5);
            _gameScreenOffsetY = Math.floor((_screenHeight - _gameScreenHeight)*.5);
            
            _gameScreenWidthRadio = _gameScreenWidth/DEFAULT_GAME_SCREEN_WIDTH;
            _gameScreenHeightRadio = _gameScreenHeight/DEFAULT_GAME_SCREEN_HEIGHT;
            
        }
        
        public function dispose():void
        {
            if(_isDisposed == false)
            {
                distruct();
                _isDisposed = true;
            }
            
        }
        
        /**
         * 析构
         */
        protected function distruct():void
        {
            _projectStage = null;
        }
        
        public function get isDisposed():Boolean
        {
            return _isDisposed;
        }
        
        /**
         * 当前的游戏屏幕宽度与默认屏幕宽度的比例
         */
        public function get gameScreenWidthRadio():Number
        {
            return _gameScreenWidthRadio;
        }
        
        /**
         * 当前的游戏屏幕高度与默认屏幕高度的比例
         */
        public function get gameScreenHeightRadio():Number
        {
            return _gameScreenHeightRadio;
            
        }
        
        /**
         * 游戏屏幕宽度
         */        
        public function get gameScreenWidth():int
        {
            return _gameScreenWidth;
        }
        
        /**
         * 游戏屏幕高度
         */        
        public function get gameScreenHeight():int
        {
            return _gameScreenHeight;
        }
        
        /**
         * 当前的舞台宽度(像素)
         */
        public function get screenWidth():int
        {
            return _screenWidth;
        }
        
        /**
         * 当前的舞台高度(像素)
         */
        public function get screenHeight():int
        {
            return _screenHeight;
        }
        
        /**
         * 默认的舞台宽度(像素)
         */
        public function get defaultScreenWidth():int
        {
            return DEFAULT_GAME_SCREEN_WIDTH;
        }
        
        /**
         * 默认的舞台高度(像素)
         */
        public function get defaultScreenHeight():int
        {
            return DEFAULT_GAME_SCREEN_HEIGHT;
        }
        
        public function get gameScreenOffsetX():int
        {
            return _gameScreenOffsetX;
        }
        
        public function get gameScreenOffsetY():int
        {
            return _gameScreenOffsetY;
        }
        
        public function get currentStage():Stage
        {
            return _projectStage;
        }
    }
}