package common.models.map
{
   import flash.utils.Dictionary;
   import common.models.BattleBGMObject;
   
   public class MapData extends Object
   {
      
      public function MapData()
      {
         super();
      }
      
      public static function getInfoID(param1:int, param2:int) : int
      {
         return param1 * 10 + param2;
      }
      
      private var _o:Object;
      
      private var _areaDic:Dictionary;
      
      private var _bgmDic:Dictionary;
      
      public function setMasterData(param1:Array, param2:Array, param3:Array, param4:Array) : void
      {
         var _loc7_:* = 0;
         var _loc5_:* = null;
         var _loc6_:* = null;
         _o = {};
         _o["area"] = param1;
         _o["info"] = param2;
         _o["cell"] = param3;
         _areaDic = new Dictionary();
         _loc7_ = 0;
         while(_loc7_ < param1.length)
         {
            _loc5_ = new MapAreaData(param1[_loc7_]);
            _areaDic[_loc5_.areaID] = _loc5_;
            _loc5_.setMasterData(param2,param3);
            _loc7_++;
         }
         _bgmDic = new Dictionary();
         _loc7_ = 0;
         while(_loc7_ < param4.length)
         {
            _loc6_ = new BattleBGMObject(param4[_loc7_]);
            _bgmDic[_loc6_.mapID] = _loc6_;
            _loc7_++;
         }
      }
      
      public function getAreaData(param1:int) : MapAreaData
      {
         if(_areaDic.hasOwnProperty(param1))
         {
            return _areaDic[param1];
         }
         return null;
      }
      
      public function hasArea(param1:int) : Boolean
      {
         return _areaDic.hasOwnProperty(param1);
      }
      
      public function getInfoData(param1:int) : MapInfoData
      {
         var _loc2_:int = Math.floor((param1 - 1) / 10);
         var _loc3_:int = Math.floor(param1 % 10);
         var _loc4_:MapAreaData = getAreaData(_loc2_);
         if(_loc4_ != null)
         {
            return _loc4_.getInfoData(_loc3_);
         }
         return null;
      }
      
      public function getOpenMapIDs(param1:int, param2:int) : Array
      {
         var _loc3_:* = 0;
         if(param1 == 2 && param2 == 4)
         {
            return [25,31,41];
         }
         if(param1 == 3 && param2 == 4)
         {
            if(DataFacade.getMapData().getInfoData(44).isClear())
            {
               return [35,51];
            }
            return [35];
         }
         if(param1 == 26 && param2 == 3)
         {
            return [];
         }
         var _loc5_:Array = [];
         var _loc4_:int = getInfoID(param1,param2 + 1);
         if(getInfoData(_loc4_) != null)
         {
            _loc5_.push(_loc4_);
         }
         if(param2 == 4)
         {
            _loc3_ = getInfoID(param1 + 1,1);
            if(getInfoData(_loc3_) != null)
            {
               _loc5_.push(_loc3_);
            }
         }
         return _loc5_;
      }
      
      public function getBGMObj(param1:int, param2:int) : BattleBGMObject
      {
         if(param1 == 0 && param2 == 0)
         {
            var param1:* = 1;
            var param2:* = 1;
         }
         var _loc3_:int = getInfoID(param1,param2);
         if(_bgmDic.hasOwnProperty(_loc3_))
         {
            return _bgmDic[_loc3_];
         }
         return new BattleBGMObject();
      }
   }
}
