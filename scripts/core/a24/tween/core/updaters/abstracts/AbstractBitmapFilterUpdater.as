package a24.tween.core.updaters.abstracts
{
   import flash.filters.BitmapFilter;
   
   public class AbstractBitmapFilterUpdater extends AbstractUpdater
   {
      
      public function AbstractBitmapFilterUpdater()
      {
         super();
      }
      
      protected var _target:Object;
      
      public function init(param1:Object, param2:BitmapFilter) : AbstractUpdater
      {
         initFlag();
         return this;
      }
      
      public function clone() : AbstractBitmapFilterUpdater
      {
         return null;
      }
      
      protected function setFilter(param1:BitmapFilter, param2:Class) : void
      {
         var _loc3_:Array = this._target.filters;
         var _loc4_:uint = _loc3_.length;
         var _loc5_:uint = 0;
         while(_loc5_ < _loc4_)
         {
            if(_loc3_[_loc5_] is param2)
            {
               _loc3_[_loc5_] = param1;
               this._target.filters = _loc3_;
               return;
            }
            _loc5_++;
         }
         _loc3_.push(param1);
         this._target.filters = _loc3_;
      }
      
      protected function getFilter(param1:Class) : BitmapFilter
      {
         var _loc3_:BitmapFilter = null;
         var _loc2_:Array = this._target.filters;
         for each(_loc3_ in _loc2_)
         {
            if(_loc3_ is param1)
            {
               return _loc3_;
            }
         }
         return null;
      }
   }
}
