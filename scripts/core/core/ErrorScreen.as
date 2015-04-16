package core
{
   import flash.display.Sprite;
   
   public class ErrorScreen extends Sprite
   {
      
      public function ErrorScreen()
      {
         _imgCls = error_png$c68a5cf3c7d4e1744f0d6622e629e7ef619659770;
         super();
         addChild(new _imgCls());
      }
      
      private var _imgCls:Class;
   }
}
