package port.views.jukebox
{
   import flash.display.Sprite;
   import res.port.MCJukeFairy;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class JukeFairy extends Sprite
   {
      
      public function JukeFairy()
      {
         super();
         _fairy = new MCJukeFairy();
         addChild(_fairy);
         this.addEventListener("enterFrame",_handleEnterFrame);
         _fairy.addEventListener("click",_handleClickFairy);
         _fairy.rotation = rot;
      }
      
      private var _fairy:MCJukeFairy;
      
      private var _clickFlag:Boolean = false;
      
      private const TO_LEFT:int = 0;
      
      private const LEFT_TO_RIGHT:int = 1;
      
      private const TO_RIGHT:int = 2;
      
      private const RIGHT_TO_LEFT:int = 3;
      
      private var _cond:int = 0;
      
      private var _yspd:int = 0;
      
      private const XSPD:Number = 2;
      
      private const YSPD:Number = -9;
      
      private const YSPD_D:Number = 1;
      
      private const RSPD:Number = 0.08;
      
      private var count:int = 0;
      
      private var rot:int = 4;
      
      public function finalize() : void
      {
         _fairy.removeEventListener("click",_handleClickFairy);
         this.removeEventListener("enterFrame",_handleEnterFrame);
         removeChild(_fairy);
         _fairy = null;
      }
      
      protected function _handleEnterFrame(param1:Event) : void
      {
         count = count + 1;
         if(count > 14)
         {
            count = 0;
            rot = rot * -1;
            _fairy.rotation = rot;
         }
         _fairy.y = _fairy.y + _yspd;
         if(_clickFlag)
         {
            _yspd = _yspd + 1;
            if(_yspd > --9)
            {
               _yspd = 0;
               _clickFlag = false;
            }
         }
      }
      
      protected function _handleClickFairy(param1:MouseEvent) : void
      {
         if(_clickFlag == false)
         {
            _yspd = -9;
            _clickFlag = true;
         }
      }
   }
}
