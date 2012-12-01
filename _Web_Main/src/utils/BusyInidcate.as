package  utils
{
    import flash.display.DisplayObjectContainer;
    import flash.display.MovieClip;
    import flash.display.Sprite;
    import flash.display.Stage;
    import flash.events.Event;
    import flash.filters.GlowFilter;
    import flash.text.TextField;
    import flash.text.TextFormat;
    import flash.utils.getTimer;
    import common.core.utils.Counter;
    
    public class BusyInidcate extends Sprite
    {
        
        private static var _instance:BusyInidcate;
        
        private static var _busyCount:int;
        public static function initialize(container:DisplayObjectContainer):BusyInidcate
        {
            if(container != null)
            {
                _instance = new BusyInidcate(new singleton());
                _instance._container = container;
            }
            _busyCount = 0;
            return _instance;
        }
        
        public static function showBusy():void
        {
            if(_instance.parent == null)
            {
                _instance._container.addChild(_instance);
                
                _instance._lastRenderTimeStamp = getTimer();
                _instance._loadingCounter.initialize();
                _instance._loadingCounter.reset(_instance._targetFrameRate);
                
                _instance.addEventListener(Event.ENTER_FRAME, _instance.onEnterFrame);
            }
            
            _busyCount++;
        }
        
        public static function hideBusy():void
        {
            _busyCount--;
            
            if(_busyCount < 0)
            {
                _busyCount = 0;
            }
            if(_busyCount == 0 && _instance.parent != null)
            {
                _instance._container.removeChild(_instance);
                _instance.removeEventListener(Event.ENTER_FRAME, _instance.onEnterFrame);
            }
        }
        
        
        [Embed(source="../assets/loadingIndicator.swf", mimeType="application/x-shockwave-flash")]
        private var _loadingIndicatorClip:Class
        
        private var _loadingNotice:TextField;
        
        private var _loadingClip:MovieClip;
        
        private var _loadingMask:Sprite;
        
        private var _container:DisplayObjectContainer;
        
        private var _loadingCounter:Counter;
        
        private var _lastRenderTimeStamp:int;
        
        private var _targetFrameRate:Number = 500;
        
        public function BusyInidcate(s:singleton)
        {
            if(s == null)
            {
                throw new Error("Busy indicate is a singleton class");
                return;
            }
            
            _loadingMask = new Sprite();
            _loadingClip = new _loadingIndicatorClip();
            _loadingClip.stop();
            
            _loadingNotice = new TextField();
            _loadingNotice.text = "请稍候..";
            _loadingNotice.setTextFormat(new TextFormat("arial", 12, 0xffffff));
            _loadingNotice.width = 100;
            _loadingNotice.height = 20;
            _loadingNotice.filters = [new GlowFilter(0)];
            
            _loadingCounter = new Counter();
            
            addChild(_loadingNotice);
            addChild(_loadingClip);
            
        }
        
        
        protected function onEnterFrame(event:Event):void
        {
            var currentTime:int = getTimer();
            var delta:Number = currentTime- _lastRenderTimeStamp;
            _lastRenderTimeStamp = currentTime;
            _loadingCounter.tick(delta);
            
            if(_loadingCounter.expired == true)
            {
                _loadingCounter.initialize();
                _loadingCounter.reset(_targetFrameRate);
                if(_loadingClip.currentFrame == _loadingClip.totalFrames)
                {
                    _loadingClip.gotoAndStop(1);
                }
                else
                {
                    _loadingClip.nextFrame();
                }
            }
        }
        
        public function onResize(stage:Stage):void
        {
            var w:int = stage.stageWidth-5;
            var h:int = stage.stageHeight-5;
            
            graphics.clear();
            graphics.beginFill(0,.5);
            graphics.drawRect(0,0,w,h);
            graphics.endFill();
            
            _loadingClip.x = (w-55)*.5;
            _loadingClip.y = -10 + (h-55)*.5;
            
            _loadingNotice.x =  (w-_loadingNotice.textWidth)*.5;
            _loadingNotice.y = (h-_loadingNotice.textHeight)*.5+20;
            
        }
    }
}

class singleton {}