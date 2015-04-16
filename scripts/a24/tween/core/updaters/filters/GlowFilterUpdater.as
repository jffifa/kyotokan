package a24.tween.core.updaters.filters
{
   import a24.tween.core.updaters.abstracts.AbstractBitmapFilterUpdater;
   import flash.filters.GlowFilter;
   import a24.tween.core.updaters.colors.RGBUpdater;
   import a24.tween.core.updaters.abstracts.AbstractUpdater;
   import flash.filters.BitmapFilter;
   
   public final class GlowFilterUpdater extends AbstractBitmapFilterUpdater
   {
      
      public function GlowFilterUpdater()
      {
         super();
      }
      
      private var _color:Number;
      
      private var _alpha:Number;
      
      private var _blurX:Number;
      
      private var _blurY:Number;
      
      private var _strength:Number;
      
      private var _quality:Number;
      
      private var _inner:Boolean;
      
      private var _knockout:Boolean;
      
      private var _startAlpha:Number;
      
      private var _startBlurX:Number;
      
      private var _startBlurY:Number;
      
      private var _startStrength:Number;
      
      private var _startQuality:Number;
      
      private var _deltaAlpha:Number;
      
      private var _deltaBlurX:Number;
      
      private var _deltaBlurY:Number;
      
      private var _deltaStrength:Number;
      
      private var _deltaQuality:Number;
      
      private var _filter:GlowFilter;
      
      private var _rgb:RGBUpdater;
      
      public function setProp(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number) : void
      {
         this._rgb = this._rgb || new RGBUpdater();
         if(!isNaN(param1))
         {
            this.color = param1;
         }
         if(!isNaN(param2))
         {
            this.alpha = param2;
         }
         if(!isNaN(param3))
         {
            this.blurX = param3;
         }
         if(!isNaN(param4))
         {
            this.blurY = param4;
         }
         if(!isNaN(param5))
         {
            this.strength = param5;
         }
         if(!isNaN(param6))
         {
            this.quality = param6;
         }
      }
      
      override public function init(param1:Object, param2:BitmapFilter) : AbstractUpdater
      {
         super.init(param1,param2);
         _target = param1;
         this._filter = param2 as GlowFilter;
         if(_tweenFlag & 1 << 0)
         {
            this._rgb.setProp(this._filter.color,this._color);
         }
         if(_tweenFlag & 1 << 1)
         {
            this._startAlpha = this._filter.alpha;
            this._deltaAlpha = this._alpha - this._startAlpha;
         }
         if(_tweenFlag & 1 << 2)
         {
            this._startBlurX = this._filter.blurX;
            this._deltaBlurX = this._blurX - this._startBlurX;
         }
         if(_tweenFlag & 1 << 3)
         {
            this._startBlurY = this._filter.blurY;
            this._deltaBlurY = this._blurY - this._startBlurY;
         }
         if(_tweenFlag & 1 << 4)
         {
            this._startStrength = this._filter.strength;
            this._deltaStrength = this._strength - this._startStrength;
         }
         if(_tweenFlag & 1 << 5)
         {
            this._startQuality = this._filter.quality;
            this._deltaQuality = this._quality - this._startQuality;
         }
         if(_tweenFlag & 1 << 6)
         {
            this._filter.inner = this._inner;
         }
         if(_tweenFlag & 1 << 7)
         {
            this._filter.knockout = this._knockout;
         }
         return this;
      }
      
      override public function update(param1:Number) : AbstractUpdater
      {
         this._filter = getFilter(GlowFilter) as GlowFilter || this._filter;
         if(_tweenFlag & 1 << 0)
         {
            this._filter.color = RGBUpdater(this._rgb.update(param1)).getColor();
         }
         if(_tweenFlag & 1 << 1)
         {
            this._filter.alpha = this._startAlpha + this._deltaAlpha * param1;
         }
         if(_tweenFlag & 1 << 2)
         {
            this._filter.blurX = this._startBlurX + this._deltaBlurX * param1;
         }
         if(_tweenFlag & 1 << 3)
         {
            this._filter.blurY = this._startBlurY + this._deltaBlurY * param1;
         }
         if(_tweenFlag & 1 << 4)
         {
            this._filter.strength = this._startStrength + this._deltaStrength * param1;
         }
         if(_tweenFlag & 1 << 5)
         {
            this._filter.quality = this._startQuality + this._deltaQuality * param1;
         }
         setFilter(this._filter,GlowFilter);
         return this;
      }
      
      override public function clone() : AbstractBitmapFilterUpdater
      {
         var _loc1_:GlowFilterUpdater = new GlowFilterUpdater();
         _loc1_.setProp(this._color,this._alpha,this._blurX,this._blurY,this._strength,this._quality);
         _loc1_._inner = this._inner;
         _loc1_._knockout = this._knockout;
         _loc1_._updateFlag = _updateFlag;
         return _loc1_;
      }
      
      override public function toString() : String
      {
         return formatToString("glow",RGBUpdater.getInt16(this._color),this._alpha,this._blurX,this._blurY,this._strength,this._quality);
      }
      
      public function get color() : Number
      {
         return this._color;
      }
      
      public function set color(param1:Number) : void
      {
         this._color = param1;
         _updateFlag = _updateFlag | 1 << 0;
      }
      
      public function get alpha() : Number
      {
         return this._alpha;
      }
      
      public function set alpha(param1:Number) : void
      {
         this._alpha = param1;
         _updateFlag = _updateFlag | 1 << 1;
      }
      
      public function get blurX() : Number
      {
         return this._blurX;
      }
      
      public function set blurX(param1:Number) : void
      {
         this._blurX = param1;
         _updateFlag = _updateFlag | 1 << 2;
      }
      
      public function get blurY() : Number
      {
         return this._blurY;
      }
      
      public function set blurY(param1:Number) : void
      {
         this._blurY = param1;
         _updateFlag = _updateFlag | 1 << 3;
      }
      
      public function get strength() : Number
      {
         return this._strength;
      }
      
      public function set strength(param1:Number) : void
      {
         this._strength = param1;
         _updateFlag = _updateFlag | 1 << 4;
      }
      
      public function get quality() : Number
      {
         return this._quality;
      }
      
      public function set quality(param1:Number) : void
      {
         this._quality = param1;
         _updateFlag = _updateFlag | 1 << 5;
      }
      
      public function get inner() : Boolean
      {
         return this._inner;
      }
      
      public function set inner(param1:Boolean) : void
      {
         this._inner = param1;
         _updateFlag = _updateFlag | 1 << 6;
      }
      
      public function get knockout() : Boolean
      {
         return this._knockout;
      }
      
      public function set knockout(param1:Boolean) : void
      {
         this._knockout = param1;
         _updateFlag = _updateFlag | 1 << 7;
      }
   }
}
