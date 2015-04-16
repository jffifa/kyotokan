package port.models.dto
{
   import common.util.Util;
   
   public class MissionResultDTO extends Object
   {
      
      public function MissionResultDTO()
      {
         super();
      }
      
      public static const RESULT_FAILED:int = 0;
      
      public static const RESULT_SUCCESS:int = 1;
      
      public static const RESULT_BIG_SUCCESS:int = 2;
      
      public static const REWARD_ITEM_TYPE_0_NONE:int = 0;
      
      public static const REWARD_ITEM_TYPE_1_REPAIRKIT:int = 1;
      
      public static const REWARD_ITEM_TYPE_2_BUILDKIT:int = 2;
      
      public static const REWARD_ITEM_TYPE_3_DEVKIT:int = 3;
      
      public static const REWARD_ITEM_TYPE_4_USEITEM:int = 4;
      
      public static const REWARD_ITEM_TYPE_5_KAGUCOIN:int = 5;
      
      private var _o:Object;
      
      public function setData(param1:Object) : void
      {
         _o = param1;
         if(_o["api_get_material"] == -1)
         {
            _o["api_get_material"] = [];
         }
      }
      
      public function get shipIDs() : Array
      {
         var _loc3_:* = 0;
         var _loc2_:Array = Util.getArray(_o,"api_ship_id",[]);
         var _loc1_:Array = [];
         _loc3_ = 0;
         while(_loc3_ < _loc2_.length)
         {
            if(_loc2_[_loc3_] != -1)
            {
               _loc1_.push(_loc2_[_loc3_]);
            }
            _loc3_++;
         }
         return _loc1_;
      }
      
      public function get resultFlg() : int
      {
         return Util.getInt(_o,"api_clear_result",0);
      }
      
      public function get totalExp() : int
      {
         return Util.getInt(_o,"api_get_exp");
      }
      
      public function get level() : int
      {
         return Util.getInt(_o,"api_member_lv");
      }
      
      public function get missionName() : String
      {
         return Util.getString(_o,"api_quest_name");
      }
      
      public function get rewardFuel() : int
      {
         return _reward_material[0];
      }
      
      public function get rewardAmmo() : int
      {
         return _reward_material[1];
      }
      
      public function get rewardSteel() : int
      {
         return _reward_material[2];
      }
      
      public function get rewardBaux() : int
      {
         return _reward_material[3];
      }
      
      public function hasRewardItem1() : Boolean
      {
         return !(item1Type == 0);
      }
      
      public function get item1Type() : int
      {
         return _reward_item_types[0];
      }
      
      public function get item1ID() : int
      {
         var _loc1_:int = Util.getInt(_reward_item1,"api_useitem_id");
         return _getRewardItemID(item1Type,_loc1_);
      }
      
      public function get item1Name() : String
      {
         var _loc1_:String = Util.getString(_reward_item1,"api_useitem_name");
         return _getRewardItemName(item1Type,_loc1_);
      }
      
      public function get item1Count() : int
      {
         return Util.getInt(_reward_item1,"api_useitem_count",1);
      }
      
      public function hasRewardItem2() : Boolean
      {
         return !(item2Type == 0);
      }
      
      public function get item2Type() : int
      {
         return _reward_item_types[1];
      }
      
      public function get item2ID() : int
      {
         var _loc1_:int = Util.getInt(_reward_item2,"api_useitem_id");
         return _getRewardItemID(item2Type,_loc1_);
      }
      
      public function get item2Name() : String
      {
         var _loc1_:String = Util.getString(_reward_item2,"api_useitem_name");
         return _getRewardItemName(item2Type,_loc1_);
      }
      
      public function get item2Count() : int
      {
         return Util.getInt(_reward_item2,"api_useitem_count",1);
      }
      
      private function get _reward_material() : Array
      {
         var _loc1_:Array = Util.getArray(_o,"api_get_material");
         if(_loc1_ && _loc1_.length == 4)
         {
            return _loc1_;
         }
         return [];
      }
      
      private function get _reward_item_types() : Array
      {
         var _loc1_:Array = Util.getArray(_o,"api_useitem_flag");
         if(_loc1_ && _loc1_.length == 2)
         {
            return _loc1_;
         }
         return [];
      }
      
      private function get _reward_item1() : Object
      {
         return Util.getObject(_o,"api_get_item1",{});
      }
      
      private function get _reward_item2() : Object
      {
         return Util.getObject(_o,"api_get_item2",{});
      }
      
      private function _getRewardItemName(param1:int, param2:String) : String
      {
      }
      
      private function _getRewardItemID(param1:int, param2:int) : int
      {
      }
   }
}
