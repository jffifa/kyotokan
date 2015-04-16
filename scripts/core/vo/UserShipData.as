package vo
{
   import common.models.UserSlotitemObject;
   import common.util.Util;
   import flash.utils.ByteArray;
   
   public class UserShipData extends BaseData
   {
      
      public function UserShipData(param1:Object)
      {
         _obj = {};
         super();
         _obj = param1;
         _obj["api_stype"] = DataFacade.getMasterShipData().getShipType(getCharaID());
         _obj["hp_rate"] = (getNowHp()) / getMaxHp();
      }
      
      private var _obj:Object;
      
      public function isInDeck() : int
      {
         var _loc6_:* = 0;
         var _loc4_:* = null;
         var _loc5_:* = 0;
         var _loc3_:* = null;
         var _loc2_:UserDeckData = DataFacade.getUserDeckData();
         var _loc1_:* = -1;
         _loc6_ = 1;
         while(_loc6_ <= _loc2_.deckCount)
         {
            _loc4_ = _loc2_.getShipDataInDeck(_loc6_);
            _loc5_ = 0;
            while(_loc5_ < 6)
            {
               _loc3_ = _loc4_[_loc5_];
               if(_loc3_ != null)
               {
                  if(_loc3_.getShipID() == getShipID())
                  {
                     _loc1_ = _loc6_;
                     if(_loc6_ == 1 && _loc5_ == 0)
                     {
                        _loc1_ = 0;
                     }
                     break;
                  }
               }
               _loc5_++;
            }
            _loc6_++;
         }
         return _loc1_;
      }
      
      public function getName() : String
      {
         return DataFacade.getMasterShipData().getName(getCharaID());
      }
      
      public function getYomi() : String
      {
         return DataFacade.getMasterShipData().getYomi(getCharaID());
      }
      
      public function getFuelMax() : int
      {
         return DataFacade.getMasterShipData().getFuelMax(getCharaID());
      }
      
      public function getAmmoMax() : int
      {
         return DataFacade.getMasterShipData().getAmmoMax(getCharaID());
      }
      
      public function getSlotCount() : int
      {
         return DataFacade.getMasterShipData().getSlotNum(getCharaID());
      }
      
      public function getTousai() : int
      {
         return DataFacade.getMasterShipData().getTousai(getCharaID());
      }
      
      public function getSpeed() : int
      {
         return DataFacade.getMasterShipData().getSpeed(getCharaID());
      }
      
      public function getPowupParam() : Array
      {
         var _loc1_:Array = DataFacade.getMasterShipData().getPowUp(getCharaID()).concat();
         _loc1_.push(getYomi() == "まるゆ"?1:0.0);
         return _loc1_;
      }
      
      public function getGradeUpKaryokuMax() : int
      {
         return DataFacade.getMasterShipData().getGradeUpMax(getCharaID())[0];
      }
      
      public function getGradeUpRaisouMax() : int
      {
         return DataFacade.getMasterShipData().getGradeUpMax(getCharaID())[1];
      }
      
      public function getGradeUpTaikuuMax() : int
      {
         return DataFacade.getMasterShipData().getGradeUpMax(getCharaID())[2];
      }
      
      public function getGradeUpSoukouMax() : int
      {
         return DataFacade.getMasterShipData().getGradeUpMax(getCharaID())[3];
      }
      
      public function getGradeUpLuckMax() : int
      {
         return _getArray(_obj,"api_lucky",[0,0])[1];
      }
      
      public function getBacks() : int
      {
         return DataFacade.getMasterShipData().getBacks(getCharaID());
      }
      
      public function getCharaID() : int
      {
         return _getInt(_obj,"api_ship_id");
      }
      
      public function getShipID() : int
      {
         return _getInt(_obj,"api_id");
      }
      
      public function getLevel() : int
      {
         return _getInt(_obj,"api_lv");
      }
      
      public function getSortNo() : int
      {
         return _getInt(_obj,"api_sortno");
      }
      
      public function getExp() : int
      {
         return _getArray(_obj,"api_exp")[2];
      }
      
      public function getShipType() : int
      {
         return _getInt(_obj,"api_stype");
      }
      
      public function getShipTypeName() : String
      {
         return DataFacade.getMasterShipData().getShipTypeName(getCharaID());
      }
      
      public function getMaxHp() : int
      {
         return _getInt(_obj,"api_maxhp");
      }
      
      public function getNowHp() : int
      {
         return _getInt(_obj,"api_nowhp");
      }
      
      public function getFuel() : int
      {
         return _getInt(_obj,"api_fuel");
      }
      
      public function getAmmo() : int
      {
         return _getInt(_obj,"api_bull");
      }
      
      public function getTired() : int
      {
         return _getInt(_obj,"api_cond");
      }
      
      public function getTaikyu() : int
      {
         return _getInt(_obj,"api_maxhp");
      }
      
      public function getSlotItemMemberIDs() : Array
      {
         return _getArray(_obj,"api_slot").concat();
      }
      
      public function getSlotItemMasterIDs() : Array
      {
         var _loc4_:* = 0;
         var _loc1_:* = 0;
         var _loc3_:Array = [];
         var _loc2_:UserSlotItemData = DataFacade.getUserSlotItemData();
         var _loc5_:Array = getSlotItemMemberIDs();
         _loc4_ = 0;
         while(_loc4_ < getSlotCount())
         {
            _loc1_ = _loc2_.getItemID(_loc5_[_loc4_]);
            _loc3_.push(_loc1_);
            _loc4_++;
         }
         return _loc3_;
      }
      
      public function equipedLockedSlotitem() : Boolean
      {
         var _loc4_:* = 0;
         var _loc3_:* = 0;
         var _loc2_:* = null;
         var _loc1_:Array = getSlotItemMemberIDs();
         _loc4_ = 0;
         while(_loc4_ < _loc1_.length)
         {
            _loc3_ = _loc1_[_loc4_];
            _loc2_ = DataFacade.getUserSlotItemData().getItemData(_loc3_);
            if(!(_loc2_ == null) && (_loc2_.isLocked()))
            {
               return true;
            }
            _loc4_++;
         }
         return false;
      }
      
      public function getOnSlot() : Array
      {
         return _getArray(_obj,"api_onslot").concat();
      }
      
      public function getStarRate() : int
      {
         return _getInt(_obj,"api_srate") + 1;
      }
      
      public function getKaryoku() : int
      {
         return _getArray(_obj,"api_karyoku",[0,0])[0];
      }
      
      public function getKaryokuMax() : int
      {
         return _getArray(_obj,"api_karyoku",[0,0])[1];
      }
      
      public function getRaisou() : int
      {
         return _getArray(_obj,"api_raisou",[0,0])[0];
      }
      
      public function getTaiku() : int
      {
         return _getArray(_obj,"api_taiku",[0,0])[0];
      }
      
      public function getSoukou() : int
      {
         return _getArray(_obj,"api_soukou",[0,0])[0];
      }
      
      public function getKaihi() : int
      {
         return _getArray(_obj,"api_kaihi",[0,0])[0];
      }
      
      public function getTaisen() : int
      {
         return _getArray(_obj,"api_taisen",[0,0])[0];
      }
      
      public function getSakuteki() : int
      {
         return _getArray(_obj,"api_sakuteki",[0,0])[0];
      }
      
      public function getShatei() : int
      {
         return _getInt(_obj,"api_leng");
      }
      
      public function getLucky() : int
      {
         return _getArray(_obj,"api_lucky",[0,0])[0];
      }
      
      public function getLuckyMax() : int
      {
         return _getArray(_obj,"api_lucky",[0,0])[1];
      }
      
      public function isLocked() : Boolean
      {
         return _getInt(_obj,"api_locked") == 1;
      }
      
      public function isEquipLockedItem() : Boolean
      {
         return _getInt(_obj,"api_locked_equip") == 1;
      }
      
      public function getAfterLv() : int
      {
         return DataFacade.getMasterShipUpgradeData().getNextRemodelLV(_obj["api_ship_id"]);
      }
      
      public function getAfterShipId() : int
      {
         return DataFacade.getMasterShipUpgradeData().getNextShipId(_obj["api_ship_id"]);
      }
      
      public function getGradeUpKaryoku() : int
      {
         return _getArray(_obj,"api_kyouka",[0,0,0,0,0])[0];
      }
      
      public function getGradeUpRaisou() : int
      {
         return _getArray(_obj,"api_kyouka",[0,0,0,0,0])[1];
      }
      
      public function getGradeUpTaikuu() : int
      {
         return _getArray(_obj,"api_kyouka",[0,0,0,0,0])[2];
      }
      
      public function getGradeUpSoukou() : int
      {
         return _getArray(_obj,"api_kyouka",[0,0,0,0,0])[3];
      }
      
      public function getGradeUpLuck() : int
      {
         return _getArray(_obj,"api_kyouka",[0,0,0,0,0])[4];
      }
      
      public function getRepairFuel() : int
      {
         return _getArray(_obj,"api_ndock_item",[0,0])[0];
      }
      
      public function getRepairSteel() : int
      {
         return _getArray(_obj,"api_ndock_item",[0,0])[1];
      }
      
      public function getRepairTime() : int
      {
         return _getInt(_obj,"api_ndock_time",0);
      }
      
      public function isInRepairDock() : Boolean
      {
         return DataFacade.getRepairDockData().isInDock(getShipID());
      }
      
      public function getGrowMax() : Array
      {
         var _loc1_:Array = new Array(7);
         _loc1_[0] = getGradeUpKaryoku() >= getGradeUpKaryokuMax();
         _loc1_[1] = getGradeUpRaisou() >= getGradeUpRaisouMax();
         _loc1_[2] = getGradeUpTaikuu() >= getGradeUpTaikuuMax();
         _loc1_[3] = getGradeUpSoukou() >= getGradeUpSoukouMax();
         _loc1_[4] = _getArray(_obj,"api_lucky",[0,0])[1] - getLucky() == 0;
         _loc1_[5] = _loc1_[0] && _loc1_[1] && _loc1_[2] && _loc1_[3];
         _loc1_[6] = _loc1_[4] && _loc1_[5];
         return _loc1_;
      }
      
      public function isInMission() : Boolean
      {
         var _loc1_:* = 0;
         var _loc2_:int = isInDeck();
         if(_loc2_ == -1)
         {
            return false;
         }
         _loc1_ = DataFacade.getUserDeckData().missionManager.getMissionID(_loc2_);
         return !(_loc1_ == 0);
      }
      
      public function getMaterialBYBroken() : Array
      {
         var _loc5_:* = 0;
         var _loc3_:* = 0;
         var _loc2_:UserSlotItemData = DataFacade.getUserSlotItemData();
         var _loc4_:Array = DataFacade.getMasterShipData().getBroken(getCharaID());
         var _loc1_:Array = getSlotItemMemberIDs();
         _loc5_ = 0;
         while(_loc5_ < _loc1_.length)
         {
            if(_loc1_[_loc5_] != -1)
            {
               _loc3_ = _loc1_[_loc5_];
               var _loc6_:* = 0;
               var _loc7_:* = _loc4_[_loc6_] + _loc2_.getFuelFromBroken(_loc3_);
               _loc4_[_loc6_] = _loc7_;
               _loc7_ = 1;
               _loc6_ = _loc4_[_loc7_] + _loc2_.getAmmoFromBroken(_loc3_);
               _loc4_[_loc7_] = _loc6_;
               _loc6_ = 2;
               _loc7_ = _loc4_[_loc6_] + _loc2_.getSteelFromBroken(_loc3_);
               _loc4_[_loc6_] = _loc7_;
               _loc7_ = 3;
               _loc6_ = _loc4_[_loc7_] + _loc2_.getBauxFromBroken(_loc3_);
               _loc4_[_loc7_] = _loc6_;
            }
            _loc5_++;
         }
         return _loc4_;
      }
      
      public function isEquip(param1:int) : Boolean
      {
         return !(getSlotItemMemberIDs().indexOf(param1) == -1);
      }
      
      public function get isTaiha() : Boolean
      {
         return Util.isTaiha(getNowHp(),getMaxHp());
      }
      
      public function get isDamaged() : Boolean
      {
         return Util.isDamaged(getCondition());
      }
      
      public function getPlate() : int
      {
         return _getInt(_obj,"api_sally_area");
      }
      
      public function getCondition() : int
      {
         return Util.getCondition(getNowHp(),getMaxHp());
      }
      
      public function getIconType() : int
      {
         return DataFacade.getMasterShipData().getIconType(getCharaID());
      }
      
      public function hasMission() : Boolean
      {
         var _loc1_:* = 0;
         var _loc2_:int = isInDeck();
         if(_loc2_ != -1)
         {
            _loc1_ = DataFacade.getUserDeckData().missionManager.getMissionID(_loc2_);
            return !(_loc1_ == 0);
         }
         return false;
      }
      
      public function cloneOriginalObject() : Object
      {
         var _loc1_:ByteArray = new ByteArray();
         _loc1_.writeObject(_obj);
         _loc1_.position = 0;
         return _loc1_.readObject();
      }
      
      public function toString() : String
      {
         return getName();
      }
      
      function __setFuel(param1:int) : void
      {
         _obj["api_fuel"] = param1;
      }
      
      function __setAmmo(param1:int) : void
      {
         _obj["api_bull"] = param1;
      }
      
      function __setNowHP(param1:int) : void
      {
         _obj["api_nowhp"] = param1;
         _obj["hp_rate"] = (getNowHp()) / getMaxHp();
      }
      
      function __setRepairItems(param1:int, param2:int) : void
      {
         _obj["api_ndock_item"] = [param1,param2];
      }
      
      function __setRepairTime(param1:int) : void
      {
         _obj["api_ndock_time"] = param1;
      }
      
      function __setTired(param1:int) : void
      {
         _obj["api_cond"] = param1;
      }
      
      function __setSlotItems(param1:Array) : void
      {
         _obj["api_slot"] = param1;
      }
      
      function __setOnSlot(param1:Array) : Array
      {
         var _loc2_:* = param1;
         _obj["api_onslot"] = _loc2_;
         return _loc2_;
      }
      
      function __setLocked(param1:int) : void
      {
         _obj["api_locked"] = param1;
      }
   }
}
