package port.display
{
   import flash.display.Sprite;
   import common.effects.Sakura;
   import a24.tween.Tween24;
   import flash.media.SoundChannel;
   import util.TimeSignalVoice;
   import flash.geom.Rectangle;
   import manager.resource.IShipAttacher;
   import vo.MasterShipData;
   import flash.events.IEventDispatcher;
   import flash.display.Loader;
   import common.util.Util;
   import flash.geom.Point;
   import flash.events.MouseEvent;
   import common.util.SoundUtil;
   import flash.display.BitmapData;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public class PartnerShipView extends Sprite
   {
      
      public function PartnerShipView()
      {
         _sakuraCanvas = new Sprite();
         _imgCanvas = new Sprite();
         _timeSignal = new TimeSignalVoice();
         super();
         addChild(_sakuraCanvas);
         addChild(_imgCanvas);
         _lastTouchedTime = new Date().getTime();
      }
      
      public const VISIBLE_SCENE:Array = [0];
      
      public const RECOGNIZED_VOICE_INTERVAL:int = 300000;
      
      private var _sakuraCanvas:Sprite;
      
      private var _sakura:Sakura;
      
      private var _imgCanvas:Sprite;
      
      private var _active:Boolean = false;
      
      private var _animationTween:Tween24 = null;
      
      private var _charaID:int;
      
      private var _isMarriage:Boolean;
      
      private var _isRecognizedVoice:Boolean = false;
      
      private var _isTimeSignalVoice:Boolean = false;
      
      private var _touchCount:int = 0;
      
      private var _lastTouchedTime:Number = 0;
      
      private var _playingVoice:SoundChannel = null;
      
      private var _timeSignal:TimeSignalVoice;
      
      public function get touchCount() : int
      {
         return _touchCount;
      }
      
      public function set active(param1:Boolean) : void
      {
         _active = param1;
         if(_active)
         {
            if(_isMarriage == true)
            {
               _sakura = new Sakura();
               _sakuraCanvas.addChild(_sakura);
               _sakura.startAnimation(new Rectangle(800 / 2,0,800 / 2,480));
            }
            if(_animationTween == null)
            {
               _tweenAnimation();
            }
            if(_isTimeSignalVoice)
            {
               _timeSignal.initialize(_charaID);
            }
            _lastTouchedTime = new Date().getTime();
            addEventListener("enterFrame",_handleEnterframe);
         }
         else
         {
            if(_sakura != null)
            {
               _sakura.stopAnimation();
               _sakuraCanvas.removeChild(_sakura);
               _sakura = null;
            }
            _touchCount = 0;
            _timeSignal.finalize();
            removeEventListener("enterFrame",_handleEnterframe);
         }
      }
      
      public function get active() : Boolean
      {
         return _active;
      }
      
      public function load(param1:int, param2:int, param3:Boolean) : void
      {
         charaID = param1;
         condition = param2;
         isMarriage = param3;
         _charaID = charaID;
         _isMarriage = isMarriage;
         active = false;
         _imgCanvas.x = 583;
         _imgCanvas.y = 453;
         _imgCanvas.removeChildren();
         var attacher:IShipAttacher = AppFacade.createShipAttacher();
         attacher.stackFull(charaID,_imgCanvas,condition);
         Tween24.serial(Tween24.parallel(Tween24.waitEvent(attacher as IEventDispatcher,"complete"),Tween24.func(attacher.load)),Tween24.func(function():void
         {
            var _loc1_:* = null;
            var _loc2_:* = false;
            var _loc3_:* = null;
            if(_imgCanvas.numChildren > 0)
            {
               _loc1_ = _imgCanvas.getChildAt(0) as Loader;
               if(_loc1_ != null)
               {
                  _loc2_ = Util.isDamaged(condition);
                  _loc3_ = DataFacade.getStartData().getOffsetInPortMain(charaID,_loc2_);
                  _loc1_.x = _loc3_.x - 256;
                  _loc1_.y = _loc3_.y - 510;
               }
            }
         })).play();
         var masterShipData:MasterShipData = DataFacade.getMasterShipData();
         _isRecognizedVoice = masterShipData.getVoiceFlg_Recognized(_charaID);
         _isTimeSignalVoice = masterShipData.getVoiceFlg_TimeSignal(_charaID);
         if(_isTimeSignalVoice)
         {
            _timeSignal.initialize(_charaID);
         }
         var nowTime:Date = new Date();
         var nextTimeSignal:int = nowTime.hours + 1;
         nextTimeSignal = nextTimeSignal > 23?nextTimeSignal - 24:nextTimeSignal;
         active = true;
      }
      
      public function setState(param1:int) : void
      {
         if(VISIBLE_SCENE.indexOf(param1) != -1)
         {
            visible = true;
         }
         else
         {
            visible = false;
            active = false;
         }
      }
      
      public function mouseMove(param1:MouseEvent) : Boolean
      {
         return _hitTest(param1.stageX,param1.stageY);
      }
      
      public function mouseClick(param1:MouseEvent) : Boolean
      {
         if(_hitTest(param1.stageX,param1.stageY))
         {
            if(_playingVoice)
            {
               _playingVoice.stop();
            }
            if(_touchCount < 4)
            {
               if(_isMarriage == true && _touchCount == 0)
               {
                  _playingVoice = SoundUtil.playVoice(_charaID,28);
               }
               else
               {
                  _playingVoice = SoundUtil.playVoiceAtRandom(_charaID,[2,3,4],[60,30,10]);
               }
            }
            else
            {
               _playingVoice = SoundUtil.playVoice(_charaID,4);
            }
            _lastTouchedTime = new Date().getTime();
            _touchCount = _touchCount + 1;
            return true;
         }
         return false;
      }
      
      private function _tweenAnimation() : void
      {
         if(_active)
         {
            _animationTween = Tween24.tweenFunc(_anim,5.2,[0],[3.141592653589793]);
            _animationTween.onComplete(_tweenAnimation).play();
         }
         else
         {
            _animationTween = null;
         }
      }
      
      private function _anim(param1:Number) : void
      {
         var _loc2_:* = 1 + 0.012 * (0.5 + 0.5 * Math.sin(param1));
         _imgCanvas.scaleY = _loc2_;
         _imgCanvas.scaleX = _loc2_;
         _imgCanvas.y = 453 - 0.6 * Math.sin(param1);
      }
      
      private function _getBitmapData() : BitmapData
      {
         var _loc3_:* = null;
         var _loc1_:* = null;
         var _loc2_:* = null;
         if(_imgCanvas.numChildren)
         {
            _loc3_ = _imgCanvas.getChildAt(0) as Loader;
            if(_loc3_)
            {
               _loc1_ = _loc3_.content as Bitmap;
               if(_loc1_)
               {
                  return _loc1_.bitmapData;
               }
               if(_loc3_.content is MovieClip)
               {
                  _loc2_ = new BitmapData(_loc3_.width,_loc3_.height,true,0);
                  _loc2_.draw(_loc3_.content);
                  return _loc2_;
               }
            }
         }
         return null;
      }
      
      private function _hitTest(param1:Number, param2:Number) : Boolean
      {
         var _loc5_:* = null;
         var _loc4_:* = null;
         var _loc6_:* = null;
         var _loc3_:BitmapData = _getBitmapData();
         if(_loc3_)
         {
            _loc5_ = _imgCanvas.getChildAt(0) as Loader;
            _loc4_ = new Point(_loc5_.x,_loc5_.y);
            _loc6_ = _imgCanvas.localToGlobal(_loc4_);
            return _loc3_.hitTest(_loc6_,0,new Point(param1,param2));
         }
         return false;
      }
      
      private function _handleEnterframe(param1:Event) : void
      {
         if(_isRecognizedVoice)
         {
            _recognizedVoice();
         }
      }
      
      private function _recognizedVoice() : void
      {
         var _loc2_:Number = new Date().getTime();
         var _loc1_:Number = _loc2_ - _lastTouchedTime;
         if(_loc1_ > 300000)
         {
            if(SettingFacade.FLG_RECOGNIZED_VOICE)
            {
               SoundUtil.playVoice(_charaID,29);
            }
            _lastTouchedTime = new Date().getTime();
         }
      }
   }
}
