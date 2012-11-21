package update
{
	import flash.desktop.NativeApplication;
	import flash.desktop.NativeProcess;
	import flash.desktop.NativeProcessStartupInfo;
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	
	
	public class UpdateUtil
	{
		private var _urlloader:URLLoader;
		private var _updateURL:String;
		/**
		 * 
		 * @param updateURL 版本描述文件URL
		 * @param eventHandle 事件挂钩
		 * 
		 */		
		public function UpdateUtil(updateURL:String,eventHandle:Function = null)
		{
			if( isDebugMode )
			{
				return;
			}
			_updateURL = updateURL;
			
			_urlloader = new URLLoader(new URLRequest( _updateURL ));
			_urlloader.dataFormat = URLLoaderDataFormat.BINARY;
			_urlloader.addEventListener(Event.COMPLETE, onLoadUpdateXML);
		}
		protected function onLoadUpdateXML(e:Event):void
		{
			_urlloader.removeEventListener(Event.COMPLETE,onLoadUpdateXML);
			
			var loadUpdateXML:XML = XML( _urlloader.data );
			
			namespace ns = "http://ns.adobe.com/air/application/3.4"; 
			namespace ns1 = "http://ns.adobe.com/air/framework/update/description/2.5"; 
			use namespace ns; 
			use namespace ns1; 
			var nativeApplication:NativeApplication = NativeApplication.nativeApplication;
			trace("versions: " + nativeApplication.applicationDescriptor.versionNumber[0] + " : " + loadUpdateXML.versionNumber[0] )
			if( String(nativeApplication.applicationDescriptor.versionNumber[0]) != String(loadUpdateXML.versionNumber[0]) )
			{
				_urlloader = new URLLoader();
				_urlloader.dataFormat = URLLoaderDataFormat.BINARY;
				_urlloader.addEventListener(Event.COMPLETE, onStreamLoadComplete);
				var url:String = loadUpdateXML.url[0];
				_urlloader.load(new URLRequest( url ));
			}
		}
		
		protected function onStreamLoadComplete(e:Event):void
		{
			_urlloader.removeEventListener(Event.COMPLETE, onStreamLoadComplete);
			
			var fs:FileStream = new FileStream();
			var sourceBytes:ByteArray = new ByteArray();
			(_urlloader.data as ByteArray).readBytes( sourceBytes, 0, _urlloader.bytesTotal );
			var installFile:File = new File("c:\\toolsUpdater\\Hy_EffectMaker.exe");
			fs.open(installFile, FileMode.WRITE);
			fs.writeBytes(sourceBytes);
			fs.close();
			var nativeProcessInfo:NativeProcessStartupInfo = new NativeProcessStartupInfo();
			nativeProcessInfo.executable = installFile;
			var nativeProcess:NativeProcess = new NativeProcess();
			nativeProcess.start(nativeProcessInfo);
			
			NativeApplication.nativeApplication.exit();
		}
		/**
		 *
		 * 是否debug模式 
		 * @return 
		 * 
		 */		
		public function get isDebugMode():Boolean
		{
			try
			{
				trace(Object("").fuck);
			}
			catch (e:Error)
			{
				return true;
			}
			return false;
		}
	}

}