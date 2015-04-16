package a24.tween.core.updaters.colors
{
   import flash.geom.ColorTransform;
   import flash.display.DisplayObject;
   
   public class ColorTransformUpdater extends Object
   {
      
      public function ColorTransformUpdater()
      {
         super();
      }
      
      private var _redOffset:Number;
      
      private var _greenOffset:Number;
      
      private var _blueOffset:Number;
      
      private var _alphaOffset:Number;
      
      private var _redMultiplier:Number;
      
      private var _greenMultiplier:Number;
      
      private var _blueMultiplier:Number;
      
      private var _alphaMultiplier:Number;
      
      private var _startRedOffset:Number;
      
      private var _startGreenOffset:Number;
      
      private var _startBlueOffset:Number;
      
      private var _startAlphaOffset:Number;
      
      private var _startRedMultiplier:Number;
      
      private var _startGreenMultiplier:Number;
      
      private var _startBlueMultiplier:Number;
      
      private var _startAlphaMultiplier:Number;
      
      private var _deltaRedOffset:Number;
      
      private var _deltaGreenOffset:Number;
      
      private var _deltaBlueOffset:Number;
      
      private var _deltaAlphaOffset:Number;
      
      private var _deltaRedMultiplier:Number;
      
      private var _deltaGreenMultiplier:Number;
      
      private var _deltaBlueMultiplier:Number;
      
      private var _deltaAlphaMultiplier:Number;
      
      private var _compRedOffset:Number;
      
      private var _compGreenOffset:Number;
      
      private var _compBlueOffset:Number;
      
      private var _compAlphaOffset:Number;
      
      private var _compRedMultiplier:Number;
      
      private var _compGreenMultiplier:Number;
      
      private var _compBlueMultiplier:Number;
      
      private var _compAlphaMultiplier:Number;
      
      public function setProp(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number, param8:Number) : void
      {
         this._compRedOffset = param1;
         this._compGreenOffset = param2;
         this._compBlueOffset = param3;
         this._compAlphaOffset = param4;
         this._compRedMultiplier = param5;
         this._compGreenMultiplier = param6;
         this._compBlueMultiplier = param7;
         this._compAlphaMultiplier = param8;
      }
      
      public function init(param1:ColorTransform) : void
      {
         this._startRedOffset = param1.redOffset;
         this._startGreenOffset = param1.greenOffset;
         this._startBlueOffset = param1.blueOffset;
         this._startAlphaOffset = param1.alphaOffset;
         this._startRedMultiplier = param1.redMultiplier;
         this._startGreenMultiplier = param1.greenMultiplier;
         this._startBlueMultiplier = param1.blueMultiplier;
         this._startAlphaMultiplier = param1.alphaMultiplier;
         if(!isNaN(this._compRedOffset))
         {
            this._deltaRedOffset = this._compRedOffset - this._startRedOffset;
         }
         if(!isNaN(this._compGreenOffset))
         {
            this._deltaGreenOffset = this._compGreenOffset - this._startGreenOffset;
         }
         if(!isNaN(this._compBlueOffset))
         {
            this._deltaBlueOffset = this._compBlueOffset - this._startBlueOffset;
         }
         if(!isNaN(this._compAlphaOffset))
         {
            this._deltaAlphaOffset = this._compAlphaOffset - this._startAlphaOffset;
         }
         if(!isNaN(this._compRedMultiplier))
         {
            this._deltaRedMultiplier = this._compRedMultiplier - this._startRedMultiplier;
         }
         if(!isNaN(this._compGreenMultiplier))
         {
            this._deltaGreenMultiplier = this._compGreenMultiplier - this._startGreenMultiplier;
         }
         if(!isNaN(this._compBlueMultiplier))
         {
            this._deltaBlueMultiplier = this._compBlueMultiplier - this._startBlueMultiplier;
         }
         if(!isNaN(this._compAlphaMultiplier))
         {
            this._deltaAlphaMultiplier = this._compAlphaMultiplier - this._startAlphaMultiplier;
         }
      }
      
      public function update(param1:DisplayObject, param2:Number) : void
      {
         var _loc3_:ColorTransform = param1.transform.colorTransform;
         if(!isNaN(this._compRedOffset))
         {
            _loc3_.redOffset = this._redOffset = this._startRedOffset + this._deltaRedOffset * param2;
         }
         if(!isNaN(this._compGreenOffset))
         {
            _loc3_.greenOffset = this._greenOffset = this._startGreenOffset + this._deltaGreenOffset * param2;
         }
         if(!isNaN(this._compBlueOffset))
         {
            _loc3_.blueOffset = this._blueOffset = this._startBlueOffset + this._deltaBlueOffset * param2;
         }
         if(!isNaN(this._compAlphaOffset))
         {
            _loc3_.alphaOffset = this._alphaOffset = this._startAlphaOffset + this._deltaAlphaOffset * param2;
         }
         if(!isNaN(this._compRedMultiplier))
         {
            _loc3_.redMultiplier = this._redMultiplier = this._startRedMultiplier + this._deltaRedMultiplier * param2;
         }
         if(!isNaN(this._compGreenMultiplier))
         {
            _loc3_.greenMultiplier = this._greenMultiplier = this._startGreenMultiplier + this._deltaGreenMultiplier * param2;
         }
         if(!isNaN(this._compBlueMultiplier))
         {
            _loc3_.blueMultiplier = this._blueMultiplier = this._startBlueMultiplier + this._deltaBlueMultiplier * param2;
         }
         if(!isNaN(this._compAlphaMultiplier))
         {
            _loc3_.alphaMultiplier = this._alphaMultiplier = this._startAlphaMultiplier + this._deltaAlphaMultiplier * param2;
         }
         param1.transform.colorTransform = _loc3_;
      }
      
      public function complete() : void
      {
         if(!isNaN(this._compRedOffset))
         {
            this._redOffset = this._compRedOffset;
         }
         if(!isNaN(this._compGreenOffset))
         {
            this._greenOffset = this._compGreenOffset;
         }
         if(!isNaN(this._compBlueOffset))
         {
            this._blueOffset = this._compBlueOffset;
         }
         if(!isNaN(this._compAlphaOffset))
         {
            this._alphaOffset = this._compAlphaOffset;
         }
         if(!isNaN(this._compRedMultiplier))
         {
            this._redMultiplier = this._compRedMultiplier;
         }
         if(!isNaN(this._compGreenMultiplier))
         {
            this._greenMultiplier = this._compGreenMultiplier;
         }
         if(!isNaN(this._compBlueMultiplier))
         {
            this._blueMultiplier = this._compBlueMultiplier;
         }
         if(!isNaN(this._compAlphaMultiplier))
         {
            this._alphaMultiplier = this._compAlphaMultiplier;
         }
      }
      
      public function get redOffset() : Number
      {
         return this._redOffset;
      }
      
      public function get greenOffset() : Number
      {
         return this._greenOffset;
      }
      
      public function get blueOffset() : Number
      {
         return this._blueOffset;
      }
      
      public function get alphaOffset() : Number
      {
         return this._alphaOffset;
      }
      
      public function get redMultiplier() : Number
      {
         return this._redMultiplier;
      }
      
      public function get greenMultiplier() : Number
      {
         return this._greenMultiplier;
      }
      
      public function get blueMultiplier() : Number
      {
         return this._blueMultiplier;
      }
      
      public function get alphaMultiplier() : Number
      {
         return this._alphaMultiplier;
      }
   }
}
