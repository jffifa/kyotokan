package connection.api_get_member
{
   import connection.APIConnectionBase;
   import flash.events.Event;
   
   public class UserShipAndUnuseSlotitemAPI extends APIConnectionBase
   {
      
      public function UserShipAndUnuseSlotitemAPI()
      {
         super();
         _API_NAME = "所有艦情報とデッキ情報と未装備スロットアイテム";
         _url = "api_get_member/ship3";
      }
      
      override protected function _preLoad() : void
      {
         _urlVariables.api_sort_key = "5";
         _urlVariables.spi_sort_order = "2";
      }
      
      override protected function _handleLoadComplete(param1:Event, param2:Object) : void
      {
         var _loc5_:* = null;
         var _loc3_:* = null;
         var _loc4_:* = null;
         if(param2.hasOwnProperty("api_ship_data") && (param2.hasOwnProperty("api_deck_data")) && (param2.hasOwnProperty("api_slot_data")))
         {
            _loc5_ = param2["api_ship_data"] as Array;
            if(_loc5_ != null)
            {
               DataFacade.getUserDeckData().setShipData(_loc5_);
               _loc3_ = param2["api_deck_data"] as Array;
               if(_loc3_ != null)
               {
                  DataFacade.getUserDeckData().setDeckData(_loc3_);
                  _loc4_ = param2["api_slot_data"];
                  DataFacade.getUserSlotItemData().setUnEquipedData(_loc4_);
               }
               else
               {
                  AppFacade.showErrorScreen("api_get_member/ship3 must return \"decks\" array data.");
                  return;
               }
            }
            else
            {
               if(DataFacade.getUserData().getFirstFlg())
               {
                  DataFacade.getUserDeckData().setShipData([]);
               }
               else
               {
                  AppFacade.showErrorScreen("api_get_member/ship3 must return \"ships\" array data.");
               }
               return;
            }
         }
         else
         {
            AppFacade.showErrorScreen("api_get_member/ship3 Error.");
         }
      }
   }
}
