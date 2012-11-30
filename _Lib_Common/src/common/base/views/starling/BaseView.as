package common.base.views.starling
{
    import common.base.interfaces.ITickable;
    import common.base.interfaces.IView;
    
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
        /**
         * 构造函数
         */		
        public function BaseView()
        {
            
        }
        /**
         * 填充数据到视图
         * @param data
         */		
        public function init():void
        {
            
        }
        
        public function tick(delta:Number):void
        {
            advanceTime( delta );
        }
        
        public function advanceTime( time:Number ):void
        {
            
        }
        
        /**
         * 更新视图
         */		
        public function update():void
        {
            
        }
        /**
         * 销毁视图
         */		
        public function destroy():void
        {
            
        }
        
        public function get couldTick():Boolean
        {
            return _couldTick;
        }
    }
}