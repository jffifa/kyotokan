package common.util
{
   import a24.tween.Tween24;
   import flash.display.MovieClip;
   
   public class MCUtil extends Object
   {
      
      public function MCUtil()
      {
         super();
      }
      
      public static function frameTween(param1:MovieClip, param2:int, param3:int) : Tween24
      {
         return Tween24.tween(param1,(param3 - param2) / 30).frame(param3);
      }
   }
}
