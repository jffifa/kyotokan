package a24.tween.core.updaters.colors
{
   import a24.tween.core.updaters.abstracts.AbstractDisplayObjectUpdater;
   import flash.display.DisplayObject;
   import flash.geom.ColorTransform;
   import a24.tween.core.updaters.abstracts.AbstractUpdater;
   
   public final class ColorUpdater extends AbstractDisplayObjectUpdater
   {
      
      public function ColorUpdater()
      {
         super();
      }
      
      private var _color:Number;
      
      private var _alpha:Number;
      
      private var _ctUpdater:ColorTransformUpdater;
      
      public function setProp(param1:Number, param2:Number) : void
      {
         if(!isNaN(param1))
         {
            this.color = param1;
         }
         this.alpha = param2 >= 0.99?1.0:param2 + 15 / 255;
      }
      
      override public function init(param1:DisplayObject) : AbstractDisplayObjectUpdater
      {
         super.init(param1);
         var _loc2_:ColorTransform = _target.transform.colorTransform;
         var _loc3_:Number = 1 - this._alpha;
         var _loc4_:Number = isNaN(this._color)?_loc2_.redOffset / (1 - _loc2_.redMultiplier) * this._alpha:(this._color >> 16 & 255) * this._alpha;
         var _loc5_:Number = isNaN(this._color)?_loc2_.greenOffset / (1 - _loc2_.greenMultiplier) * this._alpha:(this._color >> 8 & 255) * this._alpha;
         var _loc6_:Number = isNaN(this._color)?_loc2_.blueOffset / (1 - _loc2_.blueMultiplier) * this._alpha:(this._color & 255) * this._alpha;
         this._ctUpdater = this._ctUpdater || new ColorTransformUpdater();
         this._ctUpdater.setProp(_loc4_,_loc5_,_loc6_,0,_loc3_,_loc3_,_loc3_,_target.alpha);
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
      
      override public function complete() : void
      {
         super.complete();
      }
      
      override public function clone() : AbstractDisplayObjectUpdater
      {
         var _loc1_:ColorUpdater = new ColorUpdater();
         _loc1_.setProp(this._color,this._alpha);
         return _loc1_;
      }
      
      override public function toString() : String
      {
         return " color:[" + RGBUpdater.getInt16(this._color) + " " + this._alpha + "]";
      }
      
      public function get color() : int
      {
         return this._color;
      }
      
      public function set color(param1:int) : void
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
         _updateFlag = _updateFlag | 1 << 0;
      }
   }
}
