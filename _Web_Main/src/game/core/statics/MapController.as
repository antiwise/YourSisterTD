package  game.core.statics
{
    import common.core.controllers.BaseController;
    
    import game.core.models.statics.MapModel;
    
    public class MapController extends BaseController
    {
        private var _model:MapModel;
        
        public function MapController()
        {
            super();
        }
        
        override public function init( dataObj:Object ):void{
            
            _model = dataObj as MapModel;
        }
    }
}