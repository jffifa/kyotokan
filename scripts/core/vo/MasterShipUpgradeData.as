package vo
{
   import flash.utils.Dictionary;
   import common.util.Util;
   
   public class MasterShipUpgradeData extends Object
   {
      
      public function MasterShipUpgradeData()
      {
         super();
         _dic = new Dictionary();
         _separateDic = new Dictionary();
      }
      
      private var _dic:Dictionary;
      
      private var _separateDic:Dictionary;
      
      public function setData(param1:Array) : void
      {
         var _loc5_:* = 0;
         var _loc4_:* = null;
         var _loc3_:* = 0;
         var _loc2_:* = 0;
         _dic = new Dictionary();
         _separateDic = new Dictionary();
         _loc5_ = 0;
         while(_loc5_ < param1.length)
         {
            _loc4_ = param1[_loc5_];
            _loc3_ = _loc4_["api_id"];
            _loc2_ = _loc4_["api_original_ship_id"];
            _dic[_loc3_] = _loc4_;
            if(!_separateDic.hasOwnProperty(_loc2_))
            {
               _separateDic[_loc2_] = [];
            }
            _separateDic[_loc2_].push(_loc4_);
            _loc5_++;
         }
      }
      
      private function _getShipObj(param1:int) : Object
      {
         if(_dic.hasOwnProperty(param1))
         {
            return _dic[param1];
         }
         return {};
      }
      
      private function getOriginalID(param1:int) : int
      {
         return Util.getInt(_getShipObj(param1),"api_original_ship_id");
      }
      
      public function getUsePaper(param1:int) : int
      {
         return Util.getInt(_getShipObj(param1),"api_drawing_count");
      }
      
      private function getUpgradeRank(param1:int) : int
      {
         return Util.getInt(_getShipObj(param1),"api_upgrade_level");
      }
      
      public function getNextUseBullet(param1:int) : int
      {
         return DataFacade.getMasterShipData().getRemodelBull(param1);
      }
      
      public function getNextUseSteel(param1:int) : int
      {
         return DataFacade.getMasterShipData().getRemodelSteel(param1);
      }
      
      public function getNextRemodelLV(param1:int) : int
      {
         return DataFacade.getMasterShipData().getAfterLv(param1);
      }
      
      public function getNextShipId(param1:int) : int
      {
         return DataFacade.getMasterShipData().getAfterShipId(param1);
      }
      
      public function getRequireResources(param1:int) : Array
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc6_:* = 0;
         var _loc5_:* = 0;
         var _loc2_:Array = [];
         if(DataFacade.getMasterShipData().getAfterLv(param1) == 0)
         {
            _loc2_ = [[0,0,0]];
         }
         else if(_dic.hasOwnProperty(param1))
         {
            _loc3_ = _separateDic[getOriginalID(param1)];
            _loc4_ = [];
            _loc6_ = 0;
            while(_loc6_ < _loc3_.length)
            {
               if(_loc3_[_loc6_]["api_upgrade_level"] == getUpgradeRank(param1) + 1)
               {
                  _loc4_.push(_loc3_[_loc6_]["api_id"]);
               }
               _loc6_++;
            }
            _loc5_ = 0;
            while(_loc5_ < _loc4_.length)
            {
               _loc2_[_loc5_] = [getNextUseBullet(param1),getNextUseSteel(param1),getUsePaper(_loc4_[_loc5_])];
               _loc5_++;
            }
         }
         else
         {
            _loc2_[0] = [getNextUseBullet(param1),getNextUseSteel(param1),0];
         }
         
         return _loc2_;
      }
   }
}
