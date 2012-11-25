package game.untils
{
    import flash.events.Event;
    import flash.net.URLLoader;
    import flash.net.URLLoaderDataFormat;
    import flash.net.URLRequest;
    
    public class MapLoader
    {
        private static var mapJsonLoader:URLLoader;
        private static var _callBack:Function;
        
        public function MapLoader()
        {
            
        }
        
        private static function onMapJsonLoadCompleteHandler(e:Event):void
        {
            mapJsonLoader.removeEventListener(Event.COMPLETE, onMapJsonLoadCompleteHandler);
            
            _callBack( mapJsonLoader.data );
        }
        
        public static function load( urlStr:String, callBack:Function):void
        {
            _callBack = callBack;
            mapJsonLoader = new URLLoader();
            mapJsonLoader.dataFormat = URLLoaderDataFormat.BINARY;
            mapJsonLoader.addEventListener(Event.COMPLETE, onMapJsonLoadCompleteHandler);
            mapJsonLoader.load(new URLRequest( urlStr ));
        }
    }
}