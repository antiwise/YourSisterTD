package ai
{
    import common.core.utils.GeomUtil;
    
    import flash.geom.Point;
    
    import unit.Character;
    import unit.Enemy;
    import unit.Unit;
    
    public class CharacterAI
    {
        private static const WIDTH:Number = 32 * 0.6;
        
        public static function execute( character:Character, mapModel:MapModel ):void
        {
            var mapDataList:Vector.<int> = mapModel.mapData.dataList; 
            
            var enemyList:Vector.<Unit> = mapModel.enemyList;
            var enemy:Enemy;
            var iLen:int = enemyList.length;
            var enemyBlockX:int;
            var enemyBlockY:int;
            for(var i:int = 0;i<iLen;i++)
            {
                enemy = enemyList[i] as Enemy;
                if( enemy && GeomUtil.getLineLength( new Point(character.x, character.y), new Point(enemy.x, enemy.y)) <= character.range)
                {
                    character.attack( enemy );
                }
            }
        }
    }
}