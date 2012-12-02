package ai
{
    import unit.Enemy;
    
    public class EnemyAI
    {
        private static const WIDTH:Number = 32 * 0.6;
        
        public static function execute( enemy:Enemy, mapModel:MapModel ):void
        {
            var mapDataList:Vector.<int> = mapModel.mapData.dataList; 
            var blockX:int = Math.round( enemy.x / WIDTH );
            var blockY:int = Math.round( enemy.y / WIDTH );
            
            if( enemy.isMoving == false )
            {
                if( mapDataList[ blockX + 1 + blockY * 30 ] == 0 )//如果下一格为0
                {
                    if( enemy.currentDir == 0 || enemy.currentDir != 2 )
                    {
                        enemy.move( blockX + 1, blockY, 0 );
                        return;
                    }
                }
                if( mapDataList[ (blockY + 1) * 30 + blockX ] == 0 )
                {
                    if( enemy.currentDir == 1 || enemy.currentDir != 3 )
                    {
                        enemy.move( blockX, blockY + 1, 1 );
                        return;
                    }
                }
                if( mapDataList[ blockX - 1 + blockY * 30 ] == 0 )
                {
                    if( enemy.currentDir == 2 || enemy.currentDir != 0 )
                    {
                        enemy.move( blockX - 1, blockY, 2 );
                        return;
                    }
                }
                if( mapDataList[ (blockY - 1) * 30 + blockX ] == 0 )
                {
                    if( enemy.currentDir == 3 || enemy.currentDir != 1)
                    {
                        enemy.move( blockX, blockY - 1, 3 );
                        return;
                    }
                }
            }
        }
    }
}