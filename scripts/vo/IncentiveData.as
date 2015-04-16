package vo
{
   import dto.IncentiveDTO;
   import common.util.Util;
   
   public class IncentiveData extends Object
   {
      
      public function IncentiveData()
      {
         _obj = {};
         super();
      }
      
      private var _obj:Object;
      
      public function setData(param1:Object) : void
      {
         _obj = param1;
      }
      
      public function getCount() : int
      {
         return _item.length;
      }
      
      public function hasIncentive() : Boolean
      {
         return getCount() > 0;
      }
      
      public function shiftIncentiveItem() : IncentiveDTO
      {
         var _loc1_:Array = _item;
         if(_loc1_.length > 0)
         {
            return new IncentiveDTO(_item.shift());
         }
         return null;
      }
      
      private function get _item() : Array
      {
         return Util.getArray(_obj,"api_item",[]);
      }
   }
}
