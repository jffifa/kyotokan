package port.views.planes
{
   import flash.display.Sprite;
   import res.port.MCCombinedBrokenPopup;
   import common.display.ClickAreaLayer;
   import a24.tween.Tween24;
   import flash.events.Event;
   import flash.display.DisplayObjectContainer;
   import common.debug.Debug;
   
   public class CombinedBrokenPlane extends Sprite
   {
      
      public function CombinedBrokenPlane(param1:DisplayObjectContainer)
      {
         super();
         var _loc2_:int = DataFacade.getUserDeckData().autoUnCombinedDeck;
         if(_loc2_ > 0)
         {
            DataFacade.getUserDeckData().setCombinedFlag(0);
            if(_loc2_ == 1)
            {
               Debug.log("連合艦隊(機動部隊)の自動解除");
            }
            else if(_loc2_ == 2)
            {
               Debug.log("連合艦隊(水上部隊)の自動解除");
            }
            
            _initView();
            param1.addChild(this);
            _start();
         }
      }
      
      private var _dialog:MCCombinedBrokenPopup;
      
      private function _initView() : void
      {
         var _loc1_:ClickAreaLayer = new ClickAreaLayer(0.2);
         addChild(_loc1_);
      }
      
      private function _start() : void
      {
         _dialog = new MCCombinedBrokenPopup();
         _dialog.btn.buttonMode = true;
         _dialog.btn.addEventListener("click",_handleCloseDialog);
         Tween24.serial(Tween24.prop(_dialog).alpha(0),Tween24.addChild(this,_dialog),Tween24.tween(_dialog,0.3).alpha(1)).delay(1).play();
      }
      
      private function _handleCloseDialog(param1:Event) : void
      {
         if(_dialog != null)
         {
            _dialog.btn.removeEventListener("click",_handleCloseDialog);
            Tween24.serial(Tween24.tween(_dialog,0.3).alpha(0),Tween24.removeChild(_dialog)).onComplete(_removePlane).play();
         }
         else
         {
            _removePlane();
         }
      }
      
      private function _removePlane() : void
      {
         Tween24.removeChild(this).play();
      }
   }
}
