package a24.tween.core.updaters.colors
{
   import a24.tween.core.updaters.abstracts.AbstractDisplayObjectUpdater;
   import flash.display.DisplayObject;
   import a24.tween.core.updaters.abstracts.AbstractUpdater;
   
   public final class BrightUpdater extends AbstractDisplayObjectUpdater
   {
      
      public function BrightUpdater()
      {
         super();
      }
      
      private var _brightness:Number;
      
      private var _ctUpdater:ColorTransformUpdater;
      
      public function setProp(param1:Number) : void
      {
         this.brightness = param1;
      }
      
      override public function init(param1:DisplayObject) : AbstractDisplayObjectUpdater
      {
         super.init(param1);
         var _loc2_:Number = this._brightness * 100;
         this._ctUpdater = this._ctUpdater || new ColorTransformUpdater();
         this._ctUpdater.setProp(_loc2_,_loc2_,_loc2_,0,1,1,1,NaN);
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
         var _loc1_:BrightUpdater = new BrightUpdater();
         _loc1_.setProp(this._brightness);
         return _loc1_;
      }
      
      override public function toString() : String
      {
         return " bright:" + this._brightness;
      }
      
      public function get brightness() : Number
      {
         return this._brightness;
      }
      
      public function set brightness(param1:Number) : void
      {
         this._brightness = param1;
         _updateFlag = _updateFlag | 1 << 0;
      }
   }
}
