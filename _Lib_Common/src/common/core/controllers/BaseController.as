package common.core.controllers
{
    import common.core.interfaces.IController;
    import common.core.interfaces.IModel;
    
    /**
     * 控制类的基类
     * 
     * 所有控制类都必须继承这个类 
     * @author noah
     */	
    public class BaseController implements IController
    {
        protected var _model:IModel;
        
        public function BaseController()
        {
            
        }
        
        public function init( model:IModel ):void
        {
            _model = model;
        }
    }
}