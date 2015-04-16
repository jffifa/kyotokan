package a24.tween.core.updaters.colors
{
   import a24.tween.core.updaters.abstracts.AbstractUpdater;
   
   public final class RGBUpdater extends AbstractUpdater
   {
      
      public function RGBUpdater()
      {
         super();
      }
      
      public static function getInt16(param1:int) : String
      {
         return "0x" + String("000000" + param1.toString(16)).substr(-6,6);
      }
      
      private var _r:int;
      
      private var _g:int;
      
      private var _b:int;
      
      private var _startR:int;
      
      private var _startG:int;
      
      private var _startB:int;
      
      private var _deltaR:int;
      
      private var _deltaG:int;
      
      private var _deltaB:int;
      
      private var _compR:int;
      
      private var _compG:int;
      
      private var _compB:int;
      
      private var _complete:int;
      
      public function setProp(param1:Number, param2:uint) : RGBUpdater
      {
         this._complete = param2;
         this._startR = param1 >> 16 & 255;
         this._startG = param1 >> 8 & 255;
         this._startB = param1 & 255;
         if(param1 < 0)
         {
            this._startR = this._startR * -1;
            this._startG = this._startG * -1;
            this._startB = this._startB * -1;
         }
         this._compR = param2 >> 16 & 255;
         this._compG = param2 >> 8 & 255;
         this._compB = param2 & 255;
         if(param2 < 0)
         {
            this._compR = this._compR * -1;
            this._compG = this._compG * -1;
            this._compB = this._compB * -1;
         }
         this._deltaR = this._compR - this._startR;
         this._deltaG = this._compG - this._startG;
         this._deltaB = this._compB - this._startB;
         return this;
      }
      
      public function getColor() : uint
      {
         return this._r << 16 | this._g << 8 | this._b;
      }
      
      override public function update(param1:Number) : AbstractUpdater
      {
         this._r = this._startR + this._deltaR * param1;
         this._g = this._startG + this._deltaG * param1;
         this._b = this._startB + this._deltaB * param1;
         return this;
      }
      
      override public function toString() : String
      {
         return "0x" + this._complete.toString(16);
      }
      
      public function get r() : int
      {
         return this._r;
      }
      
      public function get g() : int
      {
         return this._g;
      }
      
      public function get b() : int
      {
         return this._b;
      }
   }
}
