package a24.tween.core.updaters.filters
{
   import a24.tween.core.updaters.abstracts.AbstractBitmapFilterUpdater;
   import flash.filters.ColorMatrixFilter;
   import a24.tween.core.updaters.abstracts.AbstractUpdater;
   import flash.filters.BitmapFilter;
   
   public final class SaturationUpdater extends AbstractBitmapFilterUpdater
   {
      
      public function SaturationUpdater()
      {
         super();
      }
      
      private var _filter:ColorMatrixFilter;
      
      private var _saturation:Number;
      
      private var _startSaturate:Number;
      
      private var _progSaturate:Number;
      
      private var _deltaSaturate:Number;
      
      public function setProp(param1:Number) : void
      {
         if(!isNaN(param1))
         {
            this.saturation = param1;
         }
      }
      
      override public function init(param1:Object, param2:BitmapFilter) : AbstractUpdater
      {
         super.init(param1,param2);
         _target = param1;
         this._filter = param2 as ColorMatrixFilter;
         this._startSaturate = (this._filter.matrix[0] - 1 / 3) / (2 / 3);
         this._progSaturate = this._startSaturate;
         this._deltaSaturate = this._saturation - this._startSaturate;
         return this;
      }
      
      override public function update(param1:Number) : AbstractUpdater
      {
         var _loc2_:* = NaN;
         var _loc3_:* = NaN;
         var _loc4_:* = NaN;
         var _loc5_:* = NaN;
         var _loc6_:* = NaN;
         var _loc7_:* = NaN;
         var _loc8_:* = NaN;
         var _loc9_:* = NaN;
         if(_tweenFlag & 1 << 0)
         {
            this._progSaturate = this._startSaturate + this._deltaSaturate * param1;
            _loc2_ = 1 / 3;
            _loc3_ = 1 / 3;
            _loc4_ = 1 / 3;
            _loc5_ = this._progSaturate;
            _loc6_ = 1 - _loc5_;
            _loc7_ = _loc2_ * _loc6_;
            _loc8_ = _loc3_ * _loc6_;
            _loc9_ = _loc4_ * _loc6_;
            this._filter.matrix = [_loc7_ + _loc5_,_loc8_,_loc9_,0,0,_loc7_,_loc8_ + _loc5_,_loc9_,0,0,_loc7_,_loc8_,_loc9_ + _loc5_,0,0,0,0,0,1,0];
            setFilter(this._filter,ColorMatrixFilter);
         }
         return this;
      }
      
      override public function clone() : AbstractBitmapFilterUpdater
      {
         var _loc1_:SaturationUpdater = new SaturationUpdater();
         _loc1_.setProp(this._saturation);
         _loc1_._updateFlag = _updateFlag;
         return _loc1_;
      }
      
      override public function toString() : String
      {
         return formatToString("saturation",this._saturation);
      }
      
      public function get saturation() : Number
      {
         return this._saturation;
      }
      
      public function set saturation(param1:Number) : void
      {
         this._saturation = param1;
         _updateFlag = _updateFlag | 1 << 0;
      }
   }
}
