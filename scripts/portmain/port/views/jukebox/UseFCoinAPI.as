package port.views.jukebox
{
   import connection.APIConnectionBase;
   import flash.events.Event;
   
   public class UseFCoinAPI extends APIConnectionBase
   {
      
      public function UseFCoinAPI(param1:int)
      {
         super();
         _API_NAME = "家具コイン使用";
         _url = "api_req_furniture/music_play";
         _music_id = param1;
      }
      
      private var _music_id:int;
      
      private var _result:Object;
      
      override protected function _preLoad() : void
      {
         _urlVariables.api_music_id = _music_id;
      }
      
      override protected function _handleLoadComplete(param1:Event, param2:Object) : void
      {
         _result = param2;
      }
      
      public function get result() : Object
      {
         return _result;
      }
   }
}
