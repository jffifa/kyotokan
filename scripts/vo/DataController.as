package vo
{
   import common.debug.Debug;
   import dto.SupplyDTO;
   import flash.events.Event;
   import dto.RepairDockDTO;
   import common.util.Util;
   import dto.FurnitureDTO;
   
   public class DataController extends Object
   {
      
      public function DataController()
      {
         super();
      }
      
      public static function updateTutorialProgress(param1:int) : void
      {
         DataFacade.getUserData().__setTutorialProgress(param1);
      }
      
      public static function addShipToDeck(param1:int, param2:int) : void
      {
         var _loc3_:* = 0;
         var _loc6_:UserDeckData = DataFacade.getUserDeckData();
         var _loc5_:Array = _loc6_.__getDeck(param1);
         var _loc4_:UserShipData = _loc6_.getShipData(param2);
         var _loc7_:int = _loc4_.isInDeck();
         if(_loc7_ > -1)
         {
            if(_loc7_ == 0)
            {
               _loc7_ = 1;
            }
            _loc3_ = _loc6_.getShipPos(_loc7_,param2);
            if(_loc7_ != param1)
            {
               deleteShipFromDeck(_loc7_,_loc3_);
            }
         }
         _loc5_[_loc6_.getShipCountInDeck(param1)] = param2;
         if(_loc7_ == param1)
         {
            deleteShipFromDeck(_loc7_,_loc3_);
         }
         else
         {
            _loc6_.__setDeck(param1,_loc5_);
         }
      }
      
      public static function deleteShipFromDeck(param1:int, param2:int) : void
      {
         var _loc6_:* = 0;
         var _loc5_:UserDeckData = DataFacade.getUserDeckData();
         var _loc4_:Array = _loc5_.__getDeck(param1);
         _loc4_[param2] = null;
         var _loc3_:Array = [];
         _loc6_ = 0;
         while(_loc6_ < 6)
         {
            if(_loc4_[_loc6_] != null)
            {
               _loc3_.push(_loc4_[_loc6_]);
            }
            _loc6_++;
         }
         _loc4_ = [];
         _loc4_ = _loc3_;
         while(_loc4_.length < 6)
         {
            _loc4_.push(null);
         }
         _loc5_.__setDeck(param1,_loc4_);
      }
      
      public static function changeShipInDeck(param1:int, param2:int, param3:int) : void
      {
         var _loc4_:* = 0;
         var _loc5_:* = null;
         var _loc9_:UserDeckData = DataFacade.getUserDeckData();
         var _loc8_:Array = _loc9_.__getDeck(param1);
         Debug.log("変更前　->　" + _loc8_.toString());
         var _loc7_:UserShipData = _loc9_.getShipData(param3);
         var _loc6_:int = _loc8_[param2];
         var _loc10_:int = _loc7_.isInDeck();
         if(_loc10_ > -1)
         {
            if(_loc10_ == 0)
            {
               _loc10_ = 1;
            }
            _loc4_ = _loc9_.getShipPos(_loc10_,param3);
            _loc5_ = _loc9_.__getDeck(_loc10_);
            _loc5_[_loc4_] = _loc6_;
            _loc9_.__setDeck(_loc10_,_loc5_);
         }
         _loc8_[param2] = param3;
         _loc9_.__setDeck(param1,_loc8_);
         Debug.log("変更後　->　" + _loc9_.__getDeck(param1).toString());
      }
      
      public static function updateDeckName(param1:int, param2:String) : void
      {
         var _loc3_:UserDeckData = DataFacade.getUserDeckData();
         _loc3_.__setDeckName(param1,param2);
      }
      
      public static function changeLockCondition(param1:int, param2:int) : void
      {
         var _loc3_:UserShipData = DataFacade.getUserDeckData().getShipData(param1);
         _loc3_.__setLocked(param2);
      }
      
      public static function supply(param1:SupplyDTO) : void
      {
         var _loc9_:* = 0;
         var _loc2_:* = 0;
         var _loc6_:* = 0;
         var _loc8_:* = 0;
         var _loc7_:* = null;
         var _loc5_:* = null;
         var _loc3_:UserDeckData = DataFacade.getUserDeckData();
         _loc9_ = 0;
         while(_loc9_ < param1.getShipCount())
         {
            _loc2_ = param1.getShipID(_loc9_);
            _loc6_ = param1.getShipFuel(_loc9_);
            _loc8_ = param1.getShipAmmo(_loc9_);
            _loc7_ = param1.getShipOnSlot(_loc9_);
            _loc5_ = _loc3_.getShipData(_loc2_);
            _loc5_.__setFuel(_loc6_);
            _loc5_.__setAmmo(_loc8_);
            _loc5_.__setOnSlot(_loc7_);
            _loc9_++;
         }
         var _loc4_:UseItemData = DataFacade.getUseItemData();
         _loc4_.__setCount(31,param1.fuel);
         _loc4_.__setCount(32,param1.ammo);
         _loc4_.__setCount(33,param1.steel);
         _loc4_.__setCount(34,param1.baux);
         _loc4_.dispatchEvent(new Event("EVENT_CHANGE"));
         if(param1.useBaux())
         {
            _loc4_.dispatchEvent(new Event("EVENT_USE_BAUXITE_AT_SUPPLY"));
         }
      }
      
      public static function remodelEatShips(param1:int, param2:Vector.<UserShipData>) : void
      {
         var _loc3_:* = 0;
         _loc3_ = 0;
         while(_loc3_ < param1)
         {
            arsenalBreakship(param2[_loc3_]);
            _loc3_++;
         }
      }
      
      public static function remodelUpdateShipData(param1:Object, param2:Array) : void
      {
         var _loc3_:UserDeckData = DataFacade.getUserDeckData();
         _loc3_.setShipDataOneShip(param1);
         _loc3_.setDeckData(param2);
      }
      
      public static function remodelUpdateRecipeCount(param1:int) : void
      {
         var _loc2_:UseItemData = DataFacade.getUseItemData();
         var _loc3_:int = _loc2_.getCount(58);
         trace("num = " + _loc3_ + " " + param1);
         _loc2_.__setCount(58,_loc3_ - param1);
      }
      
      public static function changeSlotitemLockCondition(param1:int, param2:int) : void
      {
         DataFacade.getUserSlotItemData().__setSlotitemLockCondition(param1,param2);
      }
      
      public static function openRepairDock() : void
      {
         var _loc5_:* = 0;
         var _loc2_:* = null;
         var _loc3_:UseItemData = DataFacade.getUseItemData();
         var _loc1_:Boolean = _loc3_.__useRepairDockKey();
         if(!_loc1_)
         {
            throw new Error("Failed Repair Dock Open.");
         }
         else
         {
            var _loc4_:UserRepairDockData = DataFacade.getRepairDockData();
            _loc5_ = 0;
            while(_loc5_ < _loc4_.dockNum)
            {
               _loc2_ = _loc4_.getDock(_loc5_);
               if(!_loc2_.isDockOpen())
               {
                  _loc4_.__setState(_loc5_,0);
                  break;
               }
               _loc5_++;
            }
            return;
         }
      }
      
      public static function useMaterialAtRepair(param1:UserShipData, param2:Boolean) : void
      {
         var _loc3_:UseItemData = DataFacade.getUseItemData();
         _loc3_.__useItem(31,param1.getRepairFuel());
         _loc3_.__useItem(33,param1.getRepairSteel());
         if(param2)
         {
            useRepairKit(_loc3_);
         }
         _loc3_.dispatchEvent(new Event("EVENT_CHANGE"));
      }
      
      public static function useRepairKit(param1:UseItemData = null) : void
      {
         if(param1 == null)
         {
            var param1:UseItemData = DataFacade.getUseItemData();
         }
         param1.__useItem(1,1);
      }
      
      public static function repair(param1:UserShipData, param2:int = 100) : void
      {
         param1.__setNowHP(param1.getMaxHp());
         param1.__setRepairItems(0,0);
         param1.__setRepairTime(0);
         if(param1.getTired() < 40)
         {
            param1.__setTired(40);
         }
      }
      
      public static function outRepairDock(param1:int) : void
      {
         var _loc2_:UserRepairDockData = DataFacade.getRepairDockData();
         _loc2_.__setState(param1,0);
         _loc2_.__setShipID(param1,-1);
         _loc2_.__setCompleteTime(param1,0);
      }
      
      public static function useBuildKit(param1:int, param2:UseItemData = null) : void
      {
         if(param2 == null)
         {
            var param2:UseItemData = DataFacade.getUseItemData();
         }
         param2.__useItem(2,param1);
      }
      
      public static function useKeyWithOpenArsenalDock() : void
      {
         var _loc2_:UseItemData = DataFacade.getUseItemData();
         var _loc1_:Boolean = _loc2_.__useRepairDockKey();
         if(!_loc1_)
         {
            throw new Error("Failed Repair Dock Open.");
         }
         else
         {
            return;
         }
      }
      
      public static function arsenalBuild(param1:Object, param2:Array) : void
      {
         var _loc5_:* = 0;
         var _loc4_:* = null;
         DataFacade.getUserDeckData().__addShip(param1);
         var _loc3_:UserSlotItemData = DataFacade.getUserSlotItemData();
         _loc5_ = 0;
         while(_loc5_ < param2.length)
         {
            _loc4_ = param2[_loc5_];
            _loc3_.__updateItem(_loc4_["api_id"],_loc4_);
            _loc5_++;
         }
         AppFacade.portMain.updateUpperBar();
      }
      
      public static function arsenalBreakship(param1:UserShipData) : void
      {
         var _loc7_:* = 0;
         var _loc6_:* = 0;
         var _loc4_:* = 0;
         var _loc3_:UserSlotItemData = DataFacade.getUserSlotItemData();
         var _loc5_:Array = param1.getSlotItemMemberIDs();
         _loc7_ = 0;
         while(_loc7_ < _loc5_.length)
         {
            _loc3_.__removeItem(_loc5_[_loc7_]);
            _loc7_++;
         }
         var _loc2_:UserDeckData = DataFacade.getUserDeckData();
         if(param1.isInDeck() >= 0)
         {
            _loc6_ = param1.isInDeck();
            _loc4_ = _loc2_.getShipPos(_loc6_,param1.getShipID());
            DataController.deleteShipFromDeck(_loc6_,_loc4_);
         }
         _loc2_.__removeShip(param1);
         AppFacade.portMain.updateUpperBar();
      }
      
      public static function arsenalDevelop(param1:int, param2:Object, param3:int, param4:Array) : void
      {
         var _loc5_:UserSlotItemData = DataFacade.getUserSlotItemData();
         if(!(param1 == -1) && !(param2 == null))
         {
            _loc5_.__updateItem(param1,param2);
         }
         if(!(param3 == -1) && !(param4 == null))
         {
            _loc5_.__updateUnsetList(param3,param4);
         }
      }
      
      public static function arsenalAbolish(param1:Array, param2:Array) : void
      {
         var _loc5_:* = 0;
         var _loc3_:UserSlotItemData = DataFacade.getUserSlotItemData();
         _loc5_ = 0;
         while(_loc5_ < param1.length)
         {
            _loc3_.__removeItem(param1[_loc5_]);
            _loc5_++;
         }
         var _loc4_:UseItemData = DataFacade.getUseItemData();
         _loc4_.__useItem(31,-param2[0]);
         _loc4_.__useItem(32,-param2[1]);
         _loc4_.__useItem(33,-param2[2]);
         _loc4_.__useItem(34,-param2[3]);
         _loc4_.dispatchEvent(new Event("EVENT_CHANGE"));
      }
      
      public static function revampSlotitem(param1:Object, param2:Array) : void
      {
         var _loc4_:* = 0;
         var _loc5_:* = 0;
         var _loc3_:UserSlotItemData = DataFacade.getUserSlotItemData();
         if(param1 != null)
         {
            _loc4_ = Util.getInt(param1,"api_id");
            _loc3_.__updateItem(_loc4_,param1);
         }
         _loc5_ = 0;
         while(_loc5_ < param2.length)
         {
            _loc3_.__removeItem(param2[_loc5_]);
            _loc5_++;
         }
      }
      
      public static function usePayItem(param1:int, param2:Object) : void
      {
         var _loc3_:* = null;
         var _loc7_:* = null;
         var _loc4_:* = 0;
         var _loc6_:* = 0;
         var _loc5_:* = 0;
         if(param2 != null)
         {
            _loc3_ = "使用効果：";
            _loc7_ = DataFacade.getUseItemData();
            var _loc10_:* = 0;
            var _loc9_:* = param2;
            for(var _loc8_ in param2)
            {
               _loc4_ = parseInt(_loc8_);
               _loc6_ = param2[_loc4_];
               if(_loc6_ != 0)
               {
                  _loc3_ = _loc3_ + (_loc7_.getName(_loc4_) + (_loc6_ > 0?"+":"-") + _loc6_);
                  _loc5_ = _loc7_.getCount(_loc4_);
                  _loc7_.__setCount(_loc4_,_loc5_ + _loc6_);
                  _loc3_ = _loc3_ + (" " + _loc5_ + "->" + (_loc5_ + _loc6_) + "  ");
               }
            }
            Debug.log(_loc3_);
         }
      }
      
      public static function buyFurniture(param1:FurnitureDTO) : void
      {
         var _loc3_:UseItemData = DataFacade.getUseItemData();
         if(param1.isNeedSpecialCraftsman())
         {
            _loc3_.__useItem(52);
         }
         _loc3_.__useItem(44,param1.price);
         var _loc2_:UserFurnitureData = DataFacade.getUserFurnitureData();
         _loc2_.__addData(param1.furnitureType,param1.furnitureID,param1.furnitureNo);
      }
      
      public static function useYouinInTaihaMarch(param1:UserShipData) : void
      {
         var _loc7_:* = 0;
         var _loc6_:* = 0;
         var _loc4_:* = 0;
         var _loc3_:* = 0;
         param1.__setNowHP(param1.getMaxHp() * 50 / 100);
         var _loc2_:UserSlotItemData = DataFacade.getUserSlotItemData();
         var _loc5_:Array = param1.getSlotItemMemberIDs();
         _loc7_ = 0;
         while(_loc7_ < _loc5_.length)
         {
            _loc6_ = _loc5_[_loc7_];
            _loc4_ = _loc2_.getItemID(_loc6_);
            _loc3_ = 42;
            if(_loc3_ == _loc4_)
            {
               _loc5_.splice(_loc7_,1);
               _loc5_.push(-1);
               param1.__setSlotItems(_loc5_);
               _loc2_.__removeItem(_loc6_);
               return;
            }
            _loc7_++;
         }
         AppFacade.showErrorScreen("no have youin");
      }
      
      public static function useMegamiInTaihaMarch(param1:UserShipData) : void
      {
         var _loc7_:* = 0;
         var _loc5_:* = 0;
         var _loc3_:* = 0;
         var _loc6_:* = 0;
         param1.__setNowHP(param1.getMaxHp());
         var _loc2_:UserSlotItemData = DataFacade.getUserSlotItemData();
         var _loc4_:Array = param1.getSlotItemMemberIDs();
         _loc7_ = 0;
         while(_loc7_ < _loc4_.length)
         {
            _loc5_ = _loc4_[_loc7_];
            _loc3_ = _loc2_.getItemID(_loc5_);
            _loc6_ = 43;
            if(_loc6_ == _loc3_)
            {
               _loc4_.splice(_loc7_,1);
               _loc4_.push(-1);
               param1.__setSlotItems(_loc4_);
               _loc2_.__removeItem(_loc5_);
               return;
            }
            _loc7_++;
         }
         AppFacade.showErrorScreen("no have youin");
      }
   }
}
