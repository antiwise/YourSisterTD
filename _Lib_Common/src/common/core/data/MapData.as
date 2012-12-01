package common.core.data
{
    import flash.utils.ByteArray;
    import flash.utils.CompressionAlgorithm;
    import common.core.interfaces.IMapData;
    
    public class MapData implements IMapData
    {
        public static const MAP_FILE_HEAD:String = "MAP";
        private var _dataList:Vector.<int>;
        public function get dataList():Vector.<int>
        {
            return _dataList;
        }
        private var _compentList:Vector.<int>;
        public function get compentList():Vector.<int>
        {
            return _compentList;
        }
        
        public function MapData()
        {
            //create 30 * 20 fields
            _dataList = new Vector.<int>( 30 * 20 );
            _compentList = new Vector.<int>( 30 * 20 );
        }
        
        public function fromByteArray( bytes:ByteArray ):void
        {
            bytes.position = 0;
            var head:String = bytes.readUTF();
            
            var compressData:ByteArray = new ByteArray();
            bytes.readBytes( compressData );
            compressData.uncompress( CompressionAlgorithm.DEFLATE );
            var iLen:int = compressData.readUnsignedInt();
            for (var i:int = 0;i<iLen;i++)
            {
                _dataList[i] = compressData.readUnsignedInt();
            }
            iLen = compressData.readUnsignedInt();
            for (i = 0;i<iLen;i++)
            {
                _compentList[i] = compressData.readUnsignedInt();
            }
            trace( "len: " + iLen + " HEAD: " + head );
        }
        
        public function toByteArray():ByteArray
        {
            var compressData:ByteArray = new ByteArray();
            var iLen:int = _dataList.length;
            compressData.writeUnsignedInt( iLen );
            for(var i:int = 0;i<iLen;i++)
            {
                compressData.writeUnsignedInt( _dataList[i] );
            }
            iLen = _compentList.length;
            compressData.writeUnsignedInt( iLen );
            for(i = 0;i<iLen;i++)
            {
                compressData.writeUnsignedInt( _compentList[i] );
            }
            compressData.deflate();
            
            var bytes:ByteArray = new ByteArray();
            bytes.writeUTF( MAP_FILE_HEAD );
            bytes.writeBytes( compressData );
            return bytes;
        }
    }
}