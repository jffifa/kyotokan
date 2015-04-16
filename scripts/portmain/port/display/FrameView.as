package port.display
{
   import res.port.MCPortFrameView;
   import port.views.sidemenu.SideMenu;
   import common.display.DisplayUtil;
   import a24.tween.Tween24;
   import a24.tween.Ease24;
   import common.debug.Debug;
   import flash.events.Event;
   import common.util.MathUtil;
   import flash.events.MouseEvent;
   
   public class FrameView extends MCPortFrameView
   {
      
      public function FrameView()
      {
         super();
         _upperBar = new UpperBar(upperBarMC);
         _sidemenu = new SideMenu(sideMenuMC,_handleClickMenuHandler);
         topCircle.buttonArea.addEventListener("click",_handleClickCircle);
         topClock.addEventListener("enterFrame",_handleClockEnterframe);
         topClock.mouseEnabled = false;
         topClock.mouseChildren = false;
         Tween24.loop(0,Tween24.wait(0.99),Tween24.prop([wheel,wheel2]).$$rotation(2)).play();
         circleInit(0);
         sideMenu.visible = false;
      }
      
      public const VISIBLE_SCENE:Array = [0,16,13,11,12,14,15,21,26,28,24,30];
      
      public const VISIBLE_SIDEMANU:Array = [16,13,11,12,14,15,30];
      
      public const VISIBLE_CLOCK:Array = [0,16,13,11,12,14,15,30];
      
      private var _upperBar:UpperBar;
      
      private var _sidemenu:SideMenu;
      
      public var clickMenuHandler:Function = null;
      
      public var clickCircleHandler:Function = null;
      
      public function get upperBar() : UpperBar
      {
         return _upperBar;
      }
      
      public function get sideMenu() : SideMenu
      {
         return _sidemenu;
      }
      
      public function circleInit(param1:int) : void
      {
         DisplayUtil.setButtonMode(topCircle.buttonArea);
         Tween24.loop(0,Tween24.tween(topCircle.lightEffect,1,Ease24._2_QuadIn).alpha(0),Tween24.tween(topCircle.lightEffect,1,Ease24._2_QuadOut).alpha(0.6)).play();
         topCircle.circle1.visible = false;
         Tween24.loop(0,Tween24.tween(topCircle.circle1,30).rotation(359)).play();
         Tween24.loop(0,Tween24.tween(topCircle.circle2,30).rotation(359)).play();
         topCircle.circle2.stop();
         topCircle.lightEffect.buttonMode = true;
      }
      
      public function circleChange(param1:int, param2:int) : void
      {
         fromScene = param1;
         toScene = param2;
         Debug.log("circleChange  " + toScene.toString());
         topCircle.circle1.gotoAndStop(toScene + 1);
         topCircle.circle1.alpha = 0;
         topCircle.circle1.visible = true;
         Tween24.serial(Tween24.tween(topCircle.circle1,0.6).alpha(1),Tween24.func(function():void
         {
            topCircle.circle2.gotoAndStop(toScene + 1);
            topCircle.circle2.rotation = topCircle.circle1.rotation;
            topCircle.circle1.visible = false;
         })).play();
      }
      
      public function setState(param1:int) : void
      {
         visible = !(VISIBLE_SCENE.indexOf(param1) == -1);
         sideMenu.visible = !(VISIBLE_SIDEMANU.indexOf(param1) == -1);
         topClock.visible = !(VISIBLE_CLOCK.indexOf(param1) == -1);
         wheel2.visible = param1 == 0;
      }
      
      private function _handleClockEnterframe(param1:Event) : void
      {
         var _loc6_:Date = new Date();
         var _loc4_:int = _loc6_.getMonth() + 1;
         var _loc5_:int = _loc6_.getDate();
         var _loc3_:int = _loc6_.getHours();
         var _loc2_:int = _loc6_.getMinutes();
         topClock.mmdd.text = MathUtil.digit2(_loc4_) + "/" + MathUtil.digit2(_loc5_);
         topClock.hhmm.text = MathUtil.digit2(_loc3_) + ":" + MathUtil.digit2(_loc2_);
      }
      
      private function _handleClickMenuHandler(param1:int) : void
      {
         if(!(clickMenuHandler == null) && sideMenu.getMouseEnable() == true)
         {
            clickMenuHandler(param1);
         }
      }
      
      private function _handleClickCircle(param1:MouseEvent) : void
      {
         if(clickCircleHandler != null)
         {
            clickCircleHandler(param1);
         }
      }
   }
}
