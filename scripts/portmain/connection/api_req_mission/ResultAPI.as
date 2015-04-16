package connection.api_req_mission
{
   import connection.APIConnectionBase;
   import port.models.dto.MissionResultDTO;
   import flash.events.Event;
   
   public class ResultAPI extends APIConnectionBase
   {
      
      public function ResultAPI(param1:int, param2:MissionResultDTO)
      {
         super();
         _API_NAME = "遠征結果取得";
         _url = "api_req_mission/result";
         _deckID = param1;
         _resultDTO = param2;
      }
      
      private var _deckID:int;
      
      private var _resultDTO:MissionResultDTO;
      
      override protected function _preLoad() : void
      {
         _urlVariables["api_deck_id"] = _deckID;
      }
      
      override protected function _handleLoadComplete(param1:Event, param2:Object) : void
      {
         _resultDTO.setData(param2);
      }
   }
}
