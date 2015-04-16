package connection.api_req_furniture
{
   import connection.APIConnectionBase;
   import flash.events.Event;
   
   public class JukeMusicListAPI extends APIConnectionBase
   {
      
      public function JukeMusicListAPI()
      {
         super();
         _API_NAME = "ジュークボックスの曲一覧の取得";
         _url = "api_req_furniture/music_list";
      }
      
      private var _logList:Array;
      
      override protected function _handleLoadComplete(param1:Event, param2:Object) : void
      {
         var _loc3_:Array = param2 as Array;
         if(_loc3_ != null)
         {
            DataFacade.getMasterBGMData().setJukeBoxMusicData(_loc3_);
         }
         else
         {
            AppFacade.showErrorScreen("api_req_furniture/music_list must return array data.");
         }
      }
   }
}
