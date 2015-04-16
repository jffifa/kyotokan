package port.display
{
   import res.port.MCLogBox;
   import flash.display.MovieClip;
   import a24.tween.Tween24;
   import flash.events.MouseEvent;
   import flash.ui.Mouse;
   
   public class LogBox extends MCLogBox
   {
      
      public function LogBox(param1:Number, param2:Number)
      {
         super();
         _initX = param1;
         x = param1;
         _initY = param2;
         y = param2;
         y = y + 150;
         tabBtn.buttonMode = true;
         tabBtn.gotoAndStop(2);
         addEventListener("click",_handleClick);
         addEventListener("mouseMove",_handleMouseMove);
         update(null);
      }
      
      private const MOVE_Y:Number = 150;
      
      private var _initX:Number = 0;
      
      private var _initY:Number = 0;
      
      private var _opened:Boolean = false;
      
      public function get opened() : Boolean
      {
         return _opened;
      }
      
      public function update(param1:Array) : void
      {
         var _loc5_:* = 0;
         var _loc4_:* = null;
         var _loc2_:* = null;
         var _loc3_:* = 0;
         if(param1)
         {
            while(param1.length < 5)
            {
               param1.push(null);
            }
         }
         else
         {
            var param1:Array = [null,null,null,null,null];
         }
         _loc5_ = 0;
         while(_loc5_ < 5)
         {
            _loc4_ = param1[_loc5_];
            _loc2_ = this["msg" + (_loc5_ + 1)];
            if(_loc4_)
            {
               _loc3_ = _loc4_.hasOwnProperty("api_type")?_loc4_.api_type:16;
               _loc2_.ic.gotoAndStop(_loc3_);
               _loc2_.msg.text = _loc4_.hasOwnProperty("api_message")?_loc4_.api_message:"";
               _loc2_.visible = true;
            }
            else
            {
               _loc2_.visible = false;
            }
            _loc5_++;
         }
      }
      
      public function setState(param1:*) : void
      {
         visible = param1 == 0;
         if(_opened)
         {
            _close();
         }
      }
      
      private function _open() : void
      {
         Tween24.tween(this,0.2).y(_initY).onComplete(function():void
         {
            _opened = true;
            tabBtn.gotoAndStop(1);
         }).play();
      }
      
      private function _close() : void
      {
         Tween24.tween(this,0.2).y(_initY + 150).onComplete(function():void
         {
            _opened = false;
            tabBtn.gotoAndStop(2);
         }).play();
      }
      
      private function _handleClickTabBtn(param1:MouseEvent) : void
      {
         if(_opened)
         {
            _close();
         }
         else
         {
            _open();
         }
      }
      
      private function _handleClick(param1:MouseEvent) : void
      {
         if(param1.target == tabBtn)
         {
            if(_opened)
            {
               _close();
            }
            else
            {
               _open();
            }
         }
         param1.stopImmediatePropagation();
      }
      
      private function _handleMouseMove(param1:MouseEvent) : void
      {
         param1.stopImmediatePropagation();
         if(Mouse.cursor != "auto")
         {
            Mouse.cursor = "auto";
         }
      }
   }
}
