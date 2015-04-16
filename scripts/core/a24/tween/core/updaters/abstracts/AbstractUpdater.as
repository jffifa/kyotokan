package a24.tween.core.updaters.abstracts
{
   public class AbstractUpdater extends Object
   {
      
      public function AbstractUpdater()
      {
         super();
      }
      
      protected var _tweenFlag:uint;
      
      protected var _updateFlag:uint;
      
      protected var _$updateFlag:uint;
      
      protected var _$$updateFlag:uint;
      
      public function initFlag() : void
      {
         this._tweenFlag = this._updateFlag;
      }
      
      public function update(param1:Number) : AbstractUpdater
      {
         return this;
      }
      
      public function complete() : void
      {
         this.update(1);
      }
      
      public function overwrite(param1:AbstractUpdater) : void
      {
         var _loc2_:uint = param1._tweenFlag;
         var _loc3_:uint = this._tweenFlag;
         this._tweenFlag = _loc2_ ^ (_loc2_ | _loc3_);
      }
      
      public function toString() : String
      {
         return "";
      }
      
      protected function formatToString(param1:String, ... rest) : String
      {
         if(rest.length == 1)
         {
            return " " + param1 + ":" + rest;
         }
         return " " + param1 + ":[" + rest.join(" ") + "]";
      }
   }
}
