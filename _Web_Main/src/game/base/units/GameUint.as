package game.base.units
{
    import common.core.utils.Counter;
    import common.core.views.BaseView;
    
    import game.base.interfaces.IGameUnitController;
    import game.base.interfaces.IGameUnitModel;
    import game.base.interfaces.IGameUnitView;
    
    import starling.animation.IAnimatable;
    
    public class GameUint extends BaseView implements IGameUnitView, IAnimatable
    {
        /**
         * 模型 
         */		
        protected var _model:IGameUnitModel;
        
        /**
         * 控制器 
         */		
        protected var _controller:IGameUnitController;
        
        protected var _isPlay:Boolean;
        protected var _counter:Counter;
        protected var _motionFinishedStop:Boolean;
        protected var _motionIsFinished:Boolean;
        protected var _currentFrame:int;
        protected var _currentFrameRate:Number;
        
        public function GameUint()
        {
            super();
        }
        
        override public function advanceTime( time:Number ):void
        {
            if(_couldTick == false || _isPlay == false)
            {
                return;
            }
            
            _counter.tick(time);
            var couldRender:Boolean;
            while(_counter.expired == true) //判断是否距离上一帧渲染后已经过了多帧
            {
                if(checkMotionIsFinished())
                {
                    if(_motionFinishedStop == true)
                    {
                        if(_motionIsFinished == false)
                        {
                            _motionIsFinished = true;
                            stop();
                        }
                        return;
                    }
                    _currentFrame = 0;
                }
                else
                {
                    _currentFrame += 1
                }
                couldRender = true;
                _counter.reset(_currentFrameRate);
            }
            
            if(couldRender == true)
            {
                updateFrame();
            }
        }
        
        protected function updateFrame():void
        {
            
        }
        
        public function play():void
        {
            _isPlay = true;	
        }
        public function stop():void
        {
            _isPlay = false;
        }
        
        protected function checkMotionIsFinished():Boolean
        {
            return false;
        }
        
        public function get model():IGameUnitModel
        {
            return _model;
        }
        
        public function get controller():IGameUnitController
        {
            return _controller;
        }
    }
}