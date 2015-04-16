package a24.tween.core.updaters.filters
{
   import a24.tween.core.updaters.abstracts.AbstractBitmapFilterUpdater;
   import flash.filters.ConvolutionFilter;
   import a24.tween.core.updaters.abstracts.AbstractUpdater;
   import flash.filters.BitmapFilter;
   
   public final class SharpUpdater extends AbstractBitmapFilterUpdater
   {
      
      public function SharpUpdater()
      {
         super();
      }
      
      private var _filter:ConvolutionFilter;
      
      private var _sharpness:Number;
      
      private var _matrix:Array;
      
      private var _startSharpness:Number;
      
      private var _progSharpness:Number;
      
      private var _deltaSharpness:Number;
      
      public function setProp(param1:Number) : void
      {
         if(!isNaN(param1))
         {
            this.sharpness = param1;
         }
      }
      
      override public function init(param1:Object, param2:BitmapFilter) : AbstractUpdater
      {
         super.init(param1,param2);
         _target = param1;
         this._filter = param2 as ConvolutionFilter;
         if(!this._filter.matrix.length)
         {
            this._filter.matrixX = this._filter.matrixY = 3;
            this._filter.matrix = [0,0,0,0,1,0,0,0,0];
         }
         this._matrix = this._filter.matrix;
         this._startSharpness = (this._filter.matrix[4] - 1) * 0.25;
         this._progSharpness = this._startSharpness;
         this._deltaSharpness = this._sharpness - this._startSharpness;
         return this;
      }
      
      override public function update(param1:Number) : AbstractUpdater
      {
         var _loc2_:* = NaN;
         if(_tweenFlag & 1 << 0)
         {
            _loc2_ = this._progSharpness = this._startSharpness + this._deltaSharpness * param1;
            this._matrix[4] = 1 + _loc2_ * 4;
            this._matrix[1] = this._matrix[3] = this._matrix[5] = this._matrix[7] = -_loc2_;
            this._filter.matrix = this._matrix;
            setFilter(this._filter,ConvolutionFilter);
         }
         return this;
      }
      
      override public function clone() : AbstractBitmapFilterUpdater
      {
         var _loc1_:SharpUpdater = new SharpUpdater();
         _loc1_.setProp(this._sharpness);
         _loc1_._updateFlag = _updateFlag;
         return _loc1_;
      }
      
      override public function toString() : String
      {
         return formatToString("sharp",this._sharpness);
      }
      
      public function get sharpness() : Number
      {
         return this._sharpness;
      }
      
      public function set sharpness(param1:Number) : void
      {
         this._sharpness = param1;
         _updateFlag = _updateFlag | 1 << 0;
      }
   }
}
