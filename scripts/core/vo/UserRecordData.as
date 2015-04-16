package vo
{
   import common.util.Util;
   
   public class UserRecordData extends Object
   {
      
      public function UserRecordData()
      {
         _obj = {};
         super();
      }
      
      private var _obj:Object;
      
      public function setData(param1:Object) : void
      {
         _obj = param1;
      }
      
      public function getNickName() : String
      {
         return DataFacade.getUserData().getNickName();
      }
      
      public function getLevel() : int
      {
         return DataFacade.getUserData().getLevel();
      }
      
      public function getExperienceNow() : int
      {
         return DataFacade.getUserData().getExperience();
      }
      
      public function getRank() : int
      {
         return DataFacade.getUserData().getRank();
      }
      
      public function getDeckCount() : int
      {
         return DataFacade.getUserDeckData().deckCount;
      }
      
      public function getBuildDockCount() : int
      {
         return DataFacade.getUserData().getBuildDockCount();
      }
      
      public function getRepairDockCount() : int
      {
         return DataFacade.getUserData().getRepairDockCount();
      }
      
      public function getShipCount() : int
      {
         return DataFacade.getUserDeckData().shipCount;
      }
      
      public function getShipCountMax() : int
      {
         return DataFacade.getUserData().getMaxShipCount();
      }
      
      public function getSlotitemCount() : int
      {
         return DataFacade.getUserSlotItemData().itemCount;
      }
      
      public function getSlotItemCountMax() : int
      {
         return DataFacade.getUserData().getMaxSlotItemCount();
      }
      
      public function getFurnitureCount() : int
      {
         return DataFacade.getUserFurnitureData().furnitureCount;
      }
      
      public function getComment() : String
      {
         return Util.getString(_obj,"api_cmt","");
      }
      
      public function getExperienceNext() : int
      {
         return Util.getArray(_obj,"api_experience",[0,0])[1];
      }
      
      public function getSallyWin() : int
      {
         return Util.getInt(_getSallyData(),"api_win",0);
      }
      
      public function getSallyLose() : int
      {
         return Util.getInt(_getSallyData(),"api_lose",0);
      }
      
      public function getSallyRate() : int
      {
         var _loc2_:String = Util.getString(_getSallyData(),"api_rate","0.00");
         var _loc1_:Number = parseFloat(_loc2_);
         return isNaN(_loc1_)?0:Math.round(_loc1_ * 100);
      }
      
      public function getPracticeWin() : int
      {
         return Util.getInt(_getPracticeData(),"api_win",0);
      }
      
      public function getPraceticeLose() : int
      {
         return Util.getInt(_getPracticeData(),"api_lose",0);
      }
      
      public function getPracticeRate() : int
      {
         var _loc2_:String = Util.getString(_getPracticeData(),"api_rate","0.00");
         var _loc1_:Number = parseFloat(_loc2_);
         return isNaN(_loc1_)?0:Math.round(_loc1_);
      }
      
      public function getMissionCount() : int
      {
         return Util.getInt(_getMissionData(),"api_count",0);
      }
      
      public function getMissionSuccess() : int
      {
         return Util.getInt(_getMissionData(),"api_success",0);
      }
      
      public function getMissionRate() : int
      {
         var _loc2_:String = Util.getString(_getMissionData(),"api_rate","0.00");
         var _loc1_:Number = parseFloat(_loc2_);
         return isNaN(_loc1_)?0:Math.round(_loc1_);
      }
      
      public function getMaterialMaxCount() : int
      {
         return Util.getInt(_obj,"api_material_max",0);
      }
      
      private function _getSallyData() : Object
      {
         return Util.getObject(_obj,"api_war",{});
      }
      
      private function _getPracticeData() : Object
      {
         return Util.getObject(_obj,"api_practice",{});
      }
      
      private function _getMissionData() : Object
      {
         return Util.getObject(_obj,"api_mission",{});
      }
   }
}