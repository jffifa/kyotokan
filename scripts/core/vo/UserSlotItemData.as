package vo
{
   import flash.utils.Dictionary;
   import common.models.UserSlotitemObject;
   import common.util.Util;
   
   public class UserSlotItemData extends Object
   {
      
      public function UserSlotItemData()
      {
         super();
         _dic = new Dictionary();
         _unEquipedDic = new Dictionary();
      }
      
      private var _dic:Dictionary;
      
      private var _unEquipedDic:Dictionary;
      
      public function get itemCount() : int
      {
         return __getItemCount();
      }
      
      public function get vacancyCount() : int
      {
         var _loc1_:int = DataFacade.getUserData().getMaxSlotItemCount();
         return _loc1_ - itemCount;
      }
      
      public function setData(param1:Array) : void
      {
         var _loc4_:* = 0;
         var _loc2_:* = null;
         var _loc3_:* = 0;
         _dic = new Dictionary();
         _loc4_ = 0;
         while(_loc4_ < param1.length)
         {
            _loc2_ = {};
            _loc2_ = param1[_loc4_];
            _loc3_ = _loc2_["api_id"];
            _dic[_loc3_] = _loc2_;
            _loc4_++;
         }
      }
      
      public function setUnEquipedData(param1:Object) : void
      {
         _unEquipedDic = new Dictionary();
         var _loc4_:* = 0;
         var _loc3_:* = param1;
         for(var _loc2_ in param1)
         {
            _unEquipedDic[_loc2_] = param1[_loc2_];
         }
      }
      
      public function getItemData(param1:int) : UserSlotitemObject
      {
         if(_dic.hasOwnProperty(param1))
         {
            return new UserSlotitemObject(_dic[param1]);
         }
         return null;
      }
      
      public function getItemID(param1:int) : int
      {
         if(_dic.hasOwnProperty(param1))
         {
            return _dic[param1]["api_slotitem_id"];
         }
         return 0;
      }
      
      public function isLocked(param1:int) : Boolean
      {
         return Util.getInt(_getItemData(param1),"api_locked",0) == 1;
      }
      
      public function getName(param1:int) : String
      {
         var _loc3_:int = getItemID(param1);
         var _loc2_:MasterSlotItemData = DataFacade.getMasterSlotItemData();
         return _loc2_.getName(_loc3_);
      }
      
      public function getSlotItemCardType(param1:int) : int
      {
         var _loc3_:int = getItemID(param1);
         var _loc2_:MasterSlotItemData = DataFacade.getMasterSlotItemData();
         return _loc2_.getSlotItemCardType(_loc3_);
      }
      
      public function getSlotItemEquipType(param1:int) : int
      {
         var _loc3_:int = getItemID(param1);
         var _loc2_:MasterSlotItemData = DataFacade.getMasterSlotItemData();
         return _loc2_.getSlotItemEquipType(_loc3_);
      }
      
      public function getSlotItemIconType(param1:int) : int
      {
         var _loc3_:int = getItemID(param1);
         var _loc2_:MasterSlotItemData = DataFacade.getMasterSlotItemData();
         return _loc2_.getSlotItemIconType(_loc3_);
      }
      
      public function getFuelFromBroken(param1:int) : int
      {
         var _loc3_:int = getItemID(param1);
         var _loc2_:MasterSlotItemData = DataFacade.getMasterSlotItemData();
         return _loc2_.getFuelFromBroken(_loc3_);
      }
      
      public function getAmmoFromBroken(param1:int) : int
      {
         var _loc3_:int = getItemID(param1);
         var _loc2_:MasterSlotItemData = DataFacade.getMasterSlotItemData();
         return _loc2_.getAmmoFromBroken(_loc3_);
      }
      
      public function getSteelFromBroken(param1:int) : int
      {
         var _loc3_:int = getItemID(param1);
         var _loc2_:MasterSlotItemData = DataFacade.getMasterSlotItemData();
         return _loc2_.getSteelFromBroken(_loc3_);
      }
      
      public function getBauxFromBroken(param1:int) : int
      {
         var _loc3_:int = getItemID(param1);
         var _loc2_:MasterSlotItemData = DataFacade.getMasterSlotItemData();
         return _loc2_.getBauxFromBroken(_loc3_);
      }
      
      public function getRarity(param1:int) : int
      {
         var _loc3_:int = getItemID(param1);
         var _loc2_:MasterSlotItemData = DataFacade.getMasterSlotItemData();
         return _loc2_.getRarity(_loc3_);
      }
      
      public function getSyatei(param1:int) : int
      {
         var _loc3_:int = getItemID(param1);
         var _loc2_:MasterSlotItemData = DataFacade.getMasterSlotItemData();
         return _loc2_.getSyatei(_loc3_);
      }
      
      public function getKaryoku(param1:int) : int
      {
         var _loc3_:int = getItemID(param1);
         var _loc2_:MasterSlotItemData = DataFacade.getMasterSlotItemData();
         return _loc2_.getKaryoku(_loc3_);
      }
      
      public function getRaisou(param1:int) : int
      {
         var _loc3_:int = getItemID(param1);
         var _loc2_:MasterSlotItemData = DataFacade.getMasterSlotItemData();
         return _loc2_.getRaisou(_loc3_);
      }
      
      public function getTaikuu(param1:int) : int
      {
         var _loc3_:int = getItemID(param1);
         var _loc2_:MasterSlotItemData = DataFacade.getMasterSlotItemData();
         return _loc2_.getTaikuu(_loc3_);
      }
      
      public function getTaisen(param1:int) : int
      {
         var _loc3_:int = getItemID(param1);
         var _loc2_:MasterSlotItemData = DataFacade.getMasterSlotItemData();
         return _loc2_.getTaisen(_loc3_);
      }
      
      public function getBakusou(param1:int) : int
      {
         var _loc3_:int = getItemID(param1);
         var _loc2_:MasterSlotItemData = DataFacade.getMasterSlotItemData();
         return _loc2_.getBakusou(_loc3_);
      }
      
      public function getMeichu(param1:int) : int
      {
         var _loc3_:int = getItemID(param1);
         var _loc2_:MasterSlotItemData = DataFacade.getMasterSlotItemData();
         return _loc2_.getMeichu(_loc3_);
      }
      
      public function getKaihi(param1:int) : int
      {
         var _loc3_:int = getItemID(param1);
         var _loc2_:MasterSlotItemData = DataFacade.getMasterSlotItemData();
         return _loc2_.getKaihi(_loc3_);
      }
      
      public function getSakuteki(param1:int) : int
      {
         var _loc3_:int = getItemID(param1);
         var _loc2_:MasterSlotItemData = DataFacade.getMasterSlotItemData();
         return _loc2_.getSakuteki(_loc3_);
      }
      
      public function getSoukou(param1:int) : int
      {
         var _loc3_:int = getItemID(param1);
         var _loc2_:MasterSlotItemData = DataFacade.getMasterSlotItemData();
         return _loc2_.getSoukou(_loc3_);
      }
      
      public function getDetailText(param1:int, param2:String = "", param3:String = "", param4:Boolean = true) : String
      {
         var _loc9_:* = 0;
         var _loc6_:* = null;
         var _loc5_:Array = [];
         if(getSyatei(param1) > 0 && (param4))
         {
            _loc5_.push("射程 " + ["","短","中","長","超長"][getSyatei(param1)]);
         }
         var _loc7_:Array = ["火力","雷装","対空","対潜","爆装","命中","回避","索敵","装甲"];
         var _loc8_:Array = [getKaryoku(param1),getRaisou(param1),getTaikuu(param1),getTaisen(param1),getBakusou(param1),getMeichu(param1),getKaihi(param1),getSakuteki(param1),getSoukou(param1)];
         _loc9_ = 0;
         while(_loc9_ < _loc8_.length)
         {
            if(_loc8_[_loc9_] != 0)
            {
               _loc6_ = param2;
               if(_loc8_[_loc9_] < 0)
               {
                  _loc6_ = param2.split("+").join("");
               }
               _loc5_.push(_loc7_[_loc9_] + _loc6_ + _loc8_[_loc9_]);
            }
            _loc9_++;
         }
         return _loc5_.join(param3);
      }
      
      public function getUnEquipedSlotitems(... rest) : Array
      {
         var _loc2_:* = null;
         var _loc4_:* = 0;
         var _loc3_:* = null;
         if(rest == null || rest.length == 0)
         {
            return getUnEquipedSlotitems.apply(null,DataFacade.getMasterSlotItemData().getEquipTypeIDs());
         }
         _loc2_ = [];
         _loc4_ = 0;
         while(_loc4_ < rest.length)
         {
            _loc3_ = _getUnEquipedSlotitems(rest[_loc4_]);
            _loc2_ = _loc2_.concat(_loc3_);
            _loc4_++;
         }
         return _loc2_;
      }
      
      private function _getItemData(param1:int) : Object
      {
         if(_dic.hasOwnProperty(param1))
         {
            return _dic[param1];
         }
         return {};
      }
      
      private function _getUnEquipedSlotitems(param1:int) : Array
      {
         var _loc2_:String = "api_slottype" + param1;
         if(_unEquipedDic.hasOwnProperty(_loc2_))
         {
            if(_unEquipedDic[_loc2_] == -1)
            {
               return [];
            }
            return _unEquipedDic[_loc2_];
         }
         return [];
      }
      
      function __updateItem(param1:int, param2:Object) : void
      {
         _dic[param1] = param2;
      }
      
      function __updateUnsetList(param1:int, param2:Array) : void
      {
         _unEquipedDic["api_slottype" + param1] = param2;
      }
      
      function __removeItem(param1:int) : void
      {
         var _loc3_:int = getSlotItemEquipType(param1);
         var _loc2_:Array = _getUnEquipedSlotitems(_loc3_);
         if(_loc2_.indexOf(param1) != -1)
         {
            _loc2_.splice(_loc2_.indexOf(param1),1);
         }
         if(_dic.hasOwnProperty(param1))
         {
            delete _dic[param1];
            true;
         }
      }
      
      function __getItemCount() : int
      {
         var _loc1_:* = 0;
         var _loc4_:* = 0;
         var _loc3_:* = _dic;
         for(var _loc2_ in _dic)
         {
            _loc1_++;
         }
         return _loc1_;
      }
      
      function __setSlotitemLockCondition(param1:int, param2:int) : void
      {
         _dic[param1]["api_locked"] = param2;
      }
   }
}
