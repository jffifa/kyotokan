package a24.tween.core.updaters.colors
{
   import a24.tween.core.updaters.abstracts.AbstractDisplayObjectUpdater;
   import flash.display.DisplayObject;
   import a24.tween.core.updaters.abstracts.AbstractUpdater;
   
   public final class ColorReversalUpdater extends AbstractDisplayObjectUpdater
   {
      
      public function ColorReversalUpdater()
      {
         super();
      }
      
      private var _value:Number;
      
      private var _ctUpdater:ColorTransformUpdater;
      
      public function setProp(param1:Number) : void
      {
         if(!isNaN(param1))
         {
            this.value = param1;
         }
      }
      
      override public function init(param1:DisplayObject) : AbstractDisplayObjectUpdater
      {
         super.init(param1);
         var _loc2_:Number = this._value * 255;
         var _loc3_:Number = this._value * -2 + 1;
         this._ctUpdater = this._ctUpdater || new ColorTransformUpdater();
         this._ctUpdater.setProp(_loc2_,_loc2_,_loc2_,0,_loc3_,_loc3_,_loc3_,1);
         this._ctUpdater.init(_target.transform.colorTransform);
         return this;
      }
      
      override public function update(param1:Number) : AbstractUpdater
      {
         if(_tweenFlag & 1 << 0)
         {
            this._ctUpdater.update(_target,param1);
         }
         return this;
      }
      
      override public function clone() : AbstractDisplayObjectUpdater
      {
         var _loc1_:ColorReversalUpdater = new ColorReversalUpdater();
         _loc1_.setProp(this._value);
         return _loc1_;
      }
      
      override public function toString() : String
      {
         return " colorReversal:[" + this._value + "]";
      }
      
      public function get value() : Number
      {
         return this._value;
      }
      
      public function set value(param1:Number) : void
      {
         this._value = param1;
         _updateFlag = _updateFlag | 1 << 0;
      }
   }
}
