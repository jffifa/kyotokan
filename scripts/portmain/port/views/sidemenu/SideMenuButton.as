package port.views.sidemenu
{
   import flash.display.MovieClip;
   import common.display.DisplayUtil;
   import flash.events.Event;
   
   public class SideMenuButton extends Object
   {
      
      public function SideMenuButton(param1:MovieClip, param2:int)
      {
         super();
         _mc = param1;
         _sceneID = param2;
         _mc.gotoAndStop(1);
      }
      
      private var _mc:MovieClip;
      
      private var _sceneID:int;
      
      private var _active:Boolean = false;
      
      public var clickHandler:Function = null;
      
      public function get y() : Number
      {
         return _mc.y;
      }
      
      public function get height() : Number
      {
         return _mc.height;
      }
      
      public function get active() : Boolean
      {
         return _active;
      }
      
      public function setState(param1:int) : void
      {
         DisplayUtil.unsetButtonMode(_mc,_handleClickHandler);
         if(_sceneID == param1)
         {
            _active = true;
            _mc.gotoAndStop(2);
            _mc.x = 5;
         }
         else
         {
            _active = false;
            DisplayUtil.setButtonMode(_mc,_handleClickHandler);
            _mc.x = 0;
         }
      }
      
      private function _handleClickHandler(param1:Event) : void
      {
         param1.stopImmediatePropagation();
         if(clickHandler != null)
         {
            clickHandler(_sceneID);
         }
      }
   }
}
