package game.app.events
{
    import common.core.events.BaseEvent;
    
    public class BtnEvent extends BaseEvent
    {
        /**
         * 
         */		
        public static const BTN_CLICK_EVENT:String = "btn_click_event";
        
        public function BtnEvent(type:String, paramObject:Object=null)
        {
            super(type, paramObject);
        }
    }
}