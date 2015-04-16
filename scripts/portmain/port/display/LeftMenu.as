package port.display
{
   import res.port.MCLeftMenu;
   import a24.tween.Tween24;
   import flash.events.MouseEvent;
   
   public class LeftMenu extends MCLeftMenu
   {
      
      public function LeftMenu()
      {
         super();
         getTweenHide().play();
         _buttons = new Vector.<MenuButton>();
         _buttons.push(new MenuButton(btn_organize,_handleClickMenuItem(13)));
         _buttons.push(new MenuButton(btn_supply,_handleClickMenuItem(11)));
         _buttons.push(new MenuButton(btn_remodel,_handleClickMenuItem(12)));
         _buttons.push(new MenuButton(btn_repair,_handleClickMenuItem(14)));
         _buttons.push(new MenuButton(btn_arsenal,_handleClickMenuItem(15)));
         _buttons.push(new MenuButton(btn_sally,_handleClickMenuItem(16)));
         _buttons.push(new MenuButton(btn_akashi_wrapper.btn_akashi,_handleClickMenuItem(30)));
         _buttons[6].btn.alpha = 0;
         var akashi_btn_base_x:int = _buttons[6].btn.x;
         var akashi_btn_move_speed:Number = 0.7;
         var akashi_btn_move_delay:Number = 0.5;
         _buttons[4].btn.addEventListener("mouseOver",function(param1:MouseEvent):void
         {
            event = param1;
            _akashiBtnTween = Tween24.tween(_buttons[6].btn,akashi_btn_move_speed).x(akashi_btn_base_x + 50).alpha(1);
            if(_buttons[6].btn.x == akashi_btn_base_x)
            {
               Tween24.wait(akashi_btn_move_delay).onComplete(function():void
               {
                  if(_akashiBtnTween != null)
                  {
                     _akashiBtnTween.play();
                  }
               }).play();
            }
            else
            {
               _akashiBtnTween.play();
            }
         });
         _buttons[4].btn.addEventListener("mouseOut",function(param1:MouseEvent):void
         {
            _akashiBtnTween = null;
            Tween24.tween(_buttons[6].btn,akashi_btn_move_speed).x(akashi_btn_base_x).alpha(0).play();
         });
         _buttons[6].btn.addEventListener("mouseOver",function(param1:MouseEvent):void
         {
            Tween24.tween(_buttons[6].btn,akashi_btn_move_speed).x(akashi_btn_base_x + 50).alpha(1).play();
         });
         _buttons[6].btn.addEventListener("mouseOut",function(param1:MouseEvent):void
         {
            Tween24.tween(_buttons[6].btn,akashi_btn_move_speed).x(akashi_btn_base_x).alpha(0).play();
         });
      }
      
      public const VISIBLE_SCENE:Array = [0];
      
      private var _buttons:Vector.<MenuButton>;
      
      private var _akashiBtnTween:Tween24 = null;
      
      public var clickHandler:Function = null;
      
      public function setState(param1:int) : void
      {
         if(VISIBLE_SCENE.indexOf(param1) != -1)
         {
            visible = true;
         }
         else
         {
            visible = false;
            getTweenHide().play();
         }
      }
      
      public function setAkashiBtnState(param1:Boolean) : void
      {
         btn_akashi_wrapper.visible = param1;
      }
      
      public function getTweenShow() : Tween24
      {
         return Tween24.tween(this,0.3).x(0).alpha(1);
      }
      
      public function getTweenHide() : Tween24
      {
         return Tween24.prop(this).x(-200).alpha(0);
      }
      
      private function _handleClickMenuItem(param1:int) : Function
      {
         sceneID = param1;
         return function(param1:MouseEvent = null):void
         {
            if(clickHandler != null)
            {
               clickHandler(sceneID);
            }
         };
      }
   }
}
import flash.display.SimpleButton;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.display.DisplayObject;
import flash.events.MouseEvent;

class MenuButton extends Object
{
   
   function MenuButton(param1:MovieClip, param2:Function)
   {
      _upState = new Sprite();
      _overState = new Sprite();
      _downState = new Sprite();
      _hitTestState = new Sprite();
      super();
      _mc = param1;
      _initialize();
      _clickHandler = param2;
   }
   
   private var _btn:SimpleButton;
   
   private var _mc:MovieClip;
   
   private var _upState:Sprite;
   
   private var _overState:Sprite;
   
   private var _downState:Sprite;
   
   private var _hitTestState:Sprite;
   
   private var _clickHandler:Function;
   
   public function get btn() : SimpleButton
   {
      return _btn;
   }
   
   private function _initialize() : void
   {
      _change(1,_upState);
      _change(2,_overState);
      _change(3,_downState);
      _change(4,_hitTestState);
      _btn = new SimpleButton(_upState,_overState,_downState,_hitTestState);
      btn.x = _mc.x;
      btn.y = _mc.y;
      _mc.parent.addChildAt(btn,_mc.parent.getChildIndex(_mc));
      _mc.parent.removeChild(_mc);
      btn.addEventListener("click",_handleClickHandler);
   }
   
   private function _change(param1:int, param2:Sprite) : void
   {
      var _loc3_:* = null;
      _mc.gotoAndStop(param1);
      while(_mc.numChildren > 0)
      {
         _loc3_ = _mc.getChildAt(0);
         param2.addChild(_loc3_);
      }
   }
   
   private function _handleClickHandler(param1:MouseEvent) : void
   {
      if(param1 != null)
      {
         param1.stopImmediatePropagation();
      }
      if(_clickHandler != null)
      {
         _clickHandler();
      }
   }
}
