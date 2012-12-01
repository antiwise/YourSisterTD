package game.app.factorys
{
    import common.core.factory.BaseFactory;
    import common.core.interfaces.IModel;
    import common.core.interfaces.IView;
    
    import game.app.types.ViewType;
    import game.app.views.LoadingView;
    
    /**
     * 视图工厂类
     * 
     * @author noah
     */	
    public class ViewsFactory extends BaseFactory{
        /**
         * 
         */		
        private static var model:IModel;
        
        public function ViewsFactory()
        {
            
        }
        
        /**
         * 
         * @param classNameStr
         * @param model
         * @return 
         */		
        public static function newView( classNameStr:String, model:IModel):IView
        {
            
            ViewsFactory.model = model;
            return (new ViewsFactory).newInstance( classNameStr );
        }
        /**
         * 
         * @param classNameStr
         * @return 
         */		
        override protected function newInstance( classNameStr:String):*
        {
            
            switch (classNameStr){
                case ViewType.ALERT:
                    return new AlertView( ViewsFactory.model );
                    ViewsFactory.model = null;
                    break;
                case ViewType.BTN:
                    return new BtnView( ViewsFactory.model );
                    break;
                case ViewType.Loading:
                    return new LoadingView();
                    break;
                default:
                    return null;
                    break;
            }
        }
    }
}