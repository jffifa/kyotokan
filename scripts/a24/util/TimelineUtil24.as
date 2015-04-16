package a24.util
{
   import flash.display.MovieClip;
   
   public final class TimelineUtil24 extends Object
   {
      
      public function TimelineUtil24()
      {
         super();
      }
      
      public function play(... rest) : void
      {
         var _loc2_:MovieClip = null;
         var rest:Array = Util24.array.compressAndClean(rest);
         for each(_loc2_ in rest)
         {
            _loc2_.play();
         }
      }
      
      public function stop(... rest) : void
      {
         var _loc2_:MovieClip = null;
         var rest:Array = Util24.array.compressAndClean(rest);
         for each(_loc2_ in rest)
         {
            _loc2_.stop();
         }
      }
      
      public function gotoAndPlay(param1:*, ... rest) : void
      {
         var _loc3_:MovieClip = null;
         var rest:Array = Util24.array.compressAndClean(rest);
         for each(_loc3_ in rest)
         {
            _loc3_.gotoAndPlay(param1);
         }
      }
      
      public function gotoAndStop(param1:*, ... rest) : void
      {
         var _loc3_:MovieClip = null;
         var rest:Array = Util24.array.compressAndClean(rest);
         for each(_loc3_ in rest)
         {
            _loc3_.gotoAndStop(param1);
         }
      }
      
      public function gotoPrevFrame(... rest) : void
      {
         var _loc2_:MovieClip = null;
         var rest:Array = Util24.array.compressAndClean(rest);
         for each(_loc2_ in rest)
         {
            _loc2_.gotoAndStop(_loc2_.currentFrame - 1);
         }
      }
      
      public function gotoNextFrame(... rest) : void
      {
         var _loc2_:MovieClip = null;
         var rest:Array = Util24.array.compressAndClean(rest);
         for each(_loc2_ in rest)
         {
            _loc2_.gotoAndStop(_loc2_.currentFrame + 1);
         }
      }
      
      public function gotoLastFrame(... rest) : void
      {
         var _loc2_:MovieClip = null;
         var rest:Array = Util24.array.compressAndClean(rest);
         for each(_loc2_ in rest)
         {
            _loc2_.gotoAndStop(_loc2_.totalFrames);
         }
      }
      
      public function gotoRandomAndPlay(... rest) : void
      {
         var _loc2_:MovieClip = null;
         var rest:Array = Util24.array.compressAndClean(rest);
         for each(_loc2_ in rest)
         {
            _loc2_.gotoAndPlay(int(_loc2_.totalFrames * Math.random() + 1));
         }
      }
      
      public function gotoRandomAndStop(... rest) : void
      {
         var _loc2_:MovieClip = null;
         var rest:Array = Util24.array.compressAndClean(rest);
         for each(_loc2_ in rest)
         {
            _loc2_.gotoAndStop(int(_loc2_.totalFrames * Math.random() + 1));
         }
      }
   }
}
