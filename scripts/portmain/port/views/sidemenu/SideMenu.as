package port.views.sidemenu
{
   import flash.display.MovieClip;
   import flash.utils.Dictionary;
   import a24.tween.Tween24;
   import common.display.DisplayUtil;
   import flash.events.MouseEvent;
   import common.util.SoundUtil;
   
   public class SideMenu extends Object
   {
      
      public function SideMenu(param1:MovieClip, param2:Function)
      {
         mc = param1;
         clickHandler = param2;
         _sideMenuButtons = new Dictionary();
         super();
         _mc = mc;
         _initializeBtn(_mc.btn_organize,13,clickHandler);
         _initializeBtn(_mc.btn_supply,11,clickHandler);
         _initializeBtn(_mc.btn_remodel,12,clickHandler);
         _initializeBtn(_mc.btn_repair,14,clickHandler);
         _initializeBtn(_mc.btn_arsenal,15,clickHandler);
         DisplayUtil.setButtonMode(_mc.btn_top,function(param1:MouseEvent):void
         {
            param1.stopImmediatePropagation();
            SoundUtil.playSE(Assets.SE_system10);
            AppFacade.gotoPort();
         });
      }
      
      private var _mc:MovieClip;
      
      private var _sideMenuButtons:Dictionary;
      
      public function get visible() : Boolean
      {
         return _mc.visible;
      }
      
      public function set visible(param1:Boolean) : void
      {
         _mc.visible = param1;
      }
      
      public function get crane() : MovieClip
      {
         return _mc["crane"];
      }
      
      public function setMouseEnebled(param1:Boolean) : void
      {
         var _loc2_:* = param1;
         _mc.mouseChildren = _loc2_;
         _mc.mouseEnabled = _loc2_;
      }
      
      public function getMouseEnable() : Boolean
      {
         return _mc.mouseEnabled;
      }
      
      public function getTween(param1:int) : Tween24
      {
         var _loc3_:* = null;
         var _loc2_:SideMenuButton = _getButton(param1);
         var _loc4_:SideMenuButton = _getActiveBtn();
         if(_loc2_ == null)
         {
            crane.visible = false;
            _setState(0);
            return Tween24.wait(0);
         }
         crane.visible = true;
         if(_loc4_ == null)
         {
            _loc3_ = Tween24.wait(0);
         }
         else
         {
            _loc3_ = Tween24.func(_loc4_.setState,-1);
         }
         return Tween24.serial(_loc3_,Tween24.tween(crane,0.2).x(60),Tween24.tween(crane,0.2).y(_loc2_.y + _loc2_.height / 2),Tween24.tween(crane,0.2).x(52),Tween24.parallel(Tween24.tween(crane,0.1).x(56),Tween24.func(_setState,param1).delay(0.05)));
      }
      
      private function _initializeBtn(param1:MovieClip, param2:int, param3:Function) : void
      {
         var _loc4_:SideMenuButton = new SideMenuButton(param1,param2);
         _loc4_.clickHandler = param3;
         _sideMenuButtons[param2] = _loc4_;
      }
      
      private function _setState(param1:int) : void
      {
         var _loc4_:* = 0;
         var _loc3_:* = _sideMenuButtons;
         for each(var _loc2_ in _sideMenuButtons)
         {
            _loc2_.setState(param1);
         }
         setMouseEnebled(true);
      }
      
      private function _getButton(param1:int) : SideMenuButton
      {
         if(_sideMenuButtons.hasOwnProperty(param1))
         {
            return _sideMenuButtons[param1];
         }
         return null;
      }
      
      private function _getActiveBtn() : SideMenuButton
      {
         var _loc3_:* = 0;
         var _loc2_:* = _sideMenuButtons;
         for each(var _loc1_ in _sideMenuButtons)
         {
            if(_loc1_.active == true)
            {
               return _loc1_;
            }
         }
         return null;
      }
   }
}
