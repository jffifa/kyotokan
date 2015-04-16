package connection
{
   import flash.net.URLLoader;
   import flash.net.URLVariables;
   import flash.events.IEventDispatcher;
   import flash.net.URLRequest;
   import common.debug.Debug;
   import flash.events.Event;
   import flash.utils.setTimeout;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   
   public class APIConnectionBase extends Object
   {
      
      public function APIConnectionBase(param1:String = "")
      {
         super();
         _token = param1;
      }
      
      public static var waitTime:Number = 0;
      
      private static var _COMPLETE:String = "APIConnectionBase::COMPLETE";
      
      public static function get COMPLETE() : String
      {
         return _COMPLETE;
      }
      
      protected var _API_NAME:String = "";
      
      public function get API_NAME() : String
      {
         return _API_NAME;
      }
      
      private var _isSuccess:Boolean = false;
      
      public function get isSuccess() : Boolean
      {
         return _isSuccess;
      }
      
      private var _token:String = "";
      
      private var _verno:int = 1;
      
      protected var _url:String = "";
      
      protected var _urlLoader:URLLoader = null;
      
      protected var _urlVariables:URLVariables = null;
      
      private var _eventDispatchTarget:IEventDispatcher = null;
      
      public function load(param1:IEventDispatcher = null) : void
      {
         _eventDispatchTarget = param1;
         if(_token == "")
         {
            _token = SettingFacade.API_TOKEN;
         }
         var _loc3_:String = SettingFacade.getURLROOT_API_Dummy(_url);
         if(_loc3_.length > 0)
         {
            _loc3_ = _loc3_ + _url;
         }
         else
         {
            _loc3_ = SettingFacade.URLROOT_API + _url;
         }
         var _loc2_:URLRequest = new URLRequest(_loc3_);
         _loc2_.method = "POST";
         _urlVariables = new URLVariables();
         _urlVariables.api_token = _token;
         _urlVariables.api_verno = _verno;
         _urlLoader = new URLLoader();
         _urlLoader.addEventListener("complete",__handleLoadComplete);
         _urlLoader.addEventListener("ioError",_handleIOErrorEvent);
         _urlLoader.addEventListener("securityError",_handleSecurityError);
         _preLoad();
         _loc2_.data = _urlVariables;
         _urlLoader.load(_loc2_);
         Debug.log("<-> " + API_NAME + " " + _loc3_);
      }
      
      protected function _preLoad() : void
      {
      }
      
      protected function _handleLoadComplete(param1:Event, param2:Object) : void
      {
      }
      
      protected function _getURLLoaderData(param1:URLLoader) : String
      {
         return param1.data;
      }
      
      private function __handleLoadComplete(param1:Event, param2:Boolean = false) : void
      {
         if(param2 == false && waitTime > 0)
         {
            return;
         }
         _urlLoader.removeEventListener("complete",__handleLoadComplete);
         _urlLoader.removeEventListener("ioError",_handleIOErrorEvent);
         _urlLoader.removeEventListener("securityError",_handleSecurityError);
         var _loc4_:String = _getURLLoaderData(_urlLoader);
         var _loc3_:Array = _loc4_.match(new RegExp("svdata=(.*)"));
         var _loc5_:String = "";
         if(_loc3_ && _loc3_.length > 1)
         {
            _loc5_ = _loc3_[1];
         }
         else if(!_loc3_)
         {
            _loc5_ = _loc4_;
         }
         else
         {
            AppFacade.showErrorScreen(API_NAME + " : API result parse error.");
            return;
         }
         
         _result(_loc5_,param1);
      }
      
      private function _handleIOErrorEvent(param1:IOErrorEvent) : void
      {
         Debug.log(param1);
         _eventDispatchTarget = null;
         _urlLoader.removeEventListener("complete",__handleLoadComplete);
         _urlLoader.removeEventListener("ioError",_handleIOErrorEvent);
         _urlLoader.removeEventListener("securityError",_handleSecurityError);
         AppFacade.showErrorScreen(API_NAME + " : IOError : " + _url);
      }
      
      private function _handleSecurityError(param1:SecurityErrorEvent) : void
      {
         Debug.log(param1);
         _eventDispatchTarget = null;
         _urlLoader.removeEventListener("complete",__handleLoadComplete);
         _urlLoader.removeEventListener("ioError",_handleIOErrorEvent);
         _urlLoader.removeEventListener("securityError",_handleSecurityError);
         AppFacade.showErrorScreen(API_NAME + " : SecurityError");
      }
      
      private function _result(param1:String, param2:Event = null) : void
      {
         var _loc3_:* = null;
         Debug.log("<-> " + API_NAME + (param2 == null?"[debug]":""));
         var _loc4_:Object = null;
         try
         {
            _loc4_ = JSON.parse(param1);
         }
         catch(error:Error)
         {
            AppFacade.showErrorScreen(API_NAME + " : JSON parse error. " + error.message);
            return;
         }
         if(_loc4_.api_result != 1)
         {
            AppFacade.showErrorScreen(API_NAME + "[" + _loc4_.api_result_msg + "] : API returned failed.");
            return;
         }
         if(_url == "api_start")
         {
            _loc4_["api_data"] = {};
            _loc4_["api_data"]["api_mst_shipgraph"] = _loc4_.api_data_mst_shipgraph;
            delete _loc4_["api_data_mst_shipgraph"];
            true;
            _loc4_["api_mst_slotitemgraph"] = _loc4_.api_data_mst_slotitemgraph;
            delete _loc4_["api_data_mst_slotitemgraph"];
            true;
            _loc4_["api_mst_furnituregraph"] = _loc4_.api_data_mst_furnituregraph;
            delete _loc4_["api_data_mst_furnituregraph"];
            true;
         }
         else if(_url == "api_get_member/ship2")
         {
            _loc3_ = _loc4_["api_data"];
            _loc4_["api_data"] = {};
            _loc4_["api_data"]["api_ship"] = _loc3_;
            _loc4_["api_data"]["api_deck"] = _loc4_["api_data_deck"];
            delete _loc4_["api_data_deck"];
            true;
         }
         
         _handleLoadComplete(param2,_loc4_.api_data);
         _isSuccess = true;
         if(_eventDispatchTarget)
         {
            _eventDispatchTarget.dispatchEvent(new Event(COMPLETE));
            _eventDispatchTarget = null;
         }
      }
   }
}
