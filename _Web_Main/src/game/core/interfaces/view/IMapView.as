package  game.core.interfaces.view
{
    import game.base.interfaces.IGameUnitView;
    
    import starling.display.Image;
    import starling.display.Sprite;
    
    public interface IMapView extends IGameUnitView
    {
        function get groundLevel():Sprite;
        function get contentLevel():Sprite;
        function get airLevel():Sprite;
        
        function addCharacter( character:ICharacterView ):void;
    }
}