package a24.tween.core.updaters.colors
{
   import a24.tween.core.updaters.abstracts.AbstractDisplayObjectUpdater;
   import flash.display.DisplayObject;
   import flash.geom.ColorTransform;
   import a24.tween.core.updaters.abstracts.AbstractUpdater;
   
   public final class ContrastUpdater extends AbstractDisplayObjectUpdater
   {
      
      public function ContrastUpdater()
      {
         super();
      }
      
      private var _contrast:Number;
      
      private var _startContrast:Number;
      
      private var _deltaContrast:Number;
      
      private var _progContrast:Number;
      
      public function setProp(param1:Number) : void
      {
         if(!isNaN(param1))
         {
            this.contrast = param1;
         }
      }
      
      override public function init(param1:DisplayObject) : AbstractDisplayObjectUpdater
      {
         super.init(param1);
         var _loc2_:ColorTransform = _target.transform.colorTransform;
         this._startContrast = _loc2_.redMultiplier - 1;
         this._deltaContrast = this._contrast - this._startContrast;
         return this;
      }
      
      override public function update(param1:Number) : AbstractUpdater
      {
         var _loc2_:* = NaN;
         var _loc3_:* = NaN;
         var _loc4_:ColorTransform = null;
         if(_tweenFlag & 1 << 0)
         {
            this._progContrast = this._startContrast + this._deltaContrast * param1;
            _loc2_ = this._progContrast + 1;
            _loc3_ = Math.round(this._progContrast * -128);
            _loc4_ = _target.transform.colorTransform;
            _loc4_.redMultiplier = _loc2_;
            _loc4_.greenMultiplier = _loc2_;
            _loc4_.blueMultiplier = _loc2_;
            _loc4_.redOffset = _loc3_;
            _loc4_.greenOffset = _loc3_;
            _loc4_.blueOffset = _loc3_;
            _loc4_.alphaOffset = 0;
            _target.transform.colorTransform = _loc4_;
         }
         return this;
      }
      
      override public function clone() : AbstractDisplayObjectUpdater
      {
         var _loc1_:ContrastUpdater = new ContrastUpdater();
         _loc1_.setProp(this._contrast);
         return _loc1_;
      }
      
      override public function toString() : String
      {
         return " contrast:" + this._contrast;
      }
      
      public function get contrast() : int
      {
         return this._contrast;
      }
      
      public function set contrast(param1:int) : void
      {
         this._contrast = param1;
         _updateFlag = _updateFlag | 1 << 0;
      }
   }
}
