package common.models.map
{
   import common.util.Util;
   
   public class MapCellData extends Object
   {
      
      public function MapCellData(param1:Object)
      {
         super();
         _o = param1;
      }
      
      private var _o:Object;
      
      public function get cellID() : int
      {
         return Util.getInt(_o,"api_id",-1);
      }
      
      public function get cellNo() : int
      {
         return Util.getInt(_o,"api_no",-1);
      }
      
      public function get areaID() : int
      {
         return Util.getInt(_o,"api_maparea_id",-1);
      }
      
      public function get infoID() : int
      {
         return Util.getInt(_o,"api_map_no",-1);
      }
      
      public function get infoNo() : int
      {
         return Util.getInt(_o,"api_mapinfo_no",-1);
      }
      
      public function get cellColor() : int
      {
         return Util.getInt(_o,"api_color_no",-1);
      }
      
      public function setMemberData(param1:Object) : void
      {
         _o["member_data"] = param1;
      }
      
      public function get passed() : Boolean
      {
         return Util.getInt(_userData,"api_passed") == 1;
      }
      
      private function get _userData() : Object
      {
         return Util.getObject(_o,"member_data",{});
      }
   }
}
