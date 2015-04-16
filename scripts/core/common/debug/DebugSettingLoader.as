package common.debug
{
   import flash.events.EventDispatcher;
   import flash.net.URLLoader;
   import flash.events.Event;
   import common.util.Util;
   import flash.events.IOErrorEvent;
   import flash.net.URLRequest;
   
   public class DebugSettingLoader extends EventDispatcher
   {
      
      public function DebugSettingLoader(param1:Object, param2:Function)
      {
         super();
         _settingData = param1;
         _nextFunction = param2;
         _url = SettingFacade.EX_SETTING + "?" + new Date().getTime();
         var _loc3_:URLRequest = new URLRequest(_url);
         _urlLoader = new URLLoader();
         _urlLoader.addEventListener("complete",_handleLoadComplete);
         _urlLoader.addEventListener("ioError",_handleLoadIOError);
         _urlLoader.load(_loc3_);
      }
      
      private var _settingData:Object;
      
      private var _nextFunction:Function = null;
      
      private var _url:String;
      
      private var _urlLoader:URLLoader;
      
      private function _finalize() : void
      {
         var _loc1_:Function = _nextFunction;
         _settingData = null;
         _nextFunction = null;
      }
      
      private function _handleLoadComplete(param1:Event) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         _urlLoader.removeEventListener("complete",_handleLoadComplete);
         _urlLoader.removeEventListener("ioError",_handleLoadIOError);
         Debug.log("[COMPLETE] Load Debug Setting.");
         try
         {
            _loc2_ = _urlLoader.data;
            _loc2_ = _loc2_.replace(new RegExp("^\\/\\/.*?$","gm"),"");
            _loc2_ = _loc2_.replace(new RegExp("[^:]\\/\\/.*?$","sgm"),"");
            _loc2_ = _loc2_.replace(new RegExp("^\\s+?$","sgm"),"");
            _loc3_ = JSON.parse(_loc2_);
            Util.overWrite(_settingData,_loc3_);
         }
         catch(error:SyntaxError)
         {
            Debug.log("[DebugSetting] Syntax Error");
         }
         _finalize();
      }
      
      private function _handleLoadIOError(param1:IOErrorEvent) : void
      {
         _urlLoader.removeEventListener("complete",_handleLoadComplete);
         _urlLoader.removeEventListener("ioError",_handleLoadIOError);
         Debug.log("[IOERROR] Error Debug Setting. url: " + _url);
         _finalize();
      }
   }
}
