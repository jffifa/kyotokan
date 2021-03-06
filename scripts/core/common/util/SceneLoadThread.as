package common.util
{
   import flash.events.EventDispatcher;
   import flash.display.Sprite;
   import scene.ISceneDTO;
   import a24.tween.Tween24;
   import flash.events.IEventDispatcher;
   import scene.SceneLoader;
   import flash.events.Event;
   
   public class SceneLoadThread extends EventDispatcher
   {
      
      public function SceneLoadThread(param1:int, param2:ISceneDTO)
      {
         super();
         _sceneID = param1;
         _dto = param2;
      }
      
      public static var actionBlockLayer:Sprite = null;
      
      private var _sceneID:int;
      
      private var _dto:ISceneDTO;
      
      private var _cls:Class = null;
      
      public function get cls() : Class
      {
         return _cls;
      }
      
      public function createTween(param1:Boolean, param2:IEventDispatcher) : Tween24
      {
         var _loc3_:BloackerBox = new BloackerBox();
         return Tween24.serial(Tween24.ifCase(param1,Tween24.serial(Tween24.prop(_loc3_).alpha(0),Tween24.addChild(actionBlockLayer,_loc3_),Tween24.tween(_loc3_,0.2).alpha(0.8))),Tween24.parallel(Tween24.waitEvent(this,"complete"),Tween24.func(_load)),Tween24.ifCase(param1,Tween24.serial(Tween24.tween(_loc3_,0.2).alpha(0),Tween24.removeChild(_loc3_))));
      }
      
      private function _load(param1:int = 0) : void
      {
         retryCount = param1;
         _cls = Assets.getSceneCLS(_sceneID);
         if(_cls == null)
         {
            if(retryCount >= 3)
            {
               AppFacade.showErrorScreen("Load failed. sceneID:" + _sceneID);
            }
            else
            {
               var sceneLoader:SceneLoader = SceneLoader.createSceneLoader(_sceneID);
               sceneLoader.load("scene:" + _sceneID,function(param1:SceneLoader):void
               {
                  _load(retryCount + 1);
               },function(param1:SceneLoader):void
               {
                  _load(retryCount + 1);
               });
            }
            return;
         }
         dispatchEvent(new Event("complete"));
      }
   }
}
import flash.display.Sprite;
import flash.display.Shape;
import flash.display.DisplayObject;
import flash.events.Event;
import flash.display.Graphics;
import flash.geom.Point;

class BloackerBox extends Sprite
{
   
   function BloackerBox()
   {
      var _loc4_:* = 0;
      var _loc2_:* = NaN;
      _bg = new Shape();
      _arc = new Shape();
      super();
      _bg.graphics.beginFill(0,0);
      _bg.graphics.drawRect(0,0,800,480);
      _bg.graphics.endFill();
      var _loc3_:uint = 20;
      var _loc1_:* = 2.0;
      _loc4_ = 0;
      while(_loc4_ < _loc3_)
      {
         _loc2_ = 90 / _loc3_ * _loc4_;
         _bg.graphics.beginFill(0,Math.cos(_loc2_ * 3.141592653589793 / 180));
         _bg.graphics.drawRect(0,480 - _loc1_ * _loc4_,800,_loc1_);
         _bg.graphics.endFill();
         _loc4_++;
      }
      addChild(_bg);
      _arc.graphics.beginFill(16777215);
      drawPie(_arc.graphics,0,0,3,0,5.497787143782138,false);
      drawPie(_arc.graphics,0,0,9,5.497787143782138,0,true);
      _arc.graphics.endFill();
      _arc.x = 800 - 15;
      _arc.y = 480 - 15;
      addChild(_arc);
   }
   
   private var _bg:Shape;
   
   private var _arc:Shape;
   
   override public function addChild(param1:DisplayObject) : DisplayObject
   {
      var _loc2_:DisplayObject = super.addChild(param1);
      addEventListener("enterFrame",_handleEnterFrame);
      return _loc2_;
   }
   
   override public function addChildAt(param1:DisplayObject, param2:int) : DisplayObject
   {
      var _loc3_:DisplayObject = super.addChildAt(param1,param2);
      addEventListener("enterFrame",_handleEnterFrame);
      return _loc3_;
   }
   
   public function _handleEnterFrame(param1:Event) : void
   {
      if(parent)
      {
         _arc.rotation = _arc.rotation + 10;
      }
      else
      {
         removeEventListener("enterFrame",_handleEnterFrame);
      }
   }
   
   public function drawPie(param1:Graphics, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Boolean = false) : void
   {
      var _loc14_:* = NaN;
      var _loc12_:* = NaN;
      var _loc11_:* = NaN;
      var _loc15_:* = 0;
      var _loc13_:* = NaN;
      var _loc10_:* = NaN;
      var _loc9_:* = NaN;
      var _loc16_:* = null;
      var _loc8_:int = Math.max(1,Math.floor(Math.abs(param5 - param6) / 0.4));
      _loc15_ = 0;
      while(_loc15_ <= _loc8_)
      {
         _loc13_ = param5 + (param6 - param5) * _loc15_ / _loc8_;
         _loc10_ = Math.cos(_loc13_) * param4 + param2;
         _loc9_ = Math.sin(_loc13_) * param4 + param3;
         if(_loc15_ == 0)
         {
            if(param7)
            {
               param1.lineTo(_loc10_,_loc9_);
            }
            else
            {
               param1.moveTo(_loc10_,_loc9_);
            }
         }
         else
         {
            _loc16_ = getControlPoint(_loc14_,_loc12_,_loc11_ + 3.141592653589793 / 2,_loc10_,_loc9_,_loc13_ + 3.141592653589793 / 2);
            param1.curveTo(_loc16_.x,_loc16_.y,_loc10_,_loc9_);
         }
         _loc14_ = _loc10_;
         _loc12_ = _loc9_;
         _loc11_ = _loc13_;
         _loc15_++;
      }
   }
   
   public function getControlPoint(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number) : Point
   {
      var _loc13_:Number = param4 - param1;
      var _loc11_:Number = param5 - param2;
      var _loc12_:Number = Math.sqrt(_loc13_ * _loc13_ + _loc11_ * _loc11_);
      var _loc7_:Number = Math.atan2(_loc11_,_loc13_);
      var _loc10_:Number = _loc12_ * Math.sin(param6 - _loc7_) / Math.sin(param6 - param3);
      var _loc9_:Number = param1 + _loc10_ * Math.cos(param3);
      var _loc8_:Number = param2 + _loc10_ * Math.sin(param3);
      return new Point(_loc9_,_loc8_);
   }
}
