package a24.util
{
   public final class ArrayUtil24 extends Object
   {
      
      public function ArrayUtil24()
      {
         super();
      }
      
      public function clean(param1:Array) : Array
      {
         var _loc3_:* = undefined;
         var _loc2_:Array = [];
         for each(_loc3_ in param1)
         {
            if(!(_loc3_ === "") && !(_loc3_ === null) && !(_loc3_ === undefined) && (_loc3_ is Number?!isNaN(_loc3_):true))
            {
               _loc2_.push(_loc3_);
            }
         }
         return _loc2_;
      }
      
      public function compress(param1:Array) : Array
      {
         var _loc3_:* = undefined;
         var _loc2_:Array = [];
         for each(_loc3_ in param1)
         {
            if(_loc3_ is Array)
            {
               _loc2_ = _loc2_.concat(_loc3_);
            }
            else
            {
               _loc2_.push(_loc3_);
            }
         }
         return _loc2_;
      }
      
      public function compressAndClean(param1:Array) : Array
      {
         return this.clean(this.compress(param1));
      }
      
      public function shuffle(param1:Array) : Array
      {
         var _loc4_:* = 0;
         var _loc5_:Object = null;
         var _loc2_:int = param1.length;
         var _loc3_:Array = param1.concat();
         while(_loc2_)
         {
            _loc4_ = Math.floor(Math.random() * _loc2_);
            _loc5_ = _loc3_[--_loc2_];
            _loc3_[_loc2_] = _loc3_[_loc4_];
            _loc3_[_loc4_] = _loc5_;
         }
         return _loc3_;
      }
      
      public function removeAt(param1:Array, param2:uint) : Array
      {
         return param1.splice(param2,1);
      }
      
      public function removeItem(param1:Array, param2:*) : Array
      {
         var _loc3_:int = param1.indexOf(param2);
         if(_loc3_ > -1)
         {
            param1.splice(_loc3_,1);
         }
         return param1;
      }
      
      public function getOrderNumberArray(param1:int, param2:int) : Array
      {
         var _loc3_:Array = [];
         var _loc4_:int = param2 - param1;
         var _loc5_:* = 0;
         while(_loc5_ <= _loc4_)
         {
            _loc3_.push(_loc5_ + param1);
            _loc5_++;
         }
         return _loc3_;
      }
   }
}
