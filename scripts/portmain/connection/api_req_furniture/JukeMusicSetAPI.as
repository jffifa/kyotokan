package connection.api_req_furniture
{
   import connection.APIConnectionBase;
   import flash.events.Event;
   
   public class JukeMusicSetAPI extends APIConnectionBase
   {
      
      public function JukeMusicSetAPI(param1:int)
      {
         super();
         _API_NAME = "ジュークボックスから母港BGMを設定";
         _url = "api_req_furniture/set_portbgm";
         _musicId = param1;
      }
      
      private var _musicId:int;
      
      override protected function _preLoad() : void
      {
         _urlVariables["api_music_id"] = _musicId;
      }
      
      override protected function _handleLoadComplete(param1:Event, param2:Object) : void
      {
      }
   }
}
