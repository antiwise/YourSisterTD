package  game.core.models.statics
{
    import game.base.interfaces.IStaticUnitModel;
    import game.base.models.StaticUnitModel;
    import game.core.interfaces.model.IBlockModel;
    
    /**
     * 地图单元模型
     * @author noah
     */	
    public class BlockModel extends StaticUnitModel implements IBlockModel,IStaticUnitModel
    {
        public function BlockModel()
        {
            super();
        }
    }
}