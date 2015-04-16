package vo
{
   import flash.utils.Dictionary;
   import common.models.ShipTypeObject;
   
   public class MasterShipTypeData extends Object
   {
      
      public function MasterShipTypeData()
      {
         super();
      }
      
      private var _dic:Dictionary;
      
      public function setData(param1:Array) : void
      {
         var _loc3_:* = 0;
         var _loc2_:* = null;
         _dic = new Dictionary();
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            _loc2_ = new ShipTypeObject(param1[_loc3_]);
            _dic[_loc2_.id] = _loc2_;
            _loc3_++;
         }
      }
      
      public function getShipTypeData(param1:int) : ShipTypeObject
      {
         if(_dic && _dic.hasOwnProperty(param1))
         {
            return _dic[param1];
         }
         return new ShipTypeObject({});
      }
      
      public function getShipTypeName(param1:int) : String
      {
         return getShipTypeData(param1).name;
      }
   }
}
