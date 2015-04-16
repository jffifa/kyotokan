package a24.tween.core.updaters.filters
{
   import a24.tween.core.updaters.abstracts.AbstractBitmapFilterUpdater;
   import flash.filters.BlurFilter;
   import a24.tween.core.updaters.abstracts.AbstractUpdater;
   import flash.filters.BitmapFilter;
   
   public final class BlurFilterUpdater extends AbstractBitmapFilterUpdater
   {
      
      public function BlurFilterUpdater()
      {
         super();
      }
      
      private var _blurX:Number;
      
      private var _blurY:Number;
      
      private var _quality:Number;
      
      private var _startBlurX:Number;
      
      private var _startBlurY:Number;
      
      private var _startQuality:Number;
      
      private var _deltaBlurX:Number;
      
      private var _deltaBlurY:Number;
      
      private var _deltaQuality:Number;
      
      private var _filter:BlurFilter;
      
      public function setProp(param1:Number = NaN, param2:Number = NaN, param3:Number = NaN) : void
      {
         if(!isNaN(param1))
         {
            this.blurX = param1;
         }
         if(!isNaN(param2))
         {
            this.blurY = param2;
         }
         if(!isNaN(param3))
         {
            this.quality = param3;
         }
      }
      
      override public function init(param1:Object, param2:BitmapFilter) : AbstractUpdater
      {
         super.init(param1,param2);
         _target = param1;
         this._filter = param2 as BlurFilter;
         if(_tweenFlag & 1 << 0)
         {
            this._startBlurX = this._filter.blurX;
            this._deltaBlurX = this._blurX - this._startBlurX;
         }
         if(_tweenFlag & 1 << 1)
         {
            this._startBlurY = this._filter.blurY;
            this._deltaBlurY = this._blurY - this._startBlurY;
         }
         if(_tweenFlag & 1 << 2)
         {
            this._startQuality = this._filter.quality;
            this._deltaQuality = this._quality - this._startQuality;
         }
         return this;
      }
      
      override public function update(param1:Number) : AbstractUpdater
      {
         this._filter = getFilter(BlurFilter) as BlurFilter || this._filter;
         if(_tweenFlag & 1 << 0)
         {
            this._filter.blurX = this._startBlurX + this._deltaBlurX * param1;
         }
         if(_tweenFlag & 1 << 1)
         {
            this._filter.blurY = this._startBlurY + this._deltaBlurY * param1;
         }
         if(_tweenFlag & 1 << 2)
         {
            this._filter.quality = this._startQuality + this._deltaQuality * param1;
         }
         setFilter(this._filter,BlurFilter);
         return this;
      }
      
      override public function clone() : AbstractBitmapFilterUpdater
      {
         var _loc1_:BlurFilterUpdater = new BlurFilterUpdater();
         _loc1_.setProp(this._blurX,this._blurY,this._quality);
         _loc1_._updateFlag = _updateFlag;
         return _loc1_;
      }
      
      override public function toString() : String
      {
         return formatToString("blur",this._blurX,this._blurY,this._quality);
      }
      
      public function get blurX() : Number
      {
         return this._blurX;
      }
      
      public function set blurX(param1:Number) : void
      {
         this._blurX = param1;
         _updateFlag = _updateFlag | 1 << 0;
      }
      
      public function get blurY() : Number
      {
         return this._blurY;
      }
      
      public function set blurY(param1:Number) : void
      {
         this._blurY = param1;
         _updateFlag = _updateFlag | 1 << 1;
      }
      
      public function get quality() : Number
      {
         return this._quality;
      }
      
      public function set quality(param1:Number) : void
      {
         this._quality = param1;
         _updateFlag = _updateFlag | 1 << 2;
      }
   }
}
