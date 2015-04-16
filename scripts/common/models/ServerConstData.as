package common.models
{
   import common.util.Util;
   
   public class ServerConstData extends Object
   {
      
      public function ServerConstData()
      {
         super();
         _o = {};
      }
      
      private var _o:Object;
      
      public function setData(param1:Object) : void
      {
         _o = param1;
      }
      
      public function get boko_max_ships() : int
      {
         return _getIntValue("api_boko_max_ships",0);
      }
      
      private function _getIntValue(param1:String, param2:int) : int
      {
         var _loc3_:Object = Util.getObject(_o,param1,{});
         return Util.getInt(_loc3_,"api_int_value",param2);
      }
      
      private function _getStringValue(param1:String, param2:String = "") : String
      {
         var _loc3_:Object = Util.getObject(_o,param1,{});
         return Util.getString(_loc3_,"api_string_value",param2);
      }
   }
}
