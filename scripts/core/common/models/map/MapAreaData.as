package common.models.map
{
   import flash.utils.Dictionary;
   import common.util.Util;
   
   public class MapAreaData extends Object
   {
      
      public function MapAreaData(param1:Object)
      {
         super();
         _o = param1;
      }
      
      private var _o:Object;
      
      private var _infoDic:Dictionary;
      
      public function get areaID() : int
      {
         return Util.getInt(_o,"api_id",-1);
      }
      
      public function setMasterData(param1:Array, param2:Array) : void
      {
         var _loc4_:* = 0;
         var _loc3_:* = null;
         _infoDic = new Dictionary();
         _loc4_ = 0;
         while(_loc4_ < param1.length)
         {
            _loc3_ = new MapInfoData(param1[_loc4_]);
            if(areaID == _loc3_.areaID)
            {
               _infoDic[_loc3_.infoNo] = _loc3_;
               _loc3_.setMasterData(param2);
            }
            _loc4_++;
         }
      }
      
      public function getInfoData(param1:int) : MapInfoData
      {
         if(hasInfoData(param1))
         {
            return _infoDic[param1];
         }
         return null;
      }
      
      public function hasInfoData(param1:int) : Boolean
      {
         return _infoDic.hasOwnProperty(param1);
      }
   }
}
