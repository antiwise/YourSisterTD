package common.nostarling.layers
{
	import common.nostarling.interfaces.ILayer;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;

	/**
	 * 基本层
	 * 
	 * 一些基本层的集合
	 * @author noah
	 */	
	public class Layer implements ILayer
	{
		/**
		 * 后层 
		 */		
		public static const BACK:uint = 0;
		/**
		 * AVG游戏层 
		 */		
		public static const GAME_AVG:uint = 1;
		/**
		 * RPG游戏层 
		 */		
		public static const GAME_RPG:uint = 2;
		/**
		 * 界面层 
		 */		
		public static const UI:uint = 3;
		/**
		 * 顶层 
		 */		
		public static const TOP:uint = 4;
		
		protected var layerArr:Vector.<Sprite>;
		
		public function Layer() 
		{
			layerArr = new Vector.<Sprite>();
		}
		/**
		 * 将一个或多个元素添加到数组的结尾，并返回该数组的新长度。
		 * @param parameters
		 * @return 
		 */		
		public function push( obj:DisplayObject):uint{
			return layerArr.push( obj );
		}
		
		public function get backLevel():Sprite{
			
			return  layerArr[ Layer.BACK ];
		}
		public function get gameAvgLevel():Sprite{
			
			return  layerArr[ Layer.GAME_AVG ];
		}
		public function get gameRpgLevel():Sprite{
			
			return  layerArr[ Layer.GAME_RPG ];
		}
		public function get uiLevel():Sprite{
			
			return  layerArr[ Layer.UI ];
		}
		public function get topLevel():Sprite{
			
			return  layerArr[ Layer.TOP ];
		}
	}
}