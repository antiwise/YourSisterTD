package common.data
{
	import flash.utils.ByteArray;

	public interface IMapData
	{
		function get dataList():Vector.<int>;
		function get compentList():Vector.<int>;
		function fromByteArray( data:ByteArray ):void;
		function toByteArray():ByteArray;
	}
}