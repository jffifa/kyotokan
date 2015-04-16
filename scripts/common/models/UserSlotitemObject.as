package common.models
{
   import common.util.Util;
   
   public class UserSlotitemObject extends Object
   {
      
      public function UserSlotitemObject(param1:Object)
      {
         super();
         _o = param1;
      }
      
      private var _o:Object;
      
      public function get mstID() : int
      {
         return Util.getInt(_o,"api_slotitem_id");
      }
      
      public function get memID() : int
      {
         return Util.getInt(_o,"api_id");
      }
      
      public function get itemName() : String
      {
         return DataFacade.getMasterSlotItemData().getName(mstID);
      }
      
      public function get level() : int
      {
         return Util.getInt(_o,"api_level");
      }
      
      public function isLocked() : Boolean
      {
         return Util.getInt(_o,"api_locked",0) == 1;
      }
      
      public function get cardType() : int
      {
         return DataFacade.getMasterSlotItemData().getSlotItemCardType(mstID);
      }
      
      public function get equipType() : int
      {
         return DataFacade.getMasterSlotItemData().getSlotItemEquipType(mstID);
      }
      
      public function get iconType() : int
      {
         return DataFacade.getMasterSlotItemData().getSlotItemIconType(mstID);
      }
      
      public function get rarity() : int
      {
         return DataFacade.getMasterSlotItemData().getRarity(mstID);
      }
      
      public function get syatei() : int
      {
         return DataFacade.getMasterSlotItemData().getSyatei(mstID);
      }
      
      public function get karyoku() : int
      {
         return DataFacade.getMasterSlotItemData().getKaryoku(mstID);
      }
      
      public function get raisou() : int
      {
         return DataFacade.getMasterSlotItemData().getRaisou(mstID);
      }
      
      public function get taikuu() : int
      {
         return DataFacade.getMasterSlotItemData().getTaikuu(mstID);
      }
      
      public function get taisen() : int
      {
         return DataFacade.getMasterSlotItemData().getTaisen(mstID);
      }
      
      public function get bakusou() : int
      {
         return DataFacade.getMasterSlotItemData().getBakusou(mstID);
      }
      
      public function get meichu() : int
      {
         return DataFacade.getMasterSlotItemData().getMeichu(mstID);
      }
      
      public function get kaihi() : int
      {
         return DataFacade.getMasterSlotItemData().getKaihi(mstID);
      }
      
      public function get sakuteki() : int
      {
         return DataFacade.getMasterSlotItemData().getSakuteki(mstID);
      }
      
      public function get soukou() : int
      {
         return DataFacade.getMasterSlotItemData().getSoukou(mstID);
      }
      
      public function detailText(param1:String = "", param2:String = "", param3:Boolean = true) : String
      {
         var _loc8_:* = 0;
         var _loc5_:* = null;
         var _loc4_:Array = [];
         if(syatei > 0 && (param3))
         {
            _loc4_.push("射程 " + ["","短","中","長","超長"][syatei]);
         }
         var _loc6_:Array = ["火力","雷装","対空","対潜","爆装","命中","回避","索敵","装甲"];
         var _loc7_:Array = [karyoku,raisou,taikuu,taisen,bakusou,meichu,kaihi,sakuteki,soukou];
         _loc8_ = 0;
         while(_loc8_ < _loc7_.length)
         {
            if(_loc7_[_loc8_] != 0)
            {
               _loc5_ = param1;
               if(_loc7_[_loc8_] < 0)
               {
                  _loc5_ = param1.split("+").join("");
               }
               _loc4_.push(_loc6_[_loc8_] + _loc5_ + _loc7_[_loc8_]);
            }
            _loc8_++;
         }
         return _loc4_.join(param2);
      }
   }
}
