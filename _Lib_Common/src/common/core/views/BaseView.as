package common.core.views
{
    import common.core.interfaces.ITickable;
    import common.core.interfaces.IView;
    
    import starling.display.Sprite;
    
    /**
     * 视图类的基类
     * 
     * 所有视图类都必须继承这个类 
     * @author noah
     */	
    public class BaseView extends Sprite implements IView, ITickable
    {
        protected var _couldTick:Boolean;
        
        public function BaseView()
        {
            
        }
        
        public function advanceTime( time:Number ):void
        {
            
        }
        
        public function init():void
        {
            
        }
        
        public function destroy():void
        {
            
        }
        
        public function tick(delta:Number):void
        {
            advanceTime( delta );
        }
        
        public function get couldTick():Boolean
        {
            return _couldTick;
        }
    }
}