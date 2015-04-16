package a24.tween.core.updaters.filters
{
   import a24.tween.core.updaters.abstracts.AbstractBitmapFilterUpdater;
   import flash.filters.DropShadowFilter;
   import a24.tween.core.updaters.colors.RGBUpdater;
   import a24.tween.core.updaters.abstracts.AbstractUpdater;
   import flash.filters.BitmapFilter;
   
   public final class DropShadowFilterUpdater extends AbstractBitmapFilterUpdater
   {
      
      public function DropShadowFilterUpdater()
      {
         super();
      }
      
      private var _distance:Number;
      
      private var _angle:Number;
      
      private var _color:Number;
      
      private var _alpha:Number;
      
      private var _blurX:Number;
      
      private var _blurY:Number;
      
      private var _strength:Number;
      
      private var _quality:Number;
      
      private var _inner:Boolean;
      
      private var _knockout:Boolean;
      
      private var _startDistance:Number;
      
      private var _startAngle:Number;
      
      private var _startAlpha:Number;
      
      private var _startBlurX:Number;
      
      private var _startBlurY:Number;
      
      private var _startStrength:Number;
      
      private var _startQuality:Number;
      
      private var _deltaDistance:Number;
      
      private var _deltaAngle:Number;
      
      private var _deltaAlpha:Number;
      
      private var _deltaBlurX:Number;
      
      private var _deltaBlurY:Number;
      
      private var _deltaStrength:Number;
      
      private var _deltaQuality:Number;
      
      private var _filter:DropShadowFilter;
      
      private var _rgb:RGBUpdater;
      
      public function setProp(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number, param8:Number) : void
      {
         this._rgb = this._rgb || new RGBUpdater();
         if(!isNaN(param1))
         {
            this.distance = param1;
         }
         if(!isNaN(param2))
         {
            this.angle = param2;
         }
         if(!isNaN(param3))
         {
            this.color = param3;
         }
         if(!isNaN(this.alpha))
         {
            this.alpha = this.alpha;
         }
         if(!isNaN(param5))
         {
            this.blurX = param5;
         }
         if(!isNaN(param6))
         {
            this.blurY = param6;
         }
         if(!isNaN(param7))
         {
            this.strength = param7;
         }
         if(!isNaN(param8))
         {
            this.quality = param8;
         }
      }
      
      override public function init(param1:Object, param2:BitmapFilter) : AbstractUpdater
      {
         super.init(param1,param2);
         _target = param1;
         this._filter = param2 as DropShadowFilter;
         if(_tweenFlag & 1 << 0)
         {
            this._startDistance = this._filter.distance;
            this._deltaDistance = this._distance - this._startDistance;
         }
         if(_tweenFlag & 1 << 1)
         {
            this._startAngle = this._filter.angle;
            this._deltaAngle = this._angle - this._startAngle;
         }
         if(_tweenFlag & 1 << 2)
         {
            this._rgb.setProp(this._filter.color,this._color);
         }
         if(_tweenFlag & 1 << 3)
         {
            this._startAlpha = this._filter.alpha;
            this._deltaAlpha = this._alpha - this._startAlpha;
         }
         if(_tweenFlag & 1 << 4)
         {
            this._startBlurX = this._filter.blurX;
            this._deltaBlurX = this._blurX - this._startBlurX;
         }
         if(_tweenFlag & 1 << 5)
         {
            this._startBlurY = this._filter.blurY;
            this._deltaBlurY = this._blurY - this._startBlurY;
         }
         if(_tweenFlag & 1 << 6)
         {
            this._startStrength = this._filter.strength;
            this._deltaStrength = this._strength - this._startStrength;
         }
         if(_tweenFlag & 1 << 7)
         {
            this._startQuality = this._filter.quality;
            this._deltaQuality = this._quality - this._startQuality;
         }
         if(_tweenFlag & 1 << 8)
         {
            this._filter.inner = this._inner;
         }
         if(_tweenFlag & 1 << 9)
         {
            this._filter.knockout = this._knockout;
         }
         return this;
      }
      
      override public function update(param1:Number) : AbstractUpdater
      {
         this._filter = getFilter(DropShadowFilter) as DropShadowFilter || this._filter;
         if(_tweenFlag & 1 << 0)
         {
            this._filter.distance = this._startDistance + this._deltaDistance * param1;
         }
         if(_tweenFlag & 1 << 1)
         {
            this._filter.angle = this._startAngle + this._deltaAngle * param1;
         }
         if(_tweenFlag & 1 << 2)
         {
            this._filter.color = RGBUpdater(this._rgb.update(param1)).getColor();
         }
         if(_tweenFlag & 1 << 3)
         {
            this._filter.alpha = this._startAlpha + this._deltaAlpha * param1;
         }
         if(_tweenFlag & 1 << 4)
         {
            this._filter.blurX = this._startBlurX + this._deltaBlurX * param1;
         }
         if(_tweenFlag & 1 << 5)
         {
            this._filter.blurY = this._startBlurY + this._deltaBlurY * param1;
         }
         if(_tweenFlag & 1 << 6)
         {
            this._filter.strength = this._startStrength + this._deltaStrength * param1;
         }
         if(_tweenFlag & 1 << 7)
         {
            this._filter.quality = this._startQuality + this._deltaQuality * param1;
         }
         setFilter(this._filter,DropShadowFilter);
         return this;
      }
      
      override public function clone() : AbstractBitmapFilterUpdater
      {
         var _loc1_:DropShadowFilterUpdater = new DropShadowFilterUpdater();
         _loc1_.setProp(this._distance,this._angle,this._color,this._alpha,this._blurX,this._blurY,this._strength,this._quality);
         _loc1_._inner = this._inner;
         _loc1_._knockout = this._knockout;
         _loc1_._updateFlag = _updateFlag;
         return _loc1_;
      }
      
      override public function toString() : String
      {
         return formatToString("dropShadow",this._distance,this._angle,RGBUpdater.getInt16(this._color),this._alpha,this._blurX,this._blurY,this._strength,this._quality);
      }
      
      public function get distance() : Number
      {
         return this._distance;
      }
      
      public function set distance(param1:Number) : void
      {
         this._distance = param1;
         _updateFlag = _updateFlag | 1 << 0;
      }
      
      public function get angle() : Number
      {
         return this._angle;
      }
      
      public function set angle(param1:Number) : void
      {
         this._angle = param1;
         _updateFlag = _updateFlag | 1 << 1;
      }
      
      public function get color() : Number
      {
         return this._color;
      }
      
      public function set color(param1:Number) : void
      {
         this._color = param1;
         _updateFlag = _updateFlag | 1 << 2;
      }
      
      public function get alpha() : Number
      {
         return this._alpha;
      }
      
      public function set alpha(param1:Number) : void
      {
         this._alpha = param1;
         _updateFlag = _updateFlag | 1 << 3;
      }
      
      public function get blurX() : Number
      {
         return this._blurX;
      }
      
      public function set blurX(param1:Number) : void
      {
         this._blurX = param1;
         _updateFlag = _updateFlag | 1 << 4;
      }
      
      public function get blurY() : Number
      {
         return this._blurY;
      }
      
      public function set blurY(param1:Number) : void
      {
         this._blurY = param1;
         _updateFlag = _updateFlag | 1 << 5;
      }
      
      public function get strength() : Number
      {
         return this._strength;
      }
      
      public function set strength(param1:Number) : void
      {
         this._strength = param1;
         _updateFlag = _updateFlag | 1 << 6;
      }
      
      public function get quality() : Number
      {
         return this._quality;
      }
      
      public function set quality(param1:Number) : void
      {
         this._quality = param1;
         _updateFlag = _updateFlag | 1 << 7;
      }
      
      public function get inner() : Boolean
      {
         return this._inner;
      }
      
      public function set inner(param1:Boolean) : void
      {
         this._inner = param1;
         _updateFlag = _updateFlag | 1 << 8;
      }
      
      public function get knockout() : Boolean
      {
         return this._knockout;
      }
      
      public function set knockout(param1:Boolean) : void
      {
         this._knockout = param1;
         _updateFlag = _updateFlag | 1 << 9;
      }
   }
}
