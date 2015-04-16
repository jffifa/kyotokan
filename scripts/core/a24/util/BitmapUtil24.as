package a24.util
{
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.geom.Rectangle;
   import flash.geom.Matrix;
   import flash.display.Bitmap;
   import flash.display.PixelSnapping;
   import flash.text.TextField;
   
   public final class BitmapUtil24 extends Object
   {
      
      public function BitmapUtil24()
      {
         super();
      }
      
      public function getCaptureData(param1:DisplayObject, param2:Boolean = true, param3:uint = 16777215, param4:Boolean = false) : BitmapData
      {
         var _loc5_:BitmapData = new BitmapData(param1.width / param1.scaleX,param1.height / param1.scaleY,param2,param3);
         var _loc6_:Rectangle = param1.getBounds(param1);
         var _loc7_:Matrix = new Matrix();
         _loc7_.tx = -_loc6_.left;
         _loc7_.ty = -_loc6_.top;
         _loc5_.draw(param1,_loc7_,null,null,null,param4);
         return _loc5_;
      }
      
      public function getCapture(param1:DisplayObject, param2:Boolean = false) : Bitmap
      {
         var _loc3_:Bitmap = new Bitmap(this.getCaptureData(param1,true,0,param2));
         if(param2)
         {
            _loc3_.smoothing = true;
            _loc3_.pixelSnapping = PixelSnapping.NEVER;
         }
         return _loc3_;
      }
      
      public function getCaptureAndSyncPoint(param1:DisplayObject, param2:Boolean = false) : Bitmap
      {
         var _loc3_:Bitmap = this.getCapture(param1,param2);
         var _loc4_:Rectangle = param1.getRect(param1);
         if(param1 is TextField)
         {
            _loc4_.offset(2,2);
         }
         _loc3_.x = param1.x + _loc4_.x;
         _loc3_.y = param1.y + _loc4_.y;
         return _loc3_;
      }
      
      public function getResizeAndCenterClipping(param1:DisplayObject, param2:int, param3:int, param4:Boolean = true, param5:uint = 16777215) : Bitmap
      {
         var _loc6_:Number = param2 / param1.width;
         var _loc7_:Number = param3 / param1.height;
         var _loc8_:Number = _loc6_ > _loc7_?_loc6_:_loc7_;
         var _loc9_:Number = param1.width * _loc8_;
         var _loc10_:Number = param1.height * _loc8_;
         var _loc11_:BitmapData = new BitmapData(param2,param3,param4,param5);
         var _loc12_:Rectangle = param1.getBounds(param1);
         var _loc13_:Matrix = new Matrix();
         _loc13_.tx = -_loc12_.left - (param1.width - param2 / _loc8_) / 2 >> 0;
         _loc13_.ty = -_loc12_.top - (param1.height - param3 / _loc8_) / 2 >> 0;
         _loc13_.scale(_loc8_,_loc8_);
         _loc11_.draw(param1,_loc13_,null,null);
         return new Bitmap(_loc11_);
      }
   }
}
